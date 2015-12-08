#!/bin/sh

# Login.sh - Used for testing.

opts="-oStrictHostKeyChecking=false -oUserKnownHostsFile=/dev/null -oPort=22022"
ssh $opts data@localhost

