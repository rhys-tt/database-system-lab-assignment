USE TPCH;

-- 测试1：查询账户余额高于本国顾客平均余额的顾客
SELECT c.name AS customer_name,
       n.name AS nation_name,
       c.acctbal
FROM Customer c
JOIN Nation n ON n.nationkey = c.nationkey
WHERE c.acctbal > (
    SELECT AVG(c2.acctbal)
    FROM Customer c2
    WHERE c2.nationkey = c.nationkey
)
ORDER BY c.custkey;

-- 测试2（加分）：使用 NOT EXISTS 查询从未下过订单的顾客
SELECT c.custkey,
       c.name AS customer_name,
       n.name AS nation_name,
       c.acctbal
FROM Customer c
JOIN Nation n ON n.nationkey = c.nationkey
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.custkey = c.custkey
)
ORDER BY c.custkey;
