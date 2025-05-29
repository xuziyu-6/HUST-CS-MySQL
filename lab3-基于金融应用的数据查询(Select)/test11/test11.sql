-- 11) 查询黄姓用户的编号、名称、办理的银行卡的数量（没有办卡的卡数量计为0），  
--     并按办理银行卡数量降序输出，持卡数量相同的，依客户编号排序。  
  
SELECT   
    -- 选择客户编号  
    c.c_id,  
    -- 选择客户名称  
    c.c_name,  
    -- 计算每个客户拥有的银行卡数量，没有银行卡的计为0  
    COUNT(bc.b_c_id) AS number_of_cards  
FROM   
    -- 客户表  
    client c  
LEFT JOIN   
    -- 银行卡表  
    bank_card bc ON c.c_id = bc.b_c_id  
WHERE   
    -- 筛选出姓黄的客户，使用LIKE操作符和"%"通配符  
    c.c_name LIKE '黄%'  
GROUP BY   
    -- 按客户编号进行分组，以便计算每个客户的银行卡数量  
    c.c_id, c.c_name  -- 这里虽然只写了c_id，但为了保持准确性，通常建议将GROUP BY中所有非聚合函数的列都列出  
ORDER BY   
    -- 按银行卡数量降序排序  
    number_of_cards DESC,  
    -- 如果银行卡数量相同，则按客户编号升序排序  
    c.c_id;
/*  end  of  your code  */ 
