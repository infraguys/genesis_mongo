#!/usr/bin/env bash

#    Copyright 2025 Genesis Corporation.
#
#    All Rights Reserved.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.

set -eu
set -x
set -o pipefail

GC_PATH="/opt/genesis_mongo"
PASSWD="${GEN_USER_PASSWD:-ubuntu}"

echo "Building genesis_mongo image"

[[ "$EUID" == 0 ]] || exec sudo -s "$0" "$@"

curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
   --dearmor

echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | \
    tee /etc/apt/sources.list.d/mongodb-org-8.0.list

sudo apt-get update
sudo apt-get install gnupg curl mongodb-org -y

# Set default password
cat > /tmp/__passwd <<EOF
ubuntu:$PASSWD
EOF

chpasswd < /tmp/__passwd
rm -f /tmp/__passwd

# Copy bootstrap scripts
cp "$GC_PATH/genesis/images/bootstrap.sh" /var/lib/genesis/bootstrap/scripts/    

# Clean up
sudo rm -fr "$GC_PATH"
