-- 第二周探索实验：综合操作（顾客→订单→订单明细）
USE TPCH;

-- 第一步：新增顾客，引用已存在的国家1。
INSERT INTO Customer
(custkey, name, address, nationkey, phone, acctbal, mktsegment, comment)
VALUES
(201, '王晨', '深圳', 1, '13800000201', 2000.00, 'BUILDING', '第二周综合操作');

-- 第二步：为新顾客创建订单，引用刚插入的顾客201。
INSERT INTO Orders
(orderkey, custkey, orderstatus, totalprice, orderdate,
 orderpriority, clerk, shippriority, comment)
VALUES
(201, 201, 'O', 100.00, '2026-11-06',
 '3-MEDIUM', 'Clerk001', 0, '第二周购买流程');

-- 第三步：添加订单明细。供应组合(1,1)已存在。
-- 购买10件螺栓，每件10元，明细金额100元；折扣和税率均为0。
INSERT INTO Lineitem
(orderkey, partkey, suppkey, linenumber, quantity, extendedprice,
 discount, tax, returnflag, linestatus, shipdate, commitdate,
 receiptdate, shipinstruct, shipmode, comment)
VALUES
(201, 1, 1, 1, 10.00, 100.00,
 0.00, 0.00, 'N', 'O', '2026-11-10', '2026-11-12',
 '2026-11-15', 'DELIVER IN PERSON', 'TRUCK', '购买螺栓10件');

-- 测试1：验证顾客与订单之间的联系。
SELECT c.custkey, c.name AS customer_name,
       o.orderkey, o.orderdate, o.totalprice
FROM Customer c
JOIN Orders o ON o.custkey = c.custkey
WHERE o.orderkey = 201;

-- 测试2：验证订单明细引用的零件和供应商。
SELECT l.orderkey, l.linenumber, p.name AS part_name,
       s.name AS supplier_name, l.quantity, l.extendedprice
FROM Lineitem l
JOIN PartSupp ps ON ps.partkey = l.partkey AND ps.suppkey = l.suppkey
JOIN Part p ON p.partkey = ps.partkey
JOIN Supplier s ON s.suppkey = ps.suppkey
WHERE l.orderkey = 201;
