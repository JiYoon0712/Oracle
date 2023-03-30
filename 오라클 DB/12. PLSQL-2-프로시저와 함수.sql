-- �� PL/SQL
 -- �� ���ν���
     -- : ���� �����ؾ� �ϴ� ���� �帧(SQL)�� �̸� �ۼ��Ͽ� �����ͺ��̽� ���� ������ �ξ��ٰ� �ʿ��� ������ ȣ���Ͽ� ����
    -- >  �ݵ�� COMMIT ����� ��.
     -------------------------------------------------------
     -- ���̺� �ۼ�
     CREATE TABLE test (
        num   NUMBER PRIMARY KEY,
        name  VARCHAR2(30) NOT NULL,
        score NUMBER(3) NOT NULL,
        grade VARCHAR2(10) NOT NULL
     );
     
     
     -- ������ �ۼ�
     CREATE SEQUENCE test_seq
     INCREMENT BY 1 
     START WITH 1
     NOMAXVALUE
     NOCYCLE
     NOCACHE;
     
     --
        SELECT * FROM test;
     
     -- ���ν��� �����
     CREATE PROCEDURE pInsertTest
     IS
        -- ���� ����
     BEGIN 
        -- ��ü
        INSERT INTO test(num, name, score, grade) VALUES (test_seq.NEXTVAL, '���ڹ�', 80, 'A');
        COMMIT;
     END;
/

    -- ���ν����� ��� Ȯ��
        SELECT * FROM user_procedures;

    -- ���ν����� �ҽ� Ȯ��
        SELECT * FROM user_source WHERE name = UPPER('pInsertTest');

    -- �������� Ȯ��
        SELECT * FROM user_dependencies;
    
    -- ���ν��� ����
        EXEC pInsertTest;
        
        SELECT * FROM test;
        
        
    ---------------------------------------------------
    -- ���ν��� ���� : IN �Ķ���� ( IN ���� ���� ) - ���ν����� ���޵Ǵ� �μ�, �б�����(�� ���� �Ұ�)
     CREATE OR REPLACE PROCEDURE pInsertTest
     (
        pName IN VARCHAR2,
            -- �Ķ���ʹ� �ڷ����� ũ�⸦ ������� �ʴ´�.
        -- pName IN emp.name%TYPE,
        pScore IN NUMBER
     )
     IS
        vGrade VARCHAR2(10);
     BEGIN 
        IF pScore >= 90 THEN vGrade := 'A';
        ELSIF pScore >= 80 THEN vGrade := 'B';
        ELSIF pScore >= 70 THEN vGrade := 'C';
        ELSIF pScore >= 60 THEN vGrade := 'D';
        ELSE vGrade := 'F';
        END IF;
    
        INSERT INTO test(num, name, score, grade) VALUES (test_seq.NEXTVAL, pName, pScore, vGrade);
        COMMIT;
     END;
/        

    -- ����
    EXEC pInsertTest('ȫ�浿',90);    
    EXEC pInsertTest('���ڹ�',75);
    SELECT * FROM test;
    
 -------------------------------------------------------------------------   
    -- ���ν��� ���� : ��ȿ�� �˻� - ���� ó��
     CREATE OR REPLACE PROCEDURE pInsertTest
     (
        pName IN VARCHAR2,
        pScore IN NUMBER
     )
     IS
        vGrade VARCHAR2(10);
     BEGIN 
        IF pScore < 0 OR pScore >100 THEN
            -- ���ܸ� �߻���Ŵ
            -- ����� ���� ���� ��ȣ : -20999~ -20000 ����
            RAISE_APPLICATION_ERROR(-20001, '������ 0~100 ���̸� �����մϴ�.');        
        END IF;
       
        IF pScore >= 90 THEN vGrade := 'A';
        ELSIF pScore >= 80 THEN vGrade := 'B';
        ELSIF pScore >= 70 THEN vGrade := 'C';
        ELSIF pScore >= 60 THEN vGrade := 'D';
        ELSE vGrade := 'F';
        END IF;
                                     --> ���� Ȯ�� : VALUE �� �ۼ��� ���� sky > ���ν��� ���ڶ�� Ȯ��. ��ġ�� ���ΰ�ħ ���ֱ�
        INSERT INTO test(num, name, score, grade) VALUES (test_seq.NEXTVAL, pName, pScore, vGrade);
        COMMIT;
     END;
