#!/bin/bash

## Variables
# Standard Core Demo Env details - MUST be updated for new demo environment
DLPX_ENGINE=uvo1ezo6orp6mrdjwzd.vm.cld.sr

#Naming conventions, can be updated if desired
#GROUP_NAME=
#dSOURCE_NAME=
#TARGET_NAME=
#DB_NAME=


## End Variables

## Check Operation

while getopts "a:b:c:" opt
do
   case "$opt" in
      a ) parameterAction="$OPTARG" ;;
      #b ) parameterB="$OPTARG" ;;
      #c ) parameterC="$OPTARG" ;;
      #? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

## Login to Engine
echo Logging into the engine

# Start Session
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

# Login
curl -s -X POST -k --data @- http://$DLPX_ENGINE/resources/json/delphix/login \
-b ~/cookies.txt -c ~/cookies.txt -H "Content-Type: application/json" <<EOF
{
    "type": "LoginRequest",
    "username": "admin",
    "password": "Delphix_123!"
}
EOF

echo done!

## Create environment
if [[ parameterAction -eq "create" ]] {

    echo Provisioning vDB to Dev Group
    ./dxtoolkit2/dx_provision_vdb -d $DLPX_ENGINE -group DEV -sourcename Suitecrm_master -targetname GHvDB -dbname GHvDB -environment Sqlserver_Target -type mssql -envinst MSSQLSERVER

    echo Create Self-Service Template
    ./dxtoolkit2/dx_ctl_js_template -d $DLPX_ENGINE -source 'Source,Suitecrm_master,Suitecrm_master,1' -action create -template_name GH_Template

    echo Create Self-Service Container
    ./dxtoolkit2/dx_ctl_js_container -d $DLPX_ENGINE -action create -container_def 'DEV,GHvDB' -container_name GH_Container -template_name GH_Template -container_owner dev -dontrefresh

    echo Create Bookmark Starting Version 1.0
    ./dxtoolkit2/dx_ctl_js_bookmarks -d $DLPX_ENGINE -bookmark_name "Starting Version 1.0" -bookmark_time latest -container_name GH_Container -action create -template_name GH_Template

} # end if



## Refresh Environment
if [[ parameterAction -eq "refresh" ]] {

    echo Refresh VDB Container 
    ./dxtoolkit2/dx_ctl_js_container -d $DLPX_ENGINE  -container_name GH_Container -action refresh

    echo Create Bookmark Starting Version 2.0
    ./dxtoolkit2/dx_ctl_js_bookmarks  -d $DLPX_ENGINE -bookmark_name "Starting Version 2.0" -bookmark_time latest -container_name GH_Container -action create -template_name GH_Template
} # end if

## Delete Environment
if [[ parameterAction -eq "delete" ]] {
    echo Delete Container
    ./dxtoolkit2/dx_ctl_js_container -d $DLPX_ENGINE -action delete -container_name GH_Container -dropvdb yes

    echo Delete Template
    ./dxtoolkit2/dx_ctl_js_template -d $DLPX_ENGINE -action delete -template_name GH_Template
} end if
