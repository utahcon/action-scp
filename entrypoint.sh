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
      11) VERBOSE=$1;;
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
  if [ "$PRIVATE_KEY" != "***" ]; then
    echo "$PRIVATE_KEY" > identity_file
    chmod 0400 identity_file
  fi
  ARGUMENTS+=" -i identity_file -o StrictHostKeyChecking=no"
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
  echo "scp ${ARGUMENTS} ${SOURCE} ${USERNAME}@${SERVER}:${DESTINATION}"
  scp $ARGUMENTS $SOURCE $USERNAME@$SERVER:$DESTINATION
)
