# Pandoc and Kindlegen for publishing

FROM debian:stable-slim

LABEL maintainer "https://github.com/JenniferMack/docker-pandoc"

# Update this to trigger new build
ENV PANDOC_VER "1.19.2.1"

ENV APT_CMD "apt-get install --yes --no-install-recommends"

# Debian stuff
RUN apt-get update -qq

# Install wget
RUN $APT_CMD wget

# Install Kindlegen
RUN wget -nv http://kindlegen.s3.amazonaws.com/kindlegen_linux_2.6_i386_v2_9.tar.gz -O /tmp/kindlegen.tar.gz
RUN tar xzf /tmp/kindlegen.tar.gz
RUN mv /tmp/kindlegen /bin/

# Install Pandoc latest
RUN wget -nv https://github.com/jgm/pandoc/releases/download/$PANDOC_VER/pandoc-$PANDOC_VER-1-amd64.deb -O /tmp/pandoc.deb
RUN dpkg -i /tmp/pandoc.deb

# Install PDF stuff
RUN $APT_CMD \
    texlive-latex-base \
    texlive-xetex \
    latex-xcolor \
    texlive-math-extra \
    texlive-latex-extra \
    texlive-fonts-extra \
    texlive-bibtex-extra \
    fontconfig

# Clean up
RUN rm -rf /tmp/*

CMD ["bash"]

