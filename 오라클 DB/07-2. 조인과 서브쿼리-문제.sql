-- �� ���ΰ� ���� ����
 -- �� ����(joins)
   -- ��ȸ���� �Ǹ� ��Ȳ
     -- ����÷� : cNum, cName, bCode, bName, sDate, bPrice, qty
     -- book(bCode, bPrice), dsale(sNum, bCode, qty), sale(sNum, sDate, cNum), cus(cNum, cName), member(cNum, userId)
        
        -- ȸ��/��ȸ�� �Ǹ���Ȳ
        SELECT s.cNum, cName, b.bCode, bName, sDate, bPrice, qty, userId
        FROM book b
            JOIN dsale d ON b.bCode = d.bCode
            JOIN sale s ON d.sNum = s.sNum
            JOIN cus c ON c.cNum = s.cNum
        LEFT OUTER JOIN member m ON c.cNum = m.cNum
        ORDER BY s.cNum ;
        
        -- ��ȸ�� �Ǹ���Ȳ
        SELECT s.cNum, cName, b.bCode, bName, sDate, bPrice, qty
        FROM book b
            JOIN dsale d ON b.bCode = d.bCode
            JOIN sale s ON d.sNum = s.sNum
            JOIN cus c ON c.cNum = s.cNum
        LEFT OUTER JOIN member m ON c.cNum = m.cNum
        WHERE userId IS NULL;
        
        
        -- ȸ�� �Ǹ���Ȳ
        SELECT s.cNum, cName, b.bCode, bName, sDate, bPrice, qty, userId
        FROM book b
            JOIN dsale d ON b.bCode = d.bCode
            JOIN sale s ON d.sNum = s.sNum
            JOIN cus c ON c.cNum = s.cNum
        LEFT OUTER JOIN member m ON c.cNum = m.cNum
        WHERE userId IS NOT NULL;
        
        -- ȸ�� �Ǹ���Ȳ(2)
        SELECT s.cNum, cName, b.bCode, bName, sDate, bPrice, qty, userId
        FROM book b
            JOIN dsale d ON b.bCode = d.bCode
            JOIN sale s ON d.sNum = s.sNum
            JOIN cus c ON c.cNum = s.cNum
            JOIN member m ON c.cNum = m.cNum;
        
        -- å�� �������� ���� ȸ���� ���
        SELECT s.cNum, cName, b.bCode, bName, sDate, bPrice, qty, userId
        FROM book b
            JOIN dsale d ON b.bCode = d.bCode
            JOIN sale s ON d.sNum = s.sNum
            JOIN cus c ON c.cNum = s.cNum
            RIGHT OUTER JOIN member m ON c.cNum = m.cNum;
        
        -- ����
        SELECT s.cNum, cName, b.bCode, bName, sDate, bPrice, qty
        FROM book b
            JOIN dsale d ON b.bCode = d.bCode
            JOIN sale s ON d.sNum = s.sNum
            JOIN cus c ON c.cNum = s.cNum
        WHERE c.cNum NOT IN (SELECT cNum FROM member) 
        ORDER BY c.cNum;
            

   -- ���� �����Ǹűݾ� ���
     -- ����÷� : cNum, cName, �Ǹűݾ���(qty*bPrice)
     -- �ѱǵ� å�� �������� ���� ���� ���
     -- book(bCode, bPrice), dsale(sNum, bCode, qty), sale(sNum, cNum), cus(cNum, cName)
     SELECT c.cNum, cName, NVL(SUM(qty*bPrice),0) amt
     FROM book b
        JOIN dsale d ON b.bCode=d.bCode
        JOIN sale s ON s.sNum = d.sNum
        RIGHT OUTER JOIN cus c ON c.cNum = s.cNum
     GROUP BY c.cNum, cName
     ORDER BY cNum;
     
     
     SELECT c.cNum, cName, NVL(SUM(qty*bPrice),0) amt
     FROM cus c
        LEFT OUTER JOIN sale s ON c.cNum = s.cNum
        LEFT OUTER JOIN dsale d ON s.sNum = d.sNum
        LEFT OUTER JOIN book b ON b.bCode = d.bCode
     GROUP BY c.cNum, cName
     ORDER BY cNum;
     
     

   -- ���� �����Ǹ� �ݾ� �� ����(%)
     -- ����÷� : cNum, cName, �Ǹűݾ���(qty*bPrice), ����(��ü�Ǹűݾ׿� ���� ���Ǹűݾ�)
     -- book(bCode, bPrice), dsale(sNum, bCode, qty), sale(sNum, cNum), cus(cNum, cName)
       
        SELECT c.cNum, cName, SUM(qty*bPrice) amt
        FROM book b
            JOIN dsale d ON b.bCode = d.bCode
            JOIN sale s ON d.sNum = s.sNum
            JOIN cus c ON c.cNum = s.cNum
        GROUP BY c.cNum, cName
        ORDER BY cNum;
       
       -- �����
       SELECT c.cNum, cName, (qty*bPrice) amt,
               ROUND(RATIO_TO_REPORT(SUM(qty*bPrice)) OVER() *100,1)||'%' ����
        FROM book b
            JOIN dsale d ON b.bCode = d.bCode 
            JOIN sale s ON d.sNum = s.sNum  
            JOIN cus c ON s.cNum = c.cNum
        GROUP BY c.cNum, cName,(qty*bPrice);
       
       
       -- ����
        SELECT c.cNum, cName, (qty*bPrice) �Ǹűݾ���,
               ROUND((qty*bPrice)/(SELECT SUM(qty*bPrice) FROM book b JOIN dsale d ON b.bCode = d.bCode)*100, 1)||'%' ����
        FROM book b
            JOIN dsale d ON b.bCode = d.bCode 
            JOIN sale s ON d.sNum = s.sNum  
            JOIN cus c ON s.cNum = c.cNum
        GROUP BY c.cNum, cName,(qty*bPrice);
        
        

   -- �⵵���� ���� �Ǹűݾ��� ���� ���� �����
     -- ����÷� : �Ǹų⵵, cNum, cName, �⵵���Ǹűݾ���(qty*bPrice)
     -- �Ǹų⵵ �������� ���
     -- book(bCode, bPrice), dsale(sNum, bCode, qty), sale(sNum, sDate, cNum), cus(cNum, cName)
       
       -- �����
         SELECT TO_CHAR(sDate,'YYYY') �⵵, c.cNum, cName, SUM(qty*bPrice) amt
         FROM book b
            JOIN dsale d ON b.bCode = d.bCode
            JOIN sale s ON d.sNum = s.sNum
            JOIN cus c ON s.cNum = c.cNum
            GROUP BY TO_CHAR(sDate,'YYYY'),c.cNum, cName
         ORDER BY �⵵;
         
         SELECT TO_CHAR(sDate,'YYYY') �⵵, c.cNum, cName, SUM(qty*bPrice) amt,
            RANK() OVER (PARTITION BY TO_CHAR(sDate,'YYYY') ORDER BY SUM(qty*bPrice) DESC) ����
         FROM book b
            JOIN dsale d ON b.bCode = d.bCode
            JOIN sale s ON d.sNum = s.sNum
            JOIN cus c ON s.cNum = c.cNum
            GROUP BY TO_CHAR(sDate,'YYYY'),c.cNum, cName
         ORDER BY �⵵;
       
         SELECT �⵵, cNum, cName, amt FROM(
             SELECT TO_CHAR(sDate,'YYYY') �⵵, c.cNum, cName, SUM(qty*bPrice) amt,
                RANK() OVER (PARTITION BY TO_CHAR(sDate,'YYYY') ORDER BY SUM(qty*bPrice) DESC) ����
             FROM book b
             JOIN dsale d ON b.bCode = d.bCode
             JOIN sale s ON d.sNum = s.sNum
             JOIN cus c ON s.cNum = c.cNum
             GROUP BY TO_CHAR(sDate,'YYYY'),c.cNum, cName
         )WHERE ���� = 1
          ORDER BY �⵵;



   -- �⵵�� ���� ���� �Ǹ� ���� ��
     -- ����÷� : �⵵, å�ڵ�, å�̸�, M01, M02, ... M12
     -- �⵵ ��������, å�ڵ� �������� ����
     -- book(bCode, bPrice), dsale(sNum, bCode, qty), sale(sNum, sDate)
        
        SELECT TO_CHAR(sDate,'YYYY') �⵵, b.bCode, bName, qty
        FROM book b
        JOIN dsale d ON b.bCode = d.bCode
        JOIN sale s ON d.sNum = s.sNum
        ORDER BY �⵵, b.bCode;
        
        SELECT TO_CHAR(sDate,'YYYY') �⵵, b.bCode, bName, SUM(qty),
                   SUM(DECODE( TO_CHAR(sDate,'MM'),'01',qty,0)) M01,
                   SUM(DECODE( TO_CHAR(sDate,'MM'),'02',qty,0)) M02,
                   SUM(DECODE( TO_CHAR(sDate,'MM'),'03',qty,0)) M03,
                   SUM(DECODE( TO_CHAR(sDate,'MM'),'04',qty,0)) M04,
                   SUM(DECODE( TO_CHAR(sDate,'MM'),'05',qty,0)) M05,
                   SUM(DECODE( TO_CHAR(sDate,'MM'),'06',qty,0)) M06,
                   SUM(DECODE( TO_CHAR(sDate,'MM'),'07',qty,0)) M07,
                   SUM(DECODE( TO_CHAR(sDate,'MM'),'08',qty,0)) M08,
                   SUM(DECODE( TO_CHAR(sDate,'MM'),'09',qty,0)) M09,
                   SUM(DECODE( TO_CHAR(sDate,'MM'),'10',qty,0)) M10,
                   SUM(DECODE( TO_CHAR(sDate,'MM'),'11',qty,0)) M11,
                   SUM(DECODE( TO_CHAR(sDate,'MM'),'12',qty,0)) M12            
        FROM book b
        JOIN dsale d ON b.bCode = d.bCode
        JOIN sale s ON d.sNum = s.sNum
        GROUP BY TO_CHAR(sDate,'YYYY'), b.bCode, bName
        ORDER BY �⵵, b.bCode;
        
            
   -- �⵵�� ���� ���� �Ǹ� ���� ���� ����ϰ� �⵵�� �Ұ� �� �������� ��ü �Ѱ� ���
     -- ����÷� : �⵵, å�ڵ�, å�̸�, M01, M02, ... M12
     -- �⵵ ��������, å�ڵ� �������� ����
     
     SELECT TO_CHAR(sDate,'YYYY') �⵵, b.bCode, bName, SUM(qty),
                   SUM(DECODE( TO_CHAR(sDate,'MM'),'01',qty,0)) M01,
                   SUM(DECODE( TO_CHAR(sDate,'MM'),'02',qty,0)) M02,
                   SUM(DECODE( TO_CHAR(sDate,'MM'),'03',qty,0)) M03,
                   SUM(DECODE( TO_CHAR(sDate,'MM'),'04',qty,0)) M04,
                   SUM(DECODE( TO_CHAR(sDate,'MM'),'05',qty,0)) M05,
                   SUM(DECODE( TO_CHAR(sDate,'MM'),'06',qty,0)) M06,
                   SUM(DECODE( TO_CHAR(sDate,'MM'),'07',qty,0)) M07,
                   SUM(DECODE( TO_CHAR(sDate,'MM'),'08',qty,0)) M08,
                   SUM(DECODE( TO_CHAR(sDate,'MM'),'09',qty,0)) M09,
                   SUM(DECODE( TO_CHAR(sDate,'MM'),'10',qty,0)) M10,
                   SUM(DECODE( TO_CHAR(sDate,'MM'),'11',qty,0)) M11,
                   SUM(DECODE( TO_CHAR(sDate,'MM'),'12',qty,0)) M12            
        FROM book b
        JOIN dsale d ON b.bCode = d.bCode
        JOIN sale s ON d.sNum = s.sNum
        GROUP BY ROLLUP(TO_CHAR(sDate,'YYYY'),(b.bCode, bName))
        ORDER BY �⵵, b.bCode;

