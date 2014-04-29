FROM ubuntu:12.04
MAINTAINER Education Team education@docker.com
RUN apt-get update -qq
RUN apt-get install -qqy ca-certificates openjdk-6-jdk curl git-core
RUN mkdir -p /opt/jenkins/data/plugins
RUN curl -sf -o /opt/jenkins/jenkins.war -L http://mirrors.jenkins-ci.org/war/latest/jenkins.war
RUN curl -sf -o /opt/jenkins/data/plugins/git-client.hpi -L http://mirrors.jenkins-ci.org/plugins/git-client/latest/git-client.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/scm-api.hpi -L http://mirrors.jenkins-ci.org/plugins/scm-api/latest/scm-api.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/git.hpi -L http://mirrors.jenkins-ci.org/plugins/git/latest/git.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/github-api.hpi -L http://mirrors.jenkins-ci.org/plugins/github-api/latest/github-api.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/github.hpi -L http://mirrors.jenkins-ci.org/plugins/github/latest/github.hpi
ENV JENKINS_HOME /opt/jenkins/data
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/opt/jenkins/jenkins.war"]
