-- �� ���ΰ� ���� ����
 -- �� ����(joins)
   -- �� INNER JOIN
       -- �ǽ� ���̺�
         -- �з� ���̺�(�з��ڵ�, �з���, �����з��ڵ�)
            SELECT bcCode, bcSubject, pcCode FROM bclass;

         -- ���ǻ� ���̺�(���ǻ��ȣ, ���ǻ��, ��ȭ��ȣ)
            SELECT pNum, pName, pTel FROM pub;

         -- å ���̺�(�����ڵ�, ������, ����, �з��ڵ�, ���ǻ��ȣ)
            SELECT bCode, bName, bPrice, bcCode, pNum FROM book;

         -- ���� ���̺�(���ڹ�ȣ, �����ڵ�, ���ڸ�)
            SELECT aNum, bCode, aName FROM author;

         -- �� ���̺�(����ȣ, ����, ��ȭ��ȣ)
            SELECT cNum, cName, cTel FROM cus;

         -- ȸ�� ���̺�(����ȣ, ȸ�����̵�, ȸ���н�����, �̸���)
            SELECT cNum, userId, userPwd, userEmail FROM member;
    
         -- �Ǹ� ���̺�(�ǸŹ�ȣ, �Ǹ�����, ����ȣ)
            SELECT sNum, sDate, cNum FROM sale;

         -- �Ǹ� �� ���̺�(�ǸŻ󼼹�ȣ, �ǸŹ�ȣ, �����ڵ�, �Ǹż���)
            SELECT dNum, sNum, bCode, qty FROM dsale;
            
            
      -------------------------------------------------------
     -- 1) EQUI JOIN  >> �� = ���� ǥ���ؼ�!
        -- ���� 1
           SELECT [���̺��1.]�÷���, [���̺��2.]�÷��� ....
           FROM ���̺��1, ���̺��2
           WHERE ���̺��1.�÷��� = ���̺��2.�÷���  [AND ����]
        ------------------------------------------------------
        -- �Ǹ���Ȳ : å�ڵ�(bCode), å�̸�(bName), å����(bPrice), ���ǻ��ȣ(pNum),
                    ���ǻ��̸�(pName), �Ǹ�����(sDate), ���Ű���ȣ(cNum),
                    ���Ű��̸�(cName), �Ǹż���(qty), �ݾ�(bPrice * qty)

            book  : bCode, bName, bPrice, pNum
            pub   : pNum, pName 
            dsale : sNum, bCOde, qty
            sale  : sNum, sDate, cNum
            cus   : cNum, cName
        
            SELECT b.bCode, bName, bPrice, pNum, pName, sDate, c.cNum, cName, qty, bPrice*qty amt
            FROM book b, pub p, dsale d, sale s, cus c
            WHERE b.pNum = p.pNum AND b.bCode = d.bCode AND d.sNum = s.sNum AND s.cNum=c.cNum; 
                -- ���� : ORA-00918: ���� ���ǰ� �ָ��մϴ�. >> pNum -> p.pNum���� �����ؾ� ��.

            SELECT b.bCode, bName, bPrice, p.pNum, pName, sDate, c.cNum, cName, qty, bPrice*qty amt
            FROM book b, pub p, dsale d, sale s, cus c
            WHERE b.pNum = p.pNum AND b.bCode = d.bCode AND d.sNum = s.sNum AND s.cNum=c.cNum; 
         
  

        -- ���� 2
           SELECT [���̺��1.]�÷���, [���̺��2.]�÷��� ....
           FROM ���̺��1
           [ INNER ] JOIN ���̺��2 ON ���̺��1.�÷��� = ���̺��2.�÷���
        -------------------------------------------------------
        -- 
        SELECT b.bCode, bName, bPrice, p.pNum, pName, sDate, c.cNum, cName, qty, bPrice*qty amt
        FROM book b
        JOIN pub p ON b.pNum = p.pNum
        JOIN dsale d ON b.bCode = d.bCode
        JOIN sale s ON d.sNum = s.sNum
        JOIN cus c ON s.cNum = c.cNum;
 

        -- ���� 3
           SELECT �÷���, �÷���
           FROM ���̺��1
           JOIN ���̺��2 USING (�÷���1)
           JOIN ���̺��3 USING (�÷���2);

        -------------------------------------------------------
        --
          SELECT bCode, bName, bPrice, pNum, pName, sDate, cNum, cName, qty, bPrice*qty amt
          FROM book
          JOIN pub USING(pNum)
          JOIN dsale USING(bCode)
          JOIN sale USING(sNum)
          JOIN cus USING(cNum);

     ----------------------------------------------------------
     -- ���� ����(cNum=2)�� �Ǹ� ��Ȳ
         SELECT b.bCode, bName, bPrice, p.pNum, pName, sDate, c.cNum, cName, qty, bPrice*qty amt
         FROM book b, pub p, dsale d, sale s, cus c
         WHERE b.pNum = p.pNum AND b.bCode = d.bCode AND d.sNum = s.sNum AND s.cNum=c.cNum
               AND c.cNum=2; 
            
     
         SELECT b.bCode, bName, bPrice, p.pNum, pName, sDate, c.cNum, cName, qty, bPrice*qty amt
         FROM book b
         JOIN pub p ON b.pNum = p.pNum
         JOIN dsale d ON b.bCode = d.bCode
         JOIN sale s ON d.sNum = s.sNum
         JOIN cus c ON s.cNum = c.cNum
         WHERE c.cNum=2;
     
     -- �Ǹŵ� å�ڵ�(bCode), å�̸�(bName), �ǸűǼ��� �� : å�ڵ� �������� ���
        -- book(bCode, bName), dsale(bCode, qty)
         SELECT b.bCode, bName, SUM(qty)
         FROM book b
              JOIN dsale d ON b.bCode = d.bCode
         GROUP BY b.bCode, bName
         ORDER BY b.bcode;
     
     -- �Ǹŵ� å�ڵ�(bCode), å�̸�(bName), �ǸűǼ��� ��, �Ǹűݾ��� �� : å�ڵ� �������� ���
        -- book(bCode, bName, bPrice) , dsale(bCode, qty)
        
        SELECT b.bCode, bName, SUM(qty) ����, SUM(qty*bPrice) �ݾ�
        FROM book b
              JOIN dsale d ON b.bCode = d.bCode
        GROUP BY b.bCode, bName, bPrice
        ORDER BY b.bcode;
        
     
      -- �Ǹŵ� å�ڵ�(bCode), å�̸�(bName), �ǸűǼ��� ��, �Ǹűݾ��� �� : �ǸűǼ��� ���� 80�� �̻��� å�� ���
          
        SELECT b.bCode, bName, SUM(qty) ����, SUM(qty*bPrice) �ݾ�
        FROM book b
              JOIN dsale d ON b.bCode = d.bCode
        GROUP BY b.bCode, bName, bPrice
        HAVING SUM(qty) >=80;
     
     
      -- �Ǹŵ� å�ڵ�(bCode), å�̸�(bName):�ߺ� ����
        --(1)
         SELECT DISTINCT b.bCode, bName
         FROM book b
            JOIN dsale d ON b.bCode = d.bCode 
         ORDER BY b.bCode;
        
        --(2) 
         SELECT bCode, bName
         FROM book
         WHERE bCode IN (SELECT bCode FROM dsale);
         
     
      -- �Ǹŵ� å�ڵ�(bCode), å�̸�(bName), �ǸűǼ��� �� : �ǸűǼ��� ���� ���� ū å ���
            -- book(bCode, bName, bPrice) , dsale(bCode, qty)
            SELECT b.bCode, bName, SUM(qty)
            FROM book b
                  JOIN dsale d ON b.bCode = d.bCode
            GROUP BY b.bCode, bName
            ORDER BY b.bcode;
                   
            
            SELECT b.bCode, bName, SUM(qty) �ǸűǼ�,
                RANK() OVER(ORDER BY SUM(qty) DESC) ����
            FROM book b
                  JOIN dsale d ON b.bCode = d.bCode
            GROUP BY b.bCode, bName;
        
        -- ��� 1        
            SELECT bCode, bName, �ǸűǼ� FROM(
                SELECT b.bCode, bName, SUM(qty) �ǸűǼ�,
                    RANK() OVER(ORDER BY SUM(qty) DESC) ����
                FROM book b
                      JOIN dsale d ON b.bCode = d.bCode
                GROUP BY b.bCode, bName
            ) WHERE ���� =1;
           
          -- ��� 2
            SELECT b.bCode, bName, SUM(qty) �ǸűǼ�
            FROM book b
                  JOIN dsale d ON b.bCode = d.bCode
            GROUP BY b.bCode, bName
            HAVING SUM(qty) = (
                SELECT MAX(SUM(qty))
                FROM book b1
                  JOIN dsale d1 ON b1.bCode = d1.bCode
                GROUP BY b1.bCode, bName
            );
                
      
      -- ������ �Ǹ���Ȳ ���
        -- å�ڵ�(bCode), å�̸�(bName), å����(bPrice), ���ǻ��ȣ(pName),
        -- ���ǻ��̸�(pName), �Ǹ�����(sDate), ���Ű���ȣ(cNum),
        -- ���Ű��̸�(cName), �Ǹż���(qty), �ݾ�(bPrice*qty)
            SELECT b.bCode, bName, bPrice, p.pNum, pName, sDate, c.cNum, cName, qty, bPrice*qty amt
            FROM book b
                JOIN pub p ON b.pNum = p.pNum
                JOIN dsale d ON b.bCode = d.bCode
                JOIN sale s ON d.sNum = s.sNum
                JOIN cus c ON s.cNum = c.cNum
            WHERE TO_CHAR(sDate,'YYYY') = TO_CHAR(SYSDATE,'YYYY');
            
      
            SELECT b.bCode, bName, bPrice, p.pNum, pName, sDate, c.cNum, cName, qty, bPrice*qty amt
            FROM book b
                JOIN pub p ON b.pNum = p.pNum
                JOIN dsale d ON b.bCode = d.bCode
                JOIN sale s ON d.sNum = s.sNum
                JOIN cus c ON s.cNum = c.cNum
            WHERE EXTRACT(YEAR FROM sDate) = EXTRACT(YEAR FROM SYSDATE);
      
      -- �۳��� �Ǹ���Ȳ ���
        -- å�ڵ�(bCode), å�̸�(bName), å����(bPrice), ���ǻ��ȣ(pName),
        -- ���ǻ��̸�(pName), �Ǹ�����(sDate), ���Ű���ȣ(cNum),
        -- ���Ű��̸�(cName), �Ǹż���(qty), �ݾ�(bPrice*qty)
            
            SELECT b.bCode, bName, bPrice, p.pNum, pName, sDate, c.cNum, cName, qty, bPrice*qty amt
            FROM book b
                JOIN pub p ON b.pNum = p.pNum
                JOIN dsale d ON b.bCode = d.bCode
                JOIN sale s ON d.sNum = s.sNum
                JOIN cus c ON s.cNum = c.cNum
            WHERE TO_CHAR(sDate,'YYYY') = TO_CHAR(SYSDATE,'YYYY')-1;
      
      -- �⵵�� �Ǹűݾ��� �� : �⵵, �Ǹűݾ���(�⵵ �������� ���)
         SELECT EXTRACT(YEAR FROM sDate) �⵵, SUM(qty*bPrice) �ݾ���
         FROM book b
            JOIN dsale d ON b.bCode = d.bCode
            JOIN sale s ON d.sNum = s.sNum
         GROUP BY EXTRACT(YEAR FROM sDate)  -- >  GROUP BY sDate�� �ϸ� �ȵ�!!!!!!!!!!
         ORDER BY �⵵;
         
         SELECT TO_CHAR(sDate,'YYYY') �⵵, SUM(qty*bPrice) �ݾ���
         FROM book b
            JOIN dsale d ON b.bCode = d.bCode
            JOIN sale s ON d.sNum = s.sNum
         GROUP BY TO_CHAR(sDate,'YYYY')
         ORDER BY �⵵;


      -- ����ȣ(cNum), ����(cName), �⵵, �Ǹűݾ��� :���� �Ǹ���Ȳ(����ȣ ��������, �⵵ ��������)
        SELECT s.cNum, cName, TO_CHAR(sdate,'YYYY') �⵵ , SUM(qty* bPrice) amt
        FROM book b
             JOIN pub p ON b.pNum = p.pNum
             JOIN dsale d ON b.bCode = d.bCode
             JOIN sale s ON d.sNum = s.sNum
             JOIN cus c ON s.cNum = c.cNum
        GROUP BY s.cNum, cName, TO_CHAR(sdate,'YYYY')
        ORDER BY s.cNum, �⵵;
      
     
      -- ����ȣ(cNum), ����(cName), �⵵, �Ǹűݾ��� :���� �۳�� ������ �Ǹ���Ȳ
        SELECT s.cNum, cName, TO_CHAR(sdate,'YYYY') �⵵ , SUM(qty* bPrice) amt
        FROM book b
             JOIN pub p ON b.pNum = p.pNum
             JOIN dsale d ON b.bCode = d.bCode
             JOIN sale s ON d.sNum = s.sNum
             JOIN cus c ON s.cNum = c.cNum
        WHERE TO_CHAR(SYSDATE,'YYYY') - TO_CHAR(sdate,'YYYY') <=1
        GROUP BY s.cNum, cName, TO_CHAR(sdate,'YYYY')
        ORDER BY s.cNum, �⵵;

     
      -- ����ȣ(cNum), ����(cName), ��¥(YYYYMM), �Ǹűݾ��� : ���� �̹��� �Ǹ���Ȳ
        SELECT s.cNum, cName, TO_CHAR(sdate,'YYYYMM') ��� , SUM(qty* bPrice) amt
        FROM book b
             JOIN pub p ON b.pNum = p.pNum
             JOIN dsale d ON b.bCode = d.bCode
             JOIN sale s ON d.sNum = s.sNum
             JOIN cus c ON s.cNum = c.cNum
        WHERE TO_CHAR(SYSDATE,'YYYYMM') = TO_CHAR(sdate,'YYYYMM')
        GROUP BY s.cNum, cName, TO_CHAR(sdate,'YYYYMM')
        ORDER BY s.cNum, ���;


      
      -- ����ȣ(cNum), ����(cName), ��¥(YYYYMM), �Ǹűݾ��� : ���� ���� �Ǹ���Ȳ
      -- > INTERVAL ���� �ȵ�
        SELECT TO_DATE('20230320','YYYYMMDD') - (INTERVAL '1' MONTH) FROM dual;
                -- 2023-02-20
                
        SELECT TO_DATE('20230331','YYYYMMDD') - (INTERVAL '1' MONTH) FROM dual;
                -- ����. > 2��31���� ����
                
        SELECT  ADD_MONTHS(TO_DATE('20230331','YYYYMMDD'),-1) FROM dual;
                -- 2023-02-28         
        
        SELECT s.cNum, cName, TO_CHAR(sdate,'YYYYMM') ��� , SUM(qty* bPrice) amt
        FROM book b
             JOIN pub p ON b.pNum = p.pNum
             JOIN dsale d ON b.bCode = d.bCode
             JOIN sale s ON d.sNum = s.sNum
             JOIN cus c ON s.cNum = c.cNum
        WHERE TO_CHAR(ADD_MONTHS(SYSDATE,-1),'YYYYMM') = TO_CHAR(sdate,'YYYYMM')
        GROUP BY s.cNum, cName, TO_CHAR(sdate,'YYYYMM')
        ORDER BY s.cNum, ���;
         -- >  TO_CHAR(SYSDATE,'YYYYMM')-1 = TO_CHAR(sdate,'YYYYMM') ���� �ȵ�. 202301�̸� 202300���� ��
     
        
        -- ����ȣ(cNum), ���̸�(cName) : �۳� �����Ǹűݾ��� ���� ���� �� ���
            
            SELECT cNum, cName, �Ǹűݾ� FROM (
                SELECT s.cNum, c.cName,SUM(qty*bPrice)�Ǹűݾ�, RANK() OVER(ORDER BY SUM(qty*bPrice) DESC) ����
                FROM  book b
                     JOIN dsale d ON b.bCode = d.bCode
                     JOIN sale s ON d.sNum = s.sNum
                     JOIN cus c ON s.cNum = c.cNum
                 WHERE TO_CHAR(sDate, 'YYYY') = TO_CHAR(SYSDATE,'YYYY')-1
                 GROUP BY s.cNum, c.cName
            ) WHERE ���� = 1;
        
 

     -- 2) NATURAL JOIN :  �� ���̺��� ������ �̸��� ���� �÷��� ��� ����. ������ �÷��� ���������� ã���Ƿ� �����ָ� ����
        -- ����
           SELECT �÷���, �÷��� ....
           FROM ���̺��1
           NATURAL JOIN  ���̺��2

        -------------------------------------------------------
        --
            SELECT bCode, bName, bPrice, pNum, pName, sDate, cNum, cName, qty, bPrice*qty amt
            FROM book
            NATURAL JOIN pub
            NATURAL JOIN dsale
            NATURAL JOIN sale
            NATURAL JOIN cus;
            

     -- 3) CROSS JOIN : ��ȣ ����. īƼ�� ��
        -------------------------------------------------------
        -- 
        SELECT p.pNum, pName, bCode, bName
        FROM pub p
        CROSS JOIN book b;


     -- 4) SELF JOIN
        -------------------------------------------------------
        -- bcalss : ��з���, �ߺз���
            -- bcCode, bcSubject, pcCode
        SELECT * FROM bclass;
        
        SELECT b1.bcCode, b1.bcSubject, b1.pcCode, b2.bcCode, b2.bcSubject, b2.pcCode
        FROM bclass b1
        JOIN bclass b2 ON b1.bcCode = b2.pcCode;
        
        SELECT b1.bcCode, b1.bcSubject, b2.bcCode, b2.bcSubject
        FROM bclass b1
        JOIN bclass b2 ON b1.bcCode = b2.pcCode;

        -- author ���̺�
        SELECT a1.bCode, a1.aName, a2.aName
        FROM author a1
        JOIN author a2 ON a1.bCode = a2.bCode
        ORDER BY a1.bCode;
        
        -- author ���̺� : ���ڰ� �θ� �̻��� ���
        SELECT a1.bCode, a1.aName, a2.aName
        FROM author a1
        JOIN author a2 ON a1.bCode = a2.bCode AND a1.aName > a2.aName
        ORDER BY a1.bCode;
        
        -- ���ڰ� �θ� �̻��� å ���
            SELECT bCode, bName
            FROM book
            WHERE bCode IN (
                SELECT a1.bCode
                FROM author a1
                JOIN author a2 ON a1.bCode = a2.bCode AND a1.aName > a2.aName
            );
        

     -- 5) NON-EQUI JOIN            >> ���� ���� �ʿ���� ơ
        -- ����
            SELECT [���̺��1.]�÷���, [���̺��2.]�÷��� ....
            FROM ���̺��1, ���̺��2..
            WHERE (non-equi-join ����)

        -------------------------------------------------------
        -- EQUI JOIN
            SELECT s.sNum, bCode, cNum, sDate, qty
            FROM sale s
            JOIN dsale d ON s.sNum = d.sNum;
        
        -- NON-EQUI JOIN  >> = �� �Ƚ�
            SELECT s.sNum, bCode, cNum, sDate, qty
            FROM sale s
            JOIN dsale d ON s.sNum > 10;



