-- �� �ε���(index)
 -- �� �ε���
       ---------------------------------------------------
       -- ����
         -- UNIQUE �ɼ��� ����ڰ� ���� unique�� �ε����� �����ϰ� �� �� ����Ѵ�. ����Ʈ�� non-unique �ε����� �����Ѵ�.
         -- ���� �ߺ����� ���� ����, ���� �ߺ����� ���� ������ ���ɼ��� �ִ� ��� UNIQUE �ε����� �������� �ʴ´�.

         -- B-Tree �ε���
             CREATE INDEX �ε����� ON ���̺��(�÷���, ...);

             -- ���� �ε���(Single Index) : �ϳ��� �÷��� ����Ͽ� �ε����� ����� ��
                 CREATE INDEX �ε����� ON ���̺��(�÷���);

             -- ���� �ε���(Composite Index) : �ΰ� �̻��� �÷��� ����Ͽ� �ε����� ����� ��
                CREATE INDEX �ε����� ON ���̺��(�÷���, �÷���, ...);

             -- ���� �ε���(Unique INdex) : ������ ���� ���� �÷��� ���ؼ��� �ε����� ����
                 CREATE UNIQUE INDEX �ε����� ON ���̺��(�÷���, ...);

         -- Bitmap �ε���(Express�� �������� ����a)
             CREATE BITMAP INDEX �ε����� ON ���̺��(�÷���, ...);

         -- �Լ���� �ε���
             CREATE INDEX �ε����� ON ���̺��(�Լ���(�÷���) | �����);

         -- ������ �ε���
             CREATE INDEX �ε����� ON ���̺��(�÷���1,�÷���2, ...) REVERSE;

         -- �������� �ε���
             CREATE INDEX �ε����� ON ���̺��(�÷���1,�÷���2, ... DESC);


--03/16
       ---------------------------------------------------
       -- ����
       -- �ε��� Ȯ��
          SELECT * FROM emp;
          
          SELECT * FROM user_indexes WHERE table_name='EMP';
          SELECT * FROM user_ind_columns WHERE table_name='EMP';
          
          
        -- �ε��� �ۼ�
          -- �ε��� ���� �� : ���� ���� �� F10���� Ȯ��
          SELECT empNo, name, sal FROM emp WHERE name = '�ɽ���';
          
          CREATE INDEX idx_emp_name ON emp(name);
                -- NONUNIQUE
          
          SELECT * FROM user_indexes WHERE table_name='EMP';
          SELECT * FROM user_ind_columns WHERE table_name='EMP';
          
          -- �ε��� ���� �� : ���� ���� �� F10���� Ȯ��
          SELECT empNo, name, sal FROM emp WHERE name = '�ɽ���';
                    -- �ε��� ���
                        
          SELECT empNo, name, sal FROM emp WHERE SUBSTR(name,1,1) = '��';
                    -- �ε��� ��� ����
          
    -- �ε��� ����
        DROP INDEX idx_emp_name;
        SELECT * FROM user_indexes WHERE table_name = 'EMP';

    -- ���� �ε���
        CREATE INDEX idx_emp_comp ON emp(name,dept);
          
        --CREATE INDEX idx_emp_comp ON emp(dept,name);
                -- �μ����� �̸��� �˻��ϹǷ� ������ �ӵ��� ����
                
        SELECT empNo, name, dept, sal FROM emp WHERE name ='��ž�' AND dept ='���ߺ�';
        
        DROP INDEX idx_emp_comp;
    
    -- �Լ���� �ε���
        CREATE INDEX idx_emp_fun ON emp (MOD(SUBSTR(rrn,8,1),2));
        
        SELECT empNo, name, rrn, sal FROM emp WHERE (MOD(SUBSTR(rrn,8,1),2))=0;

        DROP INDEX idx_emp_fun;



    -- �� �ε��� ����
       ---------------------------------------------------
       -- ����
        CREATE TABLE test(
            num NUMBER
        );
        
        BEGIN
            FOR n IN 1..10000 LOOP
                INSERT INTO test VALUES (n);
            END LOOP;
            COMMIT;
        END;
        / 
       
        CREATE INDEX idx_test_num ON test ( num );
        
        -- �ε��� ���� Ȯ��
        ANALYZE INDEX idx_test_num VALIDATE STRUCTURE;  -- �м�

        SELECT * FROM index_stats WHERE name = 'IDX_TEST_NUM'; 
        
        SELECT (DEL_LF_ROWS_LEN)/(LF_ROWS_LEN)*100 
        FROM index_stats 
        WHERE name = 'IDX_TEST_NUM';
            -- 0�� ����� ���� ���� ����

    -- ������ ����
        DELETE FROM test WHERE num <= 4000;
        COMMIT;
        
        ANALYZE INDEX idx_test_num VALIDATE STRUCTURE;  -- �м�
        
        SELECT (DEL_LF_ROWS_LEN) / (LF_ROWS_LEN) *100
        FROM index_stats
        WHERE name='IDX_TEST_NUM';
            -- 40% ���� �뷱���� ������
            
    -- �ε��� REBUILD
        ALTER INDEX idx_test_num REBUILD;
        
        ANALYZE INDEX idx_test_num VALIDATE STRUCTURE;  -- �м�
        
        SELECT (DEL_LF_ROWS_LEN) / (LF_ROWS_LEN) *100
        FROM index_stats
        WHERE name='IDX_TEST_NUM';
            -- 0


    -- �� ��Ʈ(hint)
       ---------------------------------------------------
       -- ��Ƽ���������� SQL�� ������ ���� ������ ��ĳ�� ���, ���� ������� �˷��ֱ� ���� ���
       -- ����
          SELECT /*+ Hint_name(param)*/ �÷�, �÷� FROM ���̺��;
        
        -- ����¡ ó�� ��  
        SELECT * FROM (
            SELECT ROWNUM rnum, empNo, name FROM (
                SELECT empNo, name
                FROM emp
                ORDER BY empNo DESC
            )tb WHERE ROWNUM <= 30
        )WHERE rnum >=21;          
       
        -- ��Ʈ(hint)�� �̿��� ����¡ ó��
        SELECT rnum, empNo, name FROM (
                SELECT /*+ INDEX_DESC(emp PK_EMP_EMPNO)*/ ROWNUM rnum,empNo,name 
                FROM emp
                WHERE ROWNUM <= 30          --> ORDER BY�� ROWNUM ���� ��� X.
        )WHERE rnum >=21;                   --> PK_EMP_EMPNO�� DESC �� INDEX�� ����Ͽ��⿡ ROWNUM ��� ����
       
        -- INDEX_ASC, INDEX_DESC : ���� ���� ����ϴ� ��Ʈ�� �ε����� ����, �������� �̿������� ����
        
       
       
       
       
       
       
       