-- 18) 查询至少有一张信用卡余额超过5000元的客户编号，以及该客户持有的信用卡总余额，总余额命名为credit_card_amount。  
-- 请用一条SQL语句实现该查询：  
  
-- 首先，我们从bank_card表中筛选出所有信用卡（b_type = "信用卡"）的记录，  
-- 然后按照客户编号（b_c_id）进行分组，并计算每个客户的信用卡总余额。  
SELECT b_c_id, credit_card_amount  
FROM   
    (  
    -- 这里是一个子查询，用于计算每个客户的信用卡总余额  
    SELECT b_c_id, SUM(b_balance) AS credit_card_amount  
    FROM bank_card  
    WHERE b_type = "信用卡"  
    GROUP BY b_c_id  
    ) AS b_amount  -- 别名为b_amount，方便后续引用  
  
-- 接下来，我们使用WHERE EXISTS子句来确保筛选出的客户至少有一张信用卡的余额超过5000元。  
WHERE EXISTS   
    (  
    -- 这是一个内嵌的子查询，用于检查某个客户是否有一张信用卡的余额超过5000元  
    SELECT * FROM bank_card  
    WHERE   
        -- 使用b_amount.b_c_id与bank_card.b_c_id进行比较，确保内外查询的客户编号一致  
        b_amount.b_c_id = bank_card.b_c_id AND  
        -- 确保筛选的是信用卡记录  
        b_type="信用卡" AND  
        -- 确保信用卡的余额超过5000元  
        b_balance > 5000  
    )  
  
-- 最后，按照客户编号（b_c_id）进行升序排序  
ORDER BY b_c_id ASC;  
  
/*  end  of  your code  */