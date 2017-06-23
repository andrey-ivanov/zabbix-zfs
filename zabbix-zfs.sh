#!/bin/bash
version=0.1

case "$1" in
"--pool-discovery")
    # Get the list of pools
    /sbin/zpool list -H -o name | /usr/bin/awk 'BEGIN {print "{ \"data\":["} {print((NR==1)?"":",") "{\"{#POOLNAME}\":\""$1"\"}"} END {print "]}"}'
    exit 0
;;
"--filesystem-discovery")
    # Get the list of dataset names
    /sbin/zfs list -t filesystem -H -o canmount,name | /bin/grep -v "^off" | /usr/bin/awk 'BEGIN {print "{ \"data\":["} {print((NR==1)?"":",") "{\"{#FILESYSTEMNAME}\":\""$2"\"}"} END {print "]}"}'
    exit 0
;;
"--pool-health")
    # Get the health of the given pool
    /sbin/zpool list -H -o health $2
    exit 0
;;
"--pool-capacity")
    # Get how much of the given pool is used
    /sbin/zpool list -H -o capacity $2 | /bin/sed 's/%$//'
    exit 0
;;
"--pool-read")
    # Get read io statistic for given ZFS pool
    /usr/bin/tail -1 /proc/spl/kstat/zfs/$2/io | /usr/bin/awk '{print $1}'
    exit 0
;;
"--pool-write")
    # Get write io statistic for given ZFS pool
    /usr/bin/tail -1 /proc/spl/kstat/zfs/$2/io | /usr/bin/awk '{print $2}'
    exit 0
;;
"--filesystem-info")
    # Get the filesystem informaton about the given pool name
    /sbin/zfs get -o value -Hp $3 $2
    exit 0
;;
"--arcstat")
    # TODO: Report more values? https://superuser.com/questions/1137416/how-can-i-determine-the-current-size-of-the-arc-in-zfs-and-how-does-the-arc-rel
    # Get the ZFS ARC stats
    /bin/grep "^$2 " /proc/spl/kstat/zfs/arcstats | /usr/bin/awk '{print $3}'
    exit 0
;;
*)
    # This should not occur!
    echo "ERROR on `hostname` in $0"
    exit 1
;;
esac
