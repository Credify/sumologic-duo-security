FROM 118455887602.dkr.ecr.us-west-2.amazonaws.com/releases/images/python-base-2023:20250802101016-044569aa
LABEL maintainer=devops@upgrade.com

USER root
RUN pip3 install duo_client==4.2.0  botocore==1.12.81

USER upgrade
COPY lambda_function.py /opt/sumologic-duo-security/

WORKDIR /opt/sumologic-duo-security
CMD ["sh","-c" ,"python3 - <<<'import lambda_function; lambda_function.lambda_handler(req=None, context=None)'"]
