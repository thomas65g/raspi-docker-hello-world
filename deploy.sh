#!/bin/bash
readonly target_address="$1"
readonly DEBUG_PORT="$2"
readonly FILEPATH="$3"
readonly USERNAME="$4"
readonly TARGET_DIR="/home/$4"

# Must match startsPattern in tasks.json
echo "Deploying to target"
PROGRAM="$(basename ${FILEPATH})"

# kill gdbserver on target and delete old binary
ssh ${USERNAME}@${target_address} "sh -c '/usr/bin/killall -q gdbserver; rm -rf ${TARGET_DIR}/${PROGRAM}  exit 0'"

# send the program to the target
scp ${FILEPATH} ${USERNAME}@${target_address}:${TARGET_DIR}

# Must match endsPattern in tasks.json
echo "Starting GDB Server on Target"

# start gdbserver on target
ssh -t ${USERNAME}@${target_address} "sh -c 'cd ${TARGET_DIR}; gdbserver localhost:${DEBUG_PORT} ${PROGRAM}'"
