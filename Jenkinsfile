node {
	def app
	def image = 'registry.hub.docker.com/partha03051989/test01'
	def branch = 'master'
	
	try {
		stage('Clone Repository') {               
	    	git branch: branch,
	        	credentialsId: 'GitHub Credentials',
	        	url: 'https://github.com/partha03051989/test01.git'
	    }
		stage('Sonar Qube Code Check'){
                         withSonarQubeEnv(credentialsId: 'SonarQube',installationName: 'SonarQube'){	 
                            sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.7.0.1746:sonar -Dsonar.login="admin" -Dsonar.password="sarathi1@DO" '
			 }
		}
	       
		stage('Building Artifactory') {
	    	docker.image('maven:3.6.3-jdk-11').inside('-v /root/.m2:/root/.m2') {
	        	sh 'mvn -B clean package'
	        	stash includes: '**/target/my-app-1.0-SNAPSHOT.jar', name: 'jar'
	    	}
	    }
	     
	    stage('Build Docker Image') {
	    	unstash 'jar'
			app = docker.build image
	    }
	    
	    stage('Pushing Docker Image') {
	    	docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_id') {            
				app.push("latest")
	        }    
	    }
	} catch (e) {
		echo 'Error occurred during build process!'
		echo e.toString()
		currentBuild.result = 'FAILURE'
	} finally {
        junit '**/target/surefire-reports/TEST-*.xml'		
	}
}
