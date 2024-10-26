pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = 'balaji997/my-react-app'
        DOCKER_CREDENTIALS_ID = '882a40c3-7ab9-422c-a394-3f30aca1dbff'     
    }

    stages {


        stage('Clone Repository') {
            steps {
                // Clone the GitHub repository
                git 'https://github.com/bswamynathan/capstone.git'
            }
        }

        stage('Build Docker Image') {
            steps {

                // Run the build.sh script to build the Docker image
                sh './build.sh'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                // Login to Docker Hub and push the Docker image
                script {
                    docker.withRegistry('', "${DOCKER_CREDENTIALS_ID}") {
                        sh "docker push ${DOCKER_HUB_REPO}:latest"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                // Run the deploy.sh script to deploy the Docker container
                sh './deploy.sh'
            }
        }
    }

    post {
        always {
            cleanWs() // Clean up workspace
        }
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
