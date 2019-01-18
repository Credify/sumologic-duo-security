FROM docker-upgrade.artifactory.build.upgrade.com/container-base:20180917-9
LABEL maintainer=devops@upgrade.com

USER root
RUN amazon-linux-extras install python3 -y && pip3 install six botocore && yum clean all

USER upgrade
ADD . /opt/sumologic-duo-security/

WORKDIR /opt/sumologic-duo-security
CMD ["sh","-c" ,"python3 - <<<'import lambda_function; lambda_function.lambda_handler(req=None, context=None)'"]
