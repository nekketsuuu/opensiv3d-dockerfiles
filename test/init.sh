#!/bin/bash

set -exu
apt-get update -y
apt-get install -y gdb valgrind
echo '/tmp/core-%p-%u-%g-%s-%t-%e' > /proc/sys/kernel/core_pattern
