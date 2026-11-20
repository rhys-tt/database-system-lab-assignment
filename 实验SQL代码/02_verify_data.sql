USE TPCH;

-- 测试1：8张表的准确行数
SELECT 'Region' AS table_name, COUNT(*) AS row_count FROM Region
UNION ALL SELECT 'Nation', COUNT(*) FROM Nation
UNION ALL SELECT 'Supplier', COUNT(*) FROM Supplier
UNION ALL SELECT 'Part', COUNT(*) FROM Part
UNION ALL SELECT 'PartSupp', COUNT(*) FROM PartSupp
UNION ALL SELECT 'Customer', COUNT(*) FROM Customer
UNION ALL SELECT 'Orders', COUNT(*) FROM Orders
UNION ALL SELECT 'Lineitem', COUNT(*) FROM Lineitem;

-- 测试2：供应关系、库存和供应价格
SELECT * FROM PartSupp ORDER BY partkey, suppkey;

-- 测试3：同一顾客多笔订单，以及未下单顾客
SELECT c.custkey, c.name, COUNT(o.orderkey) AS order_count
FROM Customer c
LEFT JOIN Orders o ON o.custkey = c.custkey
GROUP BY c.custkey, c.name
ORDER BY c.custkey;

-- 测试4：同一零件由多个供应商供应
SELECT partkey, COUNT(DISTINCT suppkey) AS supplier_count
FROM PartSupp
GROUP BY partkey
HAVING COUNT(DISTINCT suppkey) > 1
ORDER BY partkey;

-- 测试5：供应商和顾客分布在不同国家、地区
SELECT 'Supplier' AS entity_type, s.name AS entity_name,
       n.name AS nation_name, r.name AS region_name
FROM Supplier s
JOIN Nation n ON n.nationkey = s.nationkey
JOIN Region r ON r.regionkey = n.regionkey
UNION ALL
SELECT 'Customer', c.name, n.name, r.name
FROM Customer c
JOIN Nation n ON n.nationkey = c.nationkey
JOIN Region r ON r.regionkey = n.regionkey;

-- 测试6：补全任务一约束清单，应有8个主键、8个外键、2个检查约束
SELECT TABLE_NAME, CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM information_schema.TABLE_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = DATABASE()
ORDER BY TABLE_NAME, CONSTRAINT_TYPE, CONSTRAINT_NAME;
