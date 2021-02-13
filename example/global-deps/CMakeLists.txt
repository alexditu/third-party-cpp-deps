add_third_global_include_dir (${THIRD_PARTY_DEPS_DIR})
add_third_global_lib_dir (${THIRD_PARTY_DEPS_DIR})

# global third party dependecies (for convenience)
link_libraries (spdlog)

add_executable (main-global main.cpp)
