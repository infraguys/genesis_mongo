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


# Listen on all interfaces
sed -i "/  bindIp: 127.0.0.1/c\  bindIp: 0.0.0.0" /etc/mongod.conf

sudo mkdir -p /var/log/mongodb
sudo touch /var/log/mongodb/mongod.log
sudo chown mongodb:mongodb -R /var/log/mongodb

sudo systemctl enable --now mongod