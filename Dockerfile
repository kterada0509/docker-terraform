FROM sdurrheimer/alpine-glibc
MAINTAINER KOJIMA Kazunori kjm.kznr@gmail.com

ENV GOPATH /go
ENV PATH /go/bin:$PATH
ENV CGO_ENABLED 0

RUN apk --update add git bash bzr git mercurial subversion openssh-client ca-certificates
RUN wget https://releases.hashicorp.com/terraform/0.6.10/terraform_0.6.10_linux_amd64.zip
RUN unzip terraform_0.6.10_linux_amd64.zip -d /usr/bin/
RUN rm -rf /var/cache/apk/* terraform_0.6.10_linux_amd64.zip

CMD ["/usr/bin/terraform"]
