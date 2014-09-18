FROM debian:jessie
MAINTAINER Education Team education@docker.com
RUN apt-get update -qq
RUN apt-get install -qqy ca-certificates openjdk-7-jdk curl git-core 

RUN mkdir -p /opt/jenkins/data/plugins
RUN curl -sf -o /opt/jenkins/jenkins.war -L http://mirrors.jenkins-ci.org/war/latest/jenkins.war
RUN curl -sf -o /opt/jenkins/data/plugins/git-client.hpi -L http://mirrors.jenkins-ci.org/plugins/git-client/latest/git-client.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/scm-api.hpi -L http://mirrors.jenkins-ci.org/plugins/scm-api/latest/scm-api.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/git.hpi -L http://mirrors.jenkins-ci.org/plugins/git/latest/git.hpi
#RUN curl -sf -o /opt/jenkins/data/plugins/github-api.hpi -L http://mirrors.jenkins-ci.org/plugins/github-api/latest/github-api.hpi
#RUN curl -sf -o /opt/jenkins/data/plugins/github.hpi -L http://mirrors.jenkins-ci.org/plugins/github/latest/github.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/docker-build-publish.hpi -L http://mirrors.jenkins-ci.org/plugins/docker-build-publish/latest/docker-build-publish.hpi
RUN curl -sf -o /opt/jenkins/data/plugins/token-macro.hpi -L http://mirrors.jenkins-ci.org/plugins/token-macro/latest/token-macro.hpi
#RUN curl -sf -o /opt/jenkins/data/plugins/notification.hpi -L http://mirrors.jenkins-ci.org/plugins/notification/latest/notification.hpi

ADD jenkins/com.cloudbees.dockerpublish.DockerBuilder.xml /opt/jenkins/data/com.cloudbees.dockerpublish.DockerBuilder.xml
ADD jenkins/com.cloudbees.jenkins.GitHubPushTrigger.xml /opt/jenkins/data/com.cloudbees.jenkins.GitHubPushTrigger.xml 
 
ADD jenkins/jobs/ /opt/jenkins/data/jobs/

RUN curl -sf -o /usr/local/bin/docker -L https://get.docker.io/builds/Linux/x86_64/docker-latest
ADD runjenkins.sh /usr/local/bin/runjenkins

RUN chmod 0755 /usr/local/bin/docker /usr/local/bin/runjenkins

ENV JENKINS_HOME /opt/jenkins/data
EXPOSE 8080
CMD ["/usr/local/bin/runjenkins"]
