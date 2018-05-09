# Simple node creator for VirtualBox

Script does as advertised, it will create 3 nodes in virtualbox, using a nat for outbound calls and a host-only network. Nothing to fancy, I just got sick and tired of creating and then recreating cluster nodes.

## Requirements

1. Base install of VM must have a snapshot to reference, use the google to find out how to do this.
2. [hostess](https://github.com/cbednarski/hostess) must be installed and runnable by root.
3. [ansible](http://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) is required to configure the nodes
4. [VirtualBox](https://www.virtualbox.org/wiki/Linux_Downloads) is installed and configured.
5. VM must have two interfaces, Adapter 1 is NAT and second Adapter is host-only

## Script Config

* *BASE* is the name of the VM
* *SNAPSHOT* is the snapshot you wish to create from, it will create a linked clone.
* *NO_CREATE* is the number of nodes you wish to create.
* *BASENAME* is the base name of the node, so if its g-node, it will create g-node1, g-node2 and so on.
* *EXTRA_DISK_PATH* is the path name where you want to create the disks. (min are on a seperate SSD to allow faster access)

*Note* The hosts file must contain the correct number of names so that the ansible script can configure them. (Couldn't be bothered automating it)

## Run

```shell
$ ./3node-vm.sh
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Machine has been successfully cloned as "g-node1"
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Medium created. UUID: eefe42ad-6a5c-49f6-a083-a7d092c07d95
Waiting for VM "g-node1" to power on...
VM "g-node1" has been successfully started.
Name: /VirtualBox/GuestInfo/Net/1/Status, value: Up, flags:
Updated g-node1 -> 192.168.56.116 (On)
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Machine has been successfully cloned as "g-node2"
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Medium created. UUID: 7222f50a-12a2-4d06-a833-fa8146f5f980
Waiting for VM "g-node2" to power on...
VM "g-node2" has been successfully started.
[........ SNIP ..... ]
PLAY RECAP ****************************************************************
g-node1                    : ok=5    changed=4    unreachable=0    failed=0
g-node2                    : ok=5    changed=4    unreachable=0    failed=0
g-node3                    : ok=5    changed=4    unreachable=0    failed=0
```

Enjoy
