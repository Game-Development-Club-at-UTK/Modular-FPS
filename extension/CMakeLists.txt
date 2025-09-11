cmake_minimum_required(VERSION 3.20)
project(gdext_cpp_only LANGUAGES CXX)

# ---- Godot-cpp headers for IntelliSense ----
set(GODOT_CPP_DIR "${CMAKE_SOURCE_DIR}/godot-cpp")   # adjust if needed

# C++ standard and some typical defines used by godot-cpp builds
set(CMAKE_CXX_STANDARD 17)
add_compile_definitions(GODOT_CPP_NO_EXCEPTIONS)   # optional; match your scons flags if used

# ---- Add your sources so CLion indexes them ----
file(GLOB SRC CONFIGURE_DEPENDS "${CMAKE_SOURCE_DIR}/src/*.cpp" "${CMAKE_SOURCE_DIR}/src/*.h")
# Header-only "dummy" target so CLion understands the code model.
add_library(gamecode STATIC EXCLUDE_FROM_ALL ${SRC})

target_include_directories(gamecode PUBLIC
        "${GODOT_CPP_DIR}/include"
        "${GODOT_CPP_DIR}/gen/include"
        "${GODOT_CPP_DIR}/gdextension"
        "${CMAKE_SOURCE_DIR}/src"
)

# ---- SCons build shortcuts (so you can hit Build in CLion if you want) ----
if(APPLE)
    set(GODOT_PLATFORM "macos")
elseif(WIN32)
    set(GODOT_PLATFORM "windows")
else()
    set(GODOT_PLATFORM "linux")
endif()

add_custom_target(scons_debug
        COMMAND scons platform=${GODOT_PLATFORM} target=template_debug -j8
        WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
        USES_TERMINAL
)

add_custom_target(scons_release
        COMMAND scons platform=${GODOT_PLATFORM} target=template_release -j8
        WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
        USES_TERMINAL
)

# Make "Build" do nothing by default (so CLion won’t try to compile with CMake)
set_property(TARGET gamecode PROPERTY EXCLUDE_FROM_ALL TRUE)
