# Simple Calculator Makefile
CC = gcc
CFLAGS = -Wall -Wextra -std=c11 -g
LDFLAGS = -lm
GTEST_FLAGS = -lgtest -lgtest_main -lpthread

# Directories
SRC_DIR = src
TEST_DIR = tests
BUILD_DIR = build

# Files
SRCS = $(SRC_DIR)/calculator.c
OBJS = $(BUILD_DIR)/calculator.o
TEST_SRCS = $(TEST_DIR)/calculator_test.cpp
MAIN_SRC = main.c

# Targets
TARGET = $(BUILD_DIR)/calculator_app
TEST_TARGET = $(BUILD_DIR)/calculator_test

.PHONY: all clean test run build

all: build test

build: $(TARGET)

$(TARGET): $(OBJS) $(MAIN_SRC)
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) $(MAIN_SRC) $(OBJS) -o $@ $(LDFLAGS)

$(BUILD_DIR)/calculator.o: $(SRC_DIR)/calculator.c $(SRC_DIR)/calculator.h
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Test target (requires GTest installed)
test: $(TEST_TARGET)
	@echo "Running tests..."
	@./$(TEST_TARGET) --gtest_color=yes

$(TEST_TARGET): $(OBJS) $(TEST_SRCS)
	@mkdir -p $(BUILD_DIR)
	g++ $(CFLAGS) $(TEST_SRCS) $(OBJS) -o $@ $(GTEST_FLAGS)

run: $(TARGET)
	@./$(TARGET)

clean:
	rm -rf $(BUILD_DIR)

install-deps:
	@echo "Installing dependencies..."
	sudo apt-get update
	sudo apt-get install -y gcc make cmake libgtest-dev
	cd /usr/src/gtest && sudo cmake CMakeLists.txt && sudo make && sudo cp *.a /usr/lib

help:
	@echo "Available targets:"
	@echo "  all      - Build and test"
	@echo "  build    - Build the application"
	@echo "  test     - Build and run tests"
	@echo "  run      - Build and run application"
	@echo "  clean    - Clean build files"
	@echo "  install-deps - Install dependencies"