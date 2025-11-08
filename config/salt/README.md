# Salt Master Configuration


# Salt Minions Configuration



# Salt Key

## Check:
```bash
salt-key -L
Accepted Keys:
Denied Keys:
Unaccepted Keys:
bors.greece.local
helios.greece.local
Rejected Keys:
```

## Accept all hosts:
```bash
salt-key -A
The following keys are going to be accepted:
Unaccepted Keys:
bors.greece.local
helios.greece.local
Proceed? [n/Y] y
Key for minion bors.greece.local accepted.
Key for minion helios.greece.local accepted.
```

## Confirm your minions can communicate with your master:
```bash
salt '*' test.version
helios.greece.local:
    3007.8
bors.greece.local:
    3007.8

```

# Note:
You can delete a key if needed.
salt-key -d helios.greece.local


if you changed salt-master you will have to remove the cert from the minion before you can register it back.
In that situation you will have the following errors in salt minion logs
```
Error while bringing up minion for multi-master. Is master at 192.168.1.217 responding? The error message was Unable to sign_in to master: Invalid signature
```
Steps:
```bash
systemctl stop salt-minion
mv pki/minion/ /etc/salt/pki/minion.old
systemctl start salt-minion && systemctl status salt-minion
```
