#!/bin/bash
#
# --np do not show the progress bar

for node in $(mco find --np -C profiles::base)
do
  echo "restarting ssh on $node"
  mco service --np sshd restart -I $node >/dev/null
  sleep 2
  mco rpc service status service=sshd -I $node -j | \
    jgrep data.status=running -s data.status >/dev/null
  echo "ssh is up on $node"
done
