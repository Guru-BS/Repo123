cmake_minimum_required(VERSION 3.10)
project(Calculator VERSION 1.0)

set(CMAKE_C_STANDARD 11)

# Main executable
add_executable(calculator 
    src/calculator.c 
    src/main.c
)

# Include directories
target_include_directories(calculator PUBLIC src)

# Testing (optional section)
enable_testing()

# Add test directory if it exists
if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/tests)
    add_subdirectory(tests)
endif()