#!/bin/bash

# Simple Calculator Build Script
set -e  # Exit on error

echo "=== Simple Calculator Build Script ==="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print status
print_status() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

# Check for required tools
check_dependencies() {
    print_status "Checking dependencies..."
    
    # Check for CMake
    if ! command -v cmake &> /dev/null; then
        print_error "CMake is not installed. Please install CMake."
        exit 1
    fi
    
    # Check for make
    if ! command -v make &> /dev/null; then
        print_error "Make is not installed. Please install make."
        exit 1
    fi
    
    # Check for gcc
    if ! command -v gcc &> /dev/null; then
        print_error "GCC is not installed. Please install GCC."
        exit 1
    fi
    
    print_status "All dependencies found!"
}

# Install GTest
install_gtest() {
    print_status "Installing Google Test..."
    
    if [ -d "/usr/src/googletest" ] || [ -d "/usr/src/gtest" ]; then
        print_status "GTest already installed"
    else
        print_warning "GTest not found. Installing..."
        sudo apt-get update
        sudo apt-get install -y libgtest-dev
        cd /usr/src/gtest
        sudo cmake CMakeLists.txt
        sudo make
        sudo cp *.a /usr/lib
        cd -
    fi
}

# Build the project
build_project() {
    print_status "Building project..."
    
    # Create build directory
    if [ ! -d "build" ]; then
        mkdir build
    fi
    
    cd build
    
    # Configure with CMake
    cmake .. -DBUILD_TESTS=ON
    
    # Build
    make -j$(nproc)
    
    cd ..
    
    print_status "Build completed!"
}

# Run tests
run_tests() {
    print_status "Running tests..."
    
    if [ -f "build/tests/calculator_test" ]; then
        cd build
        ./tests/calculator_test --gtest_color=yes
        
        # Generate coverage report if gcov/lcov is available
        if command -v lcov &> /dev/null && command -v gcov &> /dev/null; then
            print_status "Generating coverage report..."
            lcov --capture --directory . --output-file coverage.info
            lcov --remove coverage.info '/usr/*' --output-file coverage.info
            genhtml coverage.info --output-directory coverage
            print_status "Coverage report generated in build/coverage/"
        fi
        
        cd ..
    else
        print_error "Test executable not found!"
        exit 1
    fi
}

# Run the application
run_app() {
    print_status "Running application..."
    
    if [ -f "build/calculator_app" ]; then
        build/calculator_app
    else
        print_error "Application executable not found!"
        exit 1
    fi
}

# Clean build directory
clean_build() {
    print_status "Cleaning build directory..."
    rm -rf build
}

# Main menu
main() {
    case "$1" in
        "deps")
            check_dependencies
            install_gtest
            ;;
        "build")
            check_dependencies
            build_project
            ;;
        "test")
            build_project
            run_tests
            ;;
        "run")
            build_project
            run_app
            ;;
        "clean")
            clean_build
            ;;
        "all")
            check_dependencies
            install_gtest
            build_project
            run_tests
            run_app
            ;;
        *)
            echo "Usage: $0 {deps|build|test|run|clean|all}"
            echo "  deps    - Install dependencies"
            echo "  build   - Build the project"
            echo "  test    - Build and run tests"
            echo "  run     - Build and run application"
            echo "  clean   - Clean build directory"
            echo "  all     - Run all steps"
            exit 1
            ;;
    esac
}

# Run main function with arguments
main "$@"