--使用FORALL批量插入、修改、删除数据：
--批量插入
DECLARE
  -- 定义索引表类型
  TYPE TB_TABLE_TYPE IS TABLE OF TMP_TAB%ROWTYPE INDEX BY BINARY_INTEGER;
  TB_TABLE TB_TABLE_TYPE;
BEGIN
  FOR I IN 1 .. 100 LOOP
    TB_TABLE(I).ID := I;
    TB_TABLE(I).NAME := 'NAME' || I;
  END LOOP;

  FORALL I IN 1 .. TB_TABLE.COUNT
    INSERT INTO TMP_TAB VALUES TB_TABLE (I);

  COMMIT;
END;

--批量修改
DECLARE
  TYPE TB_TABLE_TYPE IS TABLE OF TMP_TAB%ROWTYPE INDEX BY BINARY_INTEGER;
  TB_TABLE TB_TABLE_TYPE;
BEGIN
  FOR I IN 1 .. 100 LOOP
    TB_TABLE(I).ID := I;
    TB_TABLE(I).NAME := 'MY_NAME_' || I;
  END LOOP;
  FORALL I IN 1 .. TB_TABLE.COUNT
    UPDATE TMP_TAB T SET ROW = TB_TABLE(I) WHERE T.ID = TB_TABLE(I).ID;

  COMMIT;
END;

--批量删除
DECLARE
  TYPE TB_TABLE_TYPE IS TABLE OF TMP_TAB%ROWTYPE INDEX BY BINARY_INTEGER;
  TB_TABLE TB_TABLE_TYPE;
BEGIN
  FOR I IN 1 .. 10 LOOP
    TB_TABLE(I).ID := I;
    TB_TABLE(I).NAME := 'MY_NAME_' || I;
  END LOOP;
  FORALL I IN 1 .. TB_TABLE.COUNT
    DELETE FROM TMP_TAB WHERE ID = TB_TABLE(I).ID;

  COMMIT;
END;