pipeline {
    agent any

    environment {
        DOCKER_DEV_REPO = 'balaji997/dev'
        DOCKER_PROD_REPO = 'balaji997/prod'
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clone the repository
                git url: 'https://github.com/bswamynathan/newprojectrepo.git', branch: "${env.BRANCH_NAME}"
            }
        }

        stage('Build Docker Image') {
            steps {
                // Run the build script to build the Docker image
                sh './build.sh'
            }
        }

        stage('Deploy and Push to Docker Hub') {
            steps {
                script {
                    def dockerRepo
                    if (env.BRANCH_NAME == 'master') {
                        dockerRepo = DOCKER_PROD_REPO
                    } else if (env.BRANCH_NAME == 'dev') {
                        dockerRepo = DOCKER_DEV_REPO
                    } else {
                        echo "Skipping Docker push: branch is neither 'master' nor 'dev'."
                        return
                    }

                    // Log in and push the Docker image
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        // Login to Docker Hub
                        echo "Logging in to Docker Hub"
                        sh '''
                        echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin
                        '''

                        // Tag and push the Docker image
                        echo "Pushing Docker image to Docker Hub"
                        sh "docker tag my-react-app:latest ${dockerRepo}:${env.BRANCH_NAME}"
                        sh "docker push ${dockerRepo}:${env.BRANCH_NAME}"
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
