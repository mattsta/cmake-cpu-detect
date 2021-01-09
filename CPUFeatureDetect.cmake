# generated by parsing clang X86Target.def CPU definitions
include(CheckCSourceCompiles)

# Helper to generate final flags given current build type...
function(genFinalFlags RESULT_PREFIX)
# CMake doesn't have any case insensitive string compares, so nudge BUILD_TYPE:
string(TOUPPER "${CMAKE_BUILD_TYPE}" KNOWN_BUILD_TYPE)
set(FLAGS "${CMAKE_C_FLAGS} ${CMAKE_CXX_FLAGS} ")
if (KNOWN_BUILD_TYPE MATCHES DEBUG)
    string(APPEND FLAGS "${CMAKE_C_FLAGS_DEBUG} ${CMAKE_CXX_FLAGS_DEBUG} ")
elseif(KNOWN_BUILD_TYPE MATCHES RELEASE)
    string(APPEND FLAGS "${CMAKE_C_FLAGS_RELEASE} ${CMAKE_CXX_FLAGS_RELEASE} ")
elseif(KNOWN_BUILD_TYPE MATCHES RELWITHDEBINFO)
    string(APPEND FLAGS "${CMAKE_C_FLAGS_RELWITHDEBINFO} ${CMAKE_CXX_FLAGS_RELWITHDEBINFO} ")
elseif(KNOWN_BUILD_TYPE MATCHES MINSIZEREL)
    string(APPEND FLAGS "${CMAKE_C_FLAGS_MINSIZEREL} ${CMAKE_CXX_FLAGS_MINSIZEREL} ")
endif()

set(${RESULT_PREFIX}_FLAGS ${FLAGS} PARENT_SCOPE)
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
string(TOUPPER "${CMAKE_BUILD_TYPE}" KNOWN_BUILD_TYPE)
genFinalFlags(BUILDING)

if(CMAKE_BUILD_TYPE MATCHES Debug)
    message("[${RESULT_PREFIX}] flags: ${genCPUFeaturesCachedFlags_${RESULT_PREFIX}}")
