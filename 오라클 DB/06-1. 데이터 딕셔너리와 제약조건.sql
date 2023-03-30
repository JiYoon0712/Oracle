-- �� ������ ��ųʸ��� ��������
 -- �� ������ ��ųʸ�(Data Dictionary)
   -- �� �ֿ� ������ ����
     -- ��� ������ ���� ���̺� ���� Ȯ��
        SELECT * FROM dictionary;
        SELECT COUNT(*) FROM dictionary;

     -- ���� ������� ��� ��ü ����
        SELECT * FROM user_objects;
        SELECT * FROM obj;      

     -- ���̺� ���� Ȯ��
        SELECT * FROM user_tables;
        SELECT * FROM tabs;
        
        SELECT * FROM tab;

     -- ���̺��� �÷� ���� Ȯ��(���̺���� �빮�ڷ�)
        SELECT * FROM user_tab_columns WHERE table_name = UPPER('emp');
        SELECT * FROM cols WHERE table_name = UPPER('emp');
        SELECT * FROM col WHERE tname = UPPER('emp');
        
     -- �������� Ȯ��
        -- � �÷��� ���������� �ο��Ǿ����� Ȯ���� �Ұ�(���̺���� �빮�ڷ�)
        -- constraint_type �� P:�⺻Ű, C:NOT NULL ��, U:UNIQUE, R:����Ű ��
            SELECT * FROM user_constraints WHERE table_name = 'EMP';

     -- ���� ����ڰ� ������ �ִ� �÷��� �ο��� �������� ���� Ȯ��
        -- � �÷��� ���������� �ο��Ǿ����� Ȯ�� ����
        -- ���� ������ ������ Ȯ�� �Ұ���
        
        SELECT * FROM user_cons_columns WHERE table_name = 'EMP';
        

     -- �������� �� �÷� Ȯ��
        SELECT u1.table_name, column_name, constraint_type, u1.constraint_name, search_condition
        FROM user_constraints u1
        JOIN user_cons_columns u2 ON u1.constraint_name = u2.constraint_name
        WHERE u1.table_name = UPPER('���̺��');
        
        SELECT u1.table_name, column_name, constraint_type, u1.constraint_name, search_condition
        FROM user_constraints u1
        JOIN user_cons_columns u2 ON u1.constraint_name = u2.constraint_name
        WHERE u1.table_name = UPPER('emp');
        
        

     -- �ο� �� ������ ��� ���̺� ���
        SELECT fk.owner, fk.constraint_name,
                    pk.table_name parent_table, fk.table_name child_table
        FROM all_constraints fk, all_constraints pk 
        WHERE fk.r_constraint_name = pk.constraint_name AND fk.constraint_type = 'R'
        ORDER BY fk.table_name;

     -- �����̺���� �����ϴ� ��� ���̺� ��� ���(�ڽ� ���̺� ��� ���)
        SELECT fk.owner, fk.constraint_name , fk.table_name 
        FROM all_constraints fk, all_constraints pk 
        WHERE fk.r_constraint_name = pk.constraint_name 
                   AND fk.constraint_type = 'R' 
                   AND pk.table_name = UPPER('���̺��')
        ORDER BY fk.table_name;
 
     -- �����̺���� �����ϰ� �ִ� ��� ���̺� ��� ���(�θ� ���̺� ��� ���)
        SELECT table_name FROM user_constraints
        WHERE constraint_name IN (
              SELECT r_constraint_name 
              FROM user_constraints
              WHERE table_name = UPPER('���̺��') AND constraint_type = 'R'
          );

     -- �����̺���� �θ� ���̺� ��� �� �θ� �÷� ��� ���
        --  �θ� 2�� �̻����� �⺻Ű�� ���� ��� ������ ��� ��
        SELECT fk.constraint_name, fk.table_name child_table, fc.column_name child_column,
                    pk.table_name parent_table, pc.column_name parent_column
        FROM all_constraints fk, all_constraints pk, all_cons_columns fc, all_cons_columns pc
        WHERE fk.r_constraint_name = pk.constraint_name
                   AND fk.constraint_name = fc.constraint_name
                   AND pk.constraint_name = pc.constraint_name
                   AND fk.constraint_type = 'R'
                   AND pk.constraint_type = 'P'
                   AND fk.table_name = UPPER('���̺��');

