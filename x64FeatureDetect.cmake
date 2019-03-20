# Created: 2019-03-20 15:05:25.387858
# generated by parsing clang X86Target.def CPU definitions
include(CheckSymbolExists)

# Helper to generate final flags given current build type...
function(genFinalFlags RESULT_PREFIX)
# CMake doesn't have any case insensitive string compares, so nudge BUILD_TYPE:
string(TOUPPER "${CMAKE_BUILD_TYPE}" KNOWN_BUILD_TYPE)
set(FLAGS ${CMAKE_C_FLAGS} ${CMAKE_CXX_FLAGS})
if (KNOWN_BUILD_TYPE MATCHES DEBUG)
    string(APPEND FLAGS ${CMAKE_C_FLAGS_DEBUG} ${CMAKE_CXX_FLAGS_DEBUG})
elseif(KNOWN_BUILD_TYPE MATCHES RELEASE)
    string(APPEND FLAGS ${CMAKE_C_FLAGS_RELEASE} ${CMAKE_CXX_FLAGS_RELEASE})
elseif(KNOWN_BUILD_TYPE MATCHES RELWITHDEBINFO)
    string(APPEND FLAGS ${CMAKE_C_FLAGS_RELWITHDEBINFO} ${CMAKE_CXX_FLAGS_RELWITHDEBINFO})
elseif(KNOWN_BUILD_TYPE MATCHES MINSIZEREL)
    string(APPEND FLAGS ${CMAKE_C_FLAGS_MINSIZEREL} ${CMAKE_CXX_FLAGS_MINSIZEREL})
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
# CMake doesn't have any case insensitive string compares, so nudge BUILD_TYPE:
string(TOUPPER "${CMAKE_BUILD_TYPE}" KNOWN_BUILD_TYPE)
genFinalFlags(BUILDING)

# If using native or no march, use feature detection (result perma-cached)
if (("${BUILDING_FLAGS}" MATCHES "march=native") OR
    (NOT "${BUILDING_FLAGS}" MATCHES "march=") OR
    ("${KNOWN_BUILD_TYPE}" STREQUAL ""))

message(STATUS "Checking for AVX512VL...")
CHECK_SYMBOL_EXISTS(__AVX512VL__ stdlib.h CLANG_FEATURE_DETECTED_AVX512VL)
set(${RESULT_PREFIX}_AVX512VL CLANG_FEATURE_DETECTED_AVX512VL PARENT_SCOPE)

message(STATUS "Checking for AVX512BW...")
CHECK_SYMBOL_EXISTS(__AVX512BW__ stdlib.h CLANG_FEATURE_DETECTED_AVX512BW)
set(${RESULT_PREFIX}_AVX512BW CLANG_FEATURE_DETECTED_AVX512BW PARENT_SCOPE)

message(STATUS "Checking for AVX512DQ...")
CHECK_SYMBOL_EXISTS(__AVX512DQ__ stdlib.h CLANG_FEATURE_DETECTED_AVX512DQ)
set(${RESULT_PREFIX}_AVX512DQ CLANG_FEATURE_DETECTED_AVX512DQ PARENT_SCOPE)

message(STATUS "Checking for AVX512CD...")
CHECK_SYMBOL_EXISTS(__AVX512CD__ stdlib.h CLANG_FEATURE_DETECTED_AVX512CD)
set(${RESULT_PREFIX}_AVX512CD CLANG_FEATURE_DETECTED_AVX512CD PARENT_SCOPE)

message(STATUS "Checking for AVX512ER...")
CHECK_SYMBOL_EXISTS(__AVX512ER__ stdlib.h CLANG_FEATURE_DETECTED_AVX512ER)
set(${RESULT_PREFIX}_AVX512ER CLANG_FEATURE_DETECTED_AVX512ER PARENT_SCOPE)

message(STATUS "Checking for AVX512PF...")
CHECK_SYMBOL_EXISTS(__AVX512PF__ stdlib.h CLANG_FEATURE_DETECTED_AVX512PF)
set(${RESULT_PREFIX}_AVX512PF CLANG_FEATURE_DETECTED_AVX512PF PARENT_SCOPE)

