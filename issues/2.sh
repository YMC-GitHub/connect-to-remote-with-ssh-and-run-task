

#!/bin/sh

#can not define var in the eof text
ls
echo $NEW_VM_SSH_SERVER_IP
# 定义变量
NET_CARD_NAME=eth0

function hi(){
# 获取变量
echo $1,$NEW_VM_SSH_SERVER_IP,$NET_CARD_NAME,${NET_CARD_NAME} #,192.168.2.5,,
}
hi $NEW_VM_SSH_SERVER_IP