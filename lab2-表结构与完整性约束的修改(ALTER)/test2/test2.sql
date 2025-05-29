use MyDb;

-- 语句1：删除表orderDetail中的列orderDate  
-- 使用ALTER TABLE语句来修改表结构  
-- DROP COLUMN关键字用于删除表中的列  
-- orderDetail是表名，orderDate是要删除的列名  
ALTER TABLE orderDetail DROP COLUMN orderDate;  
  
-- 语句2：添加列unitPrice  
-- 同样使用ALTER TABLE语句来修改表结构  
-- ADD COLUMN关键字用于在表中添加新列  
-- orderDetail是表名，unitPrice是要添加的新列名  
-- numeric(10,2)定义了列的数据类型和精度，表示一个可以存储最多10位数字（其中2位是小数部分）的数字  
ALTER TABLE orderDetail  
ADD COLUMN unitPrice numeric(10,2);
 