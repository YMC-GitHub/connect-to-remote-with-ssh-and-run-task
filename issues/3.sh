

#!/bin/sh

#can not define var in a function in the eof text
ls
echo $NEW_VM_SSH_SERVER_IP
function hi(){
NET_CARD_NAME=eth0
echo $1,$NEW_VM_SSH_SERVER_IP,$NET_CARD_NAME,${NET_CARD_NAME} #,192.168.2.5,,
}
hi $NEW_VM_SSH_SERVER_IP
