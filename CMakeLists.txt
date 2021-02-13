cmake_minimum_required (VERSION 3.18)

project (third-party-cpp-deps)

include (ExternalProject)

set (CMAKE_VERBOSE_MAKEFILE ON)
set (CMAKE_POSITION_INDEPENDENT_CODE ON)

set (EP_OUTPUT_DIR "${CMAKE_BINARY_DIR}/tmp")

function (install_ep DEP_NAME)
	install (DIRECTORY ${EP_OUTPUT_DIR}/${DEP_NAME} DESTINATION ".")
endfunction ()

set (SPDLOG_EP spdlog-ep)
ExternalProject_Add (${SPDLOG_EP}
	PREFIX ${SPDLOG_EP}
	URL https://github.com/gabime/spdlog/archive/v1.8.2.tar.gz
	URL_HASH SHA256=e20e6bd8f57e866eaf25a5417f0a38a116e537f1a77ac7b5409ca2b180cec0d5
	CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${EP_OUTPUT_DIR}/${SPDLOG_EP}
)

install_ep (${SPDLOG_EP})

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