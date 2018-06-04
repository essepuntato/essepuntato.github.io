#!/bin/bash
myv=`curl -s http://www.essepuntato.it`

if [[ -z "$myv" ]] || [[ $myv = "Traceback"*  ]]; then
    /etc/init.d/lighttpd restart
    exit 0
fi

exit 1
