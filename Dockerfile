FROM docker-upgrade.artifactory.build.upgrade.com/python-base-2023:2.0.20250610.0-36.3.8-195
LABEL maintainer=devops@upgrade.com

USER root
RUN pip3 install duo_client==4.2.0  botocore==1.12.81

USER upgrade
COPY lambda_function.py /opt/sumologic-duo-security/

WORKDIR /opt/sumologic-duo-security
CMD ["sh","-c" ,"python3 - <<<'import lambda_function; lambda_function.lambda_handler(req=None, context=None)'"]
