pipeline {
    agent { label "docker" }
    environment {
        CHECKOUT_DIR = 'checkout_dir'
        DOCKER_IMAGE_NAME = 'jenkins_project_imgae'
        DOCKER_TAG = 'V1'
        CONTAINER_NAME = "final_jenkins_project_$BUILD_NUMBER"
        SLEEP_TIME = '3'
    }
   
   
    triggers {
        pollSCM('* * * * *')
    }
    
    stages {
        stage('Checkout Code') {
            steps {
                script {
                    checkout([$class: 'GitSCM',
                              branches: [[name: '*/main']],
                              userRemoteConfigs: [[url: 'https://github.com/atefsh/jenkins_docker_project.git']],
                              extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'checkout_dir']]])
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                sh """
                cd $CHECKOUT_DIR
                docker build -t $DOCKER_IMAGE_NAME:$DOCKER_TAG . 
                """
            }    
        
        }
        
        stage("Check Image") {
            steps {
                sh """
                docker images  | grep $DOCKER_IMAGE_NAME
                """
            }
        }
        
        stage("Check Container") {
            steps {
                script {
                    def status = sh(returnStatus: true, script: "docker ps -a --format '{{.Names}}' | grep $CONTAINER_NAME")
                    if (status == 0) {
                        echo "There is docker container is running with same name $CONTAINER_NAME"
                        currentBuild.result = 'FAILURE'
                        
                    }
                }
            }
        }
        
        stage('Run Container') {
            steps {
                sh "docker run -d --rm --name $CONTAINER_NAME $DOCKER_IMAGE_NAME:$DOCKER_TAG"
            }
        }
        
        stage("Sleep") {
            steps {
                sh "sleep $SLEEP_TIME"
            }
        }
        
        stage('Check Container Status') {
            steps {
                script {
                    def status = sh(returnStatus: true, script: "docker ps -a --format '{{.Names}}' | grep $CONTAINER_NAME")
                    if (status == 0) {
                        echo "There is docker container is running with same name $CONTAINER_NAME"
                        sh "docker rm -f $CONTAINER_NAME"
                        currentBuild.result = 'FAILURE'
                        
                    }
                }
            }
        }
    }
    
    post {
        always {
            sh 'rm -rf $CHECKOUT_DIR'
        }
        
        failure {
            echo "TEST IS FAILED"
        }
        
        success {
            echo "TEST IS PASSED SUCCESSFULLY"
        }
        
        
    }
}
