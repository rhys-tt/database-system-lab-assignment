-- 任务四：级联删除设计
-- 相较任务一，只在外键定义后增加 ON DELETE CASCADE。
CREATE TABLE Nation (
    nationkey INT,
    name      CHAR(25),
    regionkey INT,
    comment   VARCHAR(152),
    CONSTRAINT PK_Nation PRIMARY KEY (nationkey),
    CONSTRAINT FK_Nation_Region
        FOREIGN KEY (regionkey)
        REFERENCES Region (regionkey)
        ON DELETE CASCADE
) ENGINE = InnoDB;

-- 效果：删除 Region 中某条地区记录时，自动删除 Nation 中引用该地区的国家记录。
-- 级联方向是父表 Region 到子表 Nation；删除国家不会反向删除地区。
-- 如果这些国家还被 Supplier 或 Customer 引用，且对应外键不允许级联删除，则删除仍可能被阻止；本修改不代表同时级联删除所有供应商和顾客。
