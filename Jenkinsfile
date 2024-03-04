pipeline{
    agent{
        label 'jworker'
    }
    tools{
        jdk 'jdk11'
    }
    environment {
         AWS_ACCOUNT_ID=credentials('ACCOUN_ID')
         AWS_DEFAULT_REGION=credentials('DEFAULT_REGIO') 
         IMAGE_REPO_ON=credentials('IMAGE_REPO_ONG')
         IMAGE_REPO_OP=credentials('IMAGE_REPO_OPH')
         IMAGE_REPO_FN=credentials('IMAGE_REPO_NG')
         IMAGE_REPO_SP=credentials('IMAGE_REPO_PH')
         IMAGE_TAG="latest"
    }
    stages {
        stage('clean workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Git Checkout') {
            steps {
                echo 'Cloning Code from git branch'
                git branch: 'main', url: 'enter-your-repo-url'
            }
        }
        stage('ECR Login') {
            steps {
                script{
                    sh 'aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com'
                } 
            }
        }
        stage('Docker Image Build') {
            steps {
                script{
                    echo 'docker-compose build'
                    sh 'docker-compose build'
                    sh 'docker images'
                }  
            }
        }
        stage('Image ECR Tag') {
            steps {
                script{
                    echo 'again retag images before push it to ecr pri repo'
                    sh 'docker tag ${IMAGE_REPO_ON}:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_FN}:latest'
                    sh 'docker tag ${IMAGE_REPO_OP}:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_SP}:latest'
                    sh 'docker images'
                }  
            }
        }
        stage('Push ECR') {
            steps {
                script{
                    echo 'push tag image to ecr'
                    sh 'docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_FN}:${IMAGE_TAG}'
                    sh 'docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_SP}:${IMAGE_TAG}'
                }  
            }
        }
        stage('Docker-Compose Deploy') {
            steps {
                script{
                    sh 'docker-compose down'
                    sh 'docker-compose up -d'
                } 
            }
        }
    }
}    