properties([pipelineTriggers([githubPush()])]) 
pipeline {
    agent any
    stages {
        stage('Build') {
          agent { label "agent1" }
            steps {
              //
                script { echo "Build"
                if (env.BRANCH_NAME == "stage")
                
                { 
                sh "docker build -t detahermana/landingpage:stage-$BUILD_NUMBER . "
                sh "docker push detahermana/landingpage:stage-$BUILD_NUMBER"

                }else{ 
                sh "docker build -t detahermana/landingpage:prod-$BUILD_NUMBER . "
                sh "docker push detahermana/landingpage:prod-$BUILD_NUMBER"
                
                }
                
                
                }
                
              }
            }
        stage('Test') {
          agent { label "agent1" }
            steps {
              //
                script { echo "Test" 
                def scannerHome = tool 'sonarscanner1' ;
	              withSonarQubeEnv('sonarserver1') {
	              sh "${scannerHome}/bin/sonar-scanner"
	                }
                }
              }
            }
        stage('Deploy') {
          agent { label "agent1" }
            steps {
              //
                script { echo "Testing Deploy Lagi" 
                
                if (env.BRANCH_NAME == "stage")
                
                { 
                sh "kubectl -n test-lp set image deployment/landingpage-deployment landingpage=detahermana/landingpage:stage-$BUILD_NUMBER"
                sh "docker image rmi detahermana/landingpage:stage-$BUILD_NUMBER"
                }else{ 
                sh "kubectl -n test-lp set image deployment/landingpage-deployment landingpage=detahermana/landingpage:prod-$BUILD_NUMBER"
                sh "docker image rmi detahermana/landingpage:prod-$BUILD_NUMBER"
                }

                }
            }
          }
        }
      }