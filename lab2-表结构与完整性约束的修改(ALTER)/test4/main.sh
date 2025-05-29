 #! /bin/bash

#---------- 数据准备 ----------
export MYSQL_PWD=123123

mysql -h127.0.0.1 -uroot < /data/workspace/myshixun/src/test4/preprocess.sql 2>/dev/null

#---------- 运行学生代码 ---------- 
touch err.txt 
mysql -h127.0.0.1 -uroot < /data/workspace/myshixun/src/test4/test4.sql  > err.txt 2>&1 >/dev/null
if [ $? == 0 ]; then
#---------- 插入几行数据 ----------
mysql -h127.0.0.1 -uroot < /data/workspace/myshixun/src/test4/insert_data.sql 2>/dev/null

#---------- 检查结果 ---------- 
mysql -h127.0.0.1 -uroot < /data/workspace/myshixun/src/test4/check.sql

else 
echo "代码存在错误，以下是提示信息："
cat err.txt 
fi
