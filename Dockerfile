FROM alpine
MAINTAINER KOJIMA Kazunori kjm.kznr@gmail.com

RUN apk --update add git bash bzr git mercurial subversion openssh-client ca-certificates &&\
    rm -rf /var/cache/apk/*

ENV TERRAFORM_VERSION=0.6.13
ENV TERRAFORM_SHA256SUM=8eeddca53958d5c871de93a624eb0f5971f97cbaf107e0b2d1cc289f2ac21b79

RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip &&\
    [ "${TERRAFORM_SHA256SUM}" = "$(sha256sum terraform_${TERRAFORM_VERSION}_linux_amd64.zip| awk '{print $1}')"  ] &&\
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin/ &&\
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

CMD ["/usr/bin/terraform"]
