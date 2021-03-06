#!/usr/bin/env python3

import collections
import datetime
import sys
import re
import os

HERE = os.path.dirname(os.path.realpath(__file__))
TARGET_FILE = "{}/X86Target.def".format(HERE)
CMAKE_HELPER = "CPUFeatureDetect.cmake"


def enumerateFeatures_(feature):
    """ Given a regex, run findall on target and complain if nothing found. """
    features = []
    found = None
    with open(TARGET_FILE, "r") as t:
        tFull = t.read()
        found = re.findall(feature, tFull)
        if not found:
            print("No features found in file for {}".format(feature))
            sys.exit(1)
    return found


def enumerateFeatureHierarchy():
    # Anchoring to a newline stops us from picking up
    # #define FEATURE(ENUM)

    # Line looks like:
    # FEATURE(DESC)
    return enumerateFeatures_("\nFEATURE\(FEATURE_(.*)\)")


def enumerateCPUFeatures():
    # Line looks like:
    # PROC_WITH_FEAT(Nehalem, "nehalem", PROC_64_BIT, FEATURE_SSE4_2)
    return enumerateFeatures_(
        '\nPROC_WITH_FEAT\((.*), "(.*)", PROC_64_BIT, FEATURE_(.*)\)'
    )


def enumerateCPUAliases():
    # Line looks like:
    # PROC_ALIAS(Nehalem, "corei7")
    return enumerateFeatures_('\nPROC_ALIAS\((.*), "(.*)"\)')


# Now create multiple data structures:
# - A list of lists of features implied by the highest feature level
# - A map of architecture to features (including arch aliases)
# - A map of features to architectures (including arch aliases)
def createFeatureTree(features):
    """ Return list where each element contains each previous element """
    subFeatures = {}
    treeSoFar = []
    for feature in features:
        treeSoFar.append(feature)
        subFeatures[feature] = treeSoFar[:]
    return subFeatures


def mergeCPUWithAliases(cpus, aliases, featureMap):
    """ Generate a map of marchName: {features, alias} """
    cpuFeatureMap = {}
    for cpu in cpus:
        internalName, marchName, feature = cpu
        cpuFeatureMap[marchName] = {"features": featureMap[feature], "aliasFor": None}
        for alias in aliases:
            aliasInternal, aliasMarch = alias
            if aliasInternal == internalName:
                cpuFeatureMap[aliasMarch] = {
                    "features": featureMap[feature],
                    "aliasFor": marchName,
                }
    return cpuFeatureMap


def printCPUFeatureMap(marchFeatureMap, formatter):
    for march, value in sorted(marchFeatureMap.items(), key=lambda x: x[1]["features"]):
        alias = value["aliasFor"]
        features = value["features"]
        formatter(march, alias, features)


def enumerateFeaturesByCPU(marchFeatureMap):
    featureCPUMap = collections.defaultdict(list)
    for march, value in marchFeatureMap.items():
        features = value["features"]
        for feature in features:
            featureCPUMap[feature].append(march)

    return featureCPUMap


def printFeatureCPUMap(featureMarchMap, formatter):
    for feature, marchs in sorted(featureMarchMap.items(), key=lambda x: x[0]):
        formatter(feature, marchs)


