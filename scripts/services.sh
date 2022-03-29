#!/bin/bash

# Start the first process
/opt/remi/php56/root/usr/sbin/php-fpm --nodaemonize &
  
# Start the second process
/usr/sbin/nginx
  
# Wait for any process to exit
wait -n
  
# Exit with status of process that exited first
exit $?
