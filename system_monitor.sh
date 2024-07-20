#!/bin/bash

# Log file path
LOG_FILE="/var/log/system_monitor.log"

# Get current date and time
timestamp=$(date +"%Y-%m-%d %H:%M:%S")

# Get CPU usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')

# Get memory usage and remaining
mem_total=$(free -m | awk '/^Mem:/{print $2}')
mem_used=$(free -m | awk '/^Mem:/{print $3}')
mem_free=$(free -m | awk '/^Mem:/{print $4}')
mem_usage=$(awk "BEGIN {printf \"%.2f%%\", ($mem_used/$mem_total)*100}")

# Get storage usage and remaining
storage_total=$(df -h / | awk 'NR==2 {print $2}')
storage_used=$(df -h / | awk 'NR==2 {print $3}')
storage_free=$(df -h / | awk 'NR==2 {print $4}')
storage_usage=$(df -h / | awk 'NR==2 {print $5}')

# Log the information
echo "$timestamp - CPU Usage: $cpu_usage, Memory Usage: $mem_usage (Used: ${mem_used}MB, Free: ${mem_free}MB), Storage Usage: $storage_usage (Used: $storage_used, Free: $storage_free, Total: $storage_total)" >> $LOG_FILE