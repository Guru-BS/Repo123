# Find GoogleTest (requires C++)
find_package(GTest REQUIRED)
find_package(Threads REQUIRED)

# Explicitly specify this is a C++ executable
add_executable(calculator_test 
    calculator_test.cpp
)

# Tell CMake this is a C++ target
set_target_properties(calculator_test PROPERTIES
    CXX_STANDARD 11
    CXX_STANDARD_REQUIRED ON
)

# Link with GTest and our library
target_link_libraries(calculator_test
    GTest::gtest
    GTest::gtest_main
    calculator
    pthread
)

# Include directories
target_include_directories(calculator_test
    PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/../src
)

# Add test discovery
gtest_discover_tests(calculator_test)