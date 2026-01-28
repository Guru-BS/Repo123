.PHONY: all build test clean docker-run

all: build test

build:
	mkdir -p build
	cd build && cmake .. && make

test: build
	cd build && ctest --output-on-failure

clean:
	rm -rf build

docker-run:
	docker-compose up --build

run: build
	./build/calculator