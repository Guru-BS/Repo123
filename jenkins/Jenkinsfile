pipeline {
    agent any
    
    tools {
        cmake 'Default'
        msbuild 'Default'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('CMake Configure') {
            steps {
                bat '''
                    cd %WORKSPACE%
                    mkdir build
                    cd build
                    cmake .. -DCMAKE_TOOLCHAIN_FILE=C:/vcpkg/scripts/buildsystems/vcpkg.cmake -G "Visual Studio 17 2022" -A x64
                '''
            }
        }
        
        stage('Build C++') {
            steps {
                bat '''
                    cd %WORKSPACE%\\build
                    cmake --build . --config Debug
                '''
            }
        }
        
        stage('Test C++') {
            steps {
                bat '''
                    cd %WORKSPACE%\\build
                    ctest --output-on-failure
                '''
            }
        }
        
        stage('Test Python') {
            steps {
                bat '''
                    cd %WORKSPACE%\\python_app
                    python -m pytest -v --junitxml=test-results.xml
                '''
            }
            post {
                always {
                    junit 'python_app/test-results.xml'
                }
            }
        }
        
        stage('Docker Build') {
            steps {
                script {
                    docker.build('calculator-cpp', '-f docker/Dockerfile.cplus .')
                    docker.build('calculator-python', '-f docker/Dockerfile.python .')
                }
            }
        }
        
        stage('Docker Test') {
            steps {
                script {
                    docker.image('calculator-cpp').run('--rm')
                    docker.image('calculator-python').run('--rm')
                }
            }
        }
        
        stage('Archive') {
            steps {
                archiveArtifacts artifacts: 'build/Debug/calculator_app.exe', fingerprint: true
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}