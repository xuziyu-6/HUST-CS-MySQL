-- 4) 查询办理了储蓄卡的客户名称、手机号、银行卡号。查询结果依客户编号排序。  
-- 使用JOIN语法将client表和bank_card表进行连接，条件是它们的c_id和b_c_id相等，  
-- 并且只选择b_type为'储蓄卡'的记录，最后按照c_id排序  
  
SELECT   
    c.c_name,    -- 选择客户的名称  
    c.c_phone,   -- 选择客户的手机号  
    b.b_number   -- 选择客户的银行卡号  
FROM   
    client c      -- 从client表中选择数据，并为其指定一个别名c  
JOIN   
    bank_card b   -- 从bank_card表中选择数据，并为其指定一个别名b  
ON   
    c.c_id = b.b_c_id  -- 连接条件是client表的c_id与bank_card表的b_c_id相等  
WHERE   
    b.b_type = '储蓄卡'  -- 筛选条件：只选择b_type为'储蓄卡'的记录  
ORDER BY   
    c.c_id;   -- 查询结果按照客户编号排序
/*  end  of  your code  */
