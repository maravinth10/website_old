node{
   stage('Aravinth SCM Checkout'){
     git 'https://github.com/maravinth10/website_old.git'
   }
   stage('Aravinth Compile-Package'){
      def mvnHome =  tool name: 'maven3', type: 'maven'   
      sh "${mvnHome}/bin/mvn clean package"
	  sh 'mv target/myweb*.war target/newapp.war'
   }
   stage('Aravinth SonarQube Analysis') {
	        def mvnHome =  tool name: 'maven3', type: 'maven'
	        withSonarQubeEnv('sonar') { 
	          sh "${mvnHome}/bin/mvn sonar:sonar"
	        }
	    }
   stage('Aravinth Build Docker Imager'){
   sh 'docker build -t jjaba/myweb:0.0.2 .'
   }
   stage('Aravinth Docker Image Push'){
   withCredentials([string(credentialsId: 'dockerPass', variable: 'dockerPassword')]) {
   sh "docker login -u jjaba -p ${dockerPassword}"
    }
   sh 'docker push jjaba/myweb:0.0.2'
   }
   stage('Aravinth Nexus Image Push'){
   sh "docker login -u admin -p Admin@123 ubuntunexus.local:8087"
   sh "docker tag jjaba/myweb:0.0.2 ubuntunexus.local:8087/jjaba:1.0.0"
   sh 'docker push ubuntunexus.local:8087/jjaba:1.0.0'
   }
   stage('Aravinth Remove Previous Container'){
	try{
		sh 'docker rm -f tomcattest'
	}catch(error){
		//  do nothing if there is an exception
	}
   stage('Aravinth Docker deployment'){
   sh 'docker run -itd -p "8090:8080" --name tomcattest -v "/opt/tomcatsync/syc:/usr/local/tomcat/syc" jjaba/myweb:0.0.2'
   }
}
	stage ('Aravinth File Transfer'){
	 sh "sshpass -f '/opt/tomcatsync/pass' scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -r Dockerfile ec2-user@ubuntuwebserver.local:/opt/tomcatsync/"
	 }
}
