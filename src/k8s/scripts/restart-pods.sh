#!/bin/bash

if [ $# -lt 1 ]; then
  echo 1>&2 "$0: missed namespace!! usage: $0 <namespace>"
  exit 2
elif [ $# -gt 1 ]; then
  echo 1>&2 "$0: too many arguments"
  exit 2
fi

namespace=$1
waitfor=3s

deploys=`kubectl -n $namespace get deployments | tail -n +2 | cut -d ' ' -f 1`
for deploy in $deploys; do
  kubectl -n $1 rollout restart deployments/$deploy
  sleep $waitfor
done
