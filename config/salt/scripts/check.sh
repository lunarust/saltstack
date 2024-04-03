#!/bin/bash

salt '*' test.version
salt '.*' cmd.run 'date'

# Salt Master Key: /etc/salt/pki/minion/minion_master.pub