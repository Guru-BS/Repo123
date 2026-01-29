#include "calculator.h"
#include <stdlib.h>

// Simple addition function
int add(int a, int b) {
    return a + b;
}

int subtract(int a, int b) {
    return a - b;
}

int multiply(int a, int b) {
    return a * b;
}

float divide(int a, int b) {
    if (b == 0) {
        return 0.0f;  // Return 0 on division by zero
    }
    return (float)a / (float)b;
}

int factorial(int n) {
    if (n < 0) return -1;  // Error for negative numbers
    if (n == 0) return 1;

    int result = 1;
    for (int i = 1; i <= n; i++) {
        result *= i;
    }
    return result;
}

int is_prime(int n) {
    if (n <= 1) return 0;
    if (n == 2) return 1;
    if (n % 2 == 0) return 0;

    for (int i = 3; i * i <= n; i += 2) {
        if (n % i == 0) return 0;
    }
    return 1;
}