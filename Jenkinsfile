def gv
def version

pipeline{
    agent any
  tools {
    maven 'maven'
  }
    stages{
        stage("initialize_pipeline"){
        // here we are loading the groovy scripts
        // required = true
            steps{
                script{
                    gv = load "script.groovy"
                    echo "loaded script.groovy"
                }
            }
        }

        stage("increment version"){
        // increment version of pom.xml
            steps{
                script{
                    if (gv.isStringFoundInLastCommit("minor-update")){
                        gv.incrementMinorVersion()
                    } else if (gv.isStringFoundInLastCommit("major-update")){
                        gv.incrementMajorVersion()
                    } else if ((gv.isStringFoundInLastCommit("no-version-increment"))){
                          echo 'skipping version incrementing'
                      }
                      else {
                        gv.incrementPatchVersion()
                    }
                }
            }
        }
        stage("test"){
            steps{
              script{
                  echo "testing"
                  gv.test()
              }
            }
        }
        stage("build docker-image"){
            steps{
              script{
                // test are included here
                  echo "building the docker image ${IMAGE_TAG}"
                  gv.buildImage()
              }
            }
        }
        stage("push docker-image"){
            steps{
              script{
                  gv.pushImage()
              }
            }
        }
        stage("deploy"){
            steps{
              script{
                    echo "deplyment stage"
//                    gv.deployImage()
              }
            }
        }
        stage("committing new version"){
            steps{
                script{
                    gv.commitVersion()
                }
            }
        }
    }
}