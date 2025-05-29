-- 15) 查询资产表中客户编号，客户基金投资总收益,基金投资总收益的排名(从高到低排名)。  
--     总收益相同时名次亦相同(即并列名次)。总收益命名为total_revenue, 名次命名为rank。  
  
-- (1) 基金总收益排名(名次不连续)  
-- 使用用户定义的变量来跟踪当前的总收益和排名，当总收益相同时，不增加排名，仅增加排名计数  
SELECT pro_c_id, total_revenue, trank AS 'rank'  
FROM (  
    -- 内部查询计算总收益和进行初步排名  
    SELECT   
        pro_c_id,   
        total_revenue,  
        -- 增加排名计数  
        @rankcount := @rankcount + 1,  
        -- 如果当前总收益与上一行的总收益相同，则使用上一行的排名，否则使用新的排名计数  
        IF(@current_revenue = total_revenue, @rank, @rank := @rankcount) AS trank,  
        -- 更新当前总收益  
        @current_revenue := total_revenue  
    FROM (  
        -- 计算每个客户的基金投资总收益  
        SELECT   
            pro_c_id,  
            SUM(pro_income) AS total_revenue   
        FROM   
            property  
        WHERE   
            pro_type = 3  
        GROUP BY   
            pro_c_id  
        ORDER BY   
            total_revenue DESC, -- 先按总收益降序  
            pro_c_id -- 当总收益相同时，按客户编号排序以确保结果的一致性  
    ) AS i,  
    -- 初始化用户定义的变量  
    (  
        SELECT   
            @rank := 0,   
            @current_revenue := 0,   
            @rankcount := 0  
    ) AS v  
) AS t;  
  
-- (2) 基金总收益排名(名次连续)  
-- 使用用户定义的变量来跟踪当前的总收益和连续排名  
SELECT pro_c_id, total_revenue, trank AS 'rank'  
FROM (  
    -- 内部查询计算总收益和进行连续排名  
    SELECT   
        pro_c_id,   
        total_revenue,  
        -- 如果当前总收益与上一行的总收益相同，则使用上一行的排名，否则增加排名  
        IF(@current_revenue = total_revenue, @rank, @rank := @rank + 1) AS trank,  
        -- 更新当前总收益  
        @current_revenue := total_revenue  
    FROM (  
        -- 计算每个客户的基金投资总收益  
        SELECT   
            pro_c_id,  
            SUM(pro_income) AS total_revenue   
        FROM   
            property  
        WHERE   
            pro_type = 3  
        GROUP BY   
            pro_c_id  
        ORDER BY   
            total_revenue DESC, -- 先按总收益降序  
            pro_c_id -- 当总收益相同时，按客户编号排序以确保结果的一致性  
    ) AS i,  
    -- 初始化用户定义的变量  
    (  
        SELECT   
            @rank := 0,   
            @current_revenue := 0  
    ) AS v  
) AS t;  
  
/*  end  of  your code  */  
  