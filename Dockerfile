FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y texlive texlive-binaries texlive-latex-recommended texinfo lmodern wget texlive-fonts-extra

RUN wget --no-check-certificate https://mirrors.ctan.org/macros/latex/contrib/moderncv.zip && \
  unzip moderncv.zip && \
  mkdir -p ~/texmf/tex/latex && \
  mv moderncv/ ~/texmf/tex/latex/

RUN texhash ~/texmf/

# Mount the host's current working directory onto /data so texi2pdf can be used without full paths
VOLUME "/data"
WORKDIR /data

ENTRYPOINT ["/usr/bin/texi2pdf"]

