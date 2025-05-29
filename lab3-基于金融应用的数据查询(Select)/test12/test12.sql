-- 1. 主查询：从客户表中选择客户的名称(c_name)、身份证号(c_id_card)以及计算后的投资总金额(total_amount)  
SELECT   
    c_name,  -- 客户的名称  
    c_id_card,  -- 客户的身份证号  
    -- 使用ifNULL函数来确保如果投资总金额为NULL（即客户没有投资），则显示为0  
    ifNULL(SUM(proper_total.total), 0) AS total_amount  -- 投资总金额，如果为NULL则显示为0  
FROM   
    client  -- 主表：客户表  
  
-- 2. 左连接子查询：用于计算每个客户的投资总金额  
LEFT OUTER JOIN  
    (  
        -- 第一个子查询：计算理财产品的投资总金额  
        SELECT   
            pro_c_id,  -- 投资理财产品的客户ID  
            SUM(finances_product.p_amount * property.pro_quantity) AS total  -- 投资金额（数量*单价）  
        FROM   
            finances_product,  -- 理财产品表  
            property  -- 资产表  
        WHERE   
            p_id = pro_pif_id  -- 理财产品ID与资产表中的产品ID匹配  
            AND pro_type = 1  -- 投资类型为理财  
        GROUP BY   
            pro_c_id  -- 按客户ID分组  
  
        UNION ALL  -- 合并三个子查询的结果  
  
        -- 第二个子查询：计算保险的投资总金额  
        SELECT   
            pro_c_id,  -- 投资保险的客户ID  
            SUM(insurance.i_amount * property.pro_quantity) AS total  -- 投资金额（数量*单价）  
        FROM   
            insurance,  -- 保险表  
            property  -- 资产表  
        WHERE   
            i_id = pro_pif_id  -- 保险ID与资产表中的产品ID匹配  
            AND pro_type = 2  -- 投资类型为保险  
        GROUP BY   
            pro_c_id  -- 按客户ID分组  
  
        UNION ALL  -- 合并三个子查询的结果  
  
        -- 第三个子查询：计算基金的投资总金额  
        SELECT   
            pro_c_id,  -- 投资基金的客户ID  
            SUM(fund.f_amount * property.pro_quantity) AS total  -- 投资金额（数量*单价）  
        FROM   
            fund,  -- 基金表  
            property  -- 资产表  
        WHERE   
            f_id = pro_pif_id  -- 基金ID与资产表中的产品ID匹配  
            AND pro_type = 3  -- 投资类型为基金  
        GROUP BY   
            pro_c_id  -- 按客户ID分组  
    ) AS proper_total  -- 子查询的别名  
ON   
    c_id = pro_c_id  -- 客户表中的客户ID与子查询中的客户ID匹配  
  
-- 3. 按客户ID分组，因为可能有多个投资记录对应同一个客户  
GROUP BY   
    c_id  
  
-- 4. 按投资总金额降序排序  
ORDER BY   
    total_amount DESC;