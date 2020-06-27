#!/usr/bin/env bash

# Handle Arguments
arg_pos=1

while (( "$#" )); do
  if [[ -n $1 ]]; then
    case $arg_pos in
      1) SERVER=$1;;
      2) PORT=$1;;
      3) USERNAME=$1;;
      4) PASSWORD=$1;;
      5) PRIVATE_KEY=$1;;
      6) SOURCE=$1;;
      7) DESTINATION=$1;;
      8) RECURSIVE=$1;;
      9) JUMPS=$1;;
      10) SSH_OPTIONS=$1;;
    esac
  fi
  arg_pos=$((arg_pos+1))
  shift
done

ARGUMENTS=""

# Check that we have username
if [ -z "$USERNAME" ]; then
  echo "USERNAME required"
  exit 1
fi

# scp [-i identity_file] [-J destination] [-o ssh_option] [-P port] source target
# Check that we have either private-key (preferred) or password
if [ -z "$PRIVATE_KEY" ]; then
  if [ -z "$PASSWORD" ]; then
    echo "Must provide either PASSWORD or PRIVATE_KEY"
    exit 1
  fi
fi

# Write temporary identity file
if [ -n "$PRIVATE_KEY" ]; then
  echo -e "$PRIVATE_KEY" >> /tmp/identity
  ARGUMENTS+=" -i /tmp/identity"
fi

(
  if [ -n "${GITHUB_ACTIONS}" ]; then
    cd "${GITHUG_WORKSPACE}" || exit;
  fi;
  scp "${ARGUMENTS}" -J "${DESTINATION}" "${SOURCE}" "${USERNAME}@${SERVER}"
)
