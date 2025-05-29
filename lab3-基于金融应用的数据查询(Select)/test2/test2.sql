-- 2) 查询客户表(client)中邮箱信息为null的客户的编号、名称、身份证号、手机号。  
--    使用一条SQL语句实现该查询。  
  
-- 从客户表(client)中选择数据  
select   
    -- 选择客户的编号  
    c_id,  
    -- 选择客户的名称  
    c_name,  
    -- 选择客户的身份证号  
    c_id_card,  
    -- 选择客户的手机号  
    c_phone   
from   
    -- 指定查询的表为客户表(client)  
    client   
where   
    -- 过滤条件：邮箱信息(c_mail)为null的客户  
    c_mail is null;
/*  end  of  your code  */
