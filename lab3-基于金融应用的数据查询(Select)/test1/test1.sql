-- 1) 查询所有客户的名称、手机号和邮箱信息。查询结果按照客户编号排序。  
-- 下面是实现该查询的SQL语句，并附有详细的注释：  
  
-- 使用SELECT语句从client表中选取指定的列  
SELECT   
    -- 选择客户的名称，列名为c_name  
    c_name,   
    -- 选择客户的手机号，列名为c_phone  
    c_phone,   
    -- 选择客户的邮箱，列名为c_mail  
    c_mail    
-- FROM关键字后面跟的是要查询的表名，这里是client表  
FROM client    
-- ORDER BY关键字用于指定查询结果的排序方式  
-- 按照客户编号（列名为c_id）进行升序排序（默认是升序，也可以显式指定ASC）  
ORDER BY c_id;



/*  end  of  your code  */
 
  