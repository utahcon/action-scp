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
      6) KNOWN_HOSTS=$1;;
      7) SOURCE=$1;;
      8) DESTINATION=$1;;
      9) RECURSIVE=$1;;
      10) JUMPS=$1;;
      11) SSH_OPTIONS=$1;;
      12) VERBOSE=$1;;
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

# Write temporary known_hosts file
if [ -n "$KNOWN_HOSTS" ]; then
  if [ "$KNOWN_HOSTS" != "***" ]; then
    echo "$KNOWN_HOSTS" >> /tmp/known_hosts
  fi
  ARGUMENTS+=" -o UserKnownHostsFile=/tmp/known_hosts"
fi

# Write temporary identity file
if [ -n "$PRIVATE_KEY" ]; then
  if [ "$PRIVATE_KEY" != "***" ]; then
    echo "$PRIVATE_KEY" >> /tmp/identity
  fi
  ARGUMENTS+=" -i /tmp/identity -o StrictHostKeyChecking=no"
fi

if [ "$RECURSIVE" == "true" ]; then
  ARGUMENTS+=" -r"
fi

if [ -n "$PORT" ]; then
  ARGUMENTS+=" -P ${PORT}"
fi

if [ -n "$JUMPS" ]; then
  ARGUMENTS+=" -J $JUMPS"
fi

if [ -n "$SSH_OPTIONS" ]; then
  ARGUMENTS+=" -o $SSH_OPTIONS"
fi

if [ -n "$VERBOSE" ];  then
  ARGUMENTS+=" -vvvv"
fi

(
  cd "${GITHUB_WORKSPACE}" || exit;
  pwd
  ls -Al
  echo "scp ${ARGUMENTS} ${SOURCE} ${USERNAME}@${SERVER}:${DESTINATION}"
  scp "${ARGUMENTS}" "${SOURCE}" "${USERNAME}@${SERVER}":"${DESTINATION}"
)
