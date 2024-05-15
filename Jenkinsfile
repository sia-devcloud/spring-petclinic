pipeline {

	// More info about the Declarative Pipeline Syntax on https://www.jfrog.com/confluence/display/JFROG/Declarative+Pipeline+Syntax
	// Declarative syntax is available from version 3.0.0 of the Jenkins Artifactory Plugin.

	agent any

	
	environment {
		MAVEN_HOME = '/opt/apache-maven-3.9.6' // Set to the local MAVEN installation path.
	}

	
	stages {
		
		stage ("Clone") {
			steps {
				git branch: "main",
				url: "https://github.com/spring-projects/spring-petclinic.git"
				// credentialsId: 'git_cred_id'. If cloning the code requires credentials, set the credentials to your git in Jenkins > Configure System > credentials > "username with password" > ID: "git-cred-id"
			}
		}

		stage ("Artifactory configuration") {
			steps {
				rtServer (
					id: "jfrog-instance",
					url: "https://siadevops.jfrog.io/artifactory/",
					credentialsId: 'SONACLOUD_JENKINS', // Set the credentials to your JFrog instance in Jenkins > Configure System > credentials > "username with password" > ID: "rt-cred-id"

 					// bypassProxy: true, (If Jenkins is configured to use an http proxy, you can bypass the proxy when using this Artifactory server)
					// timeout: 300 , (Configure the connection timeout (in seconds). The default value (if not configured) is 300 seconds)
				)
				rtMavenDeployer (
					id: "MAVEN_DEPLOYER",
					serverId: "jfrog-instance",
					releaseRepo: "siadevops-libs-snapshot-local",
					snapshotRepo: "siadevops-libs-snapshot-local",

					// threads: 6, (Optional - Attach custom properties to the published artifacts)
					// properties: ['key1=value1', 'key2=value2'], (Optional - Attach custom properties to the published artifacts)
				)
			}
		}

		stage ("Exec Maven") {
			steps {
				rtMavenRun (
					pom: 'pom.xml', // path to pom.xml file
					goals: "clean install",
					deployerId: "MAVEN_DEPLOYER",

					// tool: {build installation name}, (Maven tool installation from jenkins from : Jenkins > Manage jenkins > Global Tool Configuration > Maven installations)
					// useWrapper: true, (Set to true if you'd like the build to use the Maven Wrapper.)
					// opts: '-Xms1024m -Xmx4096m', (Optional - Maven options) test git hooks
				)
			}
		}

		stage ("Publish build info") {
			steps {
				rtPublishBuildInfo (
					serverId: "jfrog-instance",
				)
			}
		}

	}
}