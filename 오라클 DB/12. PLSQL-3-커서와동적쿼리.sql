-- �� PL/SQL
 -- �� Ŀ��(Cursor)
     -------------------------------------------------------
     -- �Ͻ��� Ŀ��
         -- SQL%ROWCOUNT : �ش� SQL ���� ������ �޴� ���� ��
         -- SQL%FOUND : �ش� SQL ������ �޴� ���� ���� 1�� �̻��� ��� TRUE
         -- SQL%NOTFOUND : �ش� SQL ���� ������ �޴� ���� ���� ���� ��� TRUE
         -- SQL%ISOPEN : �׻� FALSE, �Ͻ��� Ŀ���� ���� �ִ����� ���� �˻�

        DECLARE
            vempNo emp.empNo%TYPE;
            vCount NUMBER;
            
        BEGIN
            vempNo :='8001';
            DELETE FROM emp WHERE empNo = vempNo;
            vCount := SQL%ROWCOUNT;
            COMMIT;
            
            DBMS_OUTPUT.PUT_LINE(vCount ||'���� �����Ǿ����ϴ�.');
        END;
        /


        DECLARE
            vempNo emp.empNo%TYPE;
        BEGIN
            vempNo :='8001';
            DELETE FROM emp WHERE empNo = vempNo;
            
            IF SQL%NOTFOUND THEN
                RAISE_APPLICATION_ERROR(-20001,'����');   --> try/catch�� catch�� �����ش�.
            END IF;
            
            COMMIT;
            
            DBMS_OUTPUT.PUT_LINE('�����Ǿ����ϴ�.');
        END;
        /


     -------------------------------------------------------
     -- ����� Ŀ��
     -- CURSOR ���� -> Ŀ�� OPEN -> FETCH -> Ŀ�� CLOSE
    
        DECLARE 
            vname emp.name%TYPE;
            vsal emp.sal%TYPE;
        
            -- 1.Ŀ������
            CURSOR cur_emp IS SELECT name, sal FROM emp;    
        BEGIN
            -- 2. Ŀ�� OPEN
            OPEN cur_emp;
            
            LOOP 
                -- 3. FETCH
                FETCH cur_emp INTO vname, vsal;
                EXIT WHEN cur_emp%NOTFOUND;
                
                 DBMS_OUTPUT.PUT_LINE(vname||'  '||vsal);
            END LOOP;
            
            -- 4. Ŀ�� CLOSE
            CLOSE cur_emp; 
        END;
        /
    -- > Ŀ���� �߿��� ���� �ƴ϶�. �� Ŀ���� ����� �ڹٷ� �����ִ� ���� �߿��ϴ�. >> �ƿ� �Ķ����
    
     -------------------------------------------------------
     -- �̸� �˻� :  �Ķ���Ͱ� �ִ� Ŀ���� �̿�
     CREATE OR REPLACE PROCEDURE pEmpSelect
     (
            pName emp.name%TYPE
     )
     IS
        vName emp.name%TYPE;
        vSal  emp.sal%TYPE;
     
        CURSOR cur_emp(cName emp.name%TYPE) IS
            SELECT name,sal FROM emp WHERE INSTR(name,cName) >0;
     BEGIN
        OPEN cur_emp( pName );
        LOOP
            FETCH cur_emp INTO vName, vSal;
            EXIT WHEN cur_emp%NOTFOUND;
            
            DBMS_OUTPUT.PUT_LINE(vName||'  '||vSal);
        END LOOP;
        CLOSE cur_emp;
     END;
     /
     
     EXEC pEmpSelect('��');


     -- �̸� �˻� : ���� �˻�
     CREATE OR REPLACE PROCEDURE pEmpSelect
     (
            pName emp.name%TYPE
     )
     IS
        vName emp.name%TYPE;
        vSal  emp.sal%TYPE;
     
        CURSOR cur_emp IS
            SELECT name,sal FROM emp WHERE INSTR(name,pName) >0;
     BEGIN
        OPEN cur_emp;
        LOOP
            FETCH cur_emp INTO vName, vSal;
            EXIT WHEN cur_emp%NOTFOUND;
            
            DBMS_OUTPUT.PUT_LINE(vName||'  '||vSal);
        END LOOP;
        CLOSE cur_emp;
     END;
     /
     
     EXEC pEmpSelect('��');
     
    -------------------------------------------------------
    -- Cursor FOR Loops : �ڵ� OPEN, �ڵ� FETCH, �ڵ� CLOSE
    CREATE OR REPLACE PROCEDURE pEmpSelect
    IS
        CURSOR cur_emp IS
            SELECT name,sal FROM emp;
    BEGIN
        FOR rec IN cur_emp LOOP
            DBMS_OUTPUT.PUT_LINE(rec.name||'  '||rec.sal);
        END LOOP;
    END;
    /




   �� Ŀ�� ����(cursor variable)
     -------------------------------------------------------
     -- SYS_REFCURSOR  >>> �̰� ���� �߿�ڡڡ�
        -- : ���� ���� Ŀ�� Ÿ��
        -- : ������ Ÿ���� �����ϰ� ���� �ʱ� ������ ��� ��� ���� ������ �� ����
        -- : ���ν��� ������(SELECT ��)�� �ڹ� �� ���α׷��� ���� �Ҷ� ���
      -- Ŀ�� ���� ����
        Ŀ������ SYS_REFCURSOR;
      -- Ŀ�� ���� ���
         OPEN Ŀ������ FOR SELECT ��
      -- Ŀ�� �������� �� ���� ����
         FETCH Ŀ������ INTO ����, ����;
         FETCH Ŀ������ INTO ���ڵ庯��;

     -------------------------------------------------------
     --  >> ��
     CREATE OR REPLACE PROCEDURE pEmpSelect
     (
            pName   IN  VARCHAR2,
            pResult OUT SYS_REFCURSOR
     )
     IS
     BEGIN
        -- Ŀ�� ���� ��� : OPEN Ŀ������ FOR SELECT��
        OPEN pResult FOR
            SELECT name, sal FROM emp WHERE INSTR(name, pName) > 0;
     END;
     /

    -- Ȯ�ο� ���ν���
    CREATE OR REPLACE PROCEDURE pEmpResult
    IS
        vName   emp.name%TYPE;
        vSal    emp.sal%TYPE;
        vResult SYS_REFCURSOR;
    BEGIN
        -- ���ν��� ȣ��
        pEmpSelect('��',vResult);
        
        LOOP
            FETCH vResult INTO vName, vSal;
            EXIT WHEN vResult%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(vName||' '||vSal);
        END LOOP;
    END;
    /
     
    EXEC pEmpResult;
    
     
   -----------------------------------------------------
   -- ����¡ ó�� �׽�Ʈ
   CREATE TABLE demo(
        num NUMBER PRIMARY KEY,
        name VARCHAR2(50) NOT NULL,
        content VARCHAR(4000) NOT NULL,
        reg_date DATE DEFAULT SYSDATE
   );
   
   CREATE SEQUENCE demo_seq
   INCREMENT BY 1
   START WITH 1
   NOMAXVALUE
   NOCYCLE
   NOCACHE;
   
   CREATE OR REPLACE PROCEDURE pInsertDemo
   IS
        n NUMBER := 0;
   BEGIN
        WHILE n<700000 LOOP
            n:= n+1;
            INSERT INTO demo(num, name, content) VALUES (demo_seq.NEXTVAL, '�̸�'||n,'�����̴� - '||n);
            COMMIT;
        END LOOP;
   END;
   /
   
   EXEC pInsertDemo;
   SELECT COUNT(*) FROM demo;

   -- num �������� �����Ͽ� 90001 ~ 90010 ���ڵ� ���
   SELECT * FROM (
        SELECT ROWNUM rnum, tb.* FROM(
            SELECT num, name, content
            FROM demo
            ORDER BY num DESC
        ) tb WHERE ROWNUM <=90010
   ) WHERE rnum >= 90001;
    
    SELECT num, name, content
    FROM demo
    ORDER BY num DESC
    OFFSET 90000 ROWS FETCH FIRST 10 ROWS ONLY;
    
    DROP TABLE demo PURGE;
    DROP SEQUENCE demo_seq;
    DROP PROCEDURE pInsertDemo;
    

 �� ��������(Dynamic SQL)
     -------------------------------------------------------
     -- EXECUTE IMMEDIATE
        -- : DDL, DML ������ ����
        -- : SELECT ���� ���� �� INTO ���� ����Ͽ� ���� ���� ��ȯ ���� �� ���
        -- : ���ν��� ��� �������� ������ �����ϰų� �ؽ�Ʈ ������ �Է� �޾� ó���ϴ� ��� ���
        -- : RESOURCE ���Ѹ� ������ �⺻������ ���̺����, ������ �������� �Ҽ� ������ EXECUTE IMMEDIATE ������ �Ұ����ϴ�.
        -- : EXECUTE IMMEDIATE �� ���̺��� �����ϰų� �������� ����� ���ؼ��� ������ �ý��� ������ �ʿ� �Ѵ�.
          CREATE TABLE, CREATE SEQUENCE

     -------------------------------------------------------
     -- ������ ����(sys, system)
        GRANT CREATE TABLE TO sky;
        GRANT CREATE SEQUENCE TO sky;

     -------------------------------------------------------
     -- sky ����
     -- �ý��� ���� Ȯ��
        SELECT * FROM user_sys_privs;
        
     -- �������� �Խ��� ���̺��� ����� ���ν��� �����
        CREATE OR REPLACE PROCEDURE pBoardCreate
        (
            pName VARCHAR2
        )
        IS
            s VARCHAR2(4000);
        BEGIN
            s := ' CREATE TABLE ' || pName ;
            s := s || ' ( num NUMBER PRIMARY KEY,';
            s := s || ' name VARCHAR2(30) NOT NULL,';
            s := s || ' subject VARCHAR2(300) NOT NULL,';
            s := s || ' content VARCHAR2(4000) NOT NULL,';
            s := s || ' hitCount NUMBER DEFAULT 0,';
            s := s || ' reg_date DATE DEFAULT SYSDATE)';
            
            FOR t IN ( SELECT tname FROM tab WHERE tname = UPPER(pName) ) LOOP
                EXECUTE IMMEDIATE 'DROP TABLE ' || pName || ' PURGE';
                DBMS_OUTPUT.PUT_LINE( pName || '���̺� ����...');
            END LOOP;
            
            EXECUTE IMMEDIATE s;
            
            DBMS_OUTPUT.PUT_LINE( pName || '���̺� ����');
            
            FOR t IN ( SELECT sequence_name FROM seq WHERE sequence_name = UPPER(pName || '_seq') ) LOOP
                EXECUTE IMMEDIATE 'DROP SEQUENCE ' || pName || '_seq';
                DBMS_OUTPUT.PUT_LINE(pName || '_seq ������ ����...');
            END LOOP;
            
            EXECUTE IMMEDIATE 'CREATE SEQUENCE '|| pName || '_seq';
            
            DBMS_OUTPUT.PUT_LINE( pName || '_seq ������ ����');
        END;
        /
        
        EXEC pBoardCreate('demo');
        
        SELECT * FROM tab;
        SELECT * FROM seq;
        