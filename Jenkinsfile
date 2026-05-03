pipeline {
    agent any

    environment {
        IMAGE_NAME = "amiranda1/meu-app"
        VERSION = "v1.${BUILD_NUMBER}"
    }

    stages {

        stage('Clonar código') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$VERSION -f docker/Dockerfile .'
            }
        }

        stage('Login Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-cred',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                sh '''
                docker push $IMAGE_NAME:$VERSION

                # cria tag latest baseada na versão atual
                docker tag $IMAGE_NAME:$VERSION $IMAGE_NAME:latest
                docker push $IMAGE_NAME:latest
                '''
            }
        }

        stage('Limpeza') {
            steps {
                sh 'docker system prune -f'
            }
        }
    }
}
