#!/usr/bin/env bash
cur_path=`pwd`
echo "++++++++++++++++++++++++++++++++$1 install!!!!!!!!!++++++++++++++++++++++++++++++++"
#路径配置
root_path=$cur_path/../../
log_path=$root_path/log/$1/
mkdir -p $log_path
print_info(){
if [ $1 -ne 0 ];then
    cat ${log_path}/$2.log
    echo "exit_code: 1.0" >> ${log_path}/EXIT_$2.log
else
    echo "exit_code: 0.0" >> ${log_path}/EXIT_$2.log
fi
}
hub config server==$2
hub install $1 > ${log_path}/${1}_install.log 2>&1
print_info $? ${1}_install
