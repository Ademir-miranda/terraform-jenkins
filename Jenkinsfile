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

        stage('Teste-Extra') {
            steps {
                sh 'echo "Rodando teste extra..."'
                sh 'docker images | grep $IMAGE_NAME || true'
            }
        }

        stage('Stress Test') {
            steps {
                sh '''
                echo "Iniciando teste de carga..."
                
                for i in {1..5}
                do
                    echo "Execução $i"
                    sleep 2
                done

                echo "Gerando carga de CPU..."
                for i in {1..3}
                do
                    dd if=/dev/zero of=/dev/null bs=1M count=200
                done

                echo "Teste de carga finalizado"
                '''
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
