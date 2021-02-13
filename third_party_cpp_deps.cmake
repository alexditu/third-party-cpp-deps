set (SPDLOG_EP spdlog-ep)
set (NLOHMANN_JSON_EP nlohmann-json-ep)
set (MONGO_C_DRIVER_EP mongo-c-driver-ep)
set (MONGO_CXX_DRIVER_EP mongo-cxx-driver-ep)

set (ALL_THIRD_PARTY_EP_LIST ${SPDLOG_EP} ${NLOHMANN_JSON_EP} ${MONGO_C_DRIVER_EP} ${MONGO_CXX_DRIVER_EP})



#
# param TARGET  : target to wich to add the include directory
# param TYPE    : type of include, one of: PRIVATE | PUBLIC
# param DEP_NAME: name of the dependency as specified to ExternalProject_Add (eg.: spdlog-ep)
# param BASE_DIR: directory of third party deps sources dir
#
function (add_third_party_include_dir TARGET TYPE DEP_NAME BASE_DIR)
	target_include_directories (${TARGET} ${TYPE} "${BASE_DIR}/${DEP_NAME}/include")
endfunction ()

#
# param TARGET  : target to wich to add the include directory
# param TYPE    : type of include, one of: PRIVATE | PUBLIC
# param DEP_NAME: name of the dependency as specified to ExternalProject_Add (eg.: spdlog-ep)
# param BASE_DIR: directory of third party deps sources dir
#
function (add_third_party_lib_dir TARGET TYPE DEP_NAME BASE_DIR)
	target_link_directories (${TARGET} ${TYPE} "${BASE_DIR}/${DEP_NAME}/lib")
endfunction ()

#
# param BASE_DIR: directory of third party deps sources dir
#
function (add_third_global_include_dir BASE_DIR)
	file (GLOB deps "${BASE_DIR}/*")
	foreach (dep ${deps})
		if (IS_DIRECTORY ${dep})
			include_directories ("${dep}/include")
		endif ()
	endforeach ()
endfunction ()

#
# param BASE_DIR: directory of third party deps sources dir
#
function (add_third_global_lib_dir BASE_DIR)
	file (GLOB deps "${BASE_DIR}/*")
	foreach (dep ${deps})
		if (IS_DIRECTORY ${dep})
			link_directories ("${dep}/lib")
		endif ()
	endforeach ()
endfunction ()

#[[
Usage example:

In other cpp project add the following cmake code:

include (FetchContent)

set (THIRD_PARTY_DEPS "thirdpartydeps")
FetchContent_Declare (${THIRD_PARTY_DEPS}
	URL "file:///third-party-cpp-deps/builddir/third_party_cpp_deps.tar.gz"
	URL_HASH SHA256=6a1e1098c16ea9f05e2b9f13fe31ebc209c8e5ad4cca4e5fa06fd5422a68b6eb
)

FetchContent_GetProperties (${THIRD_PARTY_DEPS})

if (NOT ${THIRD_PARTY_DEPS}_POPULATED)
	FetchContent_Populate (${THIRD_PARTY_DEPS})
endif ()

set (THIRD_PARTY_DEPS_DIR "${${THIRD_PARTY_DEPS}_SOURCE_DIR}")
include ("${THIRD_PARTY_DEPS_DIR}/third_party_cpp_deps.cmake")

# now you can add third party deps:

# for global dependencies:
add_third_global_include_dir (${THIRD_PARTY_DEPS_DIR})
add_third_global_lib_dir (${THIRD_PARTY_DEPS_DIR})

# for per target dependencies:
add_third_party_include_dir (main PRIVATE spdlog-ep ${THIRD_PARTY_DEPS_DIR})
add_third_party_lib_dir (main PRIVATE spdlog-ep ${THIRD_PARTY_DEPS_DIR})

#]]
