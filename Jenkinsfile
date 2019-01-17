standardPipeline ([timeout: 60], {
  standardNode {
    checkoutStage {}

    stage('Update .version') {
      sh "date +%Y%m%d-${env.BUILD_NUMBER} > .version"
      echo "Set version to ${readFile '.version'}"
    }

    if (isMasterBranch()) {
      def version = latestDockerTag repoName()
      def tags = dockerBuildStage {}
      autoPublishStage {
        isNewVersion =  { a, b ->
            // Follow the pattern 10-1, 10-2, 10-3, ..., 11-1, ...
            versionGreaterThan(a, b, "-")
        }
        getPublishedVer = {
          version
        }
      }
    } else {
      dockerBuildStage {}
    }
  }
})