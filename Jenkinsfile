pipeline {
    agent any

    environment {
        IMAGE_NAME = "minha-app"
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

        stage('Rodar Container') {
            steps {
                sh 'docker run --rm $IMAGE_NAME:$VERSION'
            }
        }

        stage('Limpeza') {
            steps {
                sh 'docker system prune -f'
            }
        }
    }
}
