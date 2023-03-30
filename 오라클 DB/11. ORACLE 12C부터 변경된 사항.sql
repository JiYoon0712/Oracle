-- �� ����Ŭ 12C���� ����� ����
 -- �� 12C���� �߰��� ���ο� ���
    -- �� Top-N ���
      -----------------------------------------------
      -- ó�����ڵ���� 3���� ���
        SELECT *
        FROM emp
        FETCH FIRST 3 ROWS ONLY;
        
       -- sal �������� �����Ͽ� ó������ 5���� ���
        SELECT *
        FROM emp
        ORDER BY sal DESC
        FETCH FIRST 5 ROWS ONLY;
        
       -- sal �������� �����Ͽ� 15���� �ǳʶٰ� 5���� ���
        SELECT *
        FROM emp
        ORDER BY sal DESC
        OFFSET 15 ROWS FETCH FIRST 5 ROWS ONLY;        
       
       -- sal �������� �����Ͽ� ���� 10%�� ���  
        SELECT *
        FROM emp
        ORDER BY sal DESC
        FETCH FIRST 10 PERCENT ROWS ONLY;         

        -- ����¡ ó�� : 11g
            -- sal �������� �����ؼ� 21~30��° ���ڵ� ���
            SELECT * FROM(
                SELECT ROWNUM rnum, tb.* FROM(
                      SELECT empNo, name, sal
                      FROM emp
                      ORDER BY sal DESC
                )tb WHERE ROWNUM <=31
            )WHERE rnum >=21;
        
        
        -- ����¡ ó�� : 12C �̻�
        SELECT empNo, name, sal
        FROM emp
        ORDER BY sal DESC
        OFFSET 20 ROWS FETCH FIRST 10 ROWS ONLY;
        
      -----------------------------------------------
      -- sal �������� �����Ͽ� sal�� 4540000�� ����� �ٷ� ���� ���ڵ� ���(empNo, name, sal ���)
        -- ��� : 1003 �̼��� 4550000
        SELECT empNo, name, sal         --> ���� ���� ���� ����� ���ٴ� �����Ͽ�
        FROM emp
        WHERE sal > 4540000            
        ORDER BY sal ASC
        FETCH FIRST 1 ROWS ONLY;
        
        SELECT * FROM( 
            SELECT empNo, name, sal
            FROM emp
            WHERE sal > 4540000
            ORDER BY sal ASC
        ) WHERE ROWNUM =1;
      
      -- sal �������� �����Ͽ� sal�� 4540000�� ����� �ٷ� ���� ���ڵ� ���(empNo, name, sal ���)
        -- ��� : 1031 ����ȯ 4450000
        SELECT empNo, name, sal
        FROM emp
        WHERE sal < 4540000
        ORDER BY sal DESC
        FETCH FIRST 1 ROWS ONLY;      
      
        SELECT * FROM( 
            SELECT empNo, name, sal
            FROM emp
            WHERE sal < 4540000
            ORDER BY sal DESC
        ) WHERE ROWNUM =1;
      

    -- �� INVISIBLE column : ������ �ʴ� �÷�
      -----------------------------------------------
      -- 
      CREATE TABLE test(
        num NUMBER PRIMARY KEY,
        name VARCHAR2(30) NOT NULL,
        tel VARCHAR2(30) INVISIBLE
      );
      
      -- �÷� Ȯ��
          -- DESC, col�δ� Ȯ�� �Ұ�
          DESC test;
          SELECT * FROM col WHERE tname = 'TEST';
          
          -- INVISIBLE �÷��� cols, user_tab_cols �� Ȯ��
            SELECT * FROM user_tab_cols WHERE table_name = 'TEST';
            SELECT * FROM cols WHERE table_name = 'TEST';
                    -- hidden_columns �÷��� Y ǥ��
            
          -- ������ �߰�
            INSERT INTO test VALUES(1,'a');  -- ����
            
            INSERT INTO test VALUES(2,'b','010-1');  -- ����
            
            INSERT INTO test (num, name, tel) VALUES(2,'b','010-1');  -- ����
            
          -- Ȯ��
             SELECT * FROM test;    -- INVISIBLE �÷��� ������ ����
             
             SELECT num, name, tel FROM test;   -- INVISIBLE �÷��� ����
            
          -- VISIBLE �÷����� ����
             ALTER TABLE test MODIFY (tel VISIBLE);
             DESC test;
             
          -- INVISIBLE �÷����� ����
             ALTER TABLE test MODIFY (tel INVISIBLE);
             DESC test;   
             
             UPDATE test SET tel = '010-2' WHERE num =1;
             SELECT num, name, tel FROM test;
             COMMIT;
             
          -- INVISIBLE �÷��� NOT NULL ���� �߰�
             ALTER TABLE test MODIFY (tel NOT NULL);
             
             INSERT INTO test VALUES(3,'c'); -- ����(NOT NULL ���� ����)
             SELECT num, name, tel FROM test;
             COMMIT;
            
        DROP TABLE test PURGE;
    


    -- �� IDENTITY column
      -- : �ڵ����� ���ڸ� �����ϴ� �÷�
      -- : ���������� �������� ���

      -----------------------------------------------
      --
      CREATE TABLE test(
        num NUMBER GENERATED AS IDENTITY PRIMARY KEY,
        subject VARCHAR2(100) NOT NULL
      );
      
      INSERT INTO test(subject) VALUES('�ڹ�');
      INSERT INTO test(subject) VALUES('����Ŭ');
      INSERT INTO test(subject) VALUES('��');
      SELECT * FROM test;
      
      SELECT * FROM user_objects;
            -- object_name : ISEQ$$_xxxxx -> IDENTITY �÷��� ������
      
      SELECT ISEQ$$_74677.CURRVAL FROM dual;
            -- 3 ���
    
      INSERT INTO test(num, subject) VALUES(10,'HTML'); -- ����. ���� �Ұ�
      
      DROP TABLE test PURGE;



    -- �� DEFAULT �� : ���̺��� ����ų� �����Ҷ� DEFAULT�� ������ ���� �� �� �ִ�.
      -----------------------------------------------
      --
      CREATE SEQUENCE test_seq;
      CREATE TABLE test(
        num NUMBER DEFAULT test_seq.NEXTVAL,
        subject VARCHAR2(100) NOT NULL,
        PRIMARY KEY (num)
      );
      
      INSERT INTO test(subject) VALUES('a');
      INSERT INTO test(subject) VALUES('b');
      SELECT * FROM test;
      

