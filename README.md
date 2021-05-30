# third-party-cpp-deps

CMake project used for downloading and compiling open-source cpp libraries and packaging them in a tar.gz.
Exports simple cmake functions to make all dependencies available to other cmake cpp projects. See also TODO as usage refrence.

To build, compile and package simply run *build.sh*.
To use the dependencies in other projects, include the *third_party_cpp_deps.cmake* file.

Note: whenever a new cpp library is added, don't forget to update the projects list in *third_party_cpp_deps.cmake*.
