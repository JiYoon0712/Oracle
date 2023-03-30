-- �� PL/SQL
 -- �� Ʈ����
   -- : �̸� ���� ���� Ư�� ������ �����ϰų� � ������ �����ϸ� �ڵ����� �����ϵ��� ������ ����
   -- : ���� ��� DML(INSERT, UPDATE, DELETE) ������ ����ǰų� DDL(CREATE, ALTER, DROP) ������ ����� �� Ʈ���Ű� ����� �� �ִ�.
   -- : Ʈ���Ŵ� CREATE TRIGGER �ý��� ������ �־�� ���� �����ϴ�.

   -- ������ ����(sys, system)
      GRANT CREATE TRIGGER TO sky;
      
   -- sky ����
      SELECT * FROM user_sys_privs;
      
      

     -------------------------------------------------------
     -- ���� Ʈ���� 
        -- : �ϳ��� DML ������ Ʈ���Ŵ� �ѹ� �Ͼ��.
        -- : ���� ��� "DELETE FROM ���̺�;" �������� 5���� ���ڵ尡 ���� �Ǿ Ʈ���ŵ� �ѹ� ���� �ȴ�.
        -- : ���̺� ���ڵ尡 �Է�, ����, ���� ���� �α� ���

        -- �α� ���� ���� Ʈ���� �ۼ�
            CREATE TABLE test
            (
                num NUMBER PRIMARY KEY,
                name VARCHAR2(50) NOT NULL,
                content VARCHAR2(4000) NOT NULL
            );  
            
            CREATE TABLE test_info
            (
                memo VARCHAR2(100) NOT NULL,
                created DATE DEFAULT SYSDATE
            );
            
            -- test ���̺� DML �۾��� �Ͼ ��� DML �۾��� �Ͼ �ð��� ����ϴ� Ʈ���� �ۼ�
            CREATE OR REPLACE TRIGGER testInfoTrigger
            AFTER INSERT OR UPDATE OR DELETE ON test
            BEGIN
                IF INSERTING THEN
                    INSERT INTO test_info(memo) VALUES('������ �߰�');
                ELSIF UPDATING THEN
                    INSERT INTO test_info(memo) VALUES('������ ����');
                ELSIF DELETING THEN
                    INSERT INTO test_info(memo) VALUES('������ ����');
                END IF;
                -- Ʈ���� �ȿ��� INSERT, UPDATE, DELETE �Ŀ��� �ڵ� COMMIT�ȴ�.
                --> Ʈ���� �ȿ����� COMMIT ����� �� ����
            END;
            /
            
            -- Ʈ���� Ȯ��
                SELECT * FROM user_triggers;

            -- ������ Ȯ��
                SELECT * FROM user_dependencies;
                
            -- Ȯ��
                INSERT INTO test(num, name, content) VALUES(1,'a','aa');
                INSERT INTO test(num, name, content) VALUES(2,'b','bb');
                INSERT INTO test(num, name, content) VALUES(3,'c','cc');
                COMMIT;
                
                SELECT * FROM test;
                SELECT * FROM test_info;

                DELETE FROM test;
                COMMIT;
                
                SELECT * FROM test;
                SELECT * FROM test_info;
                
            -- Ʈ���� ����
                DROP TRIGGER testInfoTrigger;
                SELECT * FROM user_triggers;


     -------------------------------------------------------
     -- ���� Ʈ���� : ������ �ð����� DML �۾��� �� �� �ִ� Ʈ���� �ۼ�
        --> ���� �� �ѹ�. Ʈ���� �� ��
        CREATE OR REPLACE TRIGGER testTrigger
        BEFORE INSERT OR UPDATE OR DELETE ON test
        BEGIN
            IF TO_CHAR(SYSDATE,'D') IN(1,7) OR
                -- (TO_CHAR(SYSDATE,'HH24') < 9 OR TO_CHAR(SYSDATE,'HH24')>18)  THEN
                   (TO_CHAR(SYSDATE,'HH24') > 12 OR TO_CHAR(SYSDATE,'HH24') < 13)  THEN
                RAISE_APPLICATION_ERROR(-20001,'�ٹ��ð��� �ƴϴ�.');
            END IF;
        END;
        /
     
        INSERT INTO test(num, name, content) VALUES(1,'a','aa');
        SELECT * FROM test;
        
        DROP TRIGGER testTrigger;
        SELECT * FROM user_triggers;
        
        
                
     -------------------------------------------------------
     -- �� Ʈ����
        -- : DML ������ ���Ǹ����ϴ� ��� �࿡ ���Ͽ� Ʈ���ų� �Ͼ��.
        -- : ���� ��� "DELETE FROM ���̺�;" �������� 5���� ���ڵ尡 ������ ��� Ʈ���Ŵ� 5�� ���� �ȴ�.
        -- : OLD �� NEW ���ڵ�
          -- �� Ʈ���ſ����� ��� ����
          -- :OLD 
            UPDATE ������ ������ ���ڵ�, DELETE ������ ������ ���ڵ�
          -- :NEW
            INSERT������ �߰��� ���ڵ�, UPDATE ������ ������ ���ڵ�

     -------------------------------------------------------
     -- �� Ʈ���� ��
        DROP TABLE score2 PURGE;
        DROP TABLE score1 PURGE;
        
        DELETE FROM score2;
        DELETE FROM score1;
        COMMIT;
        
        CREATE TABLE score1 (
          hak VARCHAR2(20) NOT NULL
          ,name VARCHAR2(30) NOT NULL
          ,kor NUMBER(3) NOT NULL
          ,eng NUMBER(3) NOT NULL
          ,mat NUMBER(3) NOT NULL
          ,CONSTRAINT pk_score1_hak PRIMARY KEY(hak)
      );

      CREATE TABLE score2 (
          hak VARCHAR2(20) NOT NULL
          ,kor NUMBER(2,1) NOT NULL
          ,eng NUMBER(2,1) NOT NULL
          ,mat NUMBER(2,1) NOT NULL
          ,CONSTRAINT pk_score2_id PRIMARY KEY(hak)
          ,CONSTRAINT fk_score2_id FOREIGN KEY(hak)
              REFERENCES score1(hak)
      );

      CREATE OR REPLACE FUNCTION fnGrade
      (
          pScore NUMBER
      )
      RETURN NUMBER
      IS
         n NUMBER(2,1);
      BEGIN
         IF  pScore<0 OR  pScore>100 THEN
              RAISE_APPLICATION_ERROR(-20001, '������ 0~100���̸� �����մϴ�.');
         END IF;

         IF pScore>=95 THEN n:=4.5;
         ELSIF pScore>=90 THEN n:=4.0;
         ELSIF pScore>=85 THEN n:=3.5;
         ELSIF pScore>=80 THEN n:=3.0;
         ELSIF pScore>=75 THEN n:=2.5;
         ELSIF pScore>=70 THEN n:=2.0;
         ELSIF pScore>=65 THEN n:=1.5;
         ELSIF pScore>=60 THEN n:=1.0;
         ELSE n:=0.0;
         END IF;

         RETURN n;
      END;
      /
    
    -- INSERT �� ���� �� Ʈ���� : score1 ���̺� INSERT�� �Ͼ�� score2 ���̺� INSERT �Ǵ� Ʈ���� �ۼ�
    CREATE OR REPLACE TRIGGER scoreInsertTri
    AFTER INSERT ON score1
    FOR EACH ROW    -- ��Ʈ����
    DECLARE
        -- ���� ����
    BEGIN
        -- :NEW -> score1 ���̺� INSERT �ϴ� ���ڵ�
        -- Ʈ���� �ȿ����� DML �� �������� COMMIT ���� �ʴ´�.(���� �߻�, �ڵ� COMMIT)
        INSERT INTO score2(hak, kor, eng, mat) VALUES
            (:NEW.hak, fnGrade(:NEW.kor),fnGrade(:NEW.eng),fnGrade(:NEW.mat));
    END;
    /
    
    INSERT INTO score1(hak, name, kor, eng, mat) VALUES('1111','������',85,90,95);
    INSERT INTO score1(hak, name, kor, eng, mat) VALUES('1112','������',100,75,90);
    COMMIT;

    SELECT * FROM score1;
    SELECT * FROM score2;


    -- UPDATE �� ���� �� Ʈ���� : score1 ���̺� UPDATE�� �Ͼ�� score2 ���̺� UPDATE �Ǵ� Ʈ���� �ۼ�
    CREATE OR REPLACE TRIGGER scoreUpdateTri
    AFTER UPDATE ON score1
    FOR EACH ROW    -- ��Ʈ����
    DECLARE
        -- ���� ����
    BEGIN
        -- :NEW -> score1 ���̺� ���� UPDATE �ϴ� ���ڵ�, : OLD -> score1 ���̺��� UPDATE �Ǳ� ���� ���ڵ�
        UPDATE score2 SET kor = fnGrade(:NEW.kor) , eng =fnGrade(:NEW.eng) , mat =fnGrade(:NEW.mat)
        WHERE hak = :OLD.hak;
    END;
    /
    
    UPDATE score1 SET kor=100 WHERE hak = '1111';
    
    COMMIT;

    SELECT * FROM score1;
    SELECT * FROM score2;
    -- �й� ����
        UPDATE score1 SET hak = '2000' WHERE hak ='1111';
            -- ORA-02292 : �ڽ��� �����ϴ� ��� �θ��� �⺻Ű ���� �Ұ�
            --> �̷���� Ʈ���� �̿��ϸ� ¯ ���� BUT...

    -- Ʈ���Ÿ� �̿��Ͽ� �θ��� �⺻Ű�� �����ϸ� �ڽ��� ����Ű�� ����ǵ��� �� �� �ִ�.
    --> ��û�� ����. �ǹ����� ����������Ŷ�.
    CREATE OR REPLACE TRIGGER scoreUpdateTri
    AFTER UPDATE ON score1
    FOR EACH ROW    -- ��Ʈ����
    DECLARE
    BEGIN
        UPDATE score2 SET 
            hak = :NEW.hak, kor = fnGrade(:NEW.kor) , eng =fnGrade(:NEW.eng) , mat =fnGrade(:NEW.mat)
        WHERE hak = :OLD.hak;
    END;
    /
    -- �й� ����
        UPDATE score1 SET hak = '2000' WHERE hak ='1111';
        COMMIT;
        
        SELECT * FROM score1;
        SELECT * FROM score2;

  -- DELETE �� ���� �� Ʈ���� : score1 ���̺� DELETE �Ͼ�� score2 ���̺����� DELETE �Ǵ� Ʈ���� �ۼ�
    CREATE OR REPLACE TRIGGER scoreDeleteTri
    BEFORE DELETE ON score1     -- AFTER �� ����
    FOR EACH ROW    -- ��Ʈ����
    DECLARE
    BEGIN
        -- :OLD -> score1 ���̺��� DELETE�Ǳ� ���� ���ڵ�
        
        DELETE FROM score2 WHERE hak = :OLD.hak;
    END;
    /
    
    DELETE FROM score1 WHERE hak = '2000';
    COMMIT;
    
    SELECT * FROM score1;
    SELECT * FROM score2;





 -- �� ��Ű��(Package)
     -------------------------------------------------------
     -- ��Ű�� ����
     CREATE OR REPLACE PACKAGE pEmp IS
        FUNCTION fnTax(p IN NUMBER) RETURN NUMBER;
        PROCEDURE empList(pName VARCHAR2);
        PROCEDURE empList;  -- > �Ķ���� ���� ��� () ���� x
     END pEmp;
     /

    -- ��Ű�� ����
    CREATE OR REPLACE PACKAGE BODY pEmp IS
        FUNCTION fnTax(p IN NUMBER) 
        RETURN NUMBER
        IS
            t NUMBER :=0;
        BEGIN
            IF p>=3000000 THEN t := TRUNC(p*0.03,-1);
            ELSIF p>=200000 THEN t := TRUNC(p*0.02,-1);
            END IF;
            
            RETURN t;
        END;
        
        PROCEDURE empList(pName VARCHAR2)   -- > pName : �˻��ϰ� ���� �̸�
        IS
            vName VARCHAR2(30);
            vSal  NUMBER;
            CURSOR cur_emp IS
                SELECT name, sal FROM emp WHERE INSTR(name, pName) >=1;
        BEGIN
            OPEN cur_emp;
            LOOP
                FETCH cur_emp INTO vName, vSal;
                EXIT WHEN cur_emp%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE(vName||' '||vSal);
            END LOOP;
            CLOSE cur_emp;
        END;
        
        PROCEDURE empList
        IS
        BEGIN
            FOR rec IN ( SELECT name, sal+bonus pay, fnTax(sal+bonus) tax FROM emp) LOOP
                DBMS_OUTPUT.PUT_LINE(rec.name || ' ' || rec.pay||' '||rec.tax);
            END LOOP;
        END;
         
    END pEmp;
    /
    
    EXEC pEmp.empList();
    EXEC pEmp.empList('��');
    