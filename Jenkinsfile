pipeline {
    agent any
     environment {
        IMAGE_NAME = "hp171100/my-node-app"
        IMAGE_VERSION = "2.0"
    }
    stages{
        stage("checkout"){
            steps{
                checkout scm
            }
        }
        stage("Install Dependencies") {
            steps {
                sh 'npm install'
            }
        }
        stage("Build App") {
            steps {
                sh 'npm run build'
            }
        }
        stage("Build Docker Image") {
            steps {
                sh 'docker build -t $IMAGE_NAME:$IMAGE_VERSION .'
                sh 'docker tag $IMAGE_NAME:$IMAGE_VERSION $IMAGE_NAME:latest'
            }
        }
        stage("Push Docker Image") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker_cred', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                    sh 'echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin'
                    sh 'docker push $IMAGE_NAME:$IMAGE_VERSION'
                    sh 'docker push $IMAGE_NAME:latest'
                    sh 'docker logout'
                }
            }
        }
    }
}
