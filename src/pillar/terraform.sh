#!/bin/bash

set -e

SCRIPT_PATH="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
CURRENT_DIRECTORY="$(basename "$SCRIPT_PATH")"
ACTION=$1
ENV=$2
shift 2
other="$*"
# must be subscription in lower case
subscription=""
BACKEND_CONFIG_PATH="../.env/${ENV}/${CURRENT_DIRECTORY}_state.tfvars"

echo "[INFO] This is the current directory: ${CURRENT_DIRECTORY}"

if [ -z "$ACTION" ]; then
  echo "[ERROR] Missed ACTION: init, apply, plan"
  exit 0
fi

if [ -z "$ENV" ]; then
  echo "[ERROR] ENV should be: dev, uat or prod."
  exit 0
fi

# shellcheck source=/dev/null
source "../.env/$ENV/backend.ini"

az account set -s "${subscription}"

if echo "init plan apply refresh import output state taint destroy" | grep -w "$ACTION" > /dev/null; then
  if [ "$ACTION" = "init" ]; then
    echo "[INFO] init tf on ENV: ${ENV}"
    terraform "$ACTION" -backend-config="${BACKEND_CONFIG_PATH}" "$other"
  elif [ "$ACTION" = "output" ] || [ "$ACTION" = "state" ] || [ "$ACTION" = "taint" ]; then
    # init terraform backend
    terraform init -reconfigure -backend-config="${BACKEND_CONFIG_PATH}"
    terraform "$ACTION" "$other"
  else
    # init terraform backend
    echo "[INFO] init tf on ENV: ${ENV}"
    terraform init -reconfigure -backend-config="${BACKEND_CONFIG_PATH}"

    echo "[INFO] run tf with: ${ACTION} on ENV: ${ENV} and other: >${other}<"
    terraform "${ACTION}" \
    -compact-warnings \
    -var-file="../.env/${ENV}/terraform.tfvars" \
    $other
  fi
else
    echo "[ERROR] ACTION not allowed."
    exit 1
fi
