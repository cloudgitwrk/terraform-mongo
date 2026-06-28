pipeline {
    agent any

    parameters {
        choice(
            name: 'ACTION',
            choices: ['apply', 'destroy'],
            description: 'Choose Terraform action'
        )
    }

    stages {

        stage('Checkout Code') {
            steps {
                git url: 'git@github.com:cloudgitwrk/terraform-mongo.git',
                    branch: 'main'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init -input=false'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    if (params.ACTION == 'destroy') {
                        sh 'terraform plan -destroy -out=tfplan'
                    } else {
                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }

        stage('Terraform Apply / Destroy') {
            steps {
                script {
                    if (params.ACTION == 'destroy') {
                        sh 'terraform apply -auto-approve tfplan'
                    } else {
                        sh 'terraform apply -auto-approve tfplan'
                    }
                }
            }
        }

        stage('Cleanup (Optional Re-init for Next Run)') {
            steps {
                sh 'rm -rf .terraform'
            }
        }
    }

    post {
        success {
            script {
                if (params.ACTION == 'destroy') {
                    echo "✅ Infrastructure Destroyed Successfully"
                } else {
                    echo "✅ MongoDB Cluster Created Successfully"
                }
            }
        }
        failure {
            echo "❌ Pipeline Failed"
        }
    }
}
