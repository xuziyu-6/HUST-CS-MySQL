-- 9) 查询购买了货币型(f_type='货币型')基金的用户的名称、电话号、邮箱。  
-- 使用嵌套的SQL子查询，首先定位到货币型基金的ID，  
-- 然后找到购买了这些基金的用户ID，  
-- 最后根据用户ID从client表中获取用户的名称、电话号和邮箱。  
  
-- 主查询：从client表中选取c_name, c_phone, c_mail字段  
select c_name, c_phone, c_mail   
-- 使用where子句限制查询结果，其中c_id必须在以下子查询结果中  
from client   
where c_id in  
(  
    -- 子查询1：从property表中选取购买了货币型基金的用户ID（pro_c_id）  
    select pro_c_id   
    from property   
    where pro_type=3  -- pro_type=3 表示基金类型（假设在数据库中是如此定义的）  
    and pro_pif_id in  -- pro_pif_id 是基金ID的外键，需要确保它在货币型基金ID列表中  
    (  
        -- 子查询2：从fund表中选取货币型基金的ID（f_id）  
        select f_id   
        from fund   
        where f_type='货币型'  -- f_type='货币型' 表示基金类型为货币型  
    )  
)  
-- 使用order by子句对结果进行排序，按照用户ID（c_id）升序排列  
order by c_id;
/*  end  of  your code  */
