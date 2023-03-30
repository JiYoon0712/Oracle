-- �� ������ ���� ���(Data Definition Language)
 -- �� ������ ���� ���(DDL) �� ������ Ÿ��

   -- �� ������ Ÿ�� - ����
      -- ������ Ÿ�� ���� Ȯ��
         SELECT DATA_TYPE, DATA_LENGTH, CHAR_LENGTH, CHAR_USED
         FROM USER_TAB_COLUMNS
         WHERE TABLE_NAME ='���̺��';


 -- �� ���̺� ���� �� ���� ����
   -- �� ���̺� ���� 
     -------------------------------------------------------
     -- �⺻ ����
         CREATE TABLE ���̺��
         (
              �÷���  Ÿ��[(ũ��)]  [��������]
              ,�÷���  Ÿ��[(ũ��)]  [��������]
          );

     -- ���̺�� : test
        �÷��� �÷�Ÿ��    ��  �������� NULL
        num    NUMBER   10  �⺻Ű   X
        name   VARCHAR  30          X
        birth  DATE  
        city   VARCHAR2 30
    

        -- PRIMARY KEY�� �⺻������ NOT NULL �Ӽ��� ������ ����
        CREATE TABLE test(
                num NUMBER(10) PRIMARY KEY,
                name VARCHAR2(30) NOT NULL,
                birth DATE,
                city VARCHAR2(30)
            );
            
            SELECT * FROM tab;
            SELECT * FROM col WHERE tname = UPPER('test');
            DESC test;
            
   -- �� ���̺� ���� - ���� �÷�(virtual column)
     -------------------------------------------------------
     --
 

   -- �� ���̺� ���� - subquery�� �̿��� ���̺� ���� 
     -------------------------------------------------------
     -- �⺻����
      CREATE  TABLE  ���̺�� [(�÷���, �÷���,...)] AS subquery;

     -- �����ϴ� ���̺��� �̿��Ͽ� ���̺� �ۼ� : ���̺� ���� �� ������ ����
        SELECT empNo, name, sal, bonus, sal+bonus FROM emp;
        
        CREATE TABLE emp1 AS
            SELECT empNo, name, sal, bonus, sal+bonus FROM emp;
            --����. sal+bonus�� �÷����� �� �� ����.
            
        CREATE table emp1 AS
            SELECT empNo, name, sal, bonus, sal+bonus pay from emp;
            -- NOT NULL �̿��� ���� ������ ������� �ʴ´�.
        
        SELECT * FROM tab;
        DESC emp1;
        
        SELECT * FROM emp1;
        
        -- �������� Ȯ��
            SELECT * FROM user_constraints;
                -- constraint_type => P : �⺻Ű, U: UNIQUE, C : NOT NULL

        -- �÷����� �����Ͽ� ���̺��� ���� �� �����͸� ����
            SELECT empNo, name, TO_DATE(SUBSTR(rrn,1,6),'RRMMDD') 
            FROM emp
            WHERE TO_DATE(SUBSTR(rrn,1,6),'RRMMDD')>= '1990-01-01';
            
            CREATE TABLE emp2(eno,name,birth) AS
                 SELECT empNo, name, TO_DATE(SUBSTR(rrn,1,6),'RRMMDD') 
                 FROM emp
                 WHERE TO_DATE(SUBSTR(rrn,1,6),'RRMMDD')>= '1990-01-01';
                -- SELECT ������ �������� �̸��� �ٲپ ���� ����
                
            DESC emp2; --> ���̺� ���� ����!    
            
            SELECT * FROM emp2;
            
         -- ���̺��� ������ ���� : �÷��� �� Ÿ�԰� ũ��
            -- NOT NULL�� ���� ������ ��Ÿ ���� ������ ������� �ʴ´�.
            
            SELECT * FROM emp WHERE 1=0;
            
            CREATE TABLE emp3 AS
                SELECT * FROM emp WHERE 1=0;    --> ������ �������µ� �����ʹ� x
                
            DESC emp3;
            SELECT * FROM emp3; 
                
        
   -- �� ALTER TABLE ~ ADD
        -- ���� ���̺� ���ο� �÷� �߰�
        -- ���� �߰��� �÷��� ���� �������� ��ġ
        
     -------------------------------------------------------
     -- �⺻����
       -- ALTER TABLE ���̺�� ADD (�÷��� �ڷ���(ũ��));
        
       -- �÷� �߰�
          DESC test;

          ALTER TABLE test ADD ( dept VARCHAR2(30), sal NUMBER(3) NOT NULL);        
          DESC test;
          
       -- �����Ͱ� �����ϴ� ���̺��� NOT NULL �Ӽ��� �÷��� �߰��� �� ����.
            SELECT * FROM emp2;
            
            ALTER TABLE emp2 ADD(dept VARCHAR2(30) NOT NULL);
                -- ����. �����Ͱ� �����ϸ� NOT NULL �Ӽ��� �÷� �߰� �Ұ�
          
            ALTER TABLE emp2 ADD(dept VARCHAR2(30));
            DESC emp2;
            SELECT * FROM emp2;

   -- �� ALTER TABLE ~ MODIFY : ���̺� �����ϴ� �÷� Ÿ��, ũ����� ����
   
     -------------------------------------------------------
     -- �⺻����
       -- ALTER TABLE ���̺�� MODIFY (�÷��� �ڷ���(ũ��));
       
       
       -- �÷� �� ����
        DESC test;
        
        ALTER TABLE test MODIFY(sal NUMBER(8));
        DESC test;
           
        DESC emp2;
        ALTER TABLE emp2 MODIFY(name VARCHAR2(8));
            -- ����. �����Ͱ� �����ϸ� �������� ���̺��� ũ�ų� ���ƾ��Ѵ�.

   -- �� ALTER TABLE ~ RENAME COLUMN : �÷����� �����Ѵ�.
     -------------------------------------------------------
     -- �⺻����
       --ALTER TABLE ���̺�� RENAME COLUMN �÷��� TO ���ο��÷���
       
       DESC emp2;
       
       ALTER TABLE emp2 RENAME COLUMN eno TO empNo; 
       DESC emp2;
    

   -- �� ALTER TABLE ~ DROP COLUMN : �÷� ����. �����Ͱ� �����ϸ� �����͵� �����ȴ�.
     -------------------------------------------------------
     -- �⺻����
      --ALTER TABLE ���̺�� DROP COLUMN �÷���
      
      -- �÷� ����
        DESC test;
        
        ALTER TABLE test DROP COLUMN dept;
        DESC test;
        
        SELECT * FROM emp2;
        ALTER TABLE emp2 DROP COLUMN name;
                -- �����Ͱ� �����ϸ� �����͵� ���� ������
        DESC emp2;
        
        SELECT * FROM emp2;


   -- �� ALTER TABLE ~ SET UNUSED : �÷��� ���������� ������ �������� ����� ����
     -------------------------------------------------------
     -- ��
        SELECT * FROM emp1;
        
        ALTER TABLE emp1 SET UNUSED(pay);
        SELECT * FROM emp1;
            -- pay �Ⱥ���
        SELECT name, pay FROM emp1;
            -- ����
        DESC emp1;
            -- pay �Ⱥ���


   -- �� ALTER TABLE ~ SET UNUSED�� ���� �������� ������ �÷��� ���� Ȯ��
     -------------------------------------------------------
     -- SET UNUSED�� ���� �������� ������ �÷��� Ȯ���ϰų� ���� �Ұ�
     -- � ���̺� ��� �÷��� UNUSED �Ǿ������� Ȯ�� ����
     
     -- UNUSED�� �÷� ���� Ȯ��
        SELECT * FROM user_unused_col_tabs;


   -- �� ALTER TABLE ~ DROP UNUSED COLUMNS : SET UNUSED�� ���� �������� ������ �÷��� ������ ����
     -------------------------------------------------------
     -- ��
     ALTER TABLE emp1 DROP UNUSED COLUMNS;
     
     SELECT * FROM user_unused_col_tabs;


   -- ��  ���̺� ����
     -------------------------------------------------------
     -- �⺻����
      DROP TABLE ���̺�;  -- �����뿡 �ӽú���
      DROP TABLE ���̺� PURGE;  -- �����뿡 �ӽú��� ���� �ʰ� �ٷ� ����
      DROP TABLE ���̺�� CASCADE CONSTRAINTS PURGE;
         -- ���̺�� �� ���̺��� �����ϴ� FOREIGN KEY�� ���������� ���ÿ� ����    
        
      CREATE TABLE demo AS
        SELECT * FROM emp;
      
      CREATE TABLE emp4 AS
        SELECT * FROM emp;
        
      SELECT * FROM tab;
      
      -- ������ �� ���̺� ���� ����
        DROP TABLE demo;  -- ���������� ����
        DROP TABLE test;  -- ���������� ����
        SELECT * FROM tab;
        
        DROP TABLE emp4 PURGE;  -- ���� ����
        SELECT * FROM tab;
     

   -- �� RENAME : ���̺��� �̸��� ����
     -------------------------------------------------------
     -- �⺻����
       RENAME ���̸� TO ���̸�;
       
       SELECT * FROM tab;
       
       RENAME emp2 TO demo;
       SELECT * FROM tab; 
        


   -- �� ������(RECYCLEBIN) ���� Ȯ��
    -- ������ ��ü(objects)Ȯ��
     -------------------------------------------------------
     -- �������� ��ü Ȯ��
        SELECT * FROM recyclebin;
        SHOW recyclebin;
    
     -- ��
        DROP TABLE demo;
        SELECT * FROM tab;
        

   -- �� FLASHBACK TABLE : ������ ����
     -------------------------------------------------------
     --��
        SELECT * FROM tab;
        
        FLASHBACK TABLE test TO BEFORE DROP;
            -- ������ ���������̸��� �ΰ��̻��̸� �������� ������ ���̺� ����
        SELECT * FROM tab;
        
      -- BIN�̸����� ����
        SELECT * FROM tab;
        
        FLASHBACK TABLE "BIN$MvMZ8BvzTti0o/jfPPqCkg==$0" TO BEFORE DROP;    -- demo ������ BIN �̸�
        SELECT * FROM tab;
        
      -- �̸��� �����ؼ� ����
        FLASHBACK TABLE demo TO BEFORE DROP RENAME TO emp2;
            -- demo : �������̸�, emp2 : ������ �̸�
        SELECT * FROM tab;

   -- �� ������ ����
     -------------------------------------------------------
     -- ��
        DROP TABLE test;
        DROP TABLE demo;
        DROP TABLE emp2;
        
        SELECT * FROM recyclebin;
        
     -- ������ ���� : demo�� ����
        PURGE TABLE demo;
        SELECT * FROM recyclebin;
        
     -- ������ �� ����
        PURGE recyclebin;
        SELECT * FROM recyclebin;
        
     -- �����뿡 �������ʰ� �ٷ� �����ϱ�
        DROP TABLE ���̺� PURGE;
        
        
   -- �� TRUNCATE : ������ ��� �����, �ڵ� COMMIT �ǹǷ� ȸ���Ұ�
     -------------------------------------------------------
     -- ��
        SELECT * FROM emp1;
        
        -- �����͸� ��� �����. ���̺��� ������ �������� �ʴ´�
        -- �ڵ� COMMIT �ǹǷ� ȸ�� �Ұ�
        -- ��� �ڷḦ �� ���� ��� DELETE ���� ����
           TRUNCATE TABLE emp1;
           
           SELECT * FROM emp1;
           DESC emp1;
           
           DROP TABLE emp1 PURGE;
           
           
