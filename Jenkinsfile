pipeline {
    agent any
    environment {
        registry = "dimur/exam2"
        registryCredential = 'dockerhub'
        dockerImage = ''
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Test') {
            steps {
                script {
                    sh """
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install -e .
                    pip install -e '.[test]'
                    coverage run -m pytest
                    coverage report
                    deactivate
                    """
                }
            }
        }
        stage('Build docker image') {
            steps {
                script {
                    dockerImage = docker.build registry + ":app$BUILD_NUMBER"
                }
            }
        }
        stage('Push docker image') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
