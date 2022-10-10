pipeline {
    agent any
    tools {
        maven 'maven'
        jdk 'jdk11'
        //ansible 'ansible'
        terraform 'terraform'
    }
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        ANSIBLE_HOST_KEY_CHECKING="False"
    }
    stages{
        stage('checkout') {
            steps {
                git(url: 'https://github.com/KR-Nitesh/sailoraws.git', credentialsId: 'githubKr-Nitesh')
            }            
        }
        stage('build') {
            steps{
                sh '''
                    mvn clean verify                    
                '''
            }
        }
        stage('setup environment') {
            steps {
                sh '''
                    terraform init
                    terraform apply --auto-approve
                    terraform output "public_ip" > hosts
                '''
            }
        }
        stage('deploy') {
            steps {
                ansiblePlaybook(playbook: 'sailor-playbook.yaml', credentialsId: 'aws_instance_ssh_key', inventory: 'hosts')
            }
        }
    }

}
