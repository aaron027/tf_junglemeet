
pipeline {
    agent any
    options {
        ansiColor('xterm')
    }
    stages{
        stage('Sonarqube') {
            environment {
                scannerHome = tool 'Sonarqube_scanner'
            }
            steps {
                withAWS(credentials: 'AWS_Credentials', region: 'us-east-1') {
//                     dir('frontend'){
//                          withSonarQubeEnv('sonarqube_frontend') {
//                            echo 'The code scanning is running...'
//                            sh "${scannerHome}/bin/sonar-scanner"
//                         }
//                     }
//                     dir('backend'){
//                          withSonarQubeEnv('sonarqube_frontend') {
//                            echo 'The code scanning is running...'
//                            sh "${scannerHome}/bin/sonar-scanner"
//                         }
//                     }
                        withSonarQubeEnv('sonarqube_frontend') {
                           echo 'The code scanning is running...'
                           sh "${scannerHome}/bin/sonar-scanner"
                        }
                }
            }
        }
        stage('frontend stage') {
            steps {
                withAWS(credentials: 'AWS_Credentials', region: 'us-east-1') {
                    // some block
                    dir('frontend') {
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