/        

    -- ����
    EXEC pInsertTest('������',95);    
    EXEC pInsertTest('���ڹ�',120);
    SELECT * FROM test;      
    
    --------------------------------------------------------------------------
    -- ���ν��� �ۼ� : ����
       CREATE OR REPLACE PROCEDURE pUpdateTest
       (
            pNum IN NUMBER,
            pName IN VARCHAR2,
            pScore IN NUMBER
       )
       IS
            vGrade VARCHAR2(10);
       BEGIN
         IF pScore < 0 OR pScore >100 THEN
            RAISE_APPLICATION_ERROR(-20001, '������ 0~100 ���̸� �����մϴ�.');        
        END IF;
       
        IF pScore >= 90 THEN vGrade := 'A';
        ELSIF pScore >= 80 THEN vGrade := 'B';
        ELSIF pScore >= 70 THEN vGrade := 'C';
        ELSIF pScore >= 60 THEN vGrade := 'D';
        ELSE vGrade := 'F';
        END IF;
        
        UPDATE test SET name = pName, score = pScore, grade = vGrade WHERE num = pNum;
        COMMIT;
        
       END;
/
    
    EXEC pUpdateTest(2,'������',85);
    SELECT * FROM test;
    
    
    --------------------------------------------------------------------------
    -- ���ν��� �ۼ� : ����
    CREATE OR REPLACE PROCEDURE pDeleteTest
    (
        pNum IN NUMBER
    )
    IS
    BEGIN 
        DELETE FROM test WHERE num = pNum;
    END;
    /
    
    EXEC pDeleteTest(2);
    SELECT * FROM test;
    
    --------------------------------------------------------------------------
    -- ���ν��� �ۼ� : �ϳ��� ���ڵ� ���
        CREATE OR REPLACE PROCEDURE pSelectOneTest
        (
            pNum IN NUMBER
        )
        IS
            -- rec test%ROWTYPE;
            
            TYPE MYTYPE IS RECORD
            (
                num test.num%TYPE,
                name test.name%TYPE,
                score test.score%TYPE,
                grade test.grade%TYPE
            );
            
            rec MYTYPE;
            
        BEGIN
            SELECT num, name, score, grade INTO rec
            FROM test
            WHERE num = pNum;
            
            DBMS_OUTPUT.PUT_LINE(rec.num||' '||rec.name||' '||rec.score||' '||rec.grade);
            
        END;
        /
        
        EXEC pSelectOneTest(1);
    
    --------------------------------------------------------------------------
    -- ���ν��� �ۼ� : ��� ���ڵ� ���
        CREATE OR REPLACE PROCEDURE pSelectListTest
        IS
        BEGIN
            FOR rec IN (SELECT num, name, score, grade FROM test ) LOOP
                DBMS_OUTPUT.PUT_LINE(rec.num||' '||rec.name||' '||rec.score||' '||rec.grade);
            END LOOP;
        END;
        /
        
        EXEC pSelectListTest;
    
    ----------------------------------------------------------------
    --
    DROP PROCEDURE pInsertTest;
    DROP PROCEDURE pUpdateTest;
    DROP PROCEDURE pDeleteTest;
    DROP PROCEDURE pSelectOneTest;
    DROP PROCEDURE pSelectListTest;
    
    DROP TABLE test PURGE;
    DROP SEQUENCE test_seq;
    
    SELECT * FROM tab;
    SELECT * FROM seq;
    SELECT * FROM user_procedures;
    
    ----------------------------------------------------------------
    -- ���̺� �ۼ�
        -- ���̺�� : ex1
        -- �÷� : num ���� �⺻Ű, name ����(30) NOT NULL
        CREATE TABLE ex1(
            num NUMBER PRIMARY KEY,
            name VARCHAR2(30) NOT NULL
        )
        
        -- ���̺�� : ex2
        -- �÷� : num ���� �⺻Ű ex1 ���̺� num�� ����Ű, birth ��¥ NOT NULL
        CREATE TABLE ex2(
            num NUMBER PRIMARY KEY,
            birth DATE NOT NULL,
            FOREIGN KEY(num) REFERENCES ex1(num)
        )
        
        
        -- ���̺�� : ex3
        -- �÷� : num ���� �⺻Ű ex1 ���̺� num�� ����Ű, score ����(3) NOT NULL, grade ����(10) NOT NULL
        CREATE TABLE ex3(
            num NUMBER PRIMARY KEY,
            score NUMBER(3) NOT NULL,
            grade VARCHAR2(10) NOT NULL,
            FOREIGN KEY(num) REFERENCES ex1(num)
        )    
        
        
        -- �������� : ex_seq
            -- 1����, �ʱⰪ 1, NOCYCLE, NOCACHE
         CREATE SEQUENCE ex_seq
         INCREMENT BY 1
         START WITH 1
         NOCYCLE
         NOCACHE;
            
        -- ex1, ex2, ex3 ���̺� �����͸� �߰��ϴ� ���ν��� �ۼ�
            -- ���ν�����, pInsertEx
            -- �̸�, �������, ������ �Ķ���ͷ� �Ѱ� �޾� num�� �������� �߰��ϸ� grade�� ������ �̿��Ͽ� ���
            -- grade : 80 �̻� -> ���, 60 �̻� -> ����, 60 �̸� -> ���
            -- ������ 0~100 �̿��� ������ ���ܸ� �߻����� �߰����� ���ϵ��� �ۼ�
            -- ���� ��
                -- EXEC pInsertEx('���ڹ�','2000-10-10',85);
        
        CREATE OR REPLACE PROCEDURE pInsertEx
       (
            pName IN VARCHAR2,
            pbirth IN VARCHAR2,
            pScore IN NUMBER
       )
       IS
            vGrade VARCHAR2(10);
       BEGIN
         IF pScore < 0 OR pScore >100 THEN
            RAISE_APPLICATION_ERROR(-20001, '������ 0~100 ���̸� �����մϴ�.');        
        END IF;
       
        IF pScore >= 80 THEN vGrade := '���';
        ELSIF pScore >= 60 THEN vGrade := '����';
        ELSE vGrade := '���';
        END IF;
        
        INSERT INTO ex1(num,name) VALUES (ex_seq.NEXTVAL, pName);
        INSERT INTO ex2(num,birth) VALUES (ex_seq.CURRVAL, TO_DATE(pBirth,'YYYY-MM-DD'));
        INSERT INTO ex3(num,score,grade) VALUES (ex_seq.CURRVAL, pScore, vGrade); 
            
