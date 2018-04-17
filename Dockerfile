FROM centos:latest

MAINTAINER DimsDev

WORKDIR /git-server

RUN yum -y update && \
    yum -y install git epel-release wget dh-autoreconf curl-devel expat-devel gettext-devel && \
    yum -y install openssl-devel perl-devel zlib-devel && \
    yum -y install asciidoc xmlto docbook2X getopt

RUN ln -s /usr/bin/db2x_docbook2texi /usr/bin/docbook2x-texi

RUN git clone https://github.com/git/git.git

RUN git checkout tags/$(git describe --tags $(git rev-list --tags --max-count=1))

RUN   make configure && \
      ./configure --prefix=/usr && \
      make all doc info && \
      make install install-doc install-html install-info

CMD ["git","--version"]
