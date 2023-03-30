-- �� ������ ���۾��(DML)
-- Ʈ�����
    -- COMMIT : Ʈ����� �Ϸ�(INSERT, UPDATE, DELETE)�� ���·� DB�� �����Ͱ� ����
    -- ROLLBACK : Ʈ����� ���(INSERT, UPDATE, DELETE)�� ���·� DB�� �����Ͱ� ������� ���� 

    -- INSERT, UPDATE, DELETE �� DDL(CREATE, ALTER, DROP) ����� ����ϸ� �ڵ����� COMMIT ��

 -- �� INSERT
   -- �� ���� �� �Է�
     -------------------------------------------------------
     -- �⺻����
         INSERT INTO ���̺�� VALUES (��, ��);
         INSERT INTO ���̺�� (�÷�, �÷�) VALUES (��, ��);
    
     -- ��
        CREATE TABLE test1(
            num NUMBER PRIMARY KEY,
            name VARCHAR2(30) NOT NULL,
            birth DATE NOT NULL,
            memo VARCHAR2(10)
        );

     -- ������ �߰� : ��� �÷��� �����͸� �߰��ϴ� ��� �÷����� ������ �� �ִ�.
        -- ���̺��� �ۼ��� �� �÷��� ������� ���� �Է��ؾ� �Ѵ�.
        INSERT INTO test1 VALUES(1,'ȫ�浿','2020-10-10','�׽�Ʈ');
        SELECT * FROM test1;
        
     -- �÷����� ����Ͽ� ������ �߰�
        INSERT INTO test1(num, name, memo, birth) VALUES(2,'���ڹ�','��2','2000-11-10' );
        SELECT * FROM test1;
        
     -- �߰� ��
        INSERT INTO test1 VALUES(3,'����','2020-11-11'); 
            -- ���� : �÷��� ������ ���� ������ �ٸ�
        
        INSERT INTO test1(num, name, birth) VALUES(3,'����','2020-11-11');
        SELECT * FROM test1;

        INSERT INTO test1(num, name, birth) VALUES(3,'������','2020-11-11');
            -- ���� : ORA-00001
            -- �⺻Ű ���� ���� ����. (�⺻Ű�� ������ ���� ���� �� ����.)
            
        INSERT INTO test1 VALUES(4,'������','2020-11-11','');
            -- ''(���̰� 0�� ���ڿ�)�� ����Ŭ������ NULL
        SELECT * FROM test1;
        
        INSERT INTO test1 (num, name, birth, memo) VALUES(5,'������','2020-11-10','��3');
        SELECT * FROM test1;
        
        INSERT INTO test1 (num, name, birth, memo) VALUES(6,'�̹̹�','05/05/90',NULL);
            -- ���� : ORA-01847. ��¥ ���� ����
        INSERT INTO test1 (num, name, birth, memo) VALUES(6,'�̹̹�',TO_DATE('05/05/90','MM/DD/RR'),NULL);
        SELECT * FROM test1;
        
        INSERT INTO test1 (num, name, memo) VALUES(7,'�ӸӸ�','��4');
            -- ���� : ORA-01400, birth NOT NULL ���� ����
            
        INSERT INTO test1 (num, name, birth, memo) VALUES(7,'�ӸӸ�','2001-02-07','�ݰ�����');
            -- ���� : ORA-12899, �Է°��� �÷������� ŭ(memo���� �ѱ� 3�ڱ����� ����)
        
        INSERT INTO test1 (num, name, birth) VALUES(7,'�ӸӸ�',SYSDATE); 
            -- �ý��� ��¥�� �Է�
        SELECT * FROM test1;
        
        
        COMMIT; -- Ʈ����� �Ϸ�. DB�� ����Ϸ�
        --ROLLBACK; --Ʈ����� ��� (DB�� ������� ����)
        
        --[����]--
        -- test1 ���̺��� memo �÷��� ������ ���� ���� �����Ѵ�.
          -- memo VARCHAR2(100);
          ALTER TABLE test1 MODIFY (memo VARCHAR2(100));
           
        -- test1 ���̺� ���� �÷��� �߰��Ѵ�.
            -- �÷��� : created
            -- Ÿ�� : TIMESTAMP
            ALTER TABLE test1 ADD(created TIMESTAMP);
            
        -- test1 ���̺� ������ �߰��Ѵ�.
            -- num : 8, name : �ڹٴ�, birth : 901010, created : 20230306172100100   
            -- TO_DATE('901010', 'RRMMDD')
            -- TO_TIMESTAMP('20230306172100100','YYYYMMDDHH24MISSFF3')
            INSERT INTO test1 (num, name, birth, created) VALUES(8,'�ڹٴ�',TO_DATE('901010', 'RRMMDD'),TO_TIMESTAMP('20230306172100100','YYYYMMDDHH24MISSFF3'));
         
            SELECT * FROM test1 ORDER BY num;
  
  ------------------------------------------------------------
  -- (3/7)
        -- ����
        -- test2 ���̺� �ۼ�
            hak    ����(30) PRIMARY KEY
            name   ����(30)  NOT NULLL
            kor    ����(3)   NOT NULLL
            eng    ����(3)   NOT NULLL
            mat    ����(3)   NOT NULLL
            tot    ����(3)   �����÷� kor + eng + mat
            ave    ����(4,1)  �����÷� (kor + eng + mat) /3
            -- ���� �÷� : ���� ������ �� ����, ������ ���̺��� ���鶧 ����
  
            CREATE TABLE test2 (
                hak    VARCHAR2(30) PRIMARY KEY,
                name   VARCHAR2(30) NOT NULL,
                kor    NUMBER(3) NOT NULL,
                eng    NUMBER(3) NOT NULL,
                mat    NUMBER(3) NOT NULL,
                tot    NUMBER(3) GENERATED ALWAYS AS (kor+eng+mat) VIRTUAL,
                ave    NUMBER(4,1) GENERATED ALWAYS AS ((kor+eng+mat)/3) VIRTUAL
            );                                          -- >�����÷����� �����÷����� X
            
            DESC test2;  
            SELECT * FROM col WHERE tname = 'TEST2';
                        -- DEFAULTVAL �÷����� ������ Ȯ��
            SELECT * FROM cols WHERE table_name = 'TEST2';
                        -- DATA_DEFALUT �÷����� ����Ȯ��
  
            -- test2 ���̺� ������ �߰�
                INSERT INTO test2 VALUES('1111','ȫ�浿',90,90,90);
                        -- ����
                INSERT INTO test2 VALUES('1111','ȫ�浿',90,90,90,270,90);
                        -- ���� : �����÷��� ���� ����� �� ����.
    
                INSERT INTO test2(hak,name,kor,eng,mat) VALUES('1111','ȫ�浿',90,90,90);
                SELECT * FROM test2;
   ------------------------------------------------------------
   -- test3 ���̺� �ۼ�               
        -- empNo   ����(30)  PRIMARY KEY
        -- name    ����(30)  NOT NULL
        -- pay     ����(10)  NOT NULL
        
        CREATE TABLE test3(
            empNo   VARCHAR2(30) PRIMARY KEY,
            name    VARCHAR2(30)  NOT NULL,
            pay     NUMBER(10)    NOT NULL
        );
        
    -- test3 ���̺� ������ �����÷��� �߰�
        -- tax ����(10) 
        -- pay�� 300�����̻��̸� pay�� 3%
        -- pay�� 250�����̻��̸� pay�� 2%
        -- ��Ÿ 0
        
        ALTER TABLE test3 ADD(
            tax NUMBER(10) GENERATED ALWAYS AS(
                ROUND(
                    CASE
                        WHEN pay >= 3000000 THEN pay *0.03
                        WHEN pay >= 2500000 THEN pay *0.02
                        ELSE 0
                    END 
                ,-1)
            )VIRTUAL
        );
        
        -- test3�� ������ �� ���
            -- '1001' ȫ�浿 3500000
            INSERT INTO test3(empNo, name, pay) VALUES('1001','ȫ�浿',3500000);
            SELECT * FROM test3;
  
  
  
  
   -- �� subquery�� �̿��� ���� �� �Է� : �ϳ��� ���̺� ���� �� �߰�
     -------------------------------------------------------
     -- �⺻����
        INSERT INTO ���̺�� [( �÷�, �÷� )]  SELECT ��;
            
     -- emp ���̺��� empNo, name, dept, pos �÷��� ���� �����Ͽ� emp1 ���̺� �ۼ�. ������ �������� ����
        CREATE TABLE emp1 AS
            SELECT empNo, name, dept, pos FROM emp WHERE 1=0;
            
        DESC emp1;
        SELECT * FROM emp1;
            
     -- emp ���̺��� ���ߺ� �ڷḸ emp1 ���̺� �߰� : �������� �̿�
            SELECT empNo, name, dept, pos FROM emp WHERE dept='���ߺ�';
        
            INSERT INTO emp1
                SELECT empNo, name, dept, pos FROM emp WHERE dept='���ߺ�';
        
            SELECT * FROM emp1;
            
        
        
        
        
  -- > �˾Ƶθ� ��       
   -- �� unconditional INSERT ALL : : ���� ���̺� ���� �� �߰�
     -------------------------------------------------------
     -- �⺻����
        INSERT ALL
              INTO ���̺��1 [( �÷�, �÷� )] VALUES (����1,����2)
              INTO ���̺��2 [( �÷�, �÷� )] VALUES (����1,����2)
              ...
         subquery;
    
     -- ���� ���̺� ���� �� �߰� : emp ���̺��� ���ߺ� �����͸� emp2, emp3�� �߰�
        CREATE TABLE emp2 AS
            SELECT empNo, name, dept, pos FROM emp WHERE 1=0;

        CREATE TABLE emp3 AS
            SELECT empNo, sal, bonus FROM emp WHERE 1=0;
                        
        SELECT * FROM emp2;
        SELECT * FROM emp3;
 

        INSERT ALL 
            INTO emp2(empNo, name, dept, pos) VALUES (empNo,name,dept,pos)
            INTO emp3(empNo, sal, bonus) VALUES(empNo,sal,bonus)
        SELECT * FROM emp WHERE dept = '���ߺ�';
        COMMIT;
        
        SELECT * FROM emp2;
        SELECT * FROM emp3;
        
    -- �ΰ��� ���̺� ���ÿ� ���ο� ������ �߰� : emp2, emp3 ���̺� ������ �߰�     
        empNo : '9999', name : '���ڹ�' , dept : '���ߺ�', pos : '���', sal : 2000000, bonus : 100000
        
        INSERT ALL 
            INTO emp2(empNo, name, dept, pos) VALUES ('9999','���ڹ�','���ߺ�','���')
            INTO emp3(empNo, sal, bonus) VALUES('9999',2000000,100000)
        SELECT * FROM dual; 
                -- > SELECT * FROM emp WHERE dept = '���ߺ�'; ������
                --   ���ߺ� ������ŭ �Ȱ��� ���� �ͤ��������� ���
        
        SELECT * FROM emp2;
        SELECT * FROM emp3;
        
        
        
        
   -- �� conditional INSERT {ALL | FIRST}
      -------------------------------------------------------
     -- �⺻����
        INSERT ALL
               WHEN ����1 THEN
                   INTO ���̺��1 [( �÷�, �÷� )] VALUES (����1,����2)
               WHEN ����2 THEN
                   INTO ���̺��2 [( �÷�, �÷� )] VALUES (����1,����2)
                  ...
               ELSE
                   INTO ���̺��n [( �÷�, �÷� )] VALUES (����1,����2)
         subquery;


     -- ���ڿ� ���� ��� �и�
        CREATE TABLE emp4 AS
                 SELECT empNo, name, rrn, dept, pos FROM emp WHERE 1=0;
     
        CREATE TABLE emp5 AS
                SELECT empNo, name, rrn, dept, pos FROM emp WHERE 1=0;
     
        INSERT ALL 
            WHEN MOD(SUBSTR(rrn,8,1),2)=0 THEN
                INTO emp4 VALUES ( empNo, name, rrn, dept, pos )
            WHEN MOD(SUBSTR(rrn,8,1),2)=1 THEN
                INTO emp5 VALUES ( empNo, name, rrn, dept, pos )
            SELECT * FROM emp;      
     
        SELECT * FROM emp4;
        SELECT * FROM emp5;
        
        
      
     -- ���̺� ����
        DROP TABLE emp1 PURGE;
        DROP TABLE emp2 PURGE;
        DROP TABLE emp3 PURGE;
        DROP TABLE emp4 PURGE;
        DROP TABLE emp5 PURGE;
        
        DROP TABLE test1 PURGE;
        DROP TABLE test2 PURGE;
        DROP TABLE test3 PURGE;
        
        SELECT * FROM tab;
   
         
 -- �� UPDATE
   -- �� UPDATE  : ������ ����
     -------------------------------------------------------
     -- �⺻����
       UPDATE ���̺�� SET �÷�=��, �÷�=�� WHERE ����;
       UPDATE ���̺�� SET �÷�=��, �÷�=��;   -- ��緹�ڵ� ����
       
     -- emp_score ���̺� : empNo 1002�� com=90, excel=95�� ����
        UPDATE emp_score SET com=90, excel=95;
                -- ��� ���ڵ尡 �����ȴ�.
                -- > �̷��� �����ϸ� ȸ�翡�� ���� ���� �԰� �Ѱܳ���.^___^
        SELECT * FROM emp_score;
        ROLLBACK;
                                                --> ��� ���� ���� ���� UPDATE�� ����.
        UPDATE emp_score SET com=90, excel=95 WHERE empNo ='1002';
        SELECT * FROM emp_score;
        COMMIT;


     -- emp_score ���̺� : empNo, com, excel, word, tot(com+excel+word), ave((com+excel+word)/3), grade
        -- ����� �Ҽ��� 2°�ڸ����� �ݿø�
        -- grade : ��� ���� ������ 40���̻��̰� ����� 60�̻��̸� �հ�, ����� 60�̻��̰� �Ѱ����̶� 40�̸��̸� ����,
        --          �׷��� ������ ���հ�
        SELECT empNo, com, excel, word,(com+excel+word) tot, 
            ROUND(((com+excel+word)/3),1) ave, 
            CASE 
                WHEN com >=40 AND excel >=40 AND word >=40 AND (com+excel+word)/3 >=60 THEN '�հ�'
                WHEN (com+excel+word)/3 >=60 THEN '����'
                ELSE '���հ�'
            END grade
        FROM emp_score;
        
        
     -- emp, emp_score ���̺��� �̿��Ͽ� ���ߺ� ������ empNo, com, excel, word ���
        SELECT empNo, com, excel, word
        FROM emp_score
        WHERE empNo IN (SELECT empNo FROM emp WHERE dept ='���ߺ�');
        
        
     -- ���ߺ� ����� com ������ 100 ���ϱ�
        UPDATE emp_score SET com = com+100
        WHERE empNo IN (SELECT empNo FROM emp WHERE dept = '���ߺ�');
        
        SELECT * FROM emp_score;
        ROLLBACK;
        
   -------------------------------------------------
   -- ���� ������ �����ϸ� ������ �Ұ��� �ϴ�. 
    SELECT * FROM user_constraints WHERE table_name = 'EMP_SCORE';
    
    UPDATE emp_score SET empNo = '1002' WHERE empNo = '1001';
        -- ���� : ORA-00001
        -- empNo�� �⺻Ű�� ������ ����������, '1002'�� �̹� �����ϹǷ� '1001'�� '1002'�� ������ �� ����.
        


 -- �� DELETE
   -- �� DELETE : ������ ����
     -------------------------------------------------------
     -- �⺻����
       DELETE FROM ���̺�� WHERE ����;
       DELETE FROM ���̺��;  -- ��緹�ڵ� ����

     -- ����
        CREATE TABLE emp1 AS SELECT * FROM emp;
        CREATE TABLE emp_score1 AS SELECT * FROM emp_score;
        
        SELECT * FROM emp1;
        SELECT * FROM emp_score1;
        
        -- emp_score ���̺��� empNo�� '1001'�� ������ ����
        DELETE FROM emp_score1 WHERE empNo='1001';
        SELECT * FROM emp_score1;
        COMMIT;

        -- ���������� �̿��Ͽ� ����
            DELETE FROM emp_score1 WHERE empNo IN(SELECT empNo FROM emp1 WHERE dept='���ߺ�');
            SELECT * FROM emp_score1;
        
        -- 
            DELETE FROM emp1 WHERE dept = '���ߺ�';
            SELECT * FROM emp1;
            COMMIT;
            
        -- ���������� �����ϸ� ������ �� ����.
            DELETE FROM emp WHERE dept = '���ߺ�';
                -- ����
                -- emp_score ���̺��� emp ���̺��� �����ϰ� ������, ���ߺ� �����Ͱ� emp_score�� �����ϹǷ� ������ �Ұ���
          
         -- ��ü ������ ���� : ������ �������� ����
            DELETE FROM emp1;
            SELECT * FROM emp1;
            COMMIT;
            
         --
            DROP TABLE emp1 PURGE;
            DROP TABLE emp_score1 PURGE;
            
            DROP TABLE emp_score PURGE;
            
            SELECT * FROM tab;
            
         -- �Ǽ��� ������ ��� �����ϱ�
            DELETE FROM emp WHERE city='����';
            COMMIT;
            SELECT * FROM emp;
            
         -- 20������ emp ���̺�
            SELECT * FROM emp
            AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '20' MINUTE);
            
        -- 20������ emp ���̺�� ������ �����͸� ����
            INSERT INTO emp (
                SELECT * FROM emp 
                AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '20' MINUTE)
                WHERE city ='����'
            );
            SELECT * FROM emp;
            COMMIT;
            
            
 -- �� MERGE
   -- �� MERGE : ������ ����
     -------------------------------------------------------
     -- �⺻����
       MERGE INTO ������̺��
           USING �������̺� ON ( ���� )
             WHEN MATCHED THEN
                 UPDATE SET �÷�=��, �÷�=��
            WHEN NOT MATCHED THEN
                INSERT [ (�÷�, �÷�) ] VALUES (��, ��)
             ;
      
    ----------------------------------------------------------
    -- ����
    CREATE TABLE emp1 AS
        SELECT empNo, name, city, dept, sal FROM emp WHERE city = '��õ';
        
    CREATE TABLE emp2 AS
        SELECT empNo, name, city, dept, sal FROM emp WHERE dept= '���ߺ�';
        
    MERGE INTO emp1 e1 -- > ����
           USING emp2 e2 ON ( e1.empNo = e2.empNo )
             WHEN MATCHED THEN
                 UPDATE SET e1.sal = e1.sal + e2.sal
            WHEN NOT MATCHED THEN
                INSERT (e1.empNo, e1.name, e1.city, e1.dept, e1.sal) -- >  �ݵ�� ����� ����
                        VALUES (e2.empNo, e2.name, e2.city, e2.dept, e2.sal);
                        
    SELECT * FROM emp1;
    COMMIT;
    
    DROP TABLE emp1 PURGE;
    DROP TABLE emp2 PURGE;
   
                        

    

