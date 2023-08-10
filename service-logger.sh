#!/bin/bash

log_file='/var/log/services-logger.log'

log_service_creation() {
    service_name=$1
    echo "New service created: $service_name" >> $log_file
}

while true; do
    running_services=$(systemctl list-units --type=service --state=active --no-legend | awk '{print $1}')
    
    for service in $running_services; do
        if ! grep -q "$service" $log_file; then
            log_service_creation $service
        fi     
    done    
    
    sleep 60
done
