pipeline {
    agent {
        docker {
            image 'gcc:12.2.0'
            args '--user root'  // Run as root inside container
        }
    }
    
    environment {
        BUILD_DIR = 'build'
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo '📥 Checking out source code...'
                checkout scm
            }
        }
        
        stage('Install Dependencies') {
            steps {
                echo '📦 Installing dependencies...'
                sh '''
                    apt-get update
                    apt-get install -y \
                        cmake \
                        make \
                        libgtest-dev
                    
                    # Build Google Test
                    cd /usr/src/gtest
                    cmake CMakeLists.txt
                    make
                    cp lib/*.a /usr/lib
                    cd -
                '''
            }
        }
        
        stage('Build') {
            steps {
                echo '🔨 Building project...'
                sh '''
                    rm -rf ${BUILD_DIR}
                    mkdir -p ${BUILD_DIR}
                    cd ${BUILD_DIR}
                    cmake .. -DBUILD_TESTS=ON
                    make -j4
                    echo "=== Build completed ==="
                    ls -la
                '''
            }
        }
        
        stage('Test') {
            steps {
                echo '🧪 Running tests...'
                sh '''
                    cd ${BUILD_DIR}
                    echo "=== Test Results ==="
                    ./tests/calculator_test --gtest_color=yes
                    ./tests/calculator_test --gtest_output=xml:test-results.xml
                '''
            }
            post {
                always {
                    junit 'build/test-results.xml'
                }
            }
        }
        
        stage('Run Application') {
            steps {
                echo '🚀 Running application...'
                sh '''
                    cd ${BUILD_DIR}
                    echo "=== Application Output ==="
                    ./calculator_app
                '''
            }
        }
        
        stage('Package') {
            steps {
                echo '📦 Creating package...'
                sh '''
                    mkdir -p package
                    cp ${BUILD_DIR}/calculator_app package/
                    cp ${BUILD_DIR}/tests/calculator_test package/
                    cp -r src package/
                    cp CMakeLists.txt package/
                    cp Jenkinsfile package/
                    
                    echo "Calculator CI/CD Build" > package/README.txt
                    echo "Build Number: ${BUILD_NUMBER}" >> package/README.txt
                    echo "Build Date: $(date)" >> package/README.txt
                    
                    tar -czf calculator-${BUILD_NUMBER}.tar.gz package/
                    echo "=== Package created ==="
                    ls -lh *.tar.gz
                '''
                archiveArtifacts artifacts: '*.tar.gz', fingerprint: true
            }
        }
    }
    
    post {
        always {
            echo '🧹 Cleaning workspace...'
            cleanWs()
        }
        success {
            echo '✅ Pipeline succeeded!'
        }
        failure {
            echo '❌ Pipeline failed!'
        }
    }
}
