-- 任务二：向空表插入测试数据。
USE TPCH;

INSERT INTO Region (regionkey, name, comment) VALUES
(1, 'ASIA', '亚洲'),
(2, 'EUROPE', '欧洲'),
(3, 'AMERICA', '美洲'),
(4, 'AFRICA', '非洲'),
(5, 'OCEANIA', '大洋洲');

INSERT INTO Nation (nationkey, name, regionkey, comment) VALUES
(1, 'CHINA', 1, '中国'),
(2, 'GERMANY', 2, '德国'),
(3, 'USA', 3, '美国'),
(4, 'EGYPT', 4, '埃及'),
(5, 'AUSTRALIA', 5, '澳大利亚');

INSERT INTO Supplier
(suppkey, name, address, nationkey, phone, acctbal, comment) VALUES
(1, '华南供应商', '广州', 1, '020-10000001', 10000.00, '供应零件1和2'),
(2, '华东供应商', '上海', 1, '021-10000002', 12000.00, '供应零件1和3'),
(3, '德国供应商', 'Berlin', 2, '030-10000003', 15000.00, '供应零件2和3'),
(4, '美国供应商', 'Boston', 3, '617-10000004', 8000.00, '预留50降至5的测试'),
(5, '埃及供应商', 'Cairo', 4, '020-10000005', 9000.00, '预留15降至12的测试');

INSERT INTO Part
(partkey, name, mfgr, brand, type, size, container, retailprice, comment) VALUES
(1, '螺栓', '工厂A', '品牌A', '紧固件', 10, 'BOX', 10.00, '通用螺栓'),
(2, '螺母', '工厂A', '品牌A', '紧固件', 10, 'BOX', 5.00, '通用螺母'),
(3, '轴承', '工厂B', '品牌B', '传动件', 20, 'BOX', 100.00, '通用轴承'),
(4, '齿轮', '工厂C', '品牌C', '传动件', 30, 'BOX', 200.00, '通用齿轮'),
(5, '阀门', '工厂D', '品牌D', '控制件', 40, 'BOX', 300.00, '通用阀门');

INSERT INTO PartSupp
(partkey, suppkey, availqty, supplycost, comment) VALUES
(1, 1, 300, 6.00, '中国供应商1'),
(2, 1, 250, 3.00, '中国供应商1'),
(1, 2, 100, 6.50, '同一零件的另一供应商'),
(3, 2, 200, 70.00, '中国供应商2'),
(3, 3, 600, 65.00, '德国供应商'),
(2, 3, 5, 2.80, '初始库存低于10'),
(4, 4, 50, 140.00, '后续测试50降至5'),
(5, 5, 15, 210.00, '后续测试15降至12');

INSERT INTO Customer
(custkey, name, address, nationkey, phone, acctbal, mktsegment, comment) VALUES
(1, '张明', '广州', 1, '13800000001', 1000.00, 'BUILDING', '同一顾客有两笔订单'),
(2, '李华', '上海', 1, '13800000002', 3000.00, 'BUILDING', '高于中国顾客平均余额'),
(3, 'Anna', 'Berlin', 2, '030-20000003', 2000.00, 'AUTOMOBILE', '低于德国顾客平均余额'),
(4, 'Ben', 'Munich', 2, '089-20000004', 6000.00, 'AUTOMOBILE', '高于德国顾客平均余额'),
(5, 'Alice', 'Boston', 3, '617-20000005', 500.00, 'HOUSEHOLD', '未下单顾客'),
(6, 'Emma', 'Sydney', 5, '029-20000006', 800.00, 'HOUSEHOLD', '未下单顾客');

INSERT INTO Orders
(orderkey, custkey, orderstatus, totalprice, orderdate,
 orderpriority, clerk, shippriority, comment) VALUES
(1, 1, 'O', 100.00, '2026-10-01', '2-HIGH', 'Clerk001', 0, '张明第一笔订单'),
(2, 1, 'O', 100.00, '2026-10-02', '3-MEDIUM', 'Clerk001', 0, '张明第二笔订单'),
(3, 2, 'O', 200.00, '2026-10-03', '3-MEDIUM', 'Clerk002', 0, '李华订单'),
(4, 3, 'O', 200.00, '2026-10-04', '4-NOT SPECIFIED', 'Clerk003', 0, 'Anna订单'),
(5, 4, 'O', 300.00, '2026-10-05', '5-LOW', 'Clerk003', 0, 'Ben订单');

INSERT INTO Lineitem
(orderkey, partkey, suppkey, linenumber, quantity, extendedprice,
 discount, tax, returnflag, linestatus, shipdate, commitdate,
 receiptdate, shipinstruct, shipmode, comment) VALUES
(1, 1, 1, 1, 10.00, 100.00, 0.00, 0.00, 'N', 'O', '2026-11-10', '2026-11-12', '2026-11-15', 'DELIVER IN PERSON', 'TRUCK', '螺栓10件'),
(2, 2, 1, 1, 20.00, 100.00, 0.00, 0.00, 'N', 'O', '2026-11-10', '2026-11-12', '2026-11-15', 'DELIVER IN PERSON', 'TRUCK', '螺母20件'),
(3, 3, 3, 1, 2.00, 200.00, 0.00, 0.00, 'N', 'O', '2026-11-11', '2026-11-13', '2026-11-16', 'DELIVER IN PERSON', 'AIR', '轴承2件'),
(4, 4, 4, 1, 1.00, 200.00, 0.00, 0.00, 'N', 'O', '2026-11-11', '2026-11-13', '2026-11-16', 'DELIVER IN PERSON', 'AIR', '齿轮1件'),
(5, 5, 5, 1, 1.00, 300.00, 0.00, 0.00, 'N', 'O', '2026-11-12', '2026-11-14', '2026-11-17', 'DELIVER IN PERSON', 'SHIP', '阀门1件');

