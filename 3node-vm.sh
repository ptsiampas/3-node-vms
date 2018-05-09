#!/bin/bash
BASE=CentOS7
SNAPSHOT=base-complete
NO_CREATE=3
BASENAME=g-node
EXTRA_DISK_PATH=/vmdisk

mkdir -p "${EXTRA_DISK_PATH}/node_disks"
for num in $(seq 1 "${NO_CREATE}")
do
  node_name="${BASENAME}${num}" 
  VBoxManage clonevm "${BASE}" --snapshot "${SNAPSHOT}" --basefolder "${EXTRA_DISK_PATH}" --options link --name "${node_name}" --register
  VBoxManage createhd --filename "${EXTRA_DISK_PATH}/node_disks/disk2-${node_name}.vdi" --size 10240
  VBoxManage storageattach "${node_name}" --storagectl "SATA" --port 1 --device 0 --type hdd --medium "${EXTRA_DISK_PATH}/node_disks/disk2-${node_name}.vdi"
  vboxmanage startvm "${node_name}" --type headless
  VBoxManage guestproperty wait "${node_name}"  "/VirtualBox/GuestInfo/Net/1/Status"
  guest_ip=$(VBoxManage guestproperty get "${node_name}" "/VirtualBox/GuestInfo/Net/1/V4/IP" | sed 's/Value: //g')
  sudo hostess add "${node_name}" "${guest_ip}"
  sleep 5s
done

# Configure all the hostnames, hosts file.
ansible-playbook -i ./hosts playbook.yml
