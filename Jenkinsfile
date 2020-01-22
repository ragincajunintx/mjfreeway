pipeline {
    agent any

    environment {

        IMAGE = 'app'

        VERSION = 'latest'

        DOCKERREPO = ''
    
    }

    stages {
        stage('Checking Out Source Code'){
            steps{
               echo 'Checking Out SCM'
               checkout scm
            }   
        }
        stage('Building Infrastructure'){
            steps{
                sh 'cd terraform && terraform init && terraform plan -out=helloworld && terraform apply -no-color -auto-approve "helloworld" '
            }
        }
        stage('Building Docker Image'){
            steps{
                echo 'Building Docker Image'
                sh 'pwd'
                sh 'docker build -t app .'
            }
            
        }
        stage('Tagging Image'){
            steps{
                sh "docker tag ${IMAGE}:${VERSION} ${DOCKERREPO}/${IMAGE}:${VERSION}"
            }
        }
        stage("ECR Login") {
            steps {
                withAWS(credentials:'aws_creds') {
                    script {
                        def login = ecrLogin()
                        sh "${login}"
                    }
                }
            }
        }
        stage('Pushing Image to ECR'){
            steps{
                sh "docker push ${DOCKERREPO}/${IMAGE}:${VERSION}"
            }
        }
  
    }
}