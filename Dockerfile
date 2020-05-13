FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q \
    && apt-get install -qy build-essential wget libfontconfig1 texlive-extra-utils texlive-fonts-recommended \
    && rm -rf /var/lib/apt/lists/*

# Install TexLive with scheme-basic
RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz; \
	mkdir /install-tl-unx; \
	tar -xvf install-tl-unx.tar.gz -C /install-tl-unx --strip-components=1; \
    echo "selected_scheme scheme-basic" >> /install-tl-unx/texlive.profile; \
	/install-tl-unx/install-tl -profile /install-tl-unx/texlive.profile; \
    rm -r /install-tl-unx; \
	rm install-tl-unx.tar.gz

ENV PATH="/usr/local/texlive/2019/bin/x86_64-linux:${PATH}"

ENV HOME /data
WORKDIR /data

RUN tlmgr init-usertree
RUN tlmgr update --self

# Install latex packages
RUN tlmgr install latexmk

VOLUME ["/data"]
ENTRYPOINT ["pdflatex"]

# Remember to change your base version if needed
# FROM blang/latex:ctanbasic

# Useful tex stuff
RUN tlmgr install collection-fontsrecommended booktabs multirow todonotes endnotes cite pbox IEEEtran koma-script eso-pic blindtext lipsum l3packages comment pdfescape letltxmacro
RUN tlmgr install bitset
RUN tlmgr install xstring
RUN tlmgr install microtype
RUN tlmgr install etoolbox
RUN tlmgr install totpages
RUN tlmgr install environ
RUN tlmgr install trimspaces
RUN tlmgr install textcase
RUN tlmgr install ncctools caption cmap float
RUN tlmgr install listings anysize makecell
RUN tlmgr install mdwtools
RUN tlmgr install soul
RUN tlmgr install adjustbox
RUN tlmgr install collectbox
RUN tlmgr install footmisc
RUN tlmgr install tcolorbox

