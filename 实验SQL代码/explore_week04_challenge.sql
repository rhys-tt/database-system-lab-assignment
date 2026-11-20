-- 第四周挑战任务：查询每个地区的顾客数量，保留顾客数为0的地区。
USE TPCH;

SELECT r.name AS region_name,
       COUNT(c.custkey) AS customer_count
FROM Region r
LEFT JOIN Nation n ON n.regionkey = r.regionkey
LEFT JOIN Customer c ON c.nationkey = n.nationkey
GROUP BY r.regionkey, r.name
ORDER BY r.regionkey;
