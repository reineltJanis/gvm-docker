#!/usr/bin/env bash

STAGE="${1}"
[[ "${STAGE}" == "" ]] && STAGE="stable"

source $HOME/.cargo/env

source "./${STAGE}"


_build(){
  python3 setup.py install
}

_download_git(){
  git clone https://github.com/greenbone/ospd.git \
  && cd ospd \
  && git reset --hard ${COMMIT}
}

_dowload_release(){
  wget -c ${RELEASE_URL} \
  && tar -xzvf *.tar.gz \
  && cd ospd*
}

if [ ! -z "${COMMIT}" ]; then
  _download_git
else
  _dowload_release
fi

_build
