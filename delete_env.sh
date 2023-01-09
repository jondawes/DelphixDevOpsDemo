#!/bin/bash

# Standard Core Demo Env
DLPX_ENGINE=uvo1ezo6orp6mrdjwzd.vm.cld.sr

# Demo Development Env
#DLPX_ENGINE=uvo1a4l6corrnhkm3f3.vm.cld.sr

echo Delete Container
./dxtoolkit2/dx_ctl_js_container -d $DLPX_ENGINE -action delete -container_name GH_Container -dropvdb yes

echo Delete Template
./dxtoolkit2/dx_ctl_js_template -d $DLPX_ENGINE -action delete -template_name GH_Template

