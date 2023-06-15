#!/bin/bash
# truenas-ACME-shell-DNS-Authenticator
# https://github.com/sbsroc/truenas-ACME-shell-DNS-Authenticator
#
# Copyright (C) 2023, Switzer Business Solutions, LLC, all rights reserved
# https://www.sbsroc.com
#
# See the accompanying LICENSE file for license information
#
# This script can be used in a TrueNAS Scale system as an ACME DNS-Authenticator
# to allow authentication with a registrar that's not yet suppported. Currently,
# only DreamHost is supported as this was our immediate need.
# Other providers will be added as the need arises and time allows.

APIKEY={KEY_HERE}
LOGDIR=/tmp

### FUNCTIONS
adddate() {
    while IFS= read -r line; do
        printf '%s | %s\n' "$(date)" "$line";
    done
}

add_record(){
    domain=$1
    subdomain=$2
    txtvalue=$3
    
    curl "https://api.dreamhost.com/?key=${APIKEY}&cmd=dns-add_record&record=${subdomain}&type=TXT&value=${txtvalue}" --fail --silent --show-error | adddate >> ${LOGDIR}/customAcme.log

}

del_record(){
    domain=$1
    subdomain=$2
    txtvalue=$3
    
    curl "https://api.dreamhost.com/?key=${APIKEY}&cmd=dns-remove_record&record=${subdomain}&type=TXT&value=${txtvalue}" --fail --silent --show-error | adddate >> ${LOGDIR}/customAcme.log

}

### Main
echo "--- called with parameters: $*" | adddate >> ${LOGDIR}/customAcme.log
#echo $* | adddate >> ${LOGDIR}/customAcme.log
if (( $# != 4 )); then
    echo "Illegal number of parameters" | adddate | tee -a ${LOGDIR}/customAcme.log
    exit 1
fi
if [ "$1" == "set" ]; then
    add_record "${2}" "${3}" "${4}"
elif [ "$1" == "unset" ]; then
    del_record "${2}" "${3}" "${4}"
else
    echo "Unknown directive: ${1}" | adddate | tee -a ${LOGDIR}/customAcme.log
    exit 1
fi

