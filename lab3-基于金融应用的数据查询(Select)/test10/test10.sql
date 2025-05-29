-- 10) 查询当前总的可用资产收益(被冻结的资产除外)前三名的客户的名称、身份证号及其总收益，  
--     按收益降序输出，总收益命名为total_income。不考虑并列排名情形。  
  
-- 使用SELECT语句来选择我们想要的列和计算值  
select   
    -- 客户的名称  
    c_name,  
    -- 客户的身份证号  
    c_id_card,  
    -- 计算每个客户的总收益，并命名为total_income  
    sum(pro_income) as total_income   
  
-- 从client表和property表中进行内连接（INNER JOIN）  
-- 连接条件是property表中的pro_c_id（资产所属客户ID）与client表中的c_id（客户ID）相等  
-- 并且property表中的pro_status（资产状态）为"可用"  
from client   
inner join property on pro_c_id=c_id and pro_status="可用"   
  
-- 使用GROUP BY子句按客户ID进行分组，以便计算每个客户的总收益  
group by c_id   
  
-- 使用ORDER BY子句按总收益降序排序结果  
order by total_income desc   
  
-- 使用LIMIT子句限制结果只返回前三名  
limit 3;
/*  end  of  your code  */ 
