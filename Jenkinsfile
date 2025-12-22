pipeline{
	agent any

	tools {
		jdk 'java-11'
		maven 'maven'
	}

	stages{
		stage('Git checkout'){
			steps{
				git branch: 'verion-1', url: 'https://github.com/Gangappa98/test-1.git'
			}
		}
		stage('Compile'){
			steps{
				sh 'mvn compile'
			}
		}		
		stage('Build'){
			steps{
				sh 'mvn clean install'
			}
		}
		stage('Compile'){
			steps{
				sh 'mvn compile'
			}
		}
		stage('Building-DockerImage'){
			steps{
				sh 'docker build -t Gangappa98/continous-intergartion:1 .'
			}
		}

		stage('Contianersation'){
			sh '''
				docker stop c1 || true
				docker rm c1 || true
				docker run -it -d --name c1 -p 9000:8080 Gangappa98/continous-intergartion:1

			'''	
		}

	}
}
