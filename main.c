#include <stdio.h>
#include "src/calculator.h"

int main() {
    printf("=== Simple Calculator ===\n\n");

    // Test addition
    printf("Addition:\n");
    printf("  5 + 3 = %d\n", add(5, 3));
    printf("  -2 + 7 = %d\n", add(-2, 7));

    // Test subtraction
    printf("\nSubtraction:\n");
    printf("  10 - 4 = %d\n", subtract(10, 4));
    printf("  3 - 8 = %d\n", subtract(3, 8));

    // Test multiplication
    printf("\nMultiplication:\n");
    printf("  6 * 7 = %d\n", multiply(6, 7));
    printf("  -4 * 5 = %d\n", multiply(-4, 5));

    // Test division
    printf("\nDivision:\n");
    printf("  15 / 3 = %.2f\n", divide(15, 3));
    printf("  7 / 2 = %.2f\n", divide(7, 2));
    printf("  5 / 0 = %.2f (division by zero handled)\n", divide(5, 0));

    // Test factorial
    printf("\nFactorial:\n");
    printf("  0! = %d\n", factorial(0));
    printf("  5! = %d\n", factorial(5));
    printf("  -3! = %d (error case)\n", factorial(-3));

    // Test prime numbers
    printf("\nPrime Numbers:\n");
    printf("  Is 17 prime? %s\n", is_prime(17) ? "Yes" : "No");
    printf("  Is 25 prime? %s\n", is_prime(25) ? "Yes" : "No");
    printf("  Is 1 prime? %s\n", is_prime(1) ? "Yes" : "No");

    printf("\n=== End of Calculator Demo ===\n");
    return 0;
}