-- �߿���.
   -- �� OUTER JOIN
     -- 1) LEFT OUTER JOIN
       -- ����1
           SELECT [���̺��1.]�÷���, [���̺��2.]�÷���
           FROM ���̺��1, ���̺��2
           WHERE ���̺��1.�÷���=���̺��2.�÷���(+);
           
        -------------------------------------------------------
        -- book(bCode, bName), dsale(bCode, sNum, qty)
        -- EQUI JOIN
            SELECT b.bCode, bName, sNum, qty
            FROM book b, dsale d
            WHERE b.bCode = d.bCode;
            
            
        -- LEFT OUTER JOIN
            SELECT b.bCode, bName, sNum, qty
            FROM book b, dsale d
            WHERE b.bCode = d.bCode(+);
        
     
       -- ����2
          SELECT [���̺��1.]�÷���, [���̺��2.]�÷���
          FROM ���̺��1
          LEFT OUTER JOIN ���̺��2 ON ���̺��1.�÷���=���̺��2.�÷���;

        ------------------------------------------------------- 
        -- book(bCode, bName), dsale(bCode, sNum, qty)
        -- EQUI JOIN
            SELECT b.bCode, bName, sNum, qty
            FROM book b
            JOIN dsale d ON b.bCode = d.bCode;  
            
        -- LEFT OUTER JOIN
            SELECT b.bCode, bName, sNum, qty
            FROM book b
            LEFT OUTER JOIN dsale d ON b.bCode = d.bCode;
            
            