# Generate a CMake function to determine available CPU features based on:
# - system feature detection (when march=native)
# - system feature knowledge (when march=[a known uarch])
def writeCMakeHelper(featureMarchMap):
    unsetAll = []
    for feature, marchs in sorted(featureMarchMap.items(), key=lambda x: x[0]):
        unsetAll.append(f"    unset(${{RESULT_PREFIX}}_FEATURE_{feature} CACHE)")
        unsetAll.append(f"    unset(${{RESULT_PREFIX}}_{feature} CACHE)")
    unsetAll = "\n".join(unsetAll)

    with open(CMAKE_HELPER, "w") as x:
        x.write("# generated by parsing clang X86Target.def CPU definitions\n")
        x.write("include(CheckCSourceCompiles)\n")

        x.write(
            """
# Helper to generate final flags given current build type...
function(genFinalFlags RESULT_PREFIX)
# CMake doesn't have any case insensitive string compares, so nudge BUILD_TYPE:
string(TOUPPER "${{CMAKE_BUILD_TYPE}}" KNOWN_BUILD_TYPE)
set(FLAGS "${{CMAKE_C_FLAGS}} ${{CMAKE_CXX_FLAGS}} ")
if (KNOWN_BUILD_TYPE MATCHES DEBUG)
    string(APPEND FLAGS "${{CMAKE_C_FLAGS_DEBUG}} ${{CMAKE_CXX_FLAGS_DEBUG}} ")
elseif(KNOWN_BUILD_TYPE MATCHES RELEASE)
    string(APPEND FLAGS "${{CMAKE_C_FLAGS_RELEASE}} ${{CMAKE_CXX_FLAGS_RELEASE}} ")
elseif(KNOWN_BUILD_TYPE MATCHES RELWITHDEBINFO)
    string(APPEND FLAGS "${{CMAKE_C_FLAGS_RELWITHDEBINFO}} ${{CMAKE_CXX_FLAGS_RELWITHDEBINFO}} ")
elseif(KNOWN_BUILD_TYPE MATCHES MINSIZEREL)
    string(APPEND FLAGS "${{CMAKE_C_FLAGS_MINSIZEREL}} ${{CMAKE_CXX_FLAGS_MINSIZEREL}} ")
endif()

set(${{RESULT_PREFIX}}_FLAGS ${{FLAGS}} PARENT_SCOPE)
endfunction(genFinalFlags)

# Yes, this function looks WEIRD because it has 100% duplicated behavior
# because CMake aggressively caches the results of feature detection.
#
# If we are cross-compiling against architectures, CMake will _never_ run
# the feature detection a second time even if we change all our compile flags.
#
# So, we ONLY run feature detection if we are using "march=native".
# If not using "march=native", parse cflags to check the arch for compilation.
#
# CPU features are based on our knowledge of compiler<->cpu interactions
# as obtained from clang's description of CPU features inside X86Target.def.
#
# Feature detection is looking at the defines you'd find just by using:
# > clang -march=native -dM -E - < /dev/null
function(genCPUFeatures RESULT_PREFIX)
# CMake doesn't have case insensitive string compares, so nudge BUILD_TYPE:
string(TOUPPER "${{CMAKE_BUILD_TYPE}}" KNOWN_BUILD_TYPE)
genFinalFlags(BUILDING)

if(CMAKE_BUILD_TYPE MATCHES Debug)
    message("[${{RESULT_PREFIX}}] flags: ${{genCPUFeaturesCachedFlags_${{RESULT_PREFIX}}}}")
endif()
if(NOT (genCPUFeaturesCachedFlags_${{RESULT_PREFIX}} STREQUAL "${{BUILDING_FLAGS}}"))
    if(CMAKE_BUILD_TYPE MATCHES Debug)
        message("Checking features against build flags: ${{BUILDING_FLAGS}}")
    endif()
    set(genCPUFeaturesCachedFlags_${{RESULT_PREFIX}} ${{BUILDING_FLAGS}} CACHE INTERNAL "prevflag")
{}
endif()

set(CMAKE_REQUIRED_FLAGS ${{BUILDING_FLAGS}})

# If using native or no march, use feature detection (result perma-cached)
if (("${{BUILDING_FLAGS}}" MATCHES "march=native") OR
    (NOT "${{BUILDING_FLAGS}}" MATCHES "march=") OR
    ("${{KNOWN_BUILD_TYPE}}" STREQUAL ""))
""".format(
                unsetAll
            )
        )  # empty format() because we already doubled all the {{}}

        # In cmake, use:
        # if (CLANG_FEATURE_AVX2) ...
        # NOTE: cmake CACHES these results so if you change
        #       your compile options these WILL NOT re-run
        # See: https://cmake.org/cmake/help/latest/module/CheckCSourceCompiles.html
        # If you are multi-compiling or cross-compiling from the
        # same cmake sources, ONLY use this feature detection for
        # march=native since your native capability won't change (ideally),
        # then use the FEATURE MAPS against the current CFLAGS march= string for
        # per-build decisions.

        # Note: the "stdlib.h" below has nothing to do with our
        #       preprocessor symbol detection. The cmake API just
        #       requires a header to preprocess against, but since
        #       the compiler just generates our requested symbols based
        #       on architecture instead of headers, we're fine using
        #       any well-known and widely available header here.
        def printCMakeDetectionCapability(feature, marchs):
            x.write(
                """
check_c_source_compiles("
#ifndef __{}__
#error not supported
#endif

int main(void) {{
    return 0;
}}" ${{RESULT_PREFIX}}_FEATURE_{})
set(${{RESULT_PREFIX}}_{} ${{${{RESULT_PREFIX}}_FEATURE_{}}} PARENT_SCOPE)
""".format(
                    feature,
                    feature,
                    feature,
                    feature,
                    feature,
                    feature,
                    feature,
                    feature,
                )
            )

            # Add a catch-all "AVX512 support" query
            if feature == "AVX512F":
                x.write(
                    """set(${{RESULT_PREFIX}}_AVX512 ${{RESULT_PREFIX}}_FEATURE_{} PARENT_SCOPE)
""".format(
                        feature
                    )
                )

        printFeatureCPUMap(featureMarchMap, printCMakeDetectionCapability)

        x.write(
            """
else()
# else, use march=string to check feature capability
"""
        )

        # In cmake, use:
        # if (LIST_CLANG_FEATURE_MAP_AVX2 IN_LIST marchvalue)
        def printCMakeFeatureLists(feature, marchs):
            x.write(
                """
set(CLANG_FEATURE_MAP_{} {})
message(STATUS "Querying for ${{marchName}} {}...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_{})
    if ("${{BUILDING_FLAGS}}" MATCHES "march=${{marchName}}")
        message(STATUS "Querying for ${{marchName}} {}... - found")
        set(${{RESULT_PREFIX}}_{} YES PARENT_SCOPE)
""".format(
                    feature, " ".join(marchs), feature, feature, feature, feature
                )
            )

            # Add a catch-all "AVX512 support" query
            if feature == "AVX512F":
                x.write(
                    """        set(${{RESULT_PREFIX}}_AVX512 YES PARENT_SCOPE)
""".format(
                        feature
                    )
                )

            x.write(
                """    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)
"""
            )

        printFeatureCPUMap(featureMarchMap, printCMakeFeatureLists)

        x.write(
            """
endif()
endfunction()
"""
        )