message(STATUS "Checking for AVX512VBMI...")
CHECK_SYMBOL_EXISTS(__AVX512VBMI__ stdlib.h CLANG_FEATURE_DETECTED_AVX512VBMI)
set(${RESULT_PREFIX}_AVX512VBMI CLANG_FEATURE_DETECTED_AVX512VBMI PARENT_SCOPE)

message(STATUS "Checking for CMOV...")
CHECK_SYMBOL_EXISTS(__CMOV__ stdlib.h CLANG_FEATURE_DETECTED_CMOV)
set(${RESULT_PREFIX}_CMOV CLANG_FEATURE_DETECTED_CMOV PARENT_SCOPE)

message(STATUS "Checking for MMX...")
CHECK_SYMBOL_EXISTS(__MMX__ stdlib.h CLANG_FEATURE_DETECTED_MMX)
set(${RESULT_PREFIX}_MMX CLANG_FEATURE_DETECTED_MMX PARENT_SCOPE)

message(STATUS "Checking for SSE...")
CHECK_SYMBOL_EXISTS(__SSE__ stdlib.h CLANG_FEATURE_DETECTED_SSE)
set(${RESULT_PREFIX}_SSE CLANG_FEATURE_DETECTED_SSE PARENT_SCOPE)

message(STATUS "Checking for SSE2...")
CHECK_SYMBOL_EXISTS(__SSE2__ stdlib.h CLANG_FEATURE_DETECTED_SSE2)
set(${RESULT_PREFIX}_SSE2 CLANG_FEATURE_DETECTED_SSE2 PARENT_SCOPE)

message(STATUS "Checking for SSE3...")
CHECK_SYMBOL_EXISTS(__SSE3__ stdlib.h CLANG_FEATURE_DETECTED_SSE3)
set(${RESULT_PREFIX}_SSE3 CLANG_FEATURE_DETECTED_SSE3 PARENT_SCOPE)

message(STATUS "Checking for SSSE3...")
CHECK_SYMBOL_EXISTS(__SSSE3__ stdlib.h CLANG_FEATURE_DETECTED_SSSE3)
set(${RESULT_PREFIX}_SSSE3 CLANG_FEATURE_DETECTED_SSSE3 PARENT_SCOPE)

message(STATUS "Checking for FMA4...")
CHECK_SYMBOL_EXISTS(__FMA4__ stdlib.h CLANG_FEATURE_DETECTED_FMA4)
set(${RESULT_PREFIX}_FMA4 CLANG_FEATURE_DETECTED_FMA4 PARENT_SCOPE)

message(STATUS "Checking for XOP...")
CHECK_SYMBOL_EXISTS(__XOP__ stdlib.h CLANG_FEATURE_DETECTED_XOP)
set(${RESULT_PREFIX}_XOP CLANG_FEATURE_DETECTED_XOP PARENT_SCOPE)

message(STATUS "Checking for FMA...")
CHECK_SYMBOL_EXISTS(__FMA__ stdlib.h CLANG_FEATURE_DETECTED_FMA)
set(${RESULT_PREFIX}_FMA CLANG_FEATURE_DETECTED_FMA PARENT_SCOPE)

message(STATUS "Checking for BMI2...")
CHECK_SYMBOL_EXISTS(__BMI2__ stdlib.h CLANG_FEATURE_DETECTED_BMI2)
set(${RESULT_PREFIX}_BMI2 CLANG_FEATURE_DETECTED_BMI2 PARENT_SCOPE)

message(STATUS "Checking for AVX2...")
CHECK_SYMBOL_EXISTS(__AVX2__ stdlib.h CLANG_FEATURE_DETECTED_AVX2)
set(${RESULT_PREFIX}_AVX2 CLANG_FEATURE_DETECTED_AVX2 PARENT_SCOPE)

message(STATUS "Checking for BMI...")
CHECK_SYMBOL_EXISTS(__BMI__ stdlib.h CLANG_FEATURE_DETECTED_BMI)
set(${RESULT_PREFIX}_BMI CLANG_FEATURE_DETECTED_BMI PARENT_SCOPE)

