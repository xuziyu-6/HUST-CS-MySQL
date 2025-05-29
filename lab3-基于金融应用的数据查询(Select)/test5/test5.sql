-- 5) 查询理财产品中每份金额在30000～50000之间的理财产品的编号,每份金额，理财年限，  
--    并按照金额升序排序，金额相同的按照理财年限降序排序。  
--    以下SQL语句实现了这一查询需求：  
  
select   
    -- 选择理财产品的编号  
    p_id,  
    -- 选择每份理财产品的金额  
    p_amount,  
    -- 选择理财产品的理财年限  
    p_year  
from   
    -- 从名为finances_product的表中查询数据  
    finances_product  
where   
    -- 筛选出每份金额在30000到50000之间的理财产品  
    p_amount between 30000 and 50000  
order by   
    -- 先按照每份金额升序排序  
    p_amount ASC,  
    -- 如果金额相同，则按照理财年限降序排序  
    p_year DESC;  
  
-- ASC关键字用于指定升序排序（在SQL中，升序是默认的排序方式，但为了清晰明确，这里还是加上了）  
-- DESC关键字用于指定降序排序
/*  end  of  your code  */
