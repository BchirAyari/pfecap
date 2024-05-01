pipeline {
    agent any


    environment {
        DOCKER_REPO = 'ayaribechir/devopspfe'
        DOCKER_IMAGE_TAG = 'latest'
    }

    stages {
        stage('checkout Code') {
            steps {
                echo 'PFE job pipeline'
                checkout([$class: 'GitSCM',
                    branches: [[name: 'main']], // Utilisez 'main' au lieu de '*/main'
                    userRemoteConfigs: [[url: 'https://github.com/BchirAyari/pfecap.git']]
                ])
            }
        }


        stage('Install Dependencies') {
            steps {
                // Assurez-vous que Node.js et npm sont installés sur l'agent Jenkins
                sh 'npm install'
            }
        }
        stage('OWASP SCAN'){
        	steps {
	        	dependencyCheck additionalArguments: ' --scan ./', odcInstallation: 'DP'
	        	dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
        	}
        }
        stage('Build') { // Renommé de 'build' à 'Build' pour suivre les conventions de casse
            steps {
                sh 'ng build'
            }
        }
        stage('Unit Test') { // Renommé de 'test' à 'Test' pour suivre les conventions de casse
            steps {
                sh 'ng test --watch=false --browsers=ChromeHeadless'
            }
        }
       // stage('Integration Tests') { // Renommé de 'test' à 'Test' pour suivre les conventions de casse
          //  steps {
                //ng test --include=**/*.integration.spec.ts
              //  sh 'ng test  --watch=false --browsers=ChromeHeadless'
            //}
        //}
        stage('Quality analysis') {
            steps {
               // sh 'ng add @angular-eslint/schematics'
                sh 'ng lint'
            }
        }
         //stage('End-to-end test') { // Renommé de 'test' à 'Test' pour suivre les conventions de casse
           // steps {
             //   sh 'ng e2e'
            //}
        //}
        stage('Build Docker Image'){
            steps{
                ///var/lib/jenkins/workspace/pfecapgiminipip
                sh 'docker build -t ${DOCKER_REPO}:${DOCKER_IMAGE_TAG} .'
            }
        }
        stage('Push Docker Image to Docker Hub') {
            steps {
                //${DOCKER_REPO}:${DOCKER_IMAGE_TAG}
                sh 'docker login -u "ayaribechir" -p "Aa00aa00&"'

                sh 'docker tag ${DOCKER_REPO}:${DOCKER_IMAGE_TAG} ${DOCKER_REPO}:${DOCKER_IMAGE_TAG}'

                sh 'docker push ${DOCKER_REPO}:${DOCKER_IMAGE_TAG}'
            }
        }

        stage('Trigger CD Pipeline') {
            steps {
                build job : "CD_PIPELINE" , wait:true
            }
        }
    }
}
