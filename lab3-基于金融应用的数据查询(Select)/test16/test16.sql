-- 16) 查询持有相同基金组合的客户对  
-- 假设property表包含字段pro_c_id（客户编号）、pro_type（资产类型）、pro_pif_id（基金编号）  
  
-- 使用一条SQL语句实现该查询  
SELECT DISTINCT   
    A.pro_c_id AS c_id1, -- 编号小者的客户编号  
    B.pro_c_id AS c_id2  -- 编号大者的客户编号  
FROM   
    property A, property B  
WHERE   
    -- 确保A的客户编号小于B的客户编号，避免重复对  
    A.pro_c_id < B.pro_c_id AND  
  
    -- 确保A持有的所有基金，B也持有  
    NOT EXISTS(  
        SELECT *   
        FROM property C  
        WHERE   
            A.pro_c_id = C.pro_c_id AND   
            C.pro_type = 3 AND -- 假设基金类型为3  
            C.pro_pif_id NOT IN (  
                SELECT pro_pif_id   
                FROM property D  
                WHERE   
                    D.pro_c_id = B.pro_c_id AND   
                    D.pro_type = 3  
            )  
    ) AND  
  
    -- 确保B持有的所有基金，A也持有  
    NOT EXISTS(  
        SELECT *   
        FROM property E  
        WHERE   
            B.pro_c_id = E.pro_c_id AND   
            E.pro_type = 3 AND  
            E.pro_pif_id NOT IN (  
                SELECT pro_pif_id   
                FROM property F  
                WHERE   
                    F.pro_c_id = A.pro_c_id AND   
                    F.pro_type = 3  
            )   
    ) AND  
  
    -- 确保A至少持有一个基金  
    EXISTS(  
        SELECT *  
        FROM property G  
        WHERE   
            G.pro_c_id = A.pro_c_id AND   
            G.pro_type = 3  
    );  
  
/*  end  of  your code  */  
