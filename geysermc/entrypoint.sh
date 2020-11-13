#!/usr/bin/env bash

#shellcheck disable=SC1091
source "/shim/umask.sh"
source "/shim/vpn.sh"

if [ -z ${MEM_LIMIT+x} ]; then
  MEM_LIMIT="1024M"
fi

exec /usr/bin/java -jar /app/Geyser.jar -Xmx "${MEM_LIMIT}" "${EXTRA_ARGS}"
