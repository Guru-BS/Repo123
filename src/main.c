#include <stdio.h>
#include "calculator.h"

int main() {
    printf("Calculator Demo:\n");
    printf("Add: 5 + 3 = %.2f\n", add(5, 3));
    printf("Subtract: 5 - 3 = %.2f\n", subtract(5, 3));
    printf("Multiply: 5 * 3 = %.2f\n", multiply(5, 3));
    printf("Divide: 5 / 3 = %.2f\n", divide(5, 3));
    return 0;
}