#!/bin/bash

function build_args() {
  local tag
  IFS=" "
  for tag in $1; do
    echo -n "--build-arg LINTERS_${tag}=true "
    
    if [[ " ${PYTHON[*]} " =~ " ${tag} " ]]; then
      echo -n "--build-arg PYTHON=true "
    fi
    
    if [[ " ${NODEJS[*]} " =~ " ${tag} " ]]; then
      echo -n "--build-arg NODEJS=true "
    fi
    
    if [[ " ${CURL[*]} " =~ " ${tag} " ]]; then
      echo -n "--build-arg CURL=true "
    fi
  done
}

PYTHON=(
  "YAML"
  "PYTHON"
  "HTML"
  "GENERIC"
  "DOTENV"
  "GIT"
)

NODEJS=(
  "CSS"
  "JAVASCRIPT"
  "FILES"
  "JSON"
  "MARKDOWN"
  "NPM"
  "GIT"
  "DOCKER"
  "HTML"
)

CURL=(
  "DOCKER"
  "TERRAFORM"
)

TAGS=(
  "DOCKER"
  "TERRAFORM"
  "SHELL"
  "YAML"
  "PYTHON"
  "HTML"
  "GENERIC"
  "DOTENV"
  "GIT"
  "ANSIBLE"
  "CSS"
  "JAVASCRIPT"
  "FILES"
  "JSON"
  "MARKDOWN"
)

function build() {
  local tags
  tags=$(IFS="|"
    for TAG in ${1}; do
      echo "${TAG}"
    done | sort | tr "\n" " "
  )
  tags=${tags:0:((${#tags} - 1))}
  
  local version
  version=${2:-$(echo "${tags}" | tr "[:upper:]" "[:lower:]" | tr " " "-")}
  
  local build_args
  build_args=$(build_args "${tags}")
  
  bash -c "docker build ${build_args} -t danielruthardt/linters:${version} ."
  docker push "danielruthardt/linters:${version}"
}

ALL_COMBINATIONS=$(./combinations.py ${#TAGS[@]} ; ./combinations.py 1 ; ./combinations.py 2;)
IFS="
"
for COMBINATIONS in $ALL_COMBINATIONS; do
  IFS=","
  for COMBINATION in $COMBINATIONS; do
    COMBINATION=$(echo "${COMBINATION}" | grep -oE "[A-Z|]+")
    if [ "$(echo "${COMBINATION}" | awk -F"|" '{print NF}')" -eq "${#TAGS[@]}" ]; then
      build "${COMBINATION}" "all"
    else
      build "${COMBINATION}"
    fi
  done
done

build "HTML|CSS"
build "HTML|CSS|JAVASCRIPT|JSON"
build "NPM|JAVASCRIPT|JSON"
build "GIT|FILES|GENERIC"
build "PHYTON|YAML|JSON"
build "TERRAFORM|ANSIBLE"