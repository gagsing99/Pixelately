pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                // Get code from a GitHub repository
                git url: 'https://github.com/gagsing99/Pixelately.git', branch: 'main',
                 credentialsId: '2eb2c202-c637-4279-b9c8-50591642d6d3'
                
            }
        }
    }
}
