#!/usr/bin/env bash

trap "exit 1" TERM
TOP_PID=$$

_abort() {
  test -n "$*" && echo "$*" >&2
  kill -s TERM ${TOP_PID}
}

test -n "${WAIT_HANDLE}" || _abort "WAIT_HANDLE must be provided"
test -n "${UNIQUE_ID}" || _abort "UNIQUE_ID must be provided"

echo "Sleeping for ${WAIT_TIMEOUT} seconds"
sleep ${WAIT_TIMEOUT} || _abort "Sleep failed"

echo "Wait complete"
curl -v -i -s -XPUT \
     -H 'Content-Type:' \
     --data-binary "{\"Status\":\"SUCCESS\",\"Reason\":\"Timeout elapsed\",\"UniqueId\":\"${UNIQUE_ID}\",\"Data\":\"Timeout elapsed\"}" \
     ${WAIT_HANDLE} || _abort "Error triggering wait condition!"

echo "Wait condition triggered"

test -n "${KEEP_ALIVE_AFTER_TRIGGER}" && yes >/dev/null
