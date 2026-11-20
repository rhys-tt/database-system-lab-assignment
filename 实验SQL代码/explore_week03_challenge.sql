-- 第三周探索实验：挑战任务
-- 查询从未下过任何订单的顾客信息，使用LEFT JOIN。
USE TPCH;

SELECT c.*
FROM Customer c
LEFT JOIN Orders o ON o.custkey = c.custkey
WHERE o.orderkey IS NULL
ORDER BY c.custkey;
