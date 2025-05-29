-- 8) 查询持有两张(含）以上信用卡的用户的名称、身份证号、手机号。  
-- 使用GROUP BY对用户的信用卡进行分组，并使用HAVING子句筛选出持有两张及以上信用卡的用户  
SELECT   
    c.c_name,  -- 用户的名称  
    c.c_id_card,  -- 用户的身份证号  
    c.c_phone  -- 用户的手机号  
FROM   
    client c  -- 从client表中选择数据  
WHERE   
    EXISTS (  -- 使用EXISTS子查询来确保用户满足条件  
        SELECT 1  -- 只需要返回一个值来表明子查询存在结果  
        FROM   
            bank_card bc  -- 从bank_card表中选择数据  
        WHERE   
            bc.b_c_id = c.c_id  -- 确保bank_card表中的用户ID与client表中的用户ID匹配  
            AND bc.b_type = '信用卡'  -- 筛选出信用卡类型  
        GROUP BY   
            bc.b_c_id  -- 对用户ID进行分组  
        HAVING   
            COUNT(*) >= 2  -- 筛选出信用卡数量大于或等于2的用户  
    );
/*  end  of  your code  */