if __name__ == "__main__":
    featuresByAge = enumerateFeatureHierarchy()
    cpuFeatures = enumerateCPUFeatures()
    cpuAliases = enumerateCPUAliases()

    featureTree = createFeatureTree(featuresByAge)

    marchFeatureMap = mergeCPUWithAliases(cpuFeatures, cpuAliases, featureTree)

    featureMarchMap = enumerateFeaturesByCPU(marchFeatureMap)

    #    print(featuresByAge)
    #    print(featureTree)
    #    print(cpuFeatures)
    #    print(cpuAliases)
    #    print(marchFeatureMap)

    # Sort feature map by list of length of features
    # from shortest to longest

    def debugPrintCFM(march, alias, features):
        features.sort()
        print(
            "{}{}: ({} features)\n{}\n".format(
                march,
                " (alias for {})".format(alias) if alias else "",
                len(features),
                features,
            )
        )

    printCPUFeatureMap(marchFeatureMap, debugPrintCFM)

    def debugPrintFCM(feature, marchs):
        marchs.sort()
        print("{}: ({} marchs)\n{}\n".format(feature, len(marchs), marchs))

    printFeatureCPUMap(featureMarchMap, debugPrintFCM)

    print("Generating CMake helper script {}...".format(CMAKE_HELPER))
    writeCMakeHelper(featureMarchMap)
    print("Generated CMake helper script {}!".format(CMAKE_HELPER))
