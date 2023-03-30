-- �� �� �� ������, �ó��
 -- �� ��(VIEW)
   -- : ������ ���̺�
   -- : �並 ����� �ִ� ������ �־�� �並 ���� �� �ִ�.
   -- : ������ ���� ��� ������ ������ �߻�
      -- ORA-01031: ������ ������մϴ�.

     -------------------------------------------------------
     -- 
       SELECT b.bCode, bName, bPrice, p.pNum, pName, sDate, c.cNum, cName, qty, bPrice*qty amt
       FROM book b
       JOIN pub p ON b.pNum = p.pNum
       JOIN dsale d ON b.bCode = d.bCode
       JOIN sale s ON d.sNum = s.sNum
       JOIN cus c ON s.cNum = c.cNum;
     
     -- sky ���� : �ڽ��� �ý��� ���� Ȯ��
        SELECT * FROM user_sys_privs;

     -- sky���� �並 ����� �ִ� ���� �ο�
        -- ������ ����(sys �Ǵ� system)
          GRANT CREATE VIEW TO sky;  --> �����ڿ��� ����
       
     -- �� �����
        CREATE VIEW panmai
        AS 
           SELECT b.bCode, bName, bPrice, p.pNum, pName, sDate, c.cNum, cName, qty
           FROM book b
           JOIN pub p ON b.pNum = p.pNum
           JOIN dsale d ON b.bCode = d.bCode
           JOIN sale s ON d.sNum = s.sNum
           JOIN cus c ON s.cNum = c.cNum;
        
     -- �� Ȯ��
        SELECT * FROM tab;
            -- tabtype : VIEW �� ǥ��
            
      -- �� �÷� Ȯ��
        DESC panmai;
        SELECT * FROM col WHERE tname = UPPER('panmai');
        
     -- �� �ҽ� Ȯ��
        SELECT view_name, text FROM user_views;
        
     -- �並 �̿��Ͽ� ���ڵ� ���
        SELECT * FROM panmai;
        SELECT SUM(qty*bPrice) FROM panmai;
        SELECT SUM(qty*bPrice) FROM panmai WHERE TO_CHAR(sDate,'YYYY') = TO_CHAR(SYSDATE,'YYYY');
             --> �̺��⵵ �Ǹ� ��
    
     -- �並 �����ϱ� (OR REPLACE : ������ �����, ������ ����)
        CREATE OR REPLACE VIEW panmai
        AS 
           SELECT b.bCode, bName, bPrice, p.pNum, pName, sDate, c.cNum, cName, qty, bPrice*qty amt
           FROM book b
           JOIN pub p ON b.pNum = p.pNum
           JOIN dsale d ON b.bCode = d.bCode
           JOIN sale s ON d.sNum = s.sNum
           JOIN cus c ON s.cNum = c.cNum;  
           
        SELECT * FROM panmai;
      -------------------------------------------------------        
       -- empView ��� �̸����� �� �ۼ�
        -- empNo, name, gender, birth, dept, pos, hireDate, sal, bonus, tot_pay(sal+bonus)
            -- gender, birth : rrn �̿�
            -- tax : tot_pay >= 300���� -> 3%, 200�����̻� -> 2%, ������ 0
        
        CREATE OR REPLACE VIEW empView
        AS(
             SELECT empNo, name, 
                   DECODE(MOD(SUBSTR(rrn,8,1),2),0,'����','����') gender, 
                   TO_DATE( CASE
                                WHEN SUBSTR(rrn,8,1) IN (1,2,5,6) THEN '19'
                                WHEN SUBSTR(rrn,8,1) IN (3,4,7,8) THEN '20' 
                                ELSE '18'
                            END || SUBSTR(rrn,1,6),'YYYYMMDD') birth, 
                   dept, pos, hireDate, sal, bonus, (sal+bonus) tot_pay,
                   ROUND( CASE 
                            WHEN (sal+bonus) >=300 THEN 0.03
                            WHEN (sal+bonus) >=200 THEN 0.02
                            ELSE 0
                          END *(sal+bonus)+4, -1) tax
            FROM emp
        );
        
        SELECT * FROM empView;
        SELECT empNo, name, gender,birth,
                TRUNC(MONTHS_BETWEEN(SYSDATE,birth)/12) age
        FROM empView;
