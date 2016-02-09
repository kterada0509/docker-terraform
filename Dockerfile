FROM alpine
MAINTAINER KOJIMA Kazunori kjm.kznr@gmail.com

RUN apk --update add git bash bzr git mercurial subversion openssh-client ca-certificates &&\
    rm -rf /var/cache/apk/*

ENV TERRAFORM_VERSION=0.6.9
ENV TERRAFORM_SHA256SUM=c7d3e76de165be9f47eff8f54b41bb873f6f1881d2fb778a54bb8aaf69abfae6

RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip &&\
    [ "${TERRAFORM_SHA256SUM}" = "$(sha256sum terraform_${TERRAFORM_VERSION}_linux_amd64.zip| awk '{print $1}')"  ] &&\
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin/ &&\
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

CMD ["/usr/bin/terraform"]
