pipeline {
    agent any

    environment {
        dbport = '3306'
        dbpath    = 'ticketsdb.cdye3ahabwlt.eu-west-1.rds.amazonaws.com'
    }

    stages {
        stage ("Test"){
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws-db-creds', passwordVariable: 'dbpassword', usernameVariable: 'dbuser')]) {
                    echo "test back end"
                    sh "mvn test"

                    echo "test front end"
                    sh "yarn test"
                }
            }
        }
    }

    stages {
        stage ("Build"){
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws-db-creds', passwordVariable: 'dbpassword', usernameVariable: 'dbuser')]) {
                                // Get some code from a GitHub repository
                                git url: 'https://github.com/HollyJenkins192/ticketmanager.git',
                                        credentialsId: 'git-creds',
                                        branch: 'main'

                                // Run Maven on a Unix agent.
                                echo "maven clean package"
                                sh "mvn clean package"

                                echo "maven build image"
                                sh "mvn spring-boot:build-image"

                                sh "docker build -t hollyrowena/ticketqueue ."

                                echo "built"
                        }
            }
        }

        stage ("Create Backend Docker"){
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws-db-creds', passwordVariable: 'dbpassword', usernameVariable: 'dbuser')]) {

                                echo "maven build image"
                                sh "mvn spring-boot:build-image"

                                sh "docker build -t hollyrowena/ticketqueue ."

                                echo "built"
                        }
            }
        }
        stage ("Create Frontend Docker"){
            steps {
                                echo "docker build image"
                                sh "docker build -t hollyrowena/ticketqueue ."

                                echo "built"
            }
        }
        stage ("Push to docker hub"){
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', passwordVariable: 'dockerpassword', usernameVariable: 'dockeruser')]) {
                                echo "docker push images"
                                sh "docker login --username $dockeruser --password $dockerpassword"
                                sh "docker push hollyrowena/ticketmanager"
                    sh "docker push hollyrowena/ticketqueue"
                }
            }
        }

        stage ("kubectl stage"){
            
        }
    }
}