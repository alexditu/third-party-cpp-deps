cmake_minimum_required (VERSION 3.18)

project (third-party-cpp-deps)

include (ExternalProject)

set (CMAKE_VERBOSE_MAKEFILE ON)
set (CMAKE_POSITION_INDEPENDENT_CODE ON)

set (EP_OUTPUT_DIR "${CMAKE_BINARY_DIR}/tmp")

function (install_ep DEP_NAME)
	install (DIRECTORY ${EP_OUTPUT_DIR}/${DEP_NAME} DESTINATION ".")
endfunction ()

function (install_all_ep)
	foreach (ep ${ALL_THIRD_PARTY_EP_LIST})
		install_ep(${ep})
	endforeach ()
endfunction ()

#
# IMPORTANT: update this list while adding new dependencies
#
include (third_party_cpp_deps.cmake)

######################################## all external deps go here ########################################

set (EP ${SPDLOG_EP})
ExternalProject_Add (${SPDLOG_EP}
	PREFIX ${EP}
	URL https://github.com/gabime/spdlog/archive/v1.8.2.tar.gz
	URL_HASH SHA256=e20e6bd8f57e866eaf25a5417f0a38a116e537f1a77ac7b5409ca2b180cec0d5
	CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${EP_OUTPUT_DIR}/${EP}
)

set (EP ${NLOHMANN_JSON_EP})
ExternalProject_Add (${EP}
	PREFIX ${EP}
	URL https://github.com/nlohmann/json/archive/v3.9.1.zip
	URL_HASH SHA256=a88449d68aab8d027c5beefe911ba217f5ffcc0686ae1793d37f3d20698b37c6
	CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${EP_OUTPUT_DIR}/${EP} -DBUILD_TESTING=OFF
)

################################################ end ######################################################

# install all external projects
install_all_ep ()

# export needed for consumer files
install (FILES third_party_cpp_deps.cmake DESTINATION ".")

# set (DEPS_EXPORT_NAME "third-party-cpp-deps")
# install (EXPORT ${DEPS_EXPORT_NAME}
# 	DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${DEPS_EXPORT_NAME}
# 	NAMESPACE "${DEPS_EXPORT_NAME}::"
# 	FILE "${DEPS_EXPORT_NAME}.cmake"
# )

set (CPACK_PACKAGE_FILE_NAME "third_party_cpp_deps")
set (CPACK_GENERATOR "TGZ")
include (CPack)