-- 13) 综合客户表(client)、资产表(property)、理财产品表(finances_product)、  
--     保险表(insurance)、基金表(fund)和投资资产表(property)，以及银行卡表(bank_card)，  
--     列出所有客户的编号、名称和总资产。  
--     总资产是储蓄卡余额，投资总额，投资总收益的和，再扣除信用卡透支的金额。  
--     客户总资产包括被冻结的资产。  
  
SELECT   
    c_id,       -- 客户的编号  
    c_name,     -- 客户的名称  
    -- 使用ifNULL函数确保如果总资产为NULL（即客户没有资产），则显示为0  
    ifNULL(SUM(proper_total.total), 0) AS total_property  -- 总资产  
FROM   
    client       -- 客户表  
  
-- 左连接子查询，用于计算每个客户的总资产  
LEFT OUTER JOIN  
    (  
        -- 计算理财产品的投资总额  
        SELECT   
            pro_c_id,                  -- 投资理财产品的客户ID  
            SUM(finances_product.p_amount * property.pro_quantity) AS total  -- 投资金额（数量*单价）  
        FROM   
            finances_product,          -- 理财产品表  
            property                    -- 资产表  
        WHERE   
            p_id = pro_pif_id          -- 理财产品ID与资产表中的产品ID匹配  
            AND pro_type = 1            -- 投资类型为理财  
        GROUP BY   
            pro_c_id                    -- 按客户ID分组  
  
        UNION ALL  
  
        -- 计算保险的投资总额  
        SELECT   
            pro_c_id,                  -- 投资保险的客户ID  
            SUM(insurance.i_amount * property.pro_quantity) AS total  -- 投资金额（数量*单价）  
        FROM   
            insurance,                 -- 保险表  
            property                    -- 资产表  
        WHERE   
            i_id = pro_pif_id          -- 保险ID与资产表中的产品ID匹配  
            AND pro_type = 2            -- 投资类型为保险  
        GROUP BY   
            pro_c_id                    -- 按客户ID分组  
  
        UNION ALL  
  
        -- 计算基金的投资总额  
        SELECT   
            pro_c_id,                  -- 投资基金的客户ID  
            SUM(fund.f_amount * property.pro_quantity) AS total  -- 投资金额（数量*单价）  
        FROM   
            fund,                      -- 基金表  
            property                    -- 资产表  
        WHERE   
            f_id = pro_pif_id          -- 基金ID与资产表中的产品ID匹配  
            AND pro_type = 3            -- 投资类型为基金  
        GROUP BY   
            pro_c_id                    -- 按客户ID分组  
  
        UNION ALL  
  
        -- 计算投资总收益  
        SELECT   
            pro_c_id,                  -- 拥有资产的客户ID  
            SUM(pro_income) AS total   -- 投资总收益  
        FROM   
            property                    -- 投资资产表  
        GROUP BY   
            pro_c_id                    -- 按客户ID分组  
  
        UNION ALL  
  
        -- 计算储蓄卡的余额  
        SELECT   
            b_c_id AS pro_c_id,        -- 储蓄卡对应的客户ID  
            SUM(b_balance) AS total    -- 储蓄卡余额  
        FROM   
            bank_card                   -- 银行卡表  
        WHERE   
            b_type = '储蓄卡'           -- 卡类型为储蓄卡  
        GROUP BY   
            b_c_id                      -- 按储蓄卡客户ID分组  
  
        UNION ALL  
  
        -- 计算信用卡的透支金额（注意这里用0-b_balance来表示透支金额）  
        SELECT   
            b_c_id AS pro_c_id,        -- 信用卡对应的客户ID  
            SUM(0 - b_balance) AS total  -- 信用卡透支金额（用负数表示）  
        FROM   
            bank_card                   -- 银行卡表  
        WHERE   
            b_type = '信用卡'           -- 卡类型为信用卡  
        GROUP BY   
            b_c_id                      -- 按信用卡客户ID分组  
    ) AS proper_total                  -- 子查询的别名  
ON   
    c_id = pro_c_id                     -- 客户表中的客户ID与子查询中的客户ID匹配  
  
-- 按客户ID分组，因为可能有多个投资记录对应同一个客户  
GROUP BY   
    c_id  