--          INSERT ALL 
--            INTO ex1(num,name) VALUES (ex_seq.NEXTVAL, pName)
--            INTO ex2(num,birth) VALUES (ex_seq.CURRVAL, TO_DATE(pBirth,'YYYY-MM-DD'))
--            INTO ex3(num,score,grade) VALUES (ex_seq.CURRVAL, pScore, vGrade)
--          SELECT * FROM dual;
          
        COMMIT;
       END;
/

    EXEC pInsertEx('������','2000-10-10',90);
    EXEC pInsertEx('������','2000-11-10',85);
    EXEC pInsertEx('������','2000-10-10',120); -- �ϳ��� ���̺��̶� �����ϸ� ��� ROLLBACK
    SELECT * FROM ex1;
    SELECT * FROM ex2;
    SELECT * FROM ex3;
    
    
    -- ex1, ex2, ex3 ���̺� �����͸� �����ϴ� ���ν��� �ۼ� : pUpdateEx
        -- ���ν��� �Ķ���� : ������ ��ȣ, �̸�, ����, ����
        CREATE OR REPLACE PROCEDURE pUpdateEx(
            pNum IN NUMBER, pName IN VARCHAR2, pbirth IN VARCHAR2, pScore IN NUMBER
        )
        IS
             vGrade VARCHAR2(10);
        BEGIN
            IF pScore < 0 OR pScore >100 THEN
                RAISE_APPLICATION_ERROR(-20001, '������ 0~100 ���̸� �����մϴ�.');        
            END IF;
        
            IF pScore >= 80 THEN vGrade := '���';
            ELSIF pScore >= 60 THEN vGrade := '����';
            ELSE vGrade := '���';
            END IF;
        
            UPDATE ex1 SET name = pName WHERE num = pNum;
            UPDATE ex2 SET birth = TO_DATE(pbirth,'YYYY-MM-DD') WHERE num = pNum;
            UPDATE ex3 SET score = pScore, grade = vGrade WHERE num = pNum;
           
            COMMIT;
        END;
        /
        
        EXEC pUpdateEx(4, '������','1999-07-12',100);
        SELECT * FROM ex1;
        SELECT * FROM ex2;
        SELECT * FROM ex3;
        
        
    -- ex1, ex2, ex3 ���̺� �����͸� �����ϴ� ���ν��� �ۼ� : pDeleteEx
        -- ���ν��� �Ķ���� : ������ ��ȣ
        CREATE OR REPLACE PROCEDURE pDeleteEx(
            pNum NUMBER
        )
        IS
        BEGIN 
            IF pScore < 0 OR pScore >100 THEN
                RAISE_APPLICATION_ERROR(-20001, '������ 0~100 ���̸� �����մϴ�.');        
            END IF;
        
            IF pScore >= 80 THEN vGrade := '���';
            ELSIF pScore >= 60 THEN vGrade := '����';
            ELSE vGrade := '���';
            END IF;
            
            DELETE FROM ex3 WHERE num = pNum;
            DELETE FROM ex2 WHERE num = pNum;
            DELETE FROM ex1 WHERE num = pNum;
            
            COMMIT;
        END;
        /
        
        EXEC pDeleteEx(4);
        SELECT * FROM ex1;
        SELECT * FROM ex2;
        SELECT * FROM ex3;    
    
    -- num�� �Ķ���ͷ� �Ѱܹ޾� ex1, ex2, ex3 ���̺� ������ ����ϴ� ���ν��� �ۼ�: pSelectOneEx
        -- ���ν��� �Ķ���� : ����� ��ȣ
        -- ��� : ��ȣ �̸� ������� ���� ����
        -- ��Ʈ : INNER JOIN!
        
        CREATE OR REPLACE PROCEDURE pSelectOneEx(
            pNum IN NUMBER
        )
        IS
            TYPE MYTYPE IS RECORD
            (
                num ex1.num%TYPE,
                name ex1.name%TYPE,
                birth ex2.birth%TYPE,
                score ex3.score%TYPE,
                grade ex3.grade%TYPE
            );
            
            rec MYTYPE;
        BEGIN 
              SELECT e1.num, name, birth, score, grade INTO rec
              FROM ex1 e1
              JOIN ex2 e2 ON e1.num = e2.num
              JOIN ex3 e3 ON e1.num = e3.num
              WHERE e1.num = pNum; 
              
              DBMS_OUTPUT.PUT_LINE(rec.num ||' '||rec.name||' '||rec.birth||' '||
                    rec.score||' '||rec.grade);
        END;
        /
        
        EXEC pSelectOneEx(5);
     -------------------------------------------------------
     -- OUT �Ķ���� : ���ν����� ������ ȣ���ڿ��� �����ִ� ���. ���ν������� �� ���� ����
        -- OUT �Ķ���ʹ� ���ν��� ó�� ����� ���α׷�(JAVA ��)���� �Ѱ��� �� ����� �� �ִ�.
        CREATE OR REPLACE PROCEDURE pSelectOneEx
        (
            pNum IN NUMBER,
            pName OUT VARCHAR2,
            pBirth OUT VARCHAR2,
            pScore OUT NUMBER,
            pGrade OUT VARCHAR2
        )
        IS
        BEGIN
            --pNum := 1;    -- ����. IN �Ķ���ʹ� �б� ����. OUT �Ķ���ʹ� �� ���� ����
            SELECT name, TO_CHAR(birth,'YYYY-MM-DD'), score, grade
                INTO pName, pBirth, pScore, pGrade
            FROM ex1 e1
            JOIN ex2 e2 ON e1.num = e2.num
            JOIN ex3 e3 ON e1.num = e3.num
            WHERE e1.num = pNum;
        END;
        /
        
      -- OUT �Ķ���� Ȯ�ο� ���ν���
      CREATE OR REPLACE PROCEDURE pSelectResultEx
      IS
        vName  VARCHAR2(30);
        vBirth VARCHAR2(10);
        vScore NUMBER(3);
        vGrade VARCHAR(10);
      BEGIN
        -- �ٸ� ���ν��� ȣ��
        pSelectOneEx(5, vName, vBirth, vScore, vGrade); -- 5 : ex1���̺� �����ϴ� num ��ȣ
                    --> IN �־��ְ� OUT �޾ƿ���
        
        DBMS_OUTPUT.PUT_LINE(vName||' '||vBirth||' '||vScore||' '||vGrade);
      END;
      /
      
      EXEC pSelectResultEx;
     
     
   
    
    
    
 -- �� �Լ�
    -- : ����ڰ� ���� ������ �����Ͽ� ������ �Լ�
    -- : ���� �Լ�(��Ʈ�� �Լ�)ó�� �������� ȣ���ϰų� EXECUTE ���� ���� ���� ����

     -------------------------------------------------------
     -- �� ���ϴ� �Լ�
     CREATE OR REPLACE FUNCTION fnSum
     ( 
        n IN NUMBER   
      )
      RETURN NUMBER
      IS
        s NUMBER := 0;
      BEGIN
        FOR i IN 1..n LOOP
            s := s+i;
        END LOOP;
        RETURN s;
      END;
      /
      
      SELECT * FROM user_procedures;
      
      SELECT fnSum(100) FROM dual;
     
     -------------------------------------------------------
     -- �ֹι�ȣ�� �̿��Ͽ� ����, �������, ���� ���ϴ� �Լ� �����

     -- ����
     CREATE OR REPLACE FUNCTION fnGender
     (
        rrn IN VARCHAR2
     )
     RETURN VARCHAR2
     IS
        s NUMBER(1);
        b VARCHAR2(6) := '����';
     BEGIN
        IF LENGTH(rrn) = 14 THEN
            s := SUBSTR(rrn, 8,1);
        ELSIF LENGTH(rrn) = 13 THEN
            s := SUBSTR(rrn,7,1);
        ELSE 
            RAISE_APPLICATION_ERROR(-20001,'�ֹι�ȣ ����');
        END IF;
        
        IF MOD(s,2) = 1 THEN
           b := '����';
        END IF;
        
        RETURN b;
     END;
     /
     
     SELECT name, rrn, fnGender(rrn) FROM emp;
     
     
     -- �������
     CREATE OR REPLACE FUNCTION fnBirth
     (
        rrn IN VARCHAR2
     )
     RETURN DATE
     IS
        s NUMBER(1);
        b VARCHAR2(8);
     BEGIN
        IF LENGTH(rrn) = 14 THEN
            s := SUBSTR(rrn, 8,1);
        ELSIF LENGTH(rrn) = 13 THEN
            s := SUBSTR(rrn,7,1);
        ELSE 
            RAISE_APPLICATION_ERROR(-20002,'�ֹι�ȣ ����');
        END IF;
        
        b :=SUBSTR(rrn,1,6);
        CASE 
            WHEN s IN (1,2,5,6) THEN b := '19'|| b;
            WHEN s IN (3,4,7,8) THEN b := '20'|| b;
            ELSE b:= '18'||b;
        END CASE;
        
     RETURN TO_DATE(b,'YYYY-MM-DD');
     END;
     /
     
     SELECT name, rrn, fnGender(rrn), fnBirth(rrn) FROM emp;     
     
     -- ����
     CREATE OR REPLACE FUNCTION fnAge      --(1)
     (
        birth IN DATE
     )
     RETURN NUMBER
     IS
     BEGIN
        RETURN TRUNC(MONTHS_BETWEEN(SYSDATE,birth)/12);
     END;
     /    
     
     CREATE OR REPLACE FUNCTION fnAge2      --(2)
     (
        rrn IN VARCHAR2
     )
     RETURN NUMBER
     IS
     BEGIN
        RETURN TRUNC(MONTHS_BETWEEN(SYSDATE,fnBirth(rrn))/12);
     END;
     /    
     
     SELECT name, rrn, fnGender(rrn), fnBirth(rrn), fnAge(fnBirth(rrn)),fnAge2(rrn) FROM emp;     

     -------------------------------------------------------
     -- ����
     -- score1 ���̺� �ۼ�
          hak     ����(20)  �⺻Ű
          name   ����(30)  NOT  NULL
          kor      ����(3)     NOT  NULL
          eng      ����(3)    NOT  NULL
          mat      ����(3)    NOT  NULL
      
      CREATE TABLE score1(
        hak VARCHAR2(20) PRIMARY KEY,
        name VARCHAR2(30) NOT NULL,
        kor NUMBER(3) NOT NULL,
        eng NUMBER(3) NOT NULL,
        mat NUMBER(3) NOT NULL
      )    
          

      -- score2 ���̺� �ۼ�
          hak     ����(20)  �⺻Ű, score1 ���̺��� ����Ű
          kor      ����(2,1)     NOT  NULL
          eng      ����(2,1)    NOT  NULL
          mat      ����(2,1)    NOT  NULL
          
     CREATE TABLE score2(
        hak VARCHAR2(20) PRIMARY KEY,
        kor NUMBER(2,1) NOT NULL,
        eng NUMBER(2,1) NOT NULL,
        mat NUMBER(2,1) NOT NULL,
        FOREIGN KEY(hak) REFERENCES score1(hak)
      )   
     
     -- ������ ���ϴ� �Լ� �ۼ�
         -- �Լ��� : fnGrade(s)
             95~100:4.5    90~94:4.0
             85~89:3.5     80~84:3.0
             75~79:2.5     70~74:2.0
             65~69:1.5     60~64:1.0
             60�̸� 0
             
        CREATE OR REPLACE FUNCTION fnGrade
        (
            score NUMBER
        ) 
        RETURN VARCHAR2
        IS 
            grade NUMBER;
        BEGIN
            CASE
                WHEN score >=95 THEN grade :=4.5;
                WHEN score >=90 THEN grade :=4.0;
                WHEN score >=85 THEN grade :=3.5;
                WHEN score >=80 THEN grade :=3.0;
                WHEN score >=75 THEN grade :=2.5;
                WHEN score >=70 THEN grade :=2.0;
                WHEN score >=65 THEN grade :=1.5;
                WHEN score >=60 THEN grade :=1.0;
                ELSE grade:=0;
            END CASE;
            
            RETURN TO_CHAR(grade,'FM9.99');
        END;
        /
       
       
      -- score1 ���̺�� score2 ���̺� �����͸� �߰��ϴ� ���ν��� �����
         ���ν����� : pScoreInsert
         ���࿹ : EXEC pScoreInsert('1111', '������', 80, 60, 75);
   
         score1 ���̺� => '1111', '������', 80, 60, 75  ���� �߰�
         score2 ���̺� => '1111',            3.0, 1.0, 2.5 ���� �߰�(��, ��, �� ������ �������� ���Ǿ� �߰�)
   
         ��, ����, ����, ���� ������ 0~100 ���̰� �ƴϸ� ���� �߻��ϰ� ����
        CREATE OR REPLACE PROCEDURE pScoreInsert
        (
            phak IN VARCHAR2,
            pname IN VARCHAR2,
            pkor IN NUMBER,
            peng IN NUMBER,
            pmat IN NUMBER
        )
        IS 
        BEGIN
            IF pkor < 0 OR pkor >100 OR  peng < 0 OR peng >100 OR pmat < 0 OR pmat >100 THEN
                RAISE_APPLICATION_ERROR(-20003,'������ 0~100 ���̸� �����մϴ�.');   
            END IF;
        
            INSERT INTO score1(hak,name,kor,eng,mat) VALUES (phak,pname,pkor,peng,pmat);
            INSERT INTO score2(hak,kor,eng,mat) VALUES (phak,fnGrade(pkor),fnGrade(peng),fnGrade(pmat));
            COMMIT;
        END;
        /
        
 
     -- score1 ���̺�� score2 ���̺� �����͸� �����ϴ� ���ν��� �����
         ���ν����� : pScoreUpdate
         ���࿹ : EXEC pScoreUpdate('1111', '������', 90, 60, 75);
   
         score1 ���̺� => �й��� '1111' �� �ڷḦ  '������', 90, 60, 75  ���� ���� ����
         score2 ���̺� => �й��� '1111' �� �ڷḦ           4.0, 1.0, 2.5 ���� ���� ����(��, ��, �� ������ �������� ���Ǿ� ����)
   
         ��, ����, ����, ���� ������ 0~100 ���̰� �ƴϸ� ���� �߻��ϰ� ����
        CREATE OR REPLACE PROCEDURE pScoreUpdate
        (
            phak VARCHAR2,
            pname VARCHAR2,
            pkor NUMBER,
            peng NUMBER,
            pmat NUMBER      
        )
        IS
        BEGIN
            IF pkor < 0 OR pkor >100 OR peng < 0 OR peng >100 OR pmat < 0 OR pmat >100 THEN
                RAISE_APPLICATION_ERROR(-20003,'������ 0~100 ���̸� �����մϴ�.');   
            END IF;
        
        UPDATE score2 SET  kor = fnGrade(pkor), eng = fnGrade(peng), mat = fnGrade(pmat)  WHERE hak = phak;
        UPDATE score1 SET name = pname, kor = pkor, eng = peng, mat = pmat  WHERE hak = phak;

        COMMIT;
        END;
        /
        

      -- score1 ���̺�� score2 ���̺� �����͸� �����ϴ� ���ν��� �����
         ���ν����� : pScoreDelete
         ���࿹ : EXEC pScoreDelete('1111');
         score1 �� score2 ���̺� ���� ����
        CREATE OR REPLACE PROCEDURE pScoreDelete
        (
            phak VARCHAR2
        )
        IS
        BEGIN
            DELETE FROM score2 WHERE hak = phak;
            DELETE FROM score1 WHERE hak = phak;
            
            COMMIT;
        END;
        /
