-- �� PL/SQL
 -- �� �⺻ ����
    -- PL/SQL
       -- : ���α׷��־���� Ư���� ������ SQL�� Ȯ��
       -- : ������ ���۰� ���� ������ PL/SQL�� ������ �ڵ� �ȿ� ���Եȴ�.

     -- PL/SQL ���α׷��� ����
       -- ��PL/SQL �͸� ���
       -- ���Լ�
       -- �����ν���
       -- ����Ű�� : ��Ű�� ��, ��Ű�� �ٵ�
       -- ��Ʈ����


   -- �� �⺻ ����
     -------------------------------------------------------
       -- sqlpus : DBMS_OUTPUT ���
        SQL> SET SERVEROUTPUT ON
        
      -- PL/SQL ������ �Ϲ����� SELECT
        SELECT �÷�, �÷� INTO ����, ���� FROM ���̺� WHERE ����;

     -- 
     DECLARE 
        vname VARCHAR2(30);
        vpay   NUMBER;
     BEGIN
        SELECT name, sal+bonus pay INTO vname, vpay    -->> name > vname // sal+bonus > vpay
        FROM emp
        WHERE empNo = '1001';
        
        DBMS_OUTPUT.PUT_LINE('�̸� : ' ||vname);      -->> ���� �ִ��� Ȯ���ϴ� �뵵. LOG ���� ����
        DBMS_OUTPUT.PUT_LINE('�޿� : ' ||vpay);
     END;
     /      --> ���� - DBMS��� â �Ѽ� Ȯ��
     
     -- %TYPE �Ӽ� : ���̺��� �÷��� �����ϴ� ������ ����
     DECLARE 
        vname  emp.name%TYPE;   --> SELECT ���� name�� �ֱ⿡ name�̶�� �ϸ� �浹�Ͼ
        vpay   NUMBER;
     BEGIN
        SELECT name, sal+bonus pay INTO vname, vpay   
        FROM emp
        WHERE empNo = '1001';
        
        DBMS_OUTPUT.PUT_LINE('�̸� : ' ||vname);     
        DBMS_OUTPUT.PUT_LINE('�޿� : ' ||vpay);
     END;
     /
     
     -- %ROWTYPE �Ӽ� : ���̺��� ���� �����ϴ� ���ڵ庯���� ����
     DECLARE 
        vrec emp%ROWTYPE;
     BEGIN
        SELECT * INTO vrec   
        FROM emp
        WHERE empNo = '1001';
        
        DBMS_OUTPUT.PUT_LINE('�̸� : ' ||vrec.name);     
        DBMS_OUTPUT.PUT_LINE('�޿� : ' ||vrec.sal);
     END;
     /     

     -- ����� ���� ���ڵ�
     DECLARE 
        -- ���ڵ� ���� ����(����)
        TYPE MYTYPE IS RECORD
        (
            name emp.name%TYPE,
            pay  emp.sal%TYPE
        );
        -- ���ڵ� ���� ����
        vrec MYTYPE;
        BEGIN
        SELECT name, sal INTO vrec.name, vrec.pay
        FROM emp
        WHERE empNo = '1001';
        
        DBMS_OUTPUT.PUT_LINE('�̸� : ' ||vrec.name);     
        DBMS_OUTPUT.PUT_LINE('�޿� : ' ||vrec.pay);
     END;
     /  
     
       
   -- �� ���� ����
     -------------------------------------------------------
     -- IF
     DECLARE 
        a NUMBER := 10;
     BEGIN
        IF MOD(a,6) = 0 THEN
            DBMS_OUTPUT.PUT_LINE(a || ' 2�Ǵ� 3�� ���');
        ELSIF MOD(a,3) =0 THEN
            DBMS_OUTPUT.PUT_LINE(a || ' 3�� ���');
        ELSIF MOD(a,2) =0 THEN
            DBMS_OUTPUT.PUT_LINE(a || ' 2�� ���');
        ELSE
            DBMS_OUTPUT.PUT_LINE(a || ' 2�Ǵ� 3�� ����� �ƴ�');
        END IF;
    END;
/

     -- emp ���̺� : empNo�� 1001 �� ���ڵ��� name, sal+bonus, tax ���
        -- tax �� IF ������ �̿��Ͽ� ���. pay�� 300�� �̻� 3%, 200�� �̻� 2%, ������ 0 / �Ҽ��� ù°�ڸ� �ݿø�
      DECLARE 
        vname emp.name%TYPE;
        vpay  NUMBER;
        vtax  NUMBER;
     BEGIN
        SELECT name, sal+bonus INTO vname, vpay   
        FROM emp
        WHERE empNo = '1001';
     
        IF vpay >= 3000000 THEN
            vtax := ROUND(vpay * 0.03);
        ELSIF vpay >= 2000000 THEN
            vtax := ROUND(vpay * 0.02);
        ELSE
            vtax := 0;
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(vname || ' ' || vpay ||' ' || vtax);
    END;
