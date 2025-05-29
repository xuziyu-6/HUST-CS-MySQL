USE TestDb1;

-- 使用 ALTER TABLE 语句来重命名一个表  
-- 将表 'your_table' 重命名为 'my_table'  
ALTER TABLE your_table  
RENAME TO my_table;  
  
-- 注释说明：  
-- 1. ALTER TABLE: 是SQL中用于修改已存在的表结构的语句。  
-- 2. your_table: 是待重命名的原始表名。  
-- 3. RENAME TO: 是ALTER TABLE语句中用于指定重命名操作的子句。  
-- 4. my_table: 是新的表名，即原始表名 'your_table' 将被重命名为 'my_table'。