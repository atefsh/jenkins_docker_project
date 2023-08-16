pipeline {
   agent any

   stages {
      stage('Build') { 
	    steps { 
	    	sh 'echo "My first pipeline FROM GIT"' 
	    	sh ''' 
	    		echo "By the way, I can do more stuff in here" 
	    		ls -la ~ 
	    	''' 
	    } 
}  
      
	  stage('Test') {
         steps {
            echo 'The Test is started'
         }
      }
	  stage('Deploy') {
         steps {
            echo 'The Deploy is started'
         }
      }
      
   }
}
