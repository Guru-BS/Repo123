pipeline {
    agent {
        docker {
            image 'gcc:12.2.0'  // Base image with GCC
            args '--user root'  // Run as root
        }
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Setup Environment') {
            steps {
                sh '''
                    # Update and install dependencies
                    apt-get update
                    apt-get install -y cmake libgtest-dev
                    
                    # Build GTest
                    cd /usr/src/gtest
                    cmake CMakeLists.txt
                    make
                    cp lib/*.a /usr/lib
                '''
            }
        }
        
        stage('Build') {
            steps {
                sh '''
                    mkdir -p build
                    cd build
                    cmake .. -DBUILD_TESTS=ON
                    make
                '''
            }
        }
        
        stage('Test') {
            steps {
                sh '''
                    cd build
                    ./tests/calculator_test
                    ./tests/calculator_test --gtest_output=xml:test-results.xml
                '''
                junit 'build/test-results.xml'
            }
        }
        
        stage('Package') {
            steps {
                sh '''
                    mkdir -p output
                    cp build/calculator_app output/
                    cp -r src output/
                    tar -czf calculator.tar.gz output/
                '''
                archiveArtifacts artifacts: 'calculator.tar.gz'
            }
        }
    }
}
