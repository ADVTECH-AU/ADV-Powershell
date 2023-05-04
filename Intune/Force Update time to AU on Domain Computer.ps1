#This script will force update the time on a domain joined computer to the Australian time servers.

w32tm /config /syncfromflags:manual /manualpeerlist:"0.au.pool.ntp.org 1.au.pool.ntp.org 2.au.pool.ntp.org 3.au.pool.ntp.org"