# Pandoc and Kindlegen for publishing

FROM alpine:latest

LABEL maintainer "https://github.com/JenniferMack/docker-pandoc"

# Update this to trigger new build
ENV PANDOC_VER "1.19.2.1"

# Package manager stuff
RUN apk update && apk add bash curl libarchive-tools

# Install Kindlegen
RUN curl -Lsf http://kindlegen.s3.amazonaws.com/kindlegen_linux_2.6_i386_v2_9.tar.gz \
    | tar xz -C /usr/local/share/ && ln /usr/local/share/kindlegen /usr/local/bin/

# Install Pandoc latest
RUN curl -Lsf https://github.com/jgm/pandoc/releases/download/$PANDOC_VER/pandoc-$PANDOC_VER-1-amd64.deb \
    | bsdtar xOf - data.tar.gz | tar xvz --strip-components 2 -C /usr/local \
    && rm /usr/local/bin/pandoc-citeproc

CMD ["bash"]

