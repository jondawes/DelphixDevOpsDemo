#!/bin/bash

## Variables
# Standard Core Demo Env details - MUST be updated for new demo environment
DLPX_ENGINE=uvo1vinydalpsjaf3pm.vm.cld.sr
DEMO_TARGET="MSSQL"     # MSSQL | ORACLE - operate on SuiteCRM or Ooracle data sources

if [[ $DEMO_TARGET == "MSSQL" ]] 
then
    #Naming conventions, can be updated if desired. 
    #MSSQL Values
    DLPX_TEMPLATE_NAME="SuiteCRM Demo"      
    GROUP_NAME="DEV"
    dSOURCE_NAME="Suitecrm_MASK"
    TARGET_NAME="GHvDB"
    DB_NAME="GHvDB"
    ENVIRONMENT="Sqlserver_Target"
    DB_TYPE="mssql"
    ENVINST="MSSQLSERVER"
    SS_CONTAINER_NAME="GH_Container"
    SS_CONTAINER_OWNER="dev"
elif [[ $DEMO_TARGET == "ORACLE" ]]
then
    #Oracle Values
    DLPX_TEMPLATE_NAME="Oracle Demo"      
    GROUP_NAME="DEV"
    dSOURCE_NAME="Oracle_MASK"
    TARGET_NAME="GHvDB"
    DB_NAME="GHvDB"
    ENVIRONMENT="Oracle_Target"
    DB_TYPE=oracle
    ENVINST="/u01/oracle/oracle19c"  
    SS_CONTAINER_NAME="Ansible_Container"
    SS_CONTAINER_OWNER="dev"
fi 

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
if [[ $parameterAction == "create" ]] 
then

    echo Provisioning vDB to Dev Group 
    ./dxtoolkit2/dx_provision_vdb -d $DLPX_ENGINE -group $GROUP_NAME -sourcename $dSOURCE_NAME -targetname $TARGET_NAME -dbname $DB_NAME -environment $ENVIRONMENT -type $DB_TYPE -envinst $ENVINST

    echo Create Self-Service Container
    ./dxtoolkit2/dx_ctl_js_container -d $DLPX_ENGINE -action create -container_def "$GROUP_NAME,$TARGET_NAME" -container_name $SS_CONTAINER_NAME -template_name "$DLPX_TEMPLATE_NAME" -container_owner $SS_CONTAINER_OWNER -dontrefresh

    echo Create Bookmark Starting Version 1.0
    ./dxtoolkit2/dx_ctl_js_bookmarks -d $DLPX_ENGINE -bookmark_name "Starting Version 1.0" -bookmark_time latest -container_name $SS_CONTAINER_NAME -action create -template_name $DLPX_TEMPLATE_NAME

fi # end if



## Refresh Environment
if [[ $parameterAction == "refresh" ]]
then

    echo Refresh VDB Container 
    ./dxtoolkit2/dx_ctl_js_container -d $DLPX_ENGINE  -container_name $SS_CONTAINER_NAME -action refresh

    echo Create Bookmark Starting Version 2.0
    ./dxtoolkit2/dx_ctl_js_bookmarks  -d $DLPX_ENGINE -bookmark_name "Starting Version 2.0" -bookmark_time latest -container_name $SS_CONTAINER_NAME -action create -template_name $DLPX_TEMPLATE_NAME

fi # end if

## Delete Environment
if [[ $parameterAction == "delete" ]] 
then

    echo Delete Container
    ./dxtoolkit2/dx_ctl_js_container -d $DLPX_ENGINE -action delete -container_name $SS_CONTAINER_NAME -dropvdb yes


fi #end if
