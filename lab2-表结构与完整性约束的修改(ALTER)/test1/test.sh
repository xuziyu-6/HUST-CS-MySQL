#! /bin/bash

#---------- 数据准备 ----------
export MYSQL_PWD=123123
mysql -h127.0.0.1 -uroot << EOF
CREATE DATABASE IF NOT EXISTS TestDb1;
use TestDb1;
DROP TABLE IF EXISTS your_table;
DROP TABLE IF EXISTS my_table;

create table your_table(
  c1 int primary key,
  c2 varchar(32)
);
EOF

#---------- 运行学生脚本 ---------- 
touch err.txt 
mysql -h127.0.0.1 -uroot < src/test1/test1.sql  > err.txt 2>&1 >/dev/null
if [ $? == 0 ]; then
#---------- 检查结果 ---------- 
mysql -h127.0.0.1 -uroot < src/test1/check.sql
else 
echo "代码存在错误，以下是提示信息："
cat err.txt 
fi

