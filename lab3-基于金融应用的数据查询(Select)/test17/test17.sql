-- 17 查询2022年2月购买基金的高峰期。至少连续三个交易日，所有投资者购买基金的总金额超过100万(含)，则称这段连续交易日为投资者购买基金的高峰期。只有交易日才能购买基金,但不能保证每个交易日都有投资者购买基金。2022年春节假期之后的第1个交易日为2月7日,周六和周日是非交易日，其余均为交易日。请列出高峰时段的日期和当日基金的总购买金额，按日期顺序排序。总购买金额命名为total_amount。
--    请用一条SQL语句实现该查询：
-- 外部查询，从子查询'peaks'中选择'pro_purchase_time'和'total_amount'  
-- 其中'gapDay'的值必须满足内部子查询'peak'的分组条件（即gapDay至少出现3次）  
SELECT pro_purchase_time, total_amount  
FROM  
    (  
    -- 子查询'peaks'，用于计算每个'pro_purchase_time'的'gapDay'  
    SELECT pro_purchase_time, total_amount,   
           IF(  
               DATEDIFF(pro_purchase_time, @curday) = IF(DATEDIFF(pro_purchase_time, "2022-2-7")%7 = 0, 3, 1),   
               @dayOffset,   
               @dayOffset := @dayOffset+1  
           ) AS gapDay,   
           @curday := pro_purchase_time  
    FROM   
        (SELECT @dayOffset := 0, @curday := 0 ) AS d, -- 初始化用户定义的变量  
        (  
        -- 子查询'highs'，用于计算每个'pro_purchase_time'的'total_amount'  
        -- 并筛选和排序数据  
        SELECT pro_purchase_time, SUM(pro_quantity*f_amount) AS total_amount  
        FROM fund, property  
        WHERE fund.f_id = property.pro_pif_id AND  
              property.pro_type = 3 AND  
              pro_purchase_time >= "2022-2-7" AND  
              pro_purchase_time <= "2022-2-28" AND  
              DATEDIFF(pro_purchase_time,"2022-2-5")%7 > 1 -- 排除周末（假设周日和周六为周末）  
        GROUP BY pro_purchase_time  
        HAVING SUM(pro_quantity*f_amount) >= 1000000 -- 筛选总金额大于或等于1000000的记录  
        ORDER BY pro_purchase_time ASC  
        ) AS highs  
    ) AS peaks  
WHERE gapDay IN   
    (  
    -- 内部子查询'peak'，用于分组和筛选满足条件的'gapDay'  
    SELECT gapDay  
    FROM      
        (  
        -- 与'peaks'子查询类似，但使用了不同的用户定义的变量  
        SELECT pro_purchase_time, total_amount,   
               IF(  
                   DATEDIFF(pro_purchase_time, @curdays) = IF(DATEDIFF(pro_purchase_time, "2022-2-7")%7 = 0, 3, 1),   
                   @dayOffsets,   
                   @dayOffsets := @dayOffsets+1  
               ) AS gapDay,   
               @curdays := pro_purchase_time  
        FROM   
            (SELECT @dayOffsets := 0, @curdays := 0 ) AS d,  
            (  
            -- 与'highs'子查询相同，但结果用于计算'gapDay'的分组  
            SELECT pro_purchase_time, SUM(pro_quantity*f_amount) AS total_amount  
            FROM fund, property  
            WHERE fund.f_id = property.pro_pif_id AND  
                  property.pro_type = 3 AND  
                  pro_purchase_time >= "2022-2-7" AND  
                  pro_purchase_time <= "2022-2-28" AND  
                  DATEDIFF(pro_purchase_time,"2022-2-5")%7 > 1  
            GROUP BY pro_purchase_time  
            HAVING SUM(pro_quantity*f_amount) >= 1000000  
            ORDER BY pro_purchase_time ASC  
            ) AS high  
        ) AS peak  
    GROUP BY gapDay  
    HAVING COUNT(*) >= 3 -- 筛选那些'gapDay'值出现至少3次的记录  
    );

/*  end  of  your code  */