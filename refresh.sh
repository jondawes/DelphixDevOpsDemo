#!/bin/bash

# Standard Core Demo Env
DLPX_ENGINE=uvo1vrkiamwhwjzfehl.vm.cld.sr


curl -s -X POST -k --data @- http://$DLPX_ENGINE/resources/json/delphix/session \
-c ~/cookies.txt -H "Content-Type: application/json" <<EOF
{
    "type": "APISession",
    "version": {
        "type": "APIVersion",
        "major": 1,
        "minor": 6,
        "micro": 5
    }
}
EOF

echo Logging into the Engine
echo done1

curl -s -X POST -k --data @- http://$DLPX_ENGINE/resources/json/delphix/login \
-b ~/cookies.txt -c ~/cookies.txt -H "Content-Type: application/json" <<EOF
{
    "type": "LoginRequest",
    "username": "admin",
    "password": "Delphix_123!"
}
EOF

echo Refresh VDB Container 
./dxtoolkit2/dx_ctl_js_container -d $DLPX_ENGINE  -container_name GH_Container -action refresh

echo Create Bookmark Starting Version 2.0
./dxtoolkit2/dx_ctl_js_bookmarks  -d $DLPX_ENGINE -bookmark_name "Starting Version 2.0" -bookmark_time latest -container_name GH_Container -action create -template_name GH_Template
