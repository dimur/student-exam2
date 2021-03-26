pipeline {
    agent { label 'agent1' }
    environment {
        registry = "dmurzin/exam2"
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
                    dockerImage = docker.build registry + ":app"
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
        stage('Clean up') {
            steps {
                script {
                    sh "docker rmi $registry:app"
                }
            }
        }
    }
}
