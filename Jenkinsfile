node {
	def app
	def image = 'registry.hub.docker.com/partha03051989/test01'
	def branch = 'master'
	
	try {
		stage('Clone repository') {               
	    	git branch: branch,
	        	credentialsId: 'GitHub Credentials',
	        	url: 'https://github.com/partha03051989/test01.git'
	    } 
	
		stage('Build JAR') {
	    	docker.image('maven:3.6.3-jdk-11').inside('-v /root/.m2:/root/.m2') {
	        	sh 'mvn -B clean package'
	        	stash includes: '**/target/my-app-1.0-SNAPSHOT.jar', name: 'jar'
	    	}
	    }
	     
	    stage('Build Image') {
	    	unstash 'jar'
			app = docker.build image
	    }
	    
	    stage('Push') {
	    	docker.withRegistry('https://registry.hub.docker.com', 'docker-hub') {            
				app.push("${env.BUILD_NUMBER}")
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
