pipeline {
    agent none
    environment {
        CODE_CHANGED = false
    }
    stages {
        stage('Preparation') {
            steps {
                git branch: 'master', url: 'https://github.com/beacon-hash/petclinic.git/'
            }
        }
        stage('Unit Test') {
            agent {
                docker {
                    image 'maven'
                    args '-v $JENKINS_HOME/.m2:/root/.m2 --user root --network devopslag'
            }
            }
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Integration Test') {
            agent {
                docker {
                    image 'maven'
                    args '-v $JENKINS_HOME/.m2:/root/.m2 --user root --network devopslag'
            }
            steps {
                sh 'mvn verify -DskipUnitTests'
            }
        }
        stage('Build') {
            agent {
                docker {
                    image 'maven'
                    args '-v $JENKINS_HOME/.m2:/root/.m2 --user root --network devopslag'
            }
            steps {
                sh 'mvn clean install'
            }
        }
        // stage('Static Code Analysis') {
        //     steps {
        //         withSonarQubeEnv(credentialsId: 'sonarqube-token', installationName: 'Sonarqube Server') {
        //             sh "mvn sonar:sonar -Dsonar.scanner.metadataFilePath=${WORKSPACE}/report-task.txt clean package"
        //         }
        //     }
        // }
        // stage('Quality Gate') {
        //     steps {
        //         waitForQualityGate abortPipeline: true
        //     }
        // }
        // stage('Push to Artifactory') {
        //     steps {
        //         script {
        //             def pom = readMavenPom file: 'pom.xml'
        //             def repository = pom.version.endsWith("SNAPSHOT") ? "petclinic-snapshot" : "petclinic-release"
        //             nexusArtifactUploader artifacts: [
        //                 [
        //                     artifactId: "${pom.artifactId}", 
        //                     classifier: '', 
        //                     file: "target/${pom.artifactId}-${pom.version}.jar", 
        //                     type: 'jar'
        //                 ]
        //             ], 
        //             credentialsId: 'nexus-creds', 
        //             groupId: "${pom.groupId}", 
        //             nexusUrl: 'nexus:8081', 
        //             nexusVersion: 'nexus3', 
        //             protocol: 'http', 
        //             repository: "${repository}", 
        //             version: "${pom.version}"
        //         }

        //     }
        // }
        stage('test') {
            agent {label 'master'}
            steps {
                script {
                    def changedFiles = sh(script: 'git diff --name-only HEAD~1 HEAD', returnStdout: true).trim().split()
                    for (int i = 0; i < changedFiles.size(); ++i) {
                        if (changedFiles[i] =~ '^src.*') {
                            CODE_CHANGED = true
                            break
                        }
                    }
                    echo "${CODE_CHANGED}"
                }
            }

        }
    }

}