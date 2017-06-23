# Zabbix ZFS monitor

## Features:
* Auto discovery of pools
* Auto discovery of filesystem. Filesystem with attribute `canmount` set to
  `off` and volumes are ignored
* Will trigger an alert on monitored pool failures
* Lists of pool and filesystem are refreshed every 1 hour
* Basic pool IO monitoring
* Basic monitoring of ARC statistics
* Active Zabbix agent discovery and items

1. Download repository files and run to install files
```bash
cd zabbix-zfs-master
sudo bash install.sh
```
2. Import zabbix-zfs.xml on Zabbix server

## Future Tasks
- [ ] add monitoring of additional ARC statistic values
- [ ] implement an alert for filesystems without
automatic snapshot configuration
- [ ] implement a notification for pool resilvering completion

## Special Thanks:
Mostly based on zab-smartmon project by Ronald Farrer (@rfarrer)
