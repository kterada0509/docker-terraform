FROM alpine
MAINTAINER KOJIMA Kazunori kjm.kznr@gmail.com

RUN apk --update add git bash bzr git mercurial subversion openssh-client ca-certificates &&\
    rm -rf /var/cache/apk/*

ENV TERRAFORM_VERSION=0.6.7
ENV TERRAFORM_SHA256SUM=2e5de08f545e117eb9825b697c5ad290ee3fdcaae7d6de4b0e99830e58b38b2e

RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip &&\
    [ "${TERRAFORM_SHA256SUM}" = "$(sha256sum terraform_${TERRAFORM_VERSION}_linux_amd64.zip| awk '{print $1}')"  ] &&\
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin/ &&\
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

CMD ["/usr/bin/terraform"]
