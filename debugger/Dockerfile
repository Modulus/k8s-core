FROM alpine:latest

RUN apk add curl bind-tools python3

WORKDIR /tmp

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    &&  chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl \
    && pip3 install pip --upgrade && pip3 install awscli \
    && curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator \
    && chmod +x ./aws-iam-authenticator && mv ./aws-iam-authenticator /usr/local/bin/aws-iam-authenticator \