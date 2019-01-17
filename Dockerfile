FROM docker-upgrade.artifactory.build.upgrade.com/container-base:20180917-9
LABEL maintainer=devops@upgrade.com

USER root

ENV I_KEY i_key
ENV S_KEY s_key
ENV HOST host
ENV COLL_ENDPOINT endpoint
ENV SCAN_INTERVAL_IN_SEC scan_interval_in_sec

RUN curl  https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm --output /tmp/epel7.rpm && rpm -Uvh /tmp/epel7.rpm && yum install epel-release
RUN yum install -y python36 python36-libs python36-devel python36-setuptools && python3.6 -m ensurepip
RUN pip3 install six botocore

COPY lambda_function.py /opt/sumologic-duo-security/
COPY duo_client /opt/sumologic-duo-security/duo_client

WORKDIR /opt/sumologic-duo-security
CMD ["sh","-c" ,"python36 - <<<'import lambda_function; lambda_function.lambda_handler(req=None, context=None)'"]
