cmake_minimum_required (VERSION 3.18)

project (deps-usage-example)

set (CMAKE_VERBOSE_MAKEFILE ON)
set (CMAKE_POSITION_INDEPENDENT_CODE ON)

if (NOT THIRD_PARTY_DEPS_URL)
	message (FATAL_ERROR "variable THIRD_PARTY_DEPS_URL not specified; \
	eg.: -DTHIRD_PARTY_DEPS_URL=file:///opt/third_party_cpp_deps.tar.gz")
endif ()

if (NOT THIRD_PARTY_DEPS_URL_SHA256)
	message (FATAL_ERROR "variable THIRD_PARTY_DEPS_URL_SHA256 not specified; \
	eg.: -DTHIRD_PARTY_DEPS_URL_SHA256=582ab8a9d35b1743246c6e40d77d8373a63befbb873f23fbe6a16579a623ba64")
endif ()

include (FetchContent)

set (THIRD_PARTY_DEPS "thirdpartydeps")
FetchContent_Declare (${THIRD_PARTY_DEPS}
	URL "${THIRD_PARTY_DEPS_URL}"
	URL_HASH SHA256=${THIRD_PARTY_DEPS_URL_SHA256}
)

FetchContent_GetProperties (${THIRD_PARTY_DEPS})

if (NOT ${THIRD_PARTY_DEPS}_POPULATED)
	FetchContent_Populate (${THIRD_PARTY_DEPS})
endif ()

set (THIRD_PARTY_DEPS_DIR "${${THIRD_PARTY_DEPS}_SOURCE_DIR}")

include ("${THIRD_PARTY_DEPS_DIR}/third_party_cpp_deps.cmake")

add_subdirectory (global-deps)
add_subdirectory (per-target-deps)
