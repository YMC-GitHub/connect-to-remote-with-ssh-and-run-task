#!/bin/sh

PRIVITE_KEY_FILE_NAME=google-clound-ssr
PRIVITE_KEY_FILE_PATH=~/.ssh/
# 公钥文件名字
PUBLIC_KEY_FILE_NAME=${PRIVITE_KEY_FILE_NAME}.pub
# SSH服务所在主机地址
SSH_SERVER_IP=192.168.2.3
# SSH服务所在主机账号
#SSH_SERVER_USER=yemiancheng
SSH_SERVER_USER=root

#SCRIPT_FILE=/d/code-store/Shell/centos-set-default-mode/tool/unpack_and_run.sh
#SCRIPT_FILE=/d/code-store/Shell/centos-set-default-mode/dist/centos-set-default-boot-mode.sh
#ssh -t -t -i ${PRIVITE_KEY_FILE_PATH}${PRIVITE_KEY_FILE_NAME} $SSH_SERVER_USER@$SSH_SERVER_IP 'bash -s'  <$SCRIPT_FILE --mode=m

#ok:SCRIPT_FILE=/d/code-store/Shell/connect-to-remote-with-ssh-then-run-task/pwd.sh
#ok:
#SCRIPT_FILE=./pwd.sh

#SCRIPT_FILE=/d/code-store/Shell/fix-github-dns-resovle/dist/fix-github-dns-resovle.sh

function run_tasks() {
    local PROJECT_DIR_CONSTRUTOR_ARR=
    local PROJECT_DIR_CONSTRUTOR=
    local REG_SHELL_COMMOMENT_PATTERN="^#"
    local var=

    PROJECT_DIR_CONSTRUTOR=$(
        cat <<EOF
#/d/code-store/Shell/centos-set-dns-resovle/dist/centos-set-dns-resovle.sh
#/d/code-store/Shell/install-git-on-centos/install-git-on-centos.sh
#/d/code-store/Shell/install-k8s-soflt-on-centos/close-firewalld.sh
#/d/code-store/Shell/install-k8s-soflt-on-centos/colse-selinux.sh
#/d/code-store/Shell/install-k8s-soflt-on-centos/colse-swap.sh
/d/code-store/Shell/install-k8s-soflt-on-centos/install-docker.sh
EOF
    )
    PROJECT_DIR_CONSTRUTOR=$(echo "$PROJECT_DIR_CONSTRUTOR" | sed "s/^#.*//g" | sed "/^$/d")
    PROJECT_DIR_CONSTRUTOR_ARR=(${PROJECT_DIR_CONSTRUTOR//,/ })

    for i in ${!PROJECT_DIR_CONSTRUTOR_ARR[@]}; do
        var=${PROJECT_DIR_CONSTRUTOR_ARR[$i]}
        if [[ "$var" =~ $REG_SHELL_COMMOMENT_PATTERN ]]; then
            echo "$var" >/dev/null 2>&1
        else
            SCRIPT_FILE="$var"
            ssh -t -t -i ${PRIVITE_KEY_FILE_PATH}${PRIVITE_KEY_FILE_NAME} $SSH_SERVER_USER@$SSH_SERVER_IP <$SCRIPT_FILE
        fi
    done
}
#ssh -t -t -i ${PRIVITE_KEY_FILE_PATH}${PRIVITE_KEY_FILE_NAME} $SSH_SERVER_USER@$SSH_SERVER_IP <$SCRIPT_FILE
run_tasks
#### usage
# ./run-local.sh