--?????????????????????????????????????????????????????????????????
            SELECT b.bCode, bName, d.sNum, sDate, qty
            FROM book b
            LEFT OUTER JOIN dsale d ON b.bCode = d.bCode
            LEFT OUTER JOIN sale s ON d.sNum = s.sNum;




     -- 2) RIGHT OUTER JOIN
       -- ����1
           SELECT [���̺��1.]�÷���, [���̺��2.]�÷���
           FROM ���̺��1, ���̺��2
           WHERE ���̺��1.�÷���(+)=���̺��2.�÷���;
           
        -------------------------------------------------------   
        -- book(bCode, bName), dsale(bCode, sNum, qty)    
        -- RIGHT OUTER JOIN
            SELECT b.bCode, bName, sNum, qty
            FROM book b, dsale d
            WHERE d.bCode(+) = b.bCode;
           

       -- ����2
          SELECT [���̺��1.]�÷���, [���̺��2.]�÷���
          FROM ���̺��1
          RIGHT OUTER JOIN ���̺��2 ON ���̺��1.�÷���=���̺��2.�÷���;

        -------------------------------------------------------
        -- book(bCode, bName), dsale(bCode, sNum, qty)    
        -- RIGHT OUTER JOIN
            SELECT b.bCode, bName, sNum, qty
            FROM dsale d
            RIGHT OUTER JOIN book b ON b.bCode = d.bCode;
            
        --------------------------------------------------------
        -- bCode, bName, qty ���
          -- �ǸŰ� ���� ���� bCode, bName�� ���
          -- qty�� NULL�� ��� 0���� ���
            SELECT b.bCode, bName, NVL(qty,0) qty
            FROM book b
            LEFT OUTER JOIN dsale d ON b.bCode = d.bCode;
            
        --------------------------------------------------------
        -- �Ǹŵ� bCode, bName ���
            SELECT bCode, bName
            FROM book 
            WHERE bCode IN (SELECT bCode FROM dsale);
            
            SELECT DISTINCT b.bCode, bName
            FROM book b
            JOIN dsale d ON b.bCode = d.bCode;
            
            SELECT DISTINCT b.bCode, bName
            FROM book b
            LEFT OUTER JOIN dsale d ON b.bCode = d.bCode
            WHERE d.bCode IS NOT NULL;
    
        --------------------------------------------------------
        -- �ѱǵ� �Ǹŵ��� ���� bCode, bName ���     
            SELECT DISTINCT b.bCode, bName
            FROM book b
            LEFT OUTER JOIN dsale d ON b.bCode = d.bCode
            WHERE d.bCode IS NULL;
        



