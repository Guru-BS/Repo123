#include <gtest/gtest.h>
#include "calculator.h"

TEST(CalculatorTest, Add) {
    EXPECT_EQ(add(2, 3), 5);
    EXPECT_EQ(add(-1, 1), 0);
}

TEST(CalculatorTest, Divide) {
    EXPECT_EQ(divide(6, 3), 2);
    EXPECT_EQ(divide(5, 0), 0); // Test error case
}

int main(int argc, char** argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}