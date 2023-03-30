-- �� ��� ����
 -- �� ������ ����(Hierarchical Query)
   -- �� ������ ���� : ������ ������ ����� ��ȯ
     -------------------------------------------------------
     -- �������� ������ ���  --> LEVEL : �����
     SELECT num, subject, LEVEL, parent
     FROM soft
     START WITH num = 1
     CONNECT BY PRIOR num = parent; -- ���� ���� ����
                -- �÷�(num) = ���������� ���� �÷�(parent)

     SELECT num, LPAD(' ',(LEVEL-1)*4) || subject subject, LEVEL, parent
     FROM soft
     START WITH num = 1
     CONNECT BY PRIOR num = parent; 
     
     SELECT num, LPAD(' ',(LEVEL-1)*4) || subject subject, LEVEL, parent
     FROM soft
     START WITH num = 1
     CONNECT BY parent= PRIOR num ;  

     SELECT num, subject, LEVEL, parent
     FROM soft
     START WITH num = 10
     CONNECT BY PRIOR num = parent;
     -------------------------------------------------------
     -- �������� ������ ���
     SELECT num, LPAD(' ',(LEVEL-1)*4) || subject subject, LEVEL, parent
     FROM soft
     START WITH num = 15
     CONNECT BY PRIOR parent=  num ;     
     
     -------------------------------------------------------
     -- ����
     SELECT num, subject, LEVEL, parent
     FROM soft
     START WITH num = 1
     CONNECT BY PRIOR num = parent
     ORDER BY subject;  -- ���� ������ ����

     -- ���� ������ �ִ� �׸� ����
     SELECT num, subject, LEVEL, parent
     FROM soft
     START WITH num = 1
     CONNECT BY PRIOR num = parent
     ORDER SIBLINGS BY subject; 

     -------------------------------------------------------
     -- ����
     SELECT num, subject, LEVEL, parent
     FROM soft
     WHERE num !=3
     START WITH num = 1
     CONNECT BY PRIOR num = parent; 
        -- �����ͺ��̽��� ��� �ȵ�(�����ͺ��̽� ������ ���)
        -- WHERE ���� �������� ��
        
     SELECT num, subject, LEVEL, parent
     FROM soft
     START WITH num = 1
     CONNECT BY PRIOR num = parent AND num !=3;
        -- �����ͺ��̽��� �����ͺ��̽������� ��µ��� �ʴ´�.
        
     -------------------------------------------------------
     -- LEVEL : ������ ���ǿ��� �˻��� ����� ���� ������ȣ(1���� ����). CONNECT BY ���� �ִ� ��츸 ��� ����     
     SELECT LEVEL v FROM dual CONNECT BY LEVEL <=20;
        -- 1 ~ 20 ���� ���
        
     -- 2023-03-01 ~ 2023-03-07
     SELECT TO_DATE('20230301','YYYYMMDD') + LEVEL-1 FROM dual CONNECT BY LEVEL <=7;
     
     
     
 -- �� PIVOT�� UNPIVOT
   -- �� PIVOT ��
     -------------------------------------------------------
     -- ����
      WITH temp_table AS (
         SELECT 1 cnt, 1000 price FROM DUAL UNION ALL
         SELECT 2 cnt, 1050 price FROM DUAL UNION ALL
         SELECT 3 cnt, 2100 price FROM DUAL UNION ALL
         SELECT 1 cnt, 5500 price FROM DUAL UNION ALL
         SELECT 2 cnt, 7000 price FROM DUAL UNION ALL
         SELECT 3 cnt, 7000 price FROM DUAL
     )
     SELECT cnt, SUM(price) price
     FROM temp_table
     GROUP BY cnt;

    -- �࿭ ��ȯ
      WITH temp_table AS (
         SELECT 1 cnt, 1000 price FROM DUAL UNION ALL
         SELECT 2 cnt, 1050 price FROM DUAL UNION ALL
         SELECT 3 cnt, 2100 price FROM DUAL UNION ALL
         SELECT 1 cnt, 5500 price FROM DUAL UNION ALL
         SELECT 2 cnt, 7000 price FROM DUAL UNION ALL
         SELECT 3 cnt, 7000 price FROM DUAL
     )
     SELECT SUM(DECODE(cnt,1,price,0))"1",
            SUM(DECODE(cnt,2,price,0))"2",
            SUM(DECODE(cnt,3,price,0))"3"
     FROM temp_table;
     
    -- PIVOT : ���������� ����  
       WITH temp_table AS (
         SELECT 1 cnt, 1000 price FROM DUAL UNION ALL
         SELECT 2 cnt, 1050 price FROM DUAL UNION ALL
         SELECT 3 cnt, 2100 price FROM DUAL UNION ALL
         SELECT 1 cnt, 5500 price FROM DUAL UNION ALL
         SELECT 2 cnt, 7000 price FROM DUAL UNION ALL
         SELECT 3 cnt, 7000 price FROM DUAL
     )
     SELECT *
     FROM(
        SELECT cnt, price FROM temp_table
     )
     PIVOT (
        SUM(price) FOR cnt IN (1,2,3)
     );
   
   ----------------------------------------------------------  
   -- �μ��� ��ŵ� �ο���
      SELECT dept, city, COUNT(*)
      FROM emp
      GROUP BY dept, city
      ORDER BY dept;
     
    -- PIVOT
       SELECT * FROM (
          SELECT city, dept
          FROM emp  
       )
       PIVOT(
          COUNT(dept) FOR dept IN (
            '���ߺ�' AS ���ߺ� ,
            '��ȹ��' AS ��ȹ�� ,
            '������' AS ������ ,
            '�λ��' AS �λ�� ,
            '�����' AS ����� ,
            '�ѹ���' AS �ѹ��� ,
            'ȫ����' AS ȫ����
          )
       );
     
      -- �⵵�� ���� ���� �Ǹ���Ȳ
         SELECT TO_CHAR(sDate, 'YYYY')�⵵, TO_CHAR(sDate, 'MM') ��,
                SUM(bPrice *qty) amt
         FROM book b
         JOIN dsale d ON b.bCode = d.bCode
         JOIN sale s ON d.sNum = s.sNum
         GROUP BY TO_CHAR(sDate,'YYYY'), TO_CHAR(sDate,'MM')
         ORDER BY �⵵, ��;
         
         --
         SELECT * FROM(
            SELECT TO_CHAR(sDate, 'YYYY')�⵵, TO_NUMBER(TO_CHAR(sDate, 'MM')) ��, (bPrice *qty) amt
             FROM book b
             JOIN dsale d ON b.bCode = d.bCode
             JOIN sale s ON d.sNum = s.sNum
         )
         PIVOT(
             SUM(amt) FOR �� IN (1,2,3,4,5,6,7,8,9,10,11,12)
         );
        
        -- 
        SELECT NVL(m01,0) m01, NVL(mo2,0) mo2, NVL(mo3,0) mo3, NVL(mo4,0) mo4, NVL(m05,0) m05, NVL(mo6,0) mo6, 
                NVL(mo7,0) mo7, NVL(mo8,0) mo8, NVL(mo9,0) mo9, NVL(m10,0) m10, NVL(m11,0) m11, NVL(m12,0) m12
        FROM(
            SELECT TO_CHAR(sDate, 'YYYY')�⵵, TO_NUMBER(TO_CHAR(sDate, 'MM')) ��, (bPrice *qty) amt
             FROM book b
             JOIN dsale d ON b.bCode = d.bCode
             JOIN sale s ON d.sNum = s.sNum
         )
         PIVOT(
             SUM(amt) FOR �� IN (1 m01, 2 mo2, 3 mo3, 4 mo4, 5 m05, 6 mo6,
                                 7 mo7, 8 mo8, 9 mo9, 10 m10, 11 m11, 12 m12 )
         );     
     
     
      -- ���Ϻ� �ǸŰǼ�
         �� �� ... ��
         
         SELECT * FROM (
            SELECT TO_CHAR(sDate, 'D')����
             FROM sale
         )
         PIVOT(
            COUNT(*) 
            FOR ���� IN (1 ��, 2 ��, 3 ȭ, 4 ��, 5 ��, 6 ��, 7 ��)
         );
         
     
     
   -- �� UNPIVOT ��
     -------------------------------------------------------
     --
       CREATE TABLE tcity AS 
       SELECT * FROM (
          SELECT city, dept
          FROM emp  
       )
       PIVOT(
          COUNT(dept) FOR dept IN (
            '���ߺ�' AS ���ߺ� ,
            '��ȹ��' AS ��ȹ�� ,
            '������' AS ������ ,
            '�λ��' AS �λ�� ,
            '�����' AS ����� ,
            '�ѹ���' AS �ѹ��� ,
            'ȫ����' AS ȫ����
          )
       );     
       
       SELECT * FROM tcity;
        
    ---------------------------------------------------
    -- UNPIVOT : �÷� ������ �� ������ ����
    SELECT * FROM tcity
    UNPIVOT
    (
        �ο���
        FOR �μ� IN (���ߺ�, ��ȹ��, ������, �λ��, �����, �ѹ���, ȫ����)
    );
    

    
    