endif()
if(NOT (genCPUFeaturesCachedFlags_${RESULT_PREFIX} STREQUAL "${BUILDING_FLAGS}"))
    if(CMAKE_BUILD_TYPE MATCHES Debug)
        message("Checking features against build flags: ${BUILDING_FLAGS}")
    endif()
    set(genCPUFeaturesCachedFlags_${RESULT_PREFIX} ${BUILDING_FLAGS} CACHE INTERNAL "prevflag")
    unset(${RESULT_PREFIX}_FEATURE_AES CACHE)
    unset(${RESULT_PREFIX}_AES CACHE)
    unset(${RESULT_PREFIX}_FEATURE_AVX CACHE)
    unset(${RESULT_PREFIX}_AVX CACHE)
    unset(${RESULT_PREFIX}_FEATURE_AVX2 CACHE)
    unset(${RESULT_PREFIX}_AVX2 CACHE)
    unset(${RESULT_PREFIX}_FEATURE_AVX5124FMAPS CACHE)
    unset(${RESULT_PREFIX}_AVX5124FMAPS CACHE)
    unset(${RESULT_PREFIX}_FEATURE_AVX5124VNNIW CACHE)
    unset(${RESULT_PREFIX}_AVX5124VNNIW CACHE)
    unset(${RESULT_PREFIX}_FEATURE_AVX512BF16 CACHE)
    unset(${RESULT_PREFIX}_AVX512BF16 CACHE)
    unset(${RESULT_PREFIX}_FEATURE_AVX512BITALG CACHE)
    unset(${RESULT_PREFIX}_AVX512BITALG CACHE)
    unset(${RESULT_PREFIX}_FEATURE_AVX512BW CACHE)
    unset(${RESULT_PREFIX}_AVX512BW CACHE)
    unset(${RESULT_PREFIX}_FEATURE_AVX512CD CACHE)
    unset(${RESULT_PREFIX}_AVX512CD CACHE)
    unset(${RESULT_PREFIX}_FEATURE_AVX512DQ CACHE)
    unset(${RESULT_PREFIX}_AVX512DQ CACHE)
    unset(${RESULT_PREFIX}_FEATURE_AVX512ER CACHE)
    unset(${RESULT_PREFIX}_AVX512ER CACHE)
    unset(${RESULT_PREFIX}_FEATURE_AVX512F CACHE)
    unset(${RESULT_PREFIX}_AVX512F CACHE)
    unset(${RESULT_PREFIX}_FEATURE_AVX512IFMA CACHE)
    unset(${RESULT_PREFIX}_AVX512IFMA CACHE)
    unset(${RESULT_PREFIX}_FEATURE_AVX512PF CACHE)
    unset(${RESULT_PREFIX}_AVX512PF CACHE)
    unset(${RESULT_PREFIX}_FEATURE_AVX512VBMI CACHE)
    unset(${RESULT_PREFIX}_AVX512VBMI CACHE)
    unset(${RESULT_PREFIX}_FEATURE_AVX512VBMI2 CACHE)
    unset(${RESULT_PREFIX}_AVX512VBMI2 CACHE)
    unset(${RESULT_PREFIX}_FEATURE_AVX512VL CACHE)
    unset(${RESULT_PREFIX}_AVX512VL CACHE)
    unset(${RESULT_PREFIX}_FEATURE_AVX512VNNI CACHE)
    unset(${RESULT_PREFIX}_AVX512VNNI CACHE)
    unset(${RESULT_PREFIX}_FEATURE_AVX512VPOPCNTDQ CACHE)
    unset(${RESULT_PREFIX}_AVX512VPOPCNTDQ CACHE)
    unset(${RESULT_PREFIX}_FEATURE_BMI CACHE)
    unset(${RESULT_PREFIX}_BMI CACHE)
    unset(${RESULT_PREFIX}_FEATURE_BMI2 CACHE)
    unset(${RESULT_PREFIX}_BMI2 CACHE)
    unset(${RESULT_PREFIX}_FEATURE_CMOV CACHE)
    unset(${RESULT_PREFIX}_CMOV CACHE)
    unset(${RESULT_PREFIX}_FEATURE_FMA CACHE)
    unset(${RESULT_PREFIX}_FMA CACHE)
    unset(${RESULT_PREFIX}_FEATURE_FMA4 CACHE)
    unset(${RESULT_PREFIX}_FMA4 CACHE)
    unset(${RESULT_PREFIX}_FEATURE_GFNI CACHE)
    unset(${RESULT_PREFIX}_GFNI CACHE)
    unset(${RESULT_PREFIX}_FEATURE_MMX CACHE)
    unset(${RESULT_PREFIX}_MMX CACHE)
    unset(${RESULT_PREFIX}_FEATURE_PCLMUL CACHE)
    unset(${RESULT_PREFIX}_PCLMUL CACHE)
    unset(${RESULT_PREFIX}_FEATURE_POPCNT CACHE)
    unset(${RESULT_PREFIX}_POPCNT CACHE)
    unset(${RESULT_PREFIX}_FEATURE_SSE CACHE)
    unset(${RESULT_PREFIX}_SSE CACHE)
    unset(${RESULT_PREFIX}_FEATURE_SSE2 CACHE)
    unset(${RESULT_PREFIX}_SSE2 CACHE)
    unset(${RESULT_PREFIX}_FEATURE_SSE3 CACHE)
    unset(${RESULT_PREFIX}_SSE3 CACHE)
    unset(${RESULT_PREFIX}_FEATURE_SSE4_1 CACHE)
    unset(${RESULT_PREFIX}_SSE4_1 CACHE)
    unset(${RESULT_PREFIX}_FEATURE_SSE4_2 CACHE)
    unset(${RESULT_PREFIX}_SSE4_2 CACHE)
    unset(${RESULT_PREFIX}_FEATURE_SSE4_A CACHE)
    unset(${RESULT_PREFIX}_SSE4_A CACHE)
    unset(${RESULT_PREFIX}_FEATURE_SSSE3 CACHE)
    unset(${RESULT_PREFIX}_SSSE3 CACHE)
    unset(${RESULT_PREFIX}_FEATURE_VPCLMULQDQ CACHE)
    unset(${RESULT_PREFIX}_VPCLMULQDQ CACHE)
    unset(${RESULT_PREFIX}_FEATURE_XOP CACHE)
    unset(${RESULT_PREFIX}_XOP CACHE)