/
     
     
     -------------------------------------------------------
     -- CASE
    DECLARE
        --��������
        vname emp.name%TYPE;
        vpay NUMBER;
        vtax NUMBER;
    BEGIN
        --db�ӿ��� ������ �������� �۾�
        SELECT name, sal+bonus INTO vname, vpay--�ϳ��Ǻ����� �ϳ��ǰ��� ���������� where���Ⱦ��� ����
        FROM emp
        WHERE empNo = '1001';
        
        CASE
            WHEN vpay>=3000000  THEN
                vtax := ROUND(vpay*0.03);
            WHEN vpay>=2000000  THEN
                vtax := ROUND(vpay*0.02);
            ELSE
                vtax := 0;
        END CASE;
        DBMS_OUTPUT.PUT_LINE(vname || ' ' || vpay||' '||vtax);
    END;
/

     -------------------------------------------------------
     -- basic LOOP, EXIT, CONTINUE
        -- ���� ����
        -- EXIT�� ������ ���� ����

     -------------------------------------------------------
     -- WHILE-LOOP
        -- 1~100���� �� ���ϱ�      
        DECLARE
            n NUMBER := 0;
            s NUMBER := 0;
        BEGIN
            -- WHERE ���� LOOP
            WHILE n <100 LOOP
            n := n+1;
            s := s+n;
            END LOOP;
            DBMS_OUTPUT.PUT_LINE('���:'||s);
        END;
        
            
        -- 1~100���� Ȧ���� ���ϱ�
        DECLARE
            n NUMBER := 1;
            s NUMBER := 0;
        BEGIN
            WHILE n <100 LOOP
                s := s+n;
                n := n+2;
            END LOOP;
            DBMS_OUTPUT.PUT_LINE('���:'||s);
        END;       
   
 
        -- 2~9�ܰ��� ������ ���
        DECLARE
            a NUMBER;
            b NUMBER;
        BEGIN
            a:=1;
            WHILE a<9 LOOP
                a := a+1;
                DBMS_OUTPUT.PUT_LINE('**' ||a||'��**');
                
                b := 0;
                WHILE b <9 LOOP
                    b := b+1;
                    DBMS_OUTPUT.PUT_LINE(a||'*'||b||'='||(a*b));
                END LOOP;
            END LOOP;
        END;  
    
    
        -- ���� LOOP, EXIT
       DECLARE
            n NUMBER := 0;
            s NUMBER := 0;
        BEGIN
           LOOP
                n := n+1;
                s := s+1;
                EXIT WHEN n = 100;
            END LOOP;
            DBMS_OUTPUT.PUT_LINE('��� : '|| s);
        END; 
        
         
        -- CONTINUE, 1~100���� ���� ���. �� 2 �Ǵ� 3�� ��� ����     
        DECLARE
            n NUMBER := 0;
        BEGIN
            WHILE n <100 LOOP
            n := n+1;
            CONTINUE WHEN MOD(n,2) =0 OR MOD(n,3)=0;
            DBMS_OUTPUT.PUT(n||' ');
                --DBMS_OUTPUT.PUT():����� ������ �ѱ��� ����
                --DBMS_OUTPUT.NEW_LINE()�Ǵ� DBMS_OUTPUT.PUT_LINE()�� ������ �����
            END LOOP; 
            DBMS_OUTPUT.NEW_LINE();--������ �ѱ�
        END;
        
     -------------------------------------------------------
     -- FOR-LOOP
        DECLARE
            s NUMBER := 0;
        BEGIN
                --FOR���� ���� ������ �������� �ʴ´�.
            FOR n IN 1..100 LOOP
            s := s+n;
            END LOOP;
            DBMS_OUTPUT.PUT_LINE('���:'||s);
        END;
  
        -- ABCD...
        DECLARE
        BEGIN
            FOR n IN 65..90 LOOP
                 DBMS_OUTPUT.PUT(CHR(n));
            END LOOP;
            DBMS_OUTPUT.NEW_LINE( );
        END;    
        
        -- ZYX....
        DECLARE
        BEGIN
                -- ������ �ݺ�(90,89,....)
            FOR n IN REVERSE 65..90 LOOP        -- >  90...65�� �ȵ�.
                 DBMS_OUTPUT.PUT(CHR(n));
            END LOOP;
            DBMS_OUTPUT.NEW_LINE( );
        END;      
        
        


     -------------------------------------------------------
     -- SQL Cursor FOR LOOP
     
     DECLARE
        vname emp.name%TYPE;
        vsal  emp.sal%TYPE;
     BEGIN
        SELECT name, sal INTO vname, vsal
        FROM emp;   --����: �ϳ��� ���ڵ常 ������ �� �ִ�. ���� ���ڵ带 �������� ���ؼ��� Ŀ���� ����ؾ���.
        
        DBMS_OUTPUT.PUT_LINE(vname || ' ' || vsal);
     END;
/
     
    -- FOR ���� �̿��Ͽ� ��� ���ڵ� ���
     DECLARE
     BEGIN
        FOR rec IN (  SELECT name, sal FROM emp ) LOOP
            DBMS_OUTPUT.PUT_LINE(rec.name || ' ' || rec.sal);
        END LOOP;
     END;
/

