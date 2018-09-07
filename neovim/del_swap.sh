#!/bin/sh

# does the swap file exist?  
grep -q "swapfile" /etc/fstab

# if it does then remove it  
if [ $? -eq 0 ]; then  
    echo 'swapfile found. Removing swapfile.'  
    sed -i '/swapfile/d' /etc/fstab  
    echo "3" > /proc/sys/vm/drop_caches  
    swapoff -a  
    rm -f /swapfile  
else  
    echo 'No swapfile found. No changes made.'  
fi

# output results to terminal  
cat /proc/swaps  
cat /proc/meminfo | grep Swap
