#include <gtest/gtest.h>

extern "C" {
  #include "calculator.h"
}

// Test fixture for calculator tests
class CalculatorTest : public ::testing::Test {
protected:
    void SetUp() override {
        // Setup code if needed
    }
    
    void TearDown() override {
        // Cleanup code if needed
    }
};

// Test addition function
TEST(CalculatorTest, AddPositiveNumbers) {
    EXPECT_EQ(add(2, 3), 5);
    EXPECT_EQ(add(0, 0), 0);
    EXPECT_EQ(add(-1, 1), 0);
}

TEST(CalculatorTest, AddNegativeNumbers) {
    EXPECT_EQ(add(-5, -3), -8);
    EXPECT_EQ(add(-10, 5), -5);
}

// Test subtraction function
TEST(CalculatorTest, SubtractNumbers) {
    EXPECT_EQ(subtract(10, 5), 5);
    EXPECT_EQ(subtract(5, 10), -5);
    EXPECT_EQ(subtract(0, 0), 0);
}

// Test multiplication function
TEST(CalculatorTest, MultiplyNumbers) {
    EXPECT_EQ(multiply(5, 6), 30);
    EXPECT_EQ(multiply(0, 100), 0);
    EXPECT_EQ(multiply(-3, 4), -12);
}

// Test division function
TEST(CalculatorTest, DivideNumbers) {
    EXPECT_FLOAT_EQ(divide(10, 2), 5.0f);
    EXPECT_FLOAT_EQ(divide(5, 2), 2.5f);
    EXPECT_FLOAT_EQ(divide(0, 5), 0.0f);
}

TEST(CalculatorTest, DivideByZero) {
    EXPECT_FLOAT_EQ(divide(10, 0), 0.0f);
}

// Test factorial function
TEST(CalculatorTest, Factorial) {
    EXPECT_EQ(factorial(0), 1);
    EXPECT_EQ(factorial(1), 1);
    EXPECT_EQ(factorial(5), 120);
    EXPECT_EQ(factorial(-1), -1);  // Error case
}

// Test prime number function
TEST(CalculatorTest, IsPrime) {
    EXPECT_EQ(is_prime(2), 1);
    EXPECT_EQ(is_prime(3), 1);
    EXPECT_EQ(is_prime(4), 0);
    EXPECT_EQ(is_prime(17), 1);
    EXPECT_EQ(is_prime(1), 0);
    EXPECT_EQ(is_prime(0), 0);
    EXPECT_EQ(is_prime(-5), 0);
}

// Parameterized tests for addition
class AddParameterizedTest : public ::testing::TestWithParam<std::tuple<int, int, int>> {
};

TEST_P(AddParameterizedTest, AddVariousNumbers) {
    int a = std::get<0>(GetParam());
    int b = std::get<1>(GetParam());
    int expected = std::get<2>(GetParam());
    
    EXPECT_EQ(add(a, b), expected);
}

INSTANTIATE_TEST_SUITE_P(
    CalculatorTests,
    AddParameterizedTest,
    ::testing::Values(
        std::make_tuple(1, 2, 3),
        std::make_tuple(-1, -1, -2),
        std::make_tuple(0, 0, 0),
        std::make_tuple(100, 200, 300),
        std::make_tuple(-5, 10, 5)
    )
);

// Death test for edge cases
TEST(CalculatorDeathTest, FactorialLargeNumber) {
    // This test might overflow, but we're just testing it doesn't crash
    EXPECT_NO_THROW(factorial(10));
}

// Main function (not needed if using gtest_main)
int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}