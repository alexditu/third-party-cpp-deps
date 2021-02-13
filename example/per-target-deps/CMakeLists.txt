add_executable (main main.cpp)

add_third_party_include_dir (main PRIVATE ${SPDLOG_EP} ${THIRD_PARTY_DEPS_DIR})
add_third_party_lib_dir (main PRIVATE ${SPDLOG_EP} ${THIRD_PARTY_DEPS_DIR})

target_link_libraries (main spdlog)