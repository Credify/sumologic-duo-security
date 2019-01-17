FROM docker-upgrade.artifactory.build.upgrade.com/container-base:20180917-9
LABEL maintainer=devops@upgrade.com

USER root

ENV I_KEY i_key
ENV S_KEY s_key
ENV HOST host
ENV COLL_ENDPOINT endpoint
ENV SCAN_INTERVAL_IN_SEC scan_interval_in_sec

RUN amazon-linux-extras install python3 -y && pip3 install six botocore && yum clean all
ADD . /opt/sumologic-duo-security/

WORKDIR /opt/sumologic-duo-security
CMD ["sh","-c" ,"python3 - <<<'import lambda_function; lambda_function.lambda_handler(req=None, context=None)'"]
