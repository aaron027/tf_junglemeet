
pipeline {
    agent any
    options {
        ansiColor('xterm')
    }
    stages{
        stage('frontend stage') {
            steps {
                withAWS(credentials: 'AWS_Credentials', region: 'us-east-1') {
                    // some block
                    dir('frontend') {
                        environment {
                            scannerHome = tool 'Sonarqube_scanner'
                        }
                        withSonarQubeEnv('sonarqube_frontend') {
                           echo 'The code scanning is running...'
                           sh "${scannerHome}/bin/sonar-scanner"
                        }
                        sh '''
                            terraform init
                            terraform validate
                            terraform apply -auto-approve
                        '''
                    }
                }
            }
        }
        stage('backend stage') {
            steps {
                withAWS(credentials: 'AWS_Credentials', region: 'us-east-1') {
                    // some block
                    dir('backend') {
                        environment {
                            scannerHome = tool 'Sonarqube_scanner'
                        }
                        withSonarQubeEnv('sonarqube_frontend') {
                           echo 'The code scanning is running...'
                           sh "${scannerHome}/bin/sonar-scanner"
                        }
                        sh '''
                            terraform init
                            terraform validate
                            terraform apply -auto-approve
                        '''
                    }
                }
            }
        }
        
    }  
   
    post {
        always{
            echo 'I will always say Hello again! test for webhook'
            cleanWs()
        }
//         success
//         {
//             emailext (
//                 subject: '$DEFAULT_SUBJECT',
//                 body: '$DEFAULT_CONTENT',
//                 to: '$DEFAULT_RECIPIENTS',
//                 recipientProviders: [ requestor() ]
//                 )
//         }
//         failure
//         {
//             emailext (
//                 subject: '$DEFAULT_SUBJECT',
//                 body: '$DEFAULT_CONTENT',
//                 recipientProviders: [developers(), requestor(), culprits()]
//                 )
//         }
        
    }
}
