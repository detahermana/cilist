properties([pipelineTriggers([githubPush()])]) 
pipeline {
    agent any
    stages {
        stage('Code Scanning') {
          agent { label "agent1" }
            steps {
              //
                script {
                echo "Begin Test" 
                def scannerHome = tool 'sonarqube' ;
	              withSonarQubeEnv('sonarqube') {
	              sh "${scannerHome}/bin/sonar-scanner"
	                }
                }
              }
            }
        stage('Build') {
          agent { label "agent1" }
            steps {
              //
                script {
                echo "Build"
                if (env.BRANCH_NAME == "staging")
                { 
                // sh "pwd && ls -lah"
                sh "docker build -t detahermana/backend-cilist:stage-$BUILD_NUMBER backend/."
                sh "docker build -t detahermana/frontend-cilist-stag:stage-$BUILD_NUMBER frontend/."
                sh "docker push detahermana/backend-cilist:stage-$BUILD_NUMBER"
                sh "docker push detahermana/frontend-cilist-stag:stage-$BUILD_NUMBER"
                }else{ 
                sh "pwd && ls -lah"
                sh "docker build -t detahermana/backend-cilist:prod-$BUILD_NUMBER backend/."
                sh "docker build -t detahermana/frontend-cilist-prod:prod-$BUILD_NUMBER frontend/."
                sh "docker push detahermana/backend-cilist:prod-$BUILD_NUMBER"
                sh "docker push detahermana/frontend-cilist-prod:prod-$BUILD_NUMBER"
                }
                }  
              }
            }
        stage('Deploy') {
          agent { label "agent1" }
            steps {
              //
                script { echo "Deploy" 
                if (env.BRANCH_NAME == "staging")
                { 
                sh "kubectl set image deployment/backend-app backend-app=detahermana/backend-cilist:stage-$BUILD_NUMBER -n staging"
                sh "kubectl set image deployment/frontend-app frontend-app=detahermana/frontend-cilist-stag:stage-$BUILD_NUMBER -n staging"
                sh "docker image rmi detahermana/backend-cilist:stage-$BUILD_NUMBER"
                sh "docker image rmi detahermana/frontend-cilist-stag:stage-$BUILD_NUMBER"
                }else{ 
                sh "kubectl set image deployment/backend-app backend-app=detahermana/backend-cilist:prod-$BUILD_NUMBER -n production"
                sh "kubectl set image deployment/frontend-app frontend-app=detahermana/frontend-cilist-prod:prod-$BUILD_NUMBER -n production"
                sh "docker image rmi detahermana/backend-cilist:prod-$BUILD_NUMBER"
                sh "docker image rmi detahermana/frontend-cilist-prod:prod-$BUILD_NUMBER"
                }
                }
            }
          }
        }
      }