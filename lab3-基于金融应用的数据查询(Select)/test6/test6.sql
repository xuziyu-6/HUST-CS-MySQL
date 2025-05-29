-- 6) 查询资产表中所有资产记录里商品收益的众数和它出现的次数。  
--    该查询的目标是找到商品收益（pro_income）在property表中出现次数最多的那个值（即众数），  
--    以及这个众数出现的次数。  
  
-- 首先，我们需要对property表进行分组，根据商品收益（pro_income）进行分组。  
-- 这样做可以统计每个商品收益值在表中出现的次数。  
select   
    pro_income,    -- 选择商品收益字段  
    count(*) as presence  -- 使用count(*)函数统计每个商品收益值出现的次数，并将其命名为presence  
from   
    property  -- 从property表中选取数据  
group by   
    pro_income  -- 根据商品收益字段进行分组  
  
-- 接下来，我们需要使用HAVING子句来筛选出出现次数最多的那个商品收益值（即众数）。  
-- HAVING子句用于对分组后的数据进行过滤。  
-- 在这里，我们使用了一个子查询来比较每个分组后的商品收益值的出现次数。  
having   
    count(*) >= all(  
        select count(*)  -- 再次使用count(*)函数统计每个商品收益值的出现次数  
        from property   -- 从property表中选取数据  
        group by pro_income  -- 根据商品收益字段进行分组  
    );  
  
-- 子查询会返回每个商品收益值的出现次数，而外层查询的HAVING子句则会比较这些次数，  
-- 找出出现次数最多的那个商品收益值（即众数），并返回它及其出现的次数。
/*  end  of  your code  */
