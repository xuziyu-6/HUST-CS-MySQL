-- 7) 查询身份证隶属武汉市（身份证前四位为4201）且没有买过任何理财产品（pro_type=1）的客户的名称、电话号、邮箱。  
-- 请用一条SQL语句实现该查询：  
  
SELECT   
    c_name,  -- 选择客户的名称  
    c_phone, -- 选择客户的电话号  
    c_mail   -- 选择客户的邮箱  
FROM   
    client   -- 从client表中选取数据  
WHERE   
    -- 条件1：身份证前四位为4201（代表武汉市）  
    SUBSTRING(c_id_card, 1, 4) = '4201'  
    -- 条件2：客户ID不在购买过理财产品的客户ID列表中（即没有买过任何理财产品）  
    AND c_id NOT IN (  
        SELECT   
            pro_c_id  -- 从property表中选取购买过理财产品的客户ID  
        FROM   
            property  -- 从property表中选取数据  
        WHERE   
            pro_type = 1  -- 筛选条件：理财产品类型为1（假设1代表理财产品）  
    );
/*  end  of  your code  */
