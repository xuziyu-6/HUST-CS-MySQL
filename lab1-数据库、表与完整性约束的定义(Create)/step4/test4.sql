# 请在以下空白处填写完成任务的语句，空白行可通过回车换行添加。
# 你也可以在命令行窗口完成任务，不过，在命令行键入的语句不会被保存。

-- 创建一个名为MyDb的数据库，如果该数据库已经存在，则不会执行创建操作  
-- 创建数据库MyDb  
CREATE DATABASE IF NOT EXISTS MyDb;  
  
-- 使用名为MyDb的数据库，后续的SQL操作将在这个数据库中进行  
-- 使用MyDb数据库  
USE MyDb;  
  
-- 在MyDb数据库中创建一个名为products的表，用于存储产品信息  
-- 创建产品表products  
CREATE TABLE products (  
    -- pid字段，作为产品表的主键，使用CHAR(10)数据类型，最大长度为10个字符  
    -- 用于唯一标识每一个产品  
    pid CHAR(10) PRIMARY KEY,  
  
    -- name字段，使用VARCHAR(32)数据类型，最大长度为32个字符  
    -- 用于存储产品的名称  
    name VARCHAR(32),  
  
    -- brand字段，使用CHAR(10)数据类型，最大长度为10个字符  
    -- 用于存储产品的品牌  
    brand CHAR(10),  
  
    -- price字段，使用INT数据类型  
    -- 用于存储产品的价格，单位为某种货币（例如元、美元等）  
    price INT,  
  
    -- CK_products_brand约束，用于检查brand字段的值  
    -- 确保brand字段的值只能是'A'或'B'中的一个  
    CONSTRAINT CK_products_brand CHECK (brand IN ('A', 'B')),  
  
    -- CK_products_price约束，用于检查price字段的值  
    -- 确保price字段的值大于0，即产品的价格不能为0或负数  
    CONSTRAINT CK_products_price CHECK (price > 0)  
);




# 结束 