#!/bin/bash

# TODO: ls ./*/Dockerfile
# Loop through all Dockerfiles and build dependency graph
# Looking at the FROM line in each file

# set -e
# set -x

(
  cd base
  docker build -t conf-base .
  docker rm conf-base || true
  docker run -d --name conf-base conf-base true
)

#for dir in ./*/
for dir in `find . -maxdepth 1 -mindepth 1 -type d -not -name 'base'`
do
  echo $dir
  tag=conf-${dir##*/}
  (
    echo $dir
    cd $dir
    docker build -t $tag .
    docker rm $tag || true
    docker run -d --name $tag $tag true
  )
done


echo
echo "#############################"
echo
echo "To try, run:"
echo docker run -i -t --volumes-from conf-nginx-qa ubuntu:12.04 /bin/bash
echo "Then ls /usr/local/etc, you will see the config files there"
echo
