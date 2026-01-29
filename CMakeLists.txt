cmake_minimum_required(VERSION 3.10)
project(SimpleCalculator VERSION 1.0.0)

# Enable both C and C++ languages
enable_language(C)
enable_language(CXX)

# Set C standard
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

# Set C++ standard for tests
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Options
option(BUILD_TESTS "Build tests" ON)

# Add source files
add_library(calculator
    src/calculator.c
)

# Include directories
target_include_directories(calculator
    PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/src
)

# Build executable
add_executable(calculator_app main.c)
target_link_libraries(calculator_app calculator)

# Add tests if enabled
if(BUILD_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif()