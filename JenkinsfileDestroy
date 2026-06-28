parameters {
    choice(
        name: 'ACTION',
        choices: ['apply', 'destroy'],
        description: 'Terraform action'
    )
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
