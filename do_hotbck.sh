#!/bin/bash
#SUBJECT: BACKUP VM's
#OBJECTIVE: REALIZAR O BACKUP DAS VMS SEM CAUSAR PARADA NA OPERAÇÃO.
#AUTHOR: JOAO DUARTE
#DATE: 13 OUT 2017
#--------------------------------------------------------------------
#IFS='\n'
DATE=$(date +%Y%m%d_%R)

SRUUID_LOCAL="$(xe sr-list name-label="Local storage"|grep 'uuid'|awk '{print $5}')"
VMUUID="$(xe vm-list is-a-snapshot=false is-control-domain=false|grep 'uuid'|awk '{print $5}')"
SNAPUUID="$(xe snapshot-list|grep 'uuid'|awk '{print $5}')"

_get_vmuuid(){
  echo -E ${VMUUID}
}
_get_sruuid(){
  echo -E ${SRUUID_LOCAL}
}
_get_snapuuid(){
  echo -E ${SNAPUUID}
}

_set_snapshot(){
  for i in ${VMUUID}; do
    $(xe vm-snapshot uuid=${i} new-name-label="$DATE-${i}" new-name-description="SNAPSHOT-$DATE-${i}") | tee new_snapshot.list; done
}

_set_snapshot
#seleciona todos os uuids das vms correntes

exit 0

