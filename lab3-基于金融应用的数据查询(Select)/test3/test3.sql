-- 3) 查询既买了保险又买了基金的客户的名称、邮箱和电话。结果依c_id排序  
-- 使用一条SQL语句实现该查询，该查询包括三个主要部分：  
  
-- 首先，从client表中选取c_name, c_mail, c_phone字段  
-- 接下来，通过子查询找到既买了保险（pro_type=3）又买了基金（pro_type=2）的客户的c_id  
-- 最后，将结果按c_id排序  
  
SELECT   
    c_name,   -- 客户名称  
    c_mail,   -- 客户邮箱  
    c_phone   -- 客户电话  
FROM   
    client    -- 客户表  
WHERE   
    c_id IN (  
        -- 子查询1：找到买了保险（pro_type=3）的客户的c_id  
        SELECT pro_c_id   
        FROM property   
        WHERE pro_type = 3  
    )  
    AND c_id IN (  
        -- 子查询2：找到买了基金（pro_type=2）的客户的c_id  
        SELECT pro_c_id   
        FROM property   
        WHERE pro_type = 2  
    )  
ORDER BY   
    c_id;  -- 结果按c_id排序
/*  end  of  your code  */