-- 03/09

     -- 3) FULL OUTER JOIN
       -- ����
          SELECT [���̺��1.]�÷���, [���̺��2.]�÷���
          FROM ���̺��1 FULL OUTER JOIN ���̺��2 ON ���̺��1.�÷���=���̺��2.�÷���;

        -------------------------------------------------------
        --
        SELECT sNum, sDate, s.cNum, m.cNum, userId
        FROM sale s
        LEFT OUTER JOIN member m ON s.cNum = m.cNum;
        
        SELECT sNum, sDate, s.cNum, m.cNum, userId
        FROM sale s
        RIGHT OUTER JOIN member m ON s.cNum = m.cNum;

        SELECT sNum, sDate, s.cNum, m.cNum, userId
        FROM sale s
        FULL OUTER JOIN member m ON s.cNum = m.cNum;
        
        SELECT sNum, sDate, s.cNum, m.cNum, cName, userId
        FROM sale s         -- > sale �� ��µ�
        FULL OUTER JOIN member m ON s.cNum = m.cNum
        FULL OUTER JOIN cus c ON c.cNum = s.cNum;

        SELECT sNum, sDate, s.cNum, m.cNum, cName, userId
        FROM cus c          --> cus �� ��µ�
        FULL OUTER JOIN member m ON c.cNum = m.cNum
        FULL OUTER JOIN sale s ON c.cNum = s.cNum;





   -- �� UPDATE JOIN VIEW �̿��Ͽ� ���� ������Ʈ(�������� ���� �ξ� ������.)
      -- ���̺��� �����Ͽ� UPDATE
      -- tb_a ���̺��� ����(new_addr1, new_addr2)�� tb_b�� �����ϴ� ����(n_addr1, n_addr2)���� ����
      -- ���� ������ �÷��� UNIQUE �Ӽ��̾�� �����ϸ�(���谡 1:1) �׷��� ������ ORA-01779 ������ �߻��Ѵ�.

     -------------------------------------------------------
     -- ����
        CREATE TABLE tb_a (
             num  NUMBER PRIMARY KEY
            ,addr1  VARCHAR2(255)
            ,addr2 VARCHAR2(255)
            ,new_addr1 VARCHAR2(255)
            ,new_addr2 VARCHAR2(255)
       );

      CREATE TABLE tb_b (
           num  NUMBER PRIMARY KEY
          ,n_addr1 VARCHAR2(255)
          ,n_addr2 VARCHAR2(255)
      );

      INSERT INTO tb_a VALUES(1,'����1-1', '����1-2','����1-1', '����1-2');
      INSERT INTO tb_a VALUES(2,'����2-1', '����2-2','����2-1', '����2-2');
      INSERT INTO tb_a VALUES(3,'����3-1', '����3-2','����3-1', '����3-2');
      INSERT INTO tb_a VALUES(4,'����4-1', '����4-2','����4-1', '����4-2');
      INSERT INTO tb_a VALUES(5,'����5-1', '����5-2','����5-1', '����5-2');

      INSERT INTO tb_b VALUES(1,'����1-1', '����1-2');
      INSERT INTO tb_b VALUES(3,'����3-1', '����3-2');
      INSERT INTO tb_b VALUES(5,'����5-1', '����5-2');
      COMMIT;

     -------------------------------------------------------
     -- ���谡 1:1�� ��츸 ����
     SELECT a.new_addr1, a.new_addr2, b.n_addr1, b.n_addr2
     FROM tb_a a, tb_b b
     WHERE a.num = b.num;
     
     UPDATE 
     (
         SELECT a.new_addr1, a.new_addr2, b.n_addr1, b.n_addr2
         FROM tb_a a, tb_b b
         WHERE a.num = b.num
     )
     SET new_addr1 = n_addr1, new_addr2 = n_addr2;
     COMMIT;

    SELECT * FROM tb_a;




 -- �� subquery
   -- �� WITH
     -------------------------------------------------------
     --
     WITH tmp AS(
            SELECT b.bCode, bName, bPrice, p.pNum, pName, sDate, c.cNum, cName, qty, bPrice*qty amt
            FROM book b
            JOIN pub p ON b.pNum = p.pNum
            JOIN dsale d ON b.bCode = d.bCode
            JOIN sale s ON d.sNum = s.sNum
            JOIN cus c ON s.cNum = c.cNum
     )
     SELECT SUM(amt)
     FROM tmp;


   -- �� ���� �� ���� ����
     -------------------------------------------------------
     --
     SELECT empNo, name, sal
     FROM emp
     WHERE sal < (SELECT AVG(sal) FROM emp);


   -- �� ���� �� ���� ����
      -- IN
       -------------------------------------------------------
       --
        SELECT bCode, bName
        FROM book
        WHERE bCode In ( SELECT bCode FROM dsale );


      -- ANY(SOME) : �ϳ� �̻� ��ġ�ϸ� ��
       -------------------------------------------------------
       -- 200�������� �� �޴� ��� 
       SELECT empNo, name, sal
       FROM emp
       WHERE sal > ANY(2000000,3000000,4000000);


      -- ALL : ��� ��ġ
       -------------------------------------------------------
       -- 400�������� �� �޴� ���
       SELECT empNo, name, sal
       FROM emp
       WHERE sal > ALL(2000000,3000000,4000000);


      -- EXISTS : �����ϴ� ���� �ϳ��� �����ϸ� ��
       -------------------------------------------------------
       --
       SELECT bName 
       FROM book
       WHERE EXISTS (SELECT * FROM dsale WHERE qty >=10);
            -- qty�� 10�̻��� ���ڵ尡 �����ϹǷ�
            -- SELECT bName FROM book; �� ����
       
       SELECT bName 
       FROM book
       WHERE EXISTS (SELECT * FROM dsale WHERE qty >=1000);     
            
       