endif()

set(CMAKE_REQUIRED_FLAGS ${BUILDING_FLAGS})

# If using native or no march, use feature detection (result perma-cached)
if (("${BUILDING_FLAGS}" MATCHES "march=native") OR
    (NOT "${BUILDING_FLAGS}" MATCHES "march=") OR
    ("${KNOWN_BUILD_TYPE}" STREQUAL ""))

check_c_source_compiles("
#ifndef __AES__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_AES)
set(${RESULT_PREFIX}_AES ${${RESULT_PREFIX}_FEATURE_AES} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __AVX__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_AVX)
set(${RESULT_PREFIX}_AVX ${${RESULT_PREFIX}_FEATURE_AVX} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __AVX2__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_AVX2)
set(${RESULT_PREFIX}_AVX2 ${${RESULT_PREFIX}_FEATURE_AVX2} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __AVX5124FMAPS__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_AVX5124FMAPS)
set(${RESULT_PREFIX}_AVX5124FMAPS ${${RESULT_PREFIX}_FEATURE_AVX5124FMAPS} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __AVX5124VNNIW__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_AVX5124VNNIW)
set(${RESULT_PREFIX}_AVX5124VNNIW ${${RESULT_PREFIX}_FEATURE_AVX5124VNNIW} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __AVX512BF16__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_AVX512BF16)
set(${RESULT_PREFIX}_AVX512BF16 ${${RESULT_PREFIX}_FEATURE_AVX512BF16} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __AVX512BITALG__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_AVX512BITALG)
set(${RESULT_PREFIX}_AVX512BITALG ${${RESULT_PREFIX}_FEATURE_AVX512BITALG} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __AVX512BW__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_AVX512BW)
set(${RESULT_PREFIX}_AVX512BW ${${RESULT_PREFIX}_FEATURE_AVX512BW} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __AVX512CD__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_AVX512CD)
set(${RESULT_PREFIX}_AVX512CD ${${RESULT_PREFIX}_FEATURE_AVX512CD} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __AVX512DQ__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_AVX512DQ)
set(${RESULT_PREFIX}_AVX512DQ ${${RESULT_PREFIX}_FEATURE_AVX512DQ} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __AVX512ER__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_AVX512ER)
set(${RESULT_PREFIX}_AVX512ER ${${RESULT_PREFIX}_FEATURE_AVX512ER} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __AVX512F__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_AVX512F)
set(${RESULT_PREFIX}_AVX512F ${${RESULT_PREFIX}_FEATURE_AVX512F} PARENT_SCOPE)
set(${RESULT_PREFIX}_AVX512 ${RESULT_PREFIX}_FEATURE_AVX512F PARENT_SCOPE)

check_c_source_compiles("
#ifndef __AVX512IFMA__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_AVX512IFMA)
set(${RESULT_PREFIX}_AVX512IFMA ${${RESULT_PREFIX}_FEATURE_AVX512IFMA} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __AVX512PF__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_AVX512PF)
set(${RESULT_PREFIX}_AVX512PF ${${RESULT_PREFIX}_FEATURE_AVX512PF} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __AVX512VBMI__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_AVX512VBMI)
set(${RESULT_PREFIX}_AVX512VBMI ${${RESULT_PREFIX}_FEATURE_AVX512VBMI} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __AVX512VBMI2__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_AVX512VBMI2)
set(${RESULT_PREFIX}_AVX512VBMI2 ${${RESULT_PREFIX}_FEATURE_AVX512VBMI2} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __AVX512VL__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_AVX512VL)
set(${RESULT_PREFIX}_AVX512VL ${${RESULT_PREFIX}_FEATURE_AVX512VL} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __AVX512VNNI__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_AVX512VNNI)
set(${RESULT_PREFIX}_AVX512VNNI ${${RESULT_PREFIX}_FEATURE_AVX512VNNI} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __AVX512VPOPCNTDQ__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_AVX512VPOPCNTDQ)
set(${RESULT_PREFIX}_AVX512VPOPCNTDQ ${${RESULT_PREFIX}_FEATURE_AVX512VPOPCNTDQ} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __BMI__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_BMI)
set(${RESULT_PREFIX}_BMI ${${RESULT_PREFIX}_FEATURE_BMI} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __BMI2__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_BMI2)
set(${RESULT_PREFIX}_BMI2 ${${RESULT_PREFIX}_FEATURE_BMI2} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __CMOV__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_CMOV)
set(${RESULT_PREFIX}_CMOV ${${RESULT_PREFIX}_FEATURE_CMOV} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __FMA__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_FMA)
set(${RESULT_PREFIX}_FMA ${${RESULT_PREFIX}_FEATURE_FMA} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __FMA4__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_FMA4)
set(${RESULT_PREFIX}_FMA4 ${${RESULT_PREFIX}_FEATURE_FMA4} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __GFNI__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_GFNI)
set(${RESULT_PREFIX}_GFNI ${${RESULT_PREFIX}_FEATURE_GFNI} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __MMX__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_MMX)
set(${RESULT_PREFIX}_MMX ${${RESULT_PREFIX}_FEATURE_MMX} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __PCLMUL__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_PCLMUL)
set(${RESULT_PREFIX}_PCLMUL ${${RESULT_PREFIX}_FEATURE_PCLMUL} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __POPCNT__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_POPCNT)
set(${RESULT_PREFIX}_POPCNT ${${RESULT_PREFIX}_FEATURE_POPCNT} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __SSE__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_SSE)
set(${RESULT_PREFIX}_SSE ${${RESULT_PREFIX}_FEATURE_SSE} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __SSE2__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_SSE2)
set(${RESULT_PREFIX}_SSE2 ${${RESULT_PREFIX}_FEATURE_SSE2} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __SSE3__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_SSE3)
set(${RESULT_PREFIX}_SSE3 ${${RESULT_PREFIX}_FEATURE_SSE3} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __SSE4_1__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_SSE4_1)
set(${RESULT_PREFIX}_SSE4_1 ${${RESULT_PREFIX}_FEATURE_SSE4_1} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __SSE4_2__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_SSE4_2)
set(${RESULT_PREFIX}_SSE4_2 ${${RESULT_PREFIX}_FEATURE_SSE4_2} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __SSE4_A__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_SSE4_A)
set(${RESULT_PREFIX}_SSE4_A ${${RESULT_PREFIX}_FEATURE_SSE4_A} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __SSSE3__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_SSSE3)
set(${RESULT_PREFIX}_SSSE3 ${${RESULT_PREFIX}_FEATURE_SSSE3} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __VPCLMULQDQ__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_VPCLMULQDQ)
set(${RESULT_PREFIX}_VPCLMULQDQ ${${RESULT_PREFIX}_FEATURE_VPCLMULQDQ} PARENT_SCOPE)

check_c_source_compiles("
#ifndef __XOP__
#error not supported
#endif

int main(void) {
    return 0;
}" ${RESULT_PREFIX}_FEATURE_XOP)
set(${RESULT_PREFIX}_XOP ${${RESULT_PREFIX}_FEATURE_XOP} PARENT_SCOPE)

else()
# else, use march=string to check feature capability

set(CLANG_FEATURE_MAP_AES bdver1 bdver2 bdver3 bdver4 broadwell btver2 cannonlake cascadelake cooperlake core-avx-i core-avx2 corei7-avx haswell ivybridge knl knm sandybridge skx skylake skylake-avx512 westmere znver1 znver2)
message(STATUS "Querying for ${marchName} AES...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AES)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} AES... - found")
        set(${RESULT_PREFIX}_AES YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX bdver1 bdver2 bdver3 bdver4 broadwell btver2 cannonlake cascadelake cooperlake core-avx-i core-avx2 corei7-avx haswell ivybridge knl knm sandybridge skx skylake skylake-avx512 znver1 znver2)
message(STATUS "Querying for ${marchName} AVX...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} AVX... - found")
        set(${RESULT_PREFIX}_AVX YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX2 bdver4 broadwell cannonlake cascadelake cooperlake core-avx2 haswell knl knm skx skylake skylake-avx512 znver1 znver2)
message(STATUS "Querying for ${marchName} AVX2...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX2)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} AVX2... - found")
        set(${RESULT_PREFIX}_AVX2 YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX5124FMAPS cascadelake cooperlake knm)
message(STATUS "Querying for ${marchName} AVX5124FMAPS...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX5124FMAPS)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} AVX5124FMAPS... - found")
        set(${RESULT_PREFIX}_AVX5124FMAPS YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX5124VNNIW cascadelake cooperlake knm)
message(STATUS "Querying for ${marchName} AVX5124VNNIW...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX5124VNNIW)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} AVX5124VNNIW... - found")
        set(${RESULT_PREFIX}_AVX5124VNNIW YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX512BF16 cooperlake)
message(STATUS "Querying for ${marchName} AVX512BF16...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX512BF16)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} AVX512BF16... - found")
        set(${RESULT_PREFIX}_AVX512BF16 YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX512BITALG cooperlake)
message(STATUS "Querying for ${marchName} AVX512BITALG...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX512BITALG)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} AVX512BITALG... - found")
        set(${RESULT_PREFIX}_AVX512BITALG YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX512BW cannonlake cascadelake cooperlake knm)
message(STATUS "Querying for ${marchName} AVX512BW...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX512BW)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} AVX512BW... - found")
        set(${RESULT_PREFIX}_AVX512BW YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX512CD cannonlake cascadelake cooperlake knm)
message(STATUS "Querying for ${marchName} AVX512CD...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX512CD)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} AVX512CD... - found")
        set(${RESULT_PREFIX}_AVX512CD YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX512DQ cannonlake cascadelake cooperlake knm)
message(STATUS "Querying for ${marchName} AVX512DQ...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX512DQ)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} AVX512DQ... - found")
        set(${RESULT_PREFIX}_AVX512DQ YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX512ER cannonlake cascadelake cooperlake knm)
message(STATUS "Querying for ${marchName} AVX512ER...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX512ER)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} AVX512ER... - found")
        set(${RESULT_PREFIX}_AVX512ER YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX512F cannonlake cascadelake cooperlake knl knm skx skylake-avx512)
message(STATUS "Querying for ${marchName} AVX512F...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX512F)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} AVX512F... - found")
        set(${RESULT_PREFIX}_AVX512F YES PARENT_SCOPE)
        set(${RESULT_PREFIX}_AVX512 YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX512IFMA cascadelake cooperlake knm)
message(STATUS "Querying for ${marchName} AVX512IFMA...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX512IFMA)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} AVX512IFMA... - found")
        set(${RESULT_PREFIX}_AVX512IFMA YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX512PF cannonlake cascadelake cooperlake knm)
message(STATUS "Querying for ${marchName} AVX512PF...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX512PF)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} AVX512PF... - found")
        set(${RESULT_PREFIX}_AVX512PF YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX512VBMI cannonlake cascadelake cooperlake knm)
message(STATUS "Querying for ${marchName} AVX512VBMI...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX512VBMI)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} AVX512VBMI... - found")
        set(${RESULT_PREFIX}_AVX512VBMI YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX512VBMI2 cascadelake cooperlake)
message(STATUS "Querying for ${marchName} AVX512VBMI2...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX512VBMI2)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} AVX512VBMI2... - found")
        set(${RESULT_PREFIX}_AVX512VBMI2 YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX512VL cannonlake cascadelake cooperlake knm)
message(STATUS "Querying for ${marchName} AVX512VL...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX512VL)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} AVX512VL... - found")
        set(${RESULT_PREFIX}_AVX512VL YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX512VNNI cascadelake cooperlake)
message(STATUS "Querying for ${marchName} AVX512VNNI...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX512VNNI)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} AVX512VNNI... - found")
        set(${RESULT_PREFIX}_AVX512VNNI YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX512VPOPCNTDQ cascadelake cooperlake)
message(STATUS "Querying for ${marchName} AVX512VPOPCNTDQ...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX512VPOPCNTDQ)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} AVX512VPOPCNTDQ... - found")
        set(${RESULT_PREFIX}_AVX512VPOPCNTDQ YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_BMI bdver1 bdver2 bdver3 bdver4 broadwell btver2 cannonlake cascadelake cooperlake core-avx2 haswell knl knm skx skylake skylake-avx512 znver1 znver2)
message(STATUS "Querying for ${marchName} BMI...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_BMI)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} BMI... - found")
        set(${RESULT_PREFIX}_BMI YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_BMI2 bdver4 broadwell cannonlake cascadelake cooperlake core-avx2 haswell knl knm skx skylake skylake-avx512 znver1 znver2)
message(STATUS "Querying for ${marchName} BMI2...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_BMI2)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} BMI2... - found")
        set(${RESULT_PREFIX}_BMI2 YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_CMOV amdfam10 atom barcelona bdver1 bdver2 bdver3 bdver4 bonnell broadwell btver1 btver2 cannonlake cascadelake cooperlake core-avx-i core-avx2 core2 corei7 corei7-avx haswell ivybridge knl knm nehalem sandybridge silvermont skx skylake skylake-avx512 slm westmere znver1 znver2)
message(STATUS "Querying for ${marchName} CMOV...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_CMOV)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} CMOV... - found")
        set(${RESULT_PREFIX}_CMOV YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_FMA bdver2 bdver3 bdver4 broadwell cannonlake cascadelake cooperlake core-avx2 haswell knl knm skx skylake skylake-avx512 znver1 znver2)
message(STATUS "Querying for ${marchName} FMA...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_FMA)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} FMA... - found")
        set(${RESULT_PREFIX}_FMA YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_FMA4 bdver1 bdver2 bdver3 bdver4 broadwell cannonlake cascadelake cooperlake core-avx2 haswell knl knm skx skylake skylake-avx512 znver1 znver2)
message(STATUS "Querying for ${marchName} FMA4...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_FMA4)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} FMA4... - found")
        set(${RESULT_PREFIX}_FMA4 YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_GFNI cascadelake cooperlake)
message(STATUS "Querying for ${marchName} GFNI...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_GFNI)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} GFNI... - found")
        set(${RESULT_PREFIX}_GFNI YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_MMX amdfam10 atom barcelona bdver1 bdver2 bdver3 bdver4 bonnell broadwell btver1 btver2 cannonlake cascadelake cooperlake core-avx-i core-avx2 core2 corei7 corei7-avx haswell ivybridge knl knm nehalem sandybridge silvermont skx skylake skylake-avx512 slm westmere znver1 znver2)
message(STATUS "Querying for ${marchName} MMX...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_MMX)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} MMX... - found")
        set(${RESULT_PREFIX}_MMX YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_PCLMUL bdver1 bdver2 bdver3 bdver4 broadwell btver2 cannonlake cascadelake cooperlake core-avx-i core-avx2 corei7-avx haswell ivybridge knl knm sandybridge skx skylake skylake-avx512 westmere znver1 znver2)
message(STATUS "Querying for ${marchName} PCLMUL...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_PCLMUL)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} PCLMUL... - found")
        set(${RESULT_PREFIX}_PCLMUL YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_POPCNT bdver1 bdver2 bdver3 bdver4 broadwell btver2 cannonlake cascadelake cooperlake core-avx-i core-avx2 corei7-avx haswell ivybridge knl knm sandybridge skx skylake skylake-avx512 westmere znver1 znver2)
message(STATUS "Querying for ${marchName} POPCNT...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_POPCNT)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} POPCNT... - found")
        set(${RESULT_PREFIX}_POPCNT YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_SSE amdfam10 atom barcelona bdver1 bdver2 bdver3 bdver4 bonnell broadwell btver1 btver2 cannonlake cascadelake cooperlake core-avx-i core-avx2 core2 corei7 corei7-avx haswell ivybridge knl knm nehalem sandybridge silvermont skx skylake skylake-avx512 slm westmere znver1 znver2)
message(STATUS "Querying for ${marchName} SSE...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_SSE)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} SSE... - found")
        set(${RESULT_PREFIX}_SSE YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_SSE2 amdfam10 atom barcelona bdver1 bdver2 bdver3 bdver4 bonnell broadwell btver1 btver2 cannonlake cascadelake cooperlake core-avx-i core-avx2 core2 corei7 corei7-avx haswell ivybridge knl knm nehalem sandybridge silvermont skx skylake skylake-avx512 slm westmere znver1 znver2)
message(STATUS "Querying for ${marchName} SSE2...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_SSE2)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} SSE2... - found")
        set(${RESULT_PREFIX}_SSE2 YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_SSE3 amdfam10 atom barcelona bdver1 bdver2 bdver3 bdver4 bonnell broadwell btver1 btver2 cannonlake cascadelake cooperlake core-avx-i core-avx2 core2 corei7 corei7-avx haswell ivybridge knl knm nehalem sandybridge silvermont skx skylake skylake-avx512 slm westmere znver1 znver2)
message(STATUS "Querying for ${marchName} SSE3...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_SSE3)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} SSE3... - found")
        set(${RESULT_PREFIX}_SSE3 YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_SSE4_1 bdver1 bdver2 bdver3 bdver4 broadwell btver2 cannonlake cascadelake cooperlake core-avx-i core-avx2 corei7 corei7-avx haswell ivybridge knl knm nehalem sandybridge silvermont skx skylake skylake-avx512 slm westmere znver1 znver2)
message(STATUS "Querying for ${marchName} SSE4_1...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_SSE4_1)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} SSE4_1... - found")
        set(${RESULT_PREFIX}_SSE4_1 YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_SSE4_2 bdver1 bdver2 bdver3 bdver4 broadwell btver2 cannonlake cascadelake cooperlake core-avx-i core-avx2 corei7 corei7-avx haswell ivybridge knl knm nehalem sandybridge silvermont skx skylake skylake-avx512 slm westmere znver1 znver2)
message(STATUS "Querying for ${marchName} SSE4_2...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_SSE4_2)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} SSE4_2... - found")
        set(${RESULT_PREFIX}_SSE4_2 YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_SSE4_A amdfam10 barcelona bdver1 bdver2 bdver3 bdver4 broadwell btver1 btver2 cannonlake cascadelake cooperlake core-avx-i core-avx2 corei7 corei7-avx haswell ivybridge knl knm nehalem sandybridge silvermont skx skylake skylake-avx512 slm westmere znver1 znver2)
message(STATUS "Querying for ${marchName} SSE4_A...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_SSE4_A)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} SSE4_A... - found")
        set(${RESULT_PREFIX}_SSE4_A YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_SSSE3 amdfam10 atom barcelona bdver1 bdver2 bdver3 bdver4 bonnell broadwell btver1 btver2 cannonlake cascadelake cooperlake core-avx-i core-avx2 core2 corei7 corei7-avx haswell ivybridge knl knm nehalem sandybridge silvermont skx skylake skylake-avx512 slm westmere znver1 znver2)
message(STATUS "Querying for ${marchName} SSSE3...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_SSSE3)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} SSSE3... - found")
        set(${RESULT_PREFIX}_SSSE3 YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_VPCLMULQDQ cascadelake cooperlake)
message(STATUS "Querying for ${marchName} VPCLMULQDQ...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_VPCLMULQDQ)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} VPCLMULQDQ... - found")
        set(${RESULT_PREFIX}_VPCLMULQDQ YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

set(CLANG_FEATURE_MAP_XOP bdver1 bdver2 bdver3 bdver4 broadwell cannonlake cascadelake cooperlake core-avx2 haswell knl knm skx skylake skylake-avx512 znver1 znver2)
message(STATUS "Querying for ${marchName} XOP...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_XOP)
    if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
        message(STATUS "Querying for ${marchName} XOP... - found")
        set(${RESULT_PREFIX}_XOP YES PARENT_SCOPE)
    endif()
set(CMAKE_REQUIRED_FLAGS)
endforeach(marchName)

endif()
endfunction()
