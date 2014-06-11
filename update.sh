#!/bin/bash

set -e
# set -x

(
  cd base
  docker build -t conf-base .
  docker rm conf-base || true
  docker run -d --name conf-base conf-base true
)

# Get list of folders in proper dependency order
dirs=`bundle exec ruby graph.rb`

for dir in $dirs
do
  if [ -d "$dir" ]; then
    tag=conf-$dir
    (
      echo $dir
      cd $dir
      docker build -t $tag .
      docker rm $tag || true
      docker run -d --name $tag $tag true
    )
  fi
done


echo
echo "#############################"
echo
echo "To try, run:"
echo docker run -i -t --volumes-from conf-nginx-qa ubuntu:12.04 /bin/bash
echo "Then ls /usr/local/etc, you will see the config files there"
echo
