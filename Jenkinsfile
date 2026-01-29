pipeline {
    agent {
        docker {
            image 'gcc:11.2.0'
            args '-v /tmp:/tmp'
        }
    }
    
    environment {
        PROJECT_NAME = 'simple-calculator'
        BUILD_DIR = 'build'
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
                checkout scm
            }
        }
        
        stage('Install Dependencies') {
            steps {
                echo 'Installing build dependencies...'
                sh '''
                    apt-get update
                    apt-get install -y \
                        cmake \
                        make \
                        libgtest-dev \
                        googletest \
                        git
                    
                    # Build GTest from source if needed
                    cd /usr/src/gtest
                    cmake CMakeLists.txt
                    make
                    cp *.a /usr/lib
                '''
            }
        }
        
        stage('Build') {
            steps {
                echo 'Building project...'
                sh '''
                    mkdir -p ${BUILD_DIR}
                    cd ${BUILD_DIR}
                    cmake .. -DBUILD_TESTS=ON
                    make -j$(nproc)
                    ls -la
                '''
            }
        }
        
        stage('Run Tests') {
            steps {
                echo 'Running unit tests...'
                sh '''
                    cd ${BUILD_DIR}
                    # Run tests with verbose output
                    ./tests/calculator_test --gtest_color=yes
                    
                    # Generate test report
                    ./tests/calculator_test --gtest_output=xml:test_results.xml
                '''
            }
            post {
                always {
                    echo 'Collecting test results...'
                    junit 'build/test_results.xml'
                }
            }
        }
        
        stage('Static Analysis') {
            steps {
                echo 'Running static analysis...'
                sh '''
                    # Install cppcheck if not present
                    if ! command -v cppcheck &> /dev/null; then
                        apt-get install -y cppcheck
                    fi
                    
                    # Run static analysis
                    cppcheck --enable=all --inconclusive \
                             --suppress=missingIncludeSystem \
                             src/ tests/ 2> cppcheck-report.xml || true
                '''
            }
            post {
                always {
                    recordIssues(
                        tools: [cppCheck(pattern: 'cppcheck-report.xml')]
                    )
                }
            }
        }
        
        stage('Build Application') {
            steps {
                echo 'Building main application...'
                sh '''
                    cd ${BUILD_DIR}
                    # Verify the executable was built
                    file calculator_app
                    ./calculator_app
                '''
            }
        }
        
        stage('Package') {
            when {
                branch 'main'
            }
            steps {
                echo 'Creating package...'
                sh '''
                    mkdir -p package
                    cp ${BUILD_DIR}/calculator_app package/
                    cp -r src package/
                    cp CMakeLists.txt package/
                    cp README.md package/
                    
                    # Create tar archive
                    tar -czf ${PROJECT_NAME}-${BUILD_NUMBER}.tar.gz package/
                '''
            }
        }
    }
    
    post {
        always {
            echo 'Cleaning up workspace...'
            cleanWs()
        }
        success {
            echo 'Pipeline succeeded!'
            // You can add notifications here
            // slackSend(color: 'good', message: "Build ${env.BUILD_NUMBER} succeeded")
        }
        failure {
            echo 'Pipeline failed!'
            // slackSend(color: 'danger', message: "Build ${env.BUILD_NUMBER} failed")
        }
        unstable {
            echo 'Pipeline is unstable!'
        }
    }
}