message(STATUS "Checking for AVX512IFMA...")
CHECK_SYMBOL_EXISTS(__AVX512IFMA__ stdlib.h CLANG_FEATURE_DETECTED_AVX512IFMA)
set(${RESULT_PREFIX}_AVX512IFMA CLANG_FEATURE_DETECTED_AVX512IFMA PARENT_SCOPE)

message(STATUS "Checking for AVX5124VNNIW...")
CHECK_SYMBOL_EXISTS(__AVX5124VNNIW__ stdlib.h CLANG_FEATURE_DETECTED_AVX5124VNNIW)
set(${RESULT_PREFIX}_AVX5124VNNIW CLANG_FEATURE_DETECTED_AVX5124VNNIW PARENT_SCOPE)

message(STATUS "Checking for AVX5124FMAPS...")
CHECK_SYMBOL_EXISTS(__AVX5124FMAPS__ stdlib.h CLANG_FEATURE_DETECTED_AVX5124FMAPS)
set(${RESULT_PREFIX}_AVX5124FMAPS CLANG_FEATURE_DETECTED_AVX5124FMAPS PARENT_SCOPE)

message(STATUS "Checking for AVX...")
CHECK_SYMBOL_EXISTS(__AVX__ stdlib.h CLANG_FEATURE_DETECTED_AVX)
set(${RESULT_PREFIX}_AVX CLANG_FEATURE_DETECTED_AVX PARENT_SCOPE)

message(STATUS "Checking for SSE4_A...")
CHECK_SYMBOL_EXISTS(__SSE4_A__ stdlib.h CLANG_FEATURE_DETECTED_SSE4_A)
set(${RESULT_PREFIX}_SSE4_A CLANG_FEATURE_DETECTED_SSE4_A PARENT_SCOPE)

message(STATUS "Checking for SSE4_1...")
CHECK_SYMBOL_EXISTS(__SSE4_1__ stdlib.h CLANG_FEATURE_DETECTED_SSE4_1)
set(${RESULT_PREFIX}_SSE4_1 CLANG_FEATURE_DETECTED_SSE4_1 PARENT_SCOPE)

message(STATUS "Checking for SSE4_2...")
CHECK_SYMBOL_EXISTS(__SSE4_2__ stdlib.h CLANG_FEATURE_DETECTED_SSE4_2)
set(${RESULT_PREFIX}_SSE4_2 CLANG_FEATURE_DETECTED_SSE4_2 PARENT_SCOPE)

message(STATUS "Checking for AVX512F...")
CHECK_SYMBOL_EXISTS(__AVX512F__ stdlib.h CLANG_FEATURE_DETECTED_AVX512F)
set(${RESULT_PREFIX}_AVX512F CLANG_FEATURE_DETECTED_AVX512F PARENT_SCOPE)
set(${RESULT_PREFIX}_AVX512 CLANG_FEATURE_DETECTED_AVX512F PARENT_SCOPE)

message(STATUS "Checking for POPCNT...")
CHECK_SYMBOL_EXISTS(__POPCNT__ stdlib.h CLANG_FEATURE_DETECTED_POPCNT)
set(${RESULT_PREFIX}_POPCNT CLANG_FEATURE_DETECTED_POPCNT PARENT_SCOPE)

message(STATUS "Checking for AES...")
CHECK_SYMBOL_EXISTS(__AES__ stdlib.h CLANG_FEATURE_DETECTED_AES)
set(${RESULT_PREFIX}_AES CLANG_FEATURE_DETECTED_AES PARENT_SCOPE)

message(STATUS "Checking for PCLMUL...")
CHECK_SYMBOL_EXISTS(__PCLMUL__ stdlib.h CLANG_FEATURE_DETECTED_PCLMUL)
set(${RESULT_PREFIX}_PCLMUL CLANG_FEATURE_DETECTED_PCLMUL PARENT_SCOPE)

else()
# else, use march=string to check feature capability

