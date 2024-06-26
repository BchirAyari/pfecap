pipeline {
    agent any
    environment {
        DOCKER_REPO = 'ayaribechir/devopspfe'
        DOCKER_IMAGE_TAG = 'latest'
        //CHROME_BIN = '/usr/bin/google-chrome'  // Pour Google Chrome
        CHROME_BIN = '/usr/bin/chromium-browser'  // Pour Chromium, décommentez cette ligne si vous utilisez Chromium
        // SCANNER_HOME=tool 'sonar-scanner'
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
        stage('Trivy FS Scan') {
            steps {
                sh "trivy fs . --format table -o /tmp/fs-report.html"
            }
        }
        //stage('OWASP dependency check'){
        	//steps {
        	  //   dependencyCheck additionalArguments: ' --scan ./', odcInstallation: 'Default'
	        //	dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
        	//}
        //}
        stage('Build') { // Renommé de 'build' à 'Build' pour suivre les conventions de casse
            steps {
                sh 'ng build'
            }
        }
        //stage('Unit Test') {
          //  when {
            //    expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            //}
            //steps {
              //  sh 'xvfb-run --auto-servernum --server-args="-screen 0 1024x768x24" ./node_modules/.bin/ng test --watch=false --browsers=ChromeHeadless'
            //}
        //}
        stage('Unit Test') { // Renommé de 'test' à 'Test' pour suivre les conventions de casse
            steps {
                sh 'ng test --watch=false --browsers=ChromeHeadless'
            }
        }
        //stage('Integration Tests') { // Renommé de 'test' à 'Test' pour suivre les conventions de casse
          //  steps {
            //    sh 'ng test --include=**/*.integration.spec.ts'
              //  sh 'ng test  --watch=false --browsers=ChromeHeadless'
            //}
        //}
        stage('Quality analysis') {
            steps {
               // sh 'ng add @angular-eslint/schematics'
                sh 'ng lint'
            }
        }
        stage('Build Docker Image'){
            steps{

                sh 'docker build -t ${DOCKER_REPO}:${DOCKER_IMAGE_TAG} .'
            }
        }
        stage('Docker Image Scan'){
            steps{
                sh 'trivy image --timeout 60m --output /var/lib/jenkins/workspace/CI_PIPELINE/trivy-fs-report.txt ${DOCKER_REPO}:${DOCKER_IMAGE_TAG}'
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
        stage('Send Trivy Report'){
        steps {
        	always{
        		emailext(
        			subject: 'Trivy Security Scan Report',
        			body: 'Please find attached the Trivy security scan report',
        			attachmentsPattern: '/var/lib/jenkins/workspace/CI_PIPELINE/trivy-fs-report.txt',
        			to: "bechir.ayari@esprit.tn",
        			from: "jenkins@example.com",
        			replyTo: "jenkins@example.com"
        		)
             }
          }
        }

        //stage('Trigger CD Pipeline') {
           //steps {
             //  build job : "CD_PIPELINEE" , wait:true
           // }
        //}
    }

}
