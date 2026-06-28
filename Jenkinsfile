 pipeline {
    agent any

    stages {

        stage('Checkout Code') {
            steps {
                git url: 'git@github.com:cloudgitwrk/terraform-mongo.git',
                    branch: 'main'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }

    post {
        success {
            echo "✅ MongoDB Cluster Created Successfully"
        }
        failure {
            echo "❌ Pipeline Failed"
        }
    }
}
