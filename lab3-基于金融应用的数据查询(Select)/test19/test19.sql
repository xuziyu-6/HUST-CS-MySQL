-- 19) 以日历表格式列出2022年2月每周每日基金购买总金额，输出格式如下：  
-- week_of_trading Monday Tuesday Wednesday Thursday Friday  
--               1  
--               2      
--               3  
--               4  
-- 请用一条SQL语句实现该查询：  
  
SELECT   
    -- 选择周次作为结果集的一部分  
    week_of_trading,  
    -- 使用SUM和IF结合来为每个工作日（Monday至Friday）计算基金购买总金额  
    SUM(IF(days=0, amount, NULL)) AS Monday,   
    SUM(IF(days=1, amount, NULL)) AS Tuesday,   
    SUM(IF(days=2, amount, NULL)) AS Wednesday,   
    SUM(IF(days=3, amount, NULL)) AS Thursday,   
    SUM(IF(days=4, amount, NULL)) AS Friday  
FROM   
    (  
    -- 子查询部分，首先确定2022年2月的购买记录  
    -- 使用WEEK函数结合WEEKDAY函数来获取周次（注意WEEK函数在不同数据库中的行为可能不同，这里假设WEEK(date)返回的是周日作为每周的第一天）  
    -- 然后计算每天的基金购买总金额（基金金额乘以购买数量）  
    SELECT   
        WEEK(pro_purchase_time) - WEEKDAY(DATE_SUB('2022-02-01', INTERVAL 1 DAY)) + 1 AS week_of_trading, -- 调整周次计算，以周一为每周第一天  
        SUM(f_amount * pro_quantity) AS amount,   
        WEEKDAY(pro_purchase_time) AS days  
    FROM   
        fund  
    JOIN   
        property ON f_id = pro_pif_id -- 使用JOIN来连接fund和property表，通过f_id和pro_pif_id  
    WHERE   
        pro_type = 3 AND -- 假设pro_type = 3代表基金类型  
        pro_purchase_time >= "2022-02-01" AND -- 2022年2月的第一天  
        pro_purchase_time <= "2022-02-28" -- 2022年2月的最后一天  
    GROUP BY   
        pro_purchase_time -- 按购买时间分组（这里可能需要调整为按周分组）  
    ) AS a  
GROUP BY   
    week_of_trading -- 按周次分组  
ORDER BY   
    week_of_trading ASC; -- 按周次升序排序  
  
/*  end  of  your code  */