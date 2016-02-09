FROM alpine
MAINTAINER KOJIMA Kazunori kjm.kznr@gmail.com

RUN apk --update add git bash bzr git mercurial subversion openssh-client ca-certificates &&\
    rm -rf /var/cache/apk/*

ENV TERRAFORM_VERSION=0.6.11
ENV TERRAFORM_SHA256SUM=f451411db521fc4d22c9fe0c80105cf028eb8df0639bac7c1e781880353d9a5f

RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip &&\
    [ "${TERRAFORM_SHA256SUM}" = "$(sha256sum terraform_${TERRAFORM_VERSION}_linux_amd64.zip| awk '{print $1}')"  ] &&\
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin/ &&\
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

CMD ["/usr/bin/terraform"]
