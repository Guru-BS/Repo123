cmake_minimum_required(VERSION 3.15)
project(CalculatorApp VERSION 1.0)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find packages
find_package(GTest REQUIRED)

# Add main executable
add_executable(calculator_app src/main.cpp src/calculator.cpp src/calculator.h)

# Add test executable
add_executable(calculator_test tests/calculator_test.cpp src/calculator.cpp src/calculator.h)
target_link_libraries(calculator_test GTest::gtest GTest::gtest_main)

# Enable testing
enable_testing()
add_test(NAME CalculatorTests COMMAND calculator_test)