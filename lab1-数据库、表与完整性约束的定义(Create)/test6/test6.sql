# 请在以下空白处填写完成任务的语句，空白行可通过回车换行添加。
# 你也可以在命令行窗口完成任务，不过，在命令行键入的语句不会被保存。

-- 如果不存在名为MyDb的数据库，则创建它  
CREATE DATABASE IF NOT EXISTS MyDb;  
  
-- 使用刚刚创建的（或已经存在的）MyDb数据库  
-- 这意味着接下来的所有SQL命令都将在这个数据库中执行  
USE MyDb;  
  
-- 创建一个名为s的表  
-- 该表有三个字段：sno, name, ID  
create table s(  
    -- sno字段，数据类型为char(10)，即最多可以存储10个字符的字符串  
    -- 此字段被设为主键，意味着sno字段的值在表中必须是唯一的，且不能为NULL  
    sno char(10) primary key,  
      
    -- name字段，数据类型为varchar(32)，即最多可以存储32个字符的可变长度字符串  
    -- not null约束表示此字段的值在插入或更新时不能为NULL  
    name varchar(32) not null,  
      
    -- ID字段，数据类型为char(18)，通常用于存储像身份证号这样的长字符串  
    -- unique约束表示此字段的值在表中必须是唯一的，但可以为NULL（除非另有指定）  
    ID char(18) unique  
);



# 结束 