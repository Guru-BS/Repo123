# Find GTest
find_package(GTest REQUIRED)

# Test executable
add_executable(test_calculator test_calculator.c)
target_include_directories(test_calculator PRIVATE ../src)
target_link_libraries(test_calculator GTest::gtest GTest::gtest_main)

# Link calculator functions
target_sources(test_calculator PRIVATE ../src/calculator.c)

add_test(NAME calculator_tests COMMAND test_calculator)