set(CLANG_FEATURE_MAP_AVX512VL cannonlake knm)
message(STATUS "Querying for AVX512VL...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX512VL)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_AVX512VL True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX512BW cannonlake knm)
message(STATUS "Querying for AVX512BW...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX512BW)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_AVX512BW True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX512DQ cannonlake knm)
message(STATUS "Querying for AVX512DQ...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX512DQ)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_AVX512DQ True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX512CD cannonlake knm)
message(STATUS "Querying for AVX512CD...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX512CD)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_AVX512CD True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX512ER cannonlake knm)
message(STATUS "Querying for AVX512ER...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX512ER)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_AVX512ER True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX512PF cannonlake knm)
message(STATUS "Querying for AVX512PF...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX512PF)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_AVX512PF True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX512VBMI cannonlake knm)
message(STATUS "Querying for AVX512VBMI...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX512VBMI)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_AVX512VBMI True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_CMOV core2 bonnell atom silvermont slm nehalem corei7 westmere sandybridge corei7-avx ivybridge core-avx-i haswell core-avx2 broadwell skylake skylake-avx512 skx cannonlake knl knm amdfam10 barcelona btver1 btver2 bdver1 bdver2 bdver3 bdver4 znver1)
message(STATUS "Querying for CMOV...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_CMOV)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_CMOV True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_MMX core2 bonnell atom silvermont slm nehalem corei7 westmere sandybridge corei7-avx ivybridge core-avx-i haswell core-avx2 broadwell skylake skylake-avx512 skx cannonlake knl knm amdfam10 barcelona btver1 btver2 bdver1 bdver2 bdver3 bdver4 znver1)
message(STATUS "Querying for MMX...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_MMX)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_MMX True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_SSE core2 bonnell atom silvermont slm nehalem corei7 westmere sandybridge corei7-avx ivybridge core-avx-i haswell core-avx2 broadwell skylake skylake-avx512 skx cannonlake knl knm amdfam10 barcelona btver1 btver2 bdver1 bdver2 bdver3 bdver4 znver1)
message(STATUS "Querying for SSE...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_SSE)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_SSE True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_SSE2 core2 bonnell atom silvermont slm nehalem corei7 westmere sandybridge corei7-avx ivybridge core-avx-i haswell core-avx2 broadwell skylake skylake-avx512 skx cannonlake knl knm amdfam10 barcelona btver1 btver2 bdver1 bdver2 bdver3 bdver4 znver1)
message(STATUS "Querying for SSE2...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_SSE2)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_SSE2 True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_SSE3 core2 bonnell atom silvermont slm nehalem corei7 westmere sandybridge corei7-avx ivybridge core-avx-i haswell core-avx2 broadwell skylake skylake-avx512 skx cannonlake knl knm amdfam10 barcelona btver1 btver2 bdver1 bdver2 bdver3 bdver4 znver1)
message(STATUS "Querying for SSE3...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_SSE3)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_SSE3 True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_SSSE3 core2 bonnell atom silvermont slm nehalem corei7 westmere sandybridge corei7-avx ivybridge core-avx-i haswell core-avx2 broadwell skylake skylake-avx512 skx cannonlake knl knm amdfam10 barcelona btver1 btver2 bdver1 bdver2 bdver3 bdver4 znver1)
message(STATUS "Querying for SSSE3...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_SSSE3)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_SSSE3 True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_FMA4 haswell core-avx2 broadwell skylake skylake-avx512 skx cannonlake knl knm bdver1 bdver2 bdver3 bdver4 znver1)
message(STATUS "Querying for FMA4...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_FMA4)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_FMA4 True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_XOP haswell core-avx2 broadwell skylake skylake-avx512 skx cannonlake knl knm bdver1 bdver2 bdver3 bdver4 znver1)
message(STATUS "Querying for XOP...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_XOP)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_XOP True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_FMA haswell core-avx2 broadwell skylake skylake-avx512 skx cannonlake knl knm bdver2 bdver3 bdver4 znver1)
message(STATUS "Querying for FMA...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_FMA)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_FMA True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_BMI2 haswell core-avx2 broadwell skylake skylake-avx512 skx cannonlake knl knm bdver4 znver1)
message(STATUS "Querying for BMI2...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_BMI2)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_BMI2 True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX2 haswell core-avx2 broadwell skylake skylake-avx512 skx cannonlake knl knm bdver4 znver1)
message(STATUS "Querying for AVX2...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX2)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_AVX2 True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_BMI haswell core-avx2 broadwell skylake skylake-avx512 skx cannonlake knl knm btver2 bdver1 bdver2 bdver3 bdver4 znver1)
message(STATUS "Querying for BMI...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_BMI)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_BMI True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX512IFMA knm)
message(STATUS "Querying for AVX512IFMA...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX512IFMA)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_AVX512IFMA True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX5124VNNIW knm)
message(STATUS "Querying for AVX5124VNNIW...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX5124VNNIW)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_AVX5124VNNIW True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX5124FMAPS knm)
message(STATUS "Querying for AVX5124FMAPS...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX5124FMAPS)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_AVX5124FMAPS True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX sandybridge corei7-avx ivybridge core-avx-i haswell core-avx2 broadwell skylake skylake-avx512 skx cannonlake knl knm btver2 bdver1 bdver2 bdver3 bdver4 znver1)
message(STATUS "Querying for AVX...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_AVX True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_SSE4_A silvermont slm nehalem corei7 westmere sandybridge corei7-avx ivybridge core-avx-i haswell core-avx2 broadwell skylake skylake-avx512 skx cannonlake knl knm amdfam10 barcelona btver1 btver2 bdver1 bdver2 bdver3 bdver4 znver1)
message(STATUS "Querying for SSE4_A...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_SSE4_A)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_SSE4_A True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_SSE4_1 silvermont slm nehalem corei7 westmere sandybridge corei7-avx ivybridge core-avx-i haswell core-avx2 broadwell skylake skylake-avx512 skx cannonlake knl knm btver2 bdver1 bdver2 bdver3 bdver4 znver1)
message(STATUS "Querying for SSE4_1...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_SSE4_1)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_SSE4_1 True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_SSE4_2 silvermont slm nehalem corei7 westmere sandybridge corei7-avx ivybridge core-avx-i haswell core-avx2 broadwell skylake skylake-avx512 skx cannonlake knl knm btver2 bdver1 bdver2 bdver3 bdver4 znver1)
message(STATUS "Querying for SSE4_2...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_SSE4_2)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_SSE4_2 True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_AVX512F skylake-avx512 skx cannonlake knl knm)
message(STATUS "Querying for AVX512F...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AVX512F)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_AVX512F True PARENT_SCOPE)
set(${RESULT_PREFIX}_AVX512 True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_POPCNT westmere sandybridge corei7-avx ivybridge core-avx-i haswell core-avx2 broadwell skylake skylake-avx512 skx cannonlake knl knm btver2 bdver1 bdver2 bdver3 bdver4 znver1)
message(STATUS "Querying for POPCNT...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_POPCNT)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_POPCNT True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_AES westmere sandybridge corei7-avx ivybridge core-avx-i haswell core-avx2 broadwell skylake skylake-avx512 skx cannonlake knl knm btver2 bdver1 bdver2 bdver3 bdver4 znver1)
message(STATUS "Querying for AES...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_AES)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_AES True PARENT_SCOPE)
endif()
endforeach(marchName)

set(CLANG_FEATURE_MAP_PCLMUL westmere sandybridge corei7-avx ivybridge core-avx-i haswell core-avx2 broadwell skylake skylake-avx512 skx cannonlake knl knm btver2 bdver1 bdver2 bdver3 bdver4 znver1)
message(STATUS "Querying for PCLMUL...")
foreach(marchName IN LISTS CLANG_FEATURE_MAP_PCLMUL)
if ("${BUILDING_FLAGS}" MATCHES "march=${marchName}")
set(${RESULT_PREFIX}_PCLMUL True PARENT_SCOPE)
endif()
endforeach(marchName)

endif()
endfunction(genCPUFeatures)