--> ��û�� ���ϸ� �ش�. �ǵ��� ��� ����
   -- �� ��ȣ ���� ���� ����(correlated subquery, ��� ���� ������): �������� �ܵ� ���� �Ұ�
     -------------------------------------------------------
     --
     SELECT name, sal,
        ( SELECT COUNT(e2.sal) + 1 FROM emp e2 WHERE e2.sal > e1.sal ) ����
     FROM emp e1;


        -------------------------------------------------------
        -- ���� ���ϱ�
        CREATE TABLE grade_table
        (
              grade  VARCHAR2(10) PRIMARY KEY
              ,score NUMBER(3)
        );
        INSERT INTO grade_table(grade, score) VALUES ('A', 90);
        INSERT INTO grade_table(grade, score) VALUES ('B', 80);
        INSERT INTO grade_table(grade, score) VALUES ('C', 70);
        INSERT INTO grade_table(grade, score) VALUES ('D', 60);
        INSERT INTO grade_table(grade, score) VALUES ('F', 0);
        COMMIT;

        CREATE TABLE score_table
        (
              hak  VARCHAR2(30) PRIMARY KEY
              ,score NUMBER(3) NOT NULL
        );

       INSERT INTO score_table(hak, score) VALUES ('1', 75);
       INSERT INTO score_table(hak, score) VALUES ('2', 50);
       INSERT INTO score_table(hak, score) VALUES ('3', 65);
       INSERT INTO score_table(hak, score) VALUES ('4', 80);
       INSERT INTO score_table(hak, score) VALUES ('5', 65);
       COMMIT;

       SELECT * FROM grade_table;
       SELECT * FROM score_table;
       
       SELECT hak,score,
        (SELECT MAX(score) FROM grade_table WHERE score <= score_table.score) gscore
        FROM score_table;
    
        SELECT hak, s1.score, grade FROM (
            SELECT hak,score,
            (SELECT MAX(score) FROM grade_table WHERE score <= score_table.score) gscore
            FROM score_table
        )S1
        JOIN grade_table s2 ON s1.gscore = s2.score;
        -- > ���� ¿�� �׳� �ڹٿ��� �ϴ°� �� ȿ����
    
    
    
    
    
    
    
