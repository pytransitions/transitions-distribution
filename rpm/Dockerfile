# Builds an srpm from transitions PyPI package and pushes it to COPR
# Example call:
# docker build -t transitions-copr --build-arg COPR_TOKEN="$(awk -v ORS='\\n' '1' ~/.config/copr)" --build-arg VERSION=$(pip index versions transitions | grep transitions | cut -c 14-19) .

FROM fedora:latest

RUN dnf -y install @development-tools @rpm-development-tools copr-cli make python3-pip
RUN python3 -m pip install copr-cli pyp2rpm 

ARG COPR_TOKEN
ARG VERSION
ARG RELEASE=1
# VERSION and COPR_TOKEN must be passed!
# don't test for COPR_TOKEN to prevent output to stdout
RUN test -n "$VERSION"  

WORKDIR /workspace
RUN mkdir -p $HOME/.config/
RUN printf "${COPR_TOKEN}" > "$HOME/.config/copr"

COPY python3-transitions.spec.tpl python3-transitions.spec.tpl
RUN sed -e "s|@VERSION@|${VERSION}|g" \
	    -e "s|@RELEASE@|${RELEASE}|g" \
	    -e "s|@DATE@|$(date +'%a %b %d %Y')|g" \
	    python3-transitions.spec.tpl > python3-transitions.spec
RUN pyp2rpm -s -r python3-transitions -d . --srpm transitions -t python3-transitions.spec
RUN copr-cli build python3-transitions *.src.rpm