--03/10    
      -------------------------------------
      -- �� ����
      DROP VIEW �� �̸�;

        
        
    --> �ݵ�� �˾ƾ� ��!!!!!!!!!       
 -- �� ������(sequence)
     -- �������� ������ ������ ����(1, 2, 3, ...)
     -- ������ ���� �⺻Ű�� ������ ��� �� �� �ִ�.
     -- Ʈ������� Ŀ�� �Ǵ� �ѹ�� ������� �������� �����Ѵ�.
     -- 12C �̻���ʹ� ���̺� ������ DEFAULT ������ ������ ���� �Ҵ� �� �� �ִ�.
     -- ������ ��� Ȯ��
        SELECT * FROM seq;
     -- ������ �� ��������
        �������̸�.NEXTVAL : ���� ������ ��
        �������̸�.CURRVAL : ���� ������ ��

     -------------------------------------------------------
     -- ������ �����
        -- ������ �̸��� seq�� �ۼ��ϸ� ����� Ȯ���Ҷ� ������ �߻��Ѵ�.
        
        
     -- 1���� 1�� �����ϴ� ������ �����    
         CREATE SEQUENCE test_seq  --> �ڿ� �ɼ� ���� ���ٸ� �ۼ��ص� ������ ������ ����  -- >> �ݵ�� �ϱ��ؾ� ��
         INCREMENT BY 1     --> 1�� ����
         START WITH 1       --> �ʱⰪ : 1
         NOMAXVALUE         --> �ִ밪 ���� X
         NOCYCLE            --> ����Ŭ ���� X
         NOCACHE;           
     
     -- ������ ��� Ȯ��
        SELECT * FROM user_sequences;
        SELECT * FROM seq;
        
     -- ������ �� ��������
        SELECT test_seq.NEXTVAL FROM dual;  -- 1
        SELECT test_seq.NEXTVAL FROM dual;  -- 2
        SELECT test_seq.NEXTVAL FROM dual;  -- 3  --> �� �� ���� ���� ���� ������ �����ư�
     
     -- ���� ������ �� Ȯ��
        SELECT test_seq.CURRVAL FROM dual;  -- 3
        
     -- ������ ����
        DROP SEQUENCE �������̸�;
     
        DROP SEQUENCE test_seq;
        SELECT * FROM seq;
     -------------------------------------------------------
     -- ������ �̿�
        CREATE TABLE board(
            num      NUMBER PRIMARY KEY,
            name     VARCHAR2(30) NOT NULL,
            subject  VARCHAR2(500) NOT NULL,
            content  VARCHAR2(4000) NOT NULL,
            reg_date DATE DEFAULT SYSDATE,
            hitCount NUMBER DEFAULT 0
        );
     
        SELECT * FROM tab;
        DESC board;
        
         CREATE SEQUENCE board_seq  
         INCREMENT BY 1     
         START WITH 1       
         NOMAXVALUE         
         NOCYCLE            
         NOCACHE;         
     
        SELECT * FROM seq;
        
        INSERT INTO board (num, name, subject, content, reg_date, hitCount)
            VALUES(board_seq.NEXTVAL, '���ڹ�','�ڹٰ����ϰ�;��','������',SYSDATE,0);
        
        INSERT INTO board (num, name, subject, content, reg_date, hitCount)
            VALUES(board_seq.NEXTVAL, '���ڹ�','�ڹٶ� ?','�������',SYSDATE,0);
        
        SELECT * FROM board;
        ROLLBACK;   
        
        -- ROLLBACK �ص� �������� �ٽ� 1�� ���ư��� �ʴ´�. --> �������� �ٽ� ����� ����� ���ۿ��� ����
        
        INSERT INTO board (num, name, subject, content, reg_date, hitCount)         
            VALUES(board_seq.NEXTVAL, '���ڹ�','�ڹٰ����ϰ�;��','������',SYSDATE,0);        
            
        SELECT * FROM board;  
        
        DROP TABLE board PURGE;
        DROP SEQUENCE board_seq;
        
        
     -------------------------------------------------------
     -- 1���� �����ϴ� ������. �⺻ ĳ�� : 20��
        CREATE SEQUENCE test_seq;
            -- �⺻ĳ�� 20 : �̸� 20���� �������� ����� ����
            -- ���� �������� 3�� ���¿��� ����Ŭ ������ �����Ǹ� ���� �������� 21���� ����
            
        SELECT * FROM seq;
        
     -- 10~20 ���� 2�� �����ϴ� ������. ĳ��:5��
         CREATE SEQUENCE test_seq2
         INCREMENT BY 2     
         START WITH 10
         MINVALUE 10
         MAXVALUE 20    
         CACHE 5;    
         
        SELECT test_seq2.NEXTVAL FROM dual;
            -- 20 ������ ����
        
     -- 10~20 ���� 3�� �����ϴ� ������. ĳ��:5��. ���� �����ϸ� 1���� �ٽ� ����
         CREATE SEQUENCE test_seq3
         INCREMENT BY 3     
         START WITH 10
         MINVALUE 1
         MAXVALUE 20 
         CYCLE
         CACHE 5; 
         
         SELECT test_seq3.NEXTVAL FROM dual;
            -- 10 13 16 19 1 4 ...
            
     -------------------------------------------------------
       DROP TABLE board PURGE;
         
       DROP SEQUENCE board_seq;
       DROP SEQUENCE test_seq;
       DROP SEQUENCE test_seq2;
       DROP SEQUENCE test_seq3;  
         
         
        
 -- �� �ó��(synonym) : ���Ǿ�
     -------------------------------------------------------
     -- sky ���� : hr ������ employees ���̺��� SELECT
        SELECT * FROM hr.employees;
            -- ����. ���̺��� �����ϴ�. (������ ����)
    
    -- hr ���� : sky �������� employees ���̺��� SELECT �� �� �ִ� ���� �ο�
        GRANT SELECT ON employees TO sky;
        
     -- sky ���� : hr ������ employees ���̺��� SELECT
        SELECT * FROM hr.employees;        
        
     -- ������ ����(sys, system) : sky �������� synonym�� ���� �� �ִ� ���� �ο�        
        GRANT CREATE synonym TO sky;
        
     -- sky ����
        -- sky ������ ������ �ִ� �ý��� ���� Ȯ��
            SELECT * FROM user_sys_privs;
            
        -- hr.employees�� employees ��� �ó�� �ۼ�    --> employees ��ü�� �̹� ������ �ȵ�
            CREATE SYNONYM employees FOR hr.employees;
            
        -- SYNONYM Ȯ��    
            SELECT * FROM syn;
            
        -- employees �ó������ ���̺��� ���� Ȯ��
            SELECT * FROM employees;
            
        -- SYNONYM ����  
            DROP SYNONYM employees;
            
            SELECT * FROM syn;            
            
