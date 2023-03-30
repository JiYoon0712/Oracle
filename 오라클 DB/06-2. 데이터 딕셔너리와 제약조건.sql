-- �� ������ ��ųʸ��� ��������
 -- �� ���� ����(constraint)
    -- �� �⺻ Ű(PRIMARY KEY)
        -- ���ϼ�, NOT NULL
        -- ���̺�� �⺻Ű�� �ϳ��� ����
        -- �ΰ� �̻��� �÷����� �⺻Ű�� ���� �� �ִ�.
    
    -- 1) ���̺� ������ ���ÿ� �⺻ Ű ����
      -- (1) �÷� ���� ����� PRIMARY KEY ����(inline constraint) : �ϳ��� �÷����θ� �⺻Ű�� ���� �� ����
        -----------------------------------------------------
        -- �⺻ ����
        CREATE TABLE ���̺�� (
               �÷�  ������Ÿ��  [ CONSTRAINT �������Ǹ� ]  PRIMARY KEY
                                 :
        );

        -- �÷������������ �⺻Ű �����
            CREATE TABLE test1(
                id VARCHAR2(50) PRIMARY KEY,
                PW VARCHAR2(100) NOT NULL,
                name VARCHAR2(30) NOT NULL
            );
            
         -- ��������Ȯ��
            SELECT * FROM user_constraints WHERE table_name = 'TEST1';
                    -- �������� ���� Ȯ��
                    -- ���������̸��� �ο����� ������ �̸��� SYS_Cxxx... ����
            SELECT * FROM user_cons_columns WHERE table_name = 'TEST1';
                    -- ���������� �ִ� �÷� Ȯ��


            -- �÷������������ �⺻Ű �����: �̸��ο�
            CREATE TABLE test2(
                id VARCHAR2(50) CONSTRAINT pk_test2_id PRIMARY KEY,
                PW VARCHAR2(100) NOT NULL,
                name VARCHAR2(30) NOT NULL
            );
            
            SELECT * FROM user_constraints WHERE table_name = 'TEST2';


      -- (2) ���̺� ���� ����� PRIMARY KEY ����(out of line constraint)
        -----------------------------------------------------
        -- �⺻ ����
        CREATE TABLE ���̺�� (
               �÷�  ������Ÿ��   [ �������� ],
                                 :
               [ CONSTRAINT ���������̸� ] PRIMARY KEY (�÷� [,�÷�])
        );
        
        -- ���̺� ������ ���ÿ� �⺻Ű �ο�
            CREATE TABLE test3(
                id VARCHAR2(50),
                PWd VARCHAR2(100) NOT NULL,
                name VARCHAR2(30) NOT NULL,
                PRIMARY KEY(id)
            );
            
            SELECT * FROM user_constraints WHERE table_name = 'TEST3';
            
            -- ����Ű(�ΰ� �̻��� �÷�)�� �⺻Ű �ο� : �������� �̸� �ο�
            CREATE TABLE test4(
                num NUMBER,
                code VARCHAR2(100),
                name VARCHAR2(30) NOT NULL,
                CONSTRAINT pk_test4_num_code PRIMARY KEY(num,code)
            );
            
            SELECT * FROM user_constraints WHERE table_name = 'TEST4';
            SELECT * FROM user_cons_columns WHERE table_name = 'TEST4';
    --------------------------------------------------------
    INSERT INTO test3(id,pwd,name) VALUES('a1','123','������');
    
    INSERT INTO test3(id, pwd, name) VALUES('a1','555','������');
                -- ���� : ORA-00001, �⺻Ű ���� ����(�⺻Ű�� �ߺ����� ���� �� ����)

    INSERT INTO test4(num, code, name) VALUES (1,'a10','������');
    INSERT INTO test4(num, code, name) VALUES (1,'b10','������');
            -- num + code�� �⺻Ű�̹Ƿ� ����
            
    INSERT INTO test4(num, code, name) VALUES (2,NULL,'������');
            -- ���� �⺻Ű�� NULL�� �� �� ����.
            
    UPDATE test3 SET id = '11' WHERE id = 'a1';
        -- �⺻Ű�� ���������� �������� ������ ���� �����ϴ�.
    
    COMMIT;        
            
    
    -- 2) �����ϴ� ���̺� �⺻ Ű ����
       -----------------------------------------------------
       -- �⺻ ����
       ALTER TABLE ���̺�� ADD [ CONSTRAINT �������Ǹ� ]  PRIMARY KEY (�÷� [,�÷�]);

        CREATE TABLE test5(
                id VARCHAR2(50),
                pwd VARCHAR2(100) NOT NULL,
                name VARCHAR2(30) NOT NULL
            );
            
            INSERT INTO test5(id,pwd,name) VALUES ('1','1','a');
            INSERT INTO test5(id,pwd,name) VALUES ('1','2','b');
            SELECT * FROM test5;

            ALTER TABLE test5 ADD PRIMARY KEY(id);
                -- ����. �⺻Ű ���࿡ �����ϴ� �����Ͱ� ����
            
            DELETE FROM test5;
            SELECT * FROM test5;
            
            -- �����ϴ� ���̺� �⺻Ű �߰�
            ALTER TABLE test5 ADD PRIMARY KEY(id);
            
            SELECT * FROM user_constraints WHERE table_name = 'TEST5';
            
    

    -- 3) �⺻Ű ���� ���� ����
       -----------------------------------------------------
       -- �⺻ ����
       ALTER TABLE ���̺�� DROP PRIMARY KEY;
       ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�;
       
         -- �����ϴ� ���̺� �⺻Ű ����
            ALTER TABLE test5 DROP PRIMARY KEY;
            
            SELECT * FROM user_constraints WHERE table_name = 'TEST5';

        -- 
            DROP TABLE test5 PURGE;
            DROP TABLE test4 PURGE;
            DROP TABLE test3 PURGE;
            DROP TABLE test2 PURGE;
            DROP TABLE test1 PURGE;



   -- �� UNIQUE ���� ����   --> �ʹ� ���� ����ϸ� �����ʴ�.
    -- ���ϼ�.
    -- PRIMARY KEY �÷��� ������ ���ϼ��� �Ӽ��� �ο��ϱ� ����
    -- UNIQUE �� �ΰ� �̻� �ۼ� ����
   
    -- 1) ���̺� ������ ���ÿ� UNIQUE ���� ���� ����
      -- (1) �÷� ���� ����� UNIQUE ���� ����
        -----------------------------------------------------
        -- �⺻ ����
        CREATE TABLE ���̺�� (
               �÷�  ������Ÿ��   [ CONSTRAINT �������Ǹ� ]  UNIQUE
                                 :
        );

      -- (2) ���̺� ���� ����� UNIQUE ���� ���� ����
        -----------------------------------------------------
        -- �⺻ ����
        CREATE TABLE ���̺�� (
               �÷�  ������Ÿ��  [ �������� ] ,
                                 :
               [ CONSTRAINT �������Ǹ� ] UNIQUE (�÷� [,�÷�])
        );
        
        CREATE TABLE test1(
            id  VARCHAR2(50),
            pwd VARCHAR2(100) NOT NULL,
            name VARCHAR2(30) NOT NULL,
            email VARCHAR2(100),
            CONSTRAINT pk_test1_id PRIMARY KEY(id),
            CONSTRAINT uq_test1_email UNIQUE(email)
        );
        
        SELECT * FROM user_constraints WHERE table_name = 'TEST1';
        
        INSERT INTO test1(id, pwd, name, email) VALUES('1','1','a','aa');
        
        INSERT INTO test1(id, pwd, name, email) VALUES('2','2','b','aa');
                -- ORA-00001 : UNIQUE ���� ����

        INSERT INTO test1(id, pwd, name, email) VALUES('2','2','b',NULL);
                -- ����. email�� NULL ���
        INSERT INTO test1(id, pwd, name, email) VALUES('3','3','c',NULL);
                -- ����. NULL�� �ߺ����� 
                
        
                
    -- 2) �����ϴ� ���̺� UNIQUE ���� ���� ����
     -------------------------------------------------------
     -- �⺻ ����
       ALTER TABLE ���̺�� ADD [ CONSTRAINT �������Ǹ� ]  UNIQUE (�÷� [,�÷�]);




    -- 3) UNIQUE ���� ���� ����
     -------------------------------------------------------
     -- �⺻ ����
       ALTER TABLE ���̺�� DROP UNIQUE (�÷� [,�÷�]);
       ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�;

        -- test1 UNIQUE �������� ����
            ALTER TABLE test1 DROP CONSTRAINT uq_test1_email;
            �Ǵ�
            ALTER TABLE test1 DROP UNIQUE(email);
        
            
        -- �������� Ȯ��
            SELECT * FROM user_constraints WHERE table_name='TEST1';
           


   -- �� NOT NULL ���� ����
        -- NULL : �����͸� �Է����� ���� ����
        -- ���ڿ� ���̰� 0('')�� ��쵵 NULL
        
     -- 1) ���̺� ������ NOT NULL ���� ���� ����
       -----------------------------------------------------
       -- �⺻ ����
        CREATE TABLE ���̺�� (
           �÷�   ������Ÿ��  NOT NULL
                :
          );


     -- 2) �����ϴ� ���̺� NOT NULL ���� ���� ����
       -----------------------------------------------------
       -- �⺻ ����
         ALTER TABLE ���̺�� MODIFY �÷�  NOT NULL;
         ALTER TABLE ���̺�� ADD [ CONSTRAINT ���������̸� ] CHECK(�÷� IS NOT NULL);


     -- 3) NOT NULL ���� ���� ����
       -----------------------------------------------------
       -- �⺻ ����
         ALTER TABLE ���̺�� MODIFY �÷� NULL;
         ALTER TABLE ���̺�� DROP CONSTRAINT ���������̸�;
         
       -----------------------------------------------------
        CREATE TABLE test2(
            id  VARCHAR2(50),
            pwd VARCHAR2(100),
            name VARCHAR2(30),
            PRIMARY KEY(id)
        );

        -- name �÷��� NOT NULL ���� ���� �߰�
        ALTER TABLE test2 MODIFY name NOT NULL;
        
        SELECT * FROM user_constraints WHERE table_name = 'TEST2';
        
        INSERT INTO test2(id,pwd,name) VALUES('1','1',NULL);
            -- ORA-01400 : NOT NULL ���� ����
            
        
   -- > DEFAULT�� ���� ������ �ƴ�
   -- �� DEFAULT : �����͸� �߰��ϰų� �����Ҷ� �⺻�� ����
     -- 1) ���̺� ������ DEFAULT ����
     -------------------------------------------------------
     -- �⺻ ����
          CREATE TABLE ���̺�� (
                    �÷�  ������Ÿ��  DEFAULT ����
                                 :
         );
        
        CREATE TABLE test3(
            num NUMBER PRIMARY KEY,
            name VARCHAR2(50) NOT NULL,
            subject VARCHAR2(500) NOT NULL,
            content VARCHAR2(4000) NOT NULL,
            created DATE DEFAULT SYSDATE,
            hitCount NUMBER DEFAULT 0 NOT NULL
        );
            -- DEFAULT�� NOT NULL�� ���� �����ϴ� ��� NOT NULL�� �ڿ� ���
        
        -- �������� Ȯ��
            SELECT * FROM user_constraints;
            
        -- default Ȯ��
            SELECT * FROM user_tab_columns WHERE table_name = 'TEST3'; -- > DATA_DEFAULT���� Ȯ��
            SELECT * FROM cols WHERE table_name = 'TEST3';
            
        -- �߰�
            INSERT INTO test3(num, name, subject, content) VALUES(1,'a','aa','aaa');
                -- created : sysdate, hitCount:0 �� ��
            SELECT * FROM test3;
            
            -- > DEFAULT �����ϱ⶧���� �ǵ��� �̷��� ��� ���ִ� ���� ����
            INSERT INTO test3(num, name, subject, content, created, hitCount) VALUES(2,'b','bb','bbb',SYSDATE,0);
            SELECT * FROM test3;
            
            INSERT INTO test3(num, name, subject, content, created, hitCount) VALUES(3,'c','cc','ccc',NULL,0);
            SELECT * FROM test3;
            
            INSERT INTO test3(num, name, subject, content, created) VALUES(4,'d','dd','ddd',DEFAULT);
            SELECT * FROM test3;
        
            UPDATE test3 SET created = DEFAULT WHERE num = 1;
            UPDATE test3 SET created = SYSDATE WHERE num = 2;
            
            COMMIT;
            
            
     -- 2) DEFAULT Ȯ��
         SELECT column_name, data_type, data_precision, data_length, nullable, data_default 
         FROM user_tab_columns WHERE table_name='���̺��';

     -- 3) DEFAULT ����
       ------------------------------------------------------
       -- �⺻ ����
          ALTER TABLE ���̺�� MODIFY �÷� DEFAULT NULL;




   -- �� CHECK ���� ����
    -- 1) ���̺� ������ ���ÿ� CHECK ���� ���� ����
      -- (1) �÷� ���� ����� CHECK ���� ����
       ------------------------------------------------------
       -- �⺻ ����
           CREATE TABLE ���̺�� (
                 �÷�  ������Ÿ��  [ CONSTRAINT �������Ǹ� ] CHECK ( ���� )
                                 :
             );


      -- (2) ���̺� ���� ����� CHECK ���� ����
       ------------------------------------------------------
       -- �⺻ ����
           CREATE TABLE ���̺�� (
                   �÷�  ������Ÿ��,
                               :
                   [ CONSTRAINT �������Ǹ� ] CHECK ( ���� )
          );


    -- 2) �����ϴ� ���̺� CHECK ���� ���� ����
     -------------------------------------------------------
     -- �⺻ ����
       ALTER TABLE ���̺��
                  ADD [ CONSTRAINT �������Ǹ� ] CHECK ( ���� );


    -- 3) CHECK ���� ���� ����
     -------------------------------------------------------
     -- �⺻ ����
        ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�;
      
       ------------------------------------------------------
        CREATE TABLE test4(
            num NUMBER PRIMARY KEY,
            name VARCHAR2(30) NOT NULL,
            kor NUMBER(3) NOT NULL,
            eng NUMBER(3) DEFAULT 0 CHECK(eng BETWEEN 0 AND 100),  -- > DEFAULT, CHECK ���� ������ DEFAULT ����
            CONSTRAINT ck_test4_kor CHECK(kor BETWEEN 0 AND 100)
        );
            
        SELECT * FROM user_constraints WHERE table_name = 'TEST4';
        
      -- ������ �÷��� �߰��Ѵ�.
        -- gender ����(6), 'M','F'�� �߰� �����ϵ��� CHECK ���� ���
            ALTER TABLE test4 ADD (gender VARCHAR2(6) CHECK(gender IN('M','F')));   
                                            -- > CHECK �������� WHERE���� �����ϴ� ��ó��.
            
            SELECT * FROM user_constraints WHERE table_name = 'TEST4';
            
        -- test4 ���̺� : ������ �÷��� �߰��Ѵ�.
            -- sdate DATE NOT NULL, edate DATE NOT NULL
            ALTER TABLE test4 ADD (sdate DATE NOT NULL, edate DATE NOT NULL);
        
        -- test4 ���̺� : ������ CHECK ������ �߰��Ѵ�.
            -- sdate <= edate
            ALTER TABLE test4 ADD CONSTRAINT ck_test4_dates CHECK ( sdate <= edate );
            
            SELECT * FROM user_constraints WHERE table_name = 'TEST4';
            
            INSERT INTO test4(num, name, kor, eng, gender, sdate, edate)
                VALUES(1,'a',90,90,'M','2023-03-07','2023-03-08');
            
            INSERT INTO test4(num, name, kor, eng, gender, sdate, edate)
                VALUES(2,'b',90,90,'M','2023-03-07','2023-03-06');
                    -- ����: CHECK ���� ���� 
        
        -- ����
         CREATE TABLE test4(
            num NUMBER PRIMARY KEY,
            sdate DATE NOT NULL,
            edate DATE CHECK (sdate <= edate)
        ); -- ����. �ٸ� �÷� ���� �Ұ�
        
        CREATE TABLE test4(
            num NUMBER PRIMARY KEY,
            sdate DATE NOT NULL,
            edate DATE NOT NULL,
            CONSTRAINT ck_test4_dates CHECK (sdate <= edate)
        ); -- ����
        
        
        DROP TABLE test1 PURGE;        
        DROP TABLE test2 PURGE;       
        DROP TABLE test3 PURGE;       
        DROP TABLE test4 PURGE;
        
        SELECT * FROM tabs;
        
        
   --> �ݵ��. �˾ƾ� ��
   -- �� ���� Ű(�ܷ� Ű, FOREIGN KEY)
     -- 1) ���̺� ������ ���ÿ� FOREIGN KEY ���� ���� ����
       -- (1) �÷� ���� ����� FOREIGN KEY ���� ����
        -----------------------------------------------------
        -- �⺻ ����
           CREATE TABLE ���̺�� (
                    �÷�  ������Ÿ��  [ CONSTRAINT �������Ǹ� ] 
                                            REFERENCES ���������̺��(�÷�)
                                            [ON DELETE { CASCADE | SET NULL } ]
                                 :
            );
   
      
     

       -- (2) ���̺� ���� ����� FOREIGN KEY ���� ���� --> ���� �̷��� ���
        -----------------------------------------------------
        -- �⺻ ����
            CREATE TABLE table_name (
                    �÷�  ������Ÿ��,
                               :
                     [ CONSTRAINT �������Ǹ� ] FOREIGN KEY ( �÷� [,�÷�] )
                             REFERENCES  ���������̺��(�÷� [,�÷�])
                             [ON DELETE { CASCADE | SET NULL } ]
             );

 -----------------------------------------------------------
    -- test1 : �θ� ���̺�
    CREATE TABLE test1(
        code    VARCHAR2(30) PRIMARY KEY,
        subject VARCHAR2(100) NOT NULL
    );
    
    -- exam1 : �ڽ� ���̺�
    CREATE TABLE exam1(
        id VARCHAR2(30) PRIMARY KEY,
        name VARCHAR2(30) NOT NULL,
        code VARCHAR2(30),               --> code�� ���� �ʾƵ� ��. Ÿ�� ũ�⸸ ������ ��. NULL ���.           
        CONSTRAINT fk_exam1_code FOREIGN KEY(code) REFERENCES test1(code) -- R
    );                                                      --> code�� �⺻Ű or UNIQUE        
    
    SELECT * FROM user_constraints WHERE table_name = 'TEST1';
    SELECT * FROM user_constraints WHERE table_name = 'EXAM1';  --> R : ����
    
    -- exam1 ���̺� ������ �߰�
        INSERT INTO exam1(id, name, code) VALUES('1','a','x100');
            -- ���� : ORA-02291
            -- �θ����̺��� ���� code���� �߰� �Ұ�

        INSERT INTO exam1(id, name, code) VALUES('1','a',NULL);
            -- ����. ����Ű�� NULL�� ����ϹǷ�

    -- test1 ���̺� ������ �߰�(�θ� ���̺�)
        INSERT INTO test1(code, subject) VALUES('x100','aaa');
        INSERT INTO test1(code, subject) VALUES('x101','bbb');
        INSERT INTO test1(code, subject) VALUES('x102','ccc');
        
    -- exam1 ���̺� ������ �߰�
        INSERT INTO exam1(id,name,code) VALUES('2','b','x100');
        INSERT INTO exam1(id,name,code) VALUES('3','c','x102');
        INSERT INTO exam1(id,name,code) VALUES('4','d','x100');
        
        SELECT * FROM test1;
        SELECT * FROM exam1;
        
        UPDATE test1 SET code='x200' WHERE code = 'x100';
            -- ����. code 'x100'�� exam1 ���̺��� �����ϰ� �����Ƿ� ������ �Ұ����ϴ�.
            
         UPDATE test1 SET code='x201' WHERE code = 'x101';
            -- ����. �������ϰ� ���� �����Ƿ� ���� ����
         SELECT * FROM test1;
         
         DELETE FROM test1 WHERE code='x100';
            -- ����. code 'x100'�� exam1 ���̺��� �����ϰ� �����Ƿ� ������ �Ұ���
        
         DELETE FROM test1 WHERE code='x201';
            -- ���� : ���� ���ϰ� ���� �����Ƿ�
            
         DROP TABLE test1 PURGE;
            -- ����. �ڽ� ���̺��� �����ϸ� ���� �Ұ���
            -- �ڽ� ���̺��� ���� ����� �θ� ���̺��� �����ؾ� ��
        
         -- ���� ���� : ����Ű�� ���� ��
            DROP TABLE test1 CASCADE CONSTRAINTS PURGE;         
                            -- >  �ڽ� ���� �� ���� ����
            SELECT * FROM user_constraints WHERE table_name = 'EXAM1';

            DROP TABLE exam1 PURGE;
            
    ----------------------------------------------
    -- �����ϴ� �÷��� �������ϴ� �÷��� Ÿ�� �� ũ��� ��ġ�ؾ� ������ �÷����� �ٸ� �� �ִ�.
      -- test1 : �θ� ���̺�
        CREATE TABLE test1(
            code VARCHAR2(30) PRIMARY KEY,
            subject VARCHAR2(100) NOT NULL 
        );
        
        --exam1 : �ڽ� ���̺�
        CREATE TABLE exam1(
            id VARCHAR2(30) PRIMARY KEY,
            name VARCHAR2(30) NOT NULL,
            scode VARCHAR2(30) NOT NULL,
            FOREIGN KEY(scode) REFERENCES test1(code)       --> �̸� �� Ȯ��
        );                       

        DROP TABLE exam1 PURGE;
        DROP TABLE test1 PURGE;
    ----------------------------------------------
    -- ���� => 1:1, 1:N(1:0)
    -- ȸ�����̺�
    CREATE TABLE member1(
        id VARCHAR2(30) PRIMARY KEY,
        pwd VARCHAR2(100) NOT NULL,
        name VARCHAR2(30) NOT NULL
    );
    
    -- 1:1 ���� 
        -- �ĺ����� : �⺻Ű�̸鼭 ����Ű
    CREATE TABLE member2 (
        id VARCHAR2(30),
        birth DATE,
        tel VARCHAR2(50),
        CONSTRAINT pk_member2_id  PRIMARY KEY(id),
        CONSTRAINT fk_member2_id  FOREIGN KEY(id) REFERENCES member1(id)
    );
    
    -- 1:�� ���� 
        -- ��ĺ����� : �ܼ��� ����Ű
    CREATE TABLE guest(     
        num NUMBER PRIMARY KEY,
        id VARCHAR2(30) NOT NULL,
        content VARCHAR2(400) NOT NULL,
        reg_date DATE DEFAULT SYSDATE,
        FOREIGN KEY(id) REFERENCES member1(id)
    );
    
    -- 2���� �÷��� �⺻Ű�� ����
        -- �ΰ��� ���̺��� ����
        -- member1:guestLike => 1:��,  guest:guestLike => 1:��
        -- �ĺ����� : �⺻Ű�̸鼭 ����Ű
      CREATE TABLE guestLike(   --> ���ƿ� ���̺�
        num NUMBER,
        id VARCHAR2(30),
        PRIMARY KEY(num, id),
        FOREIGN KEY (num) REFERENCES guest(num),
        FOREIGN KEY (id) REFERENCES member1(id)
      );
      
    --> �÷����� _(�����) ��� ����  
    -- �ϳ��� ���̺��� �ι� ���� : ���� ���̺�
        -- 1:��, ��ĺ�����
        CREATE TABLE note(     
            num NUMBER PRIMARY KEY,
            sendId VARCHAR2(30) NOT NULL,
            receiveId VARCHAR2(30) NOT NULL,
            content VARCHAR2(4000) NOT NULL,
            FOREIGN KEY (sendId) REFERENCES member1(id),
            FOREIGN KEY (receiveId) REFERENCES member1(id)
        );

      -- member1 ���̺��� �����ϴ� ��� ���̺� Ȯ�� ( �ڽ� ���̺� ��� Ȯ�� )
        SELECT fk.owner, fk.constraint_name , fk.table_name 
        FROM all_constraints fk, all_constraints pk 
        WHERE fk.r_constraint_name = pk.constraint_name 
                   AND fk.constraint_type = 'R' 
                   AND pk.table_name = UPPER('member1')
        ORDER BY fk.table_name;
        --> ���� 2���ϸ� �ΰ� ����. (ex.NOTE)
        
      -- guestLike ���̺��� �����ϰ� �ִ� ���̺� ��� ���(��� �θ� ���̺� ��� Ȯ��)
        SELECT table_name FROM user_constraints
        WHERE constraint_name IN (
              SELECT r_constraint_name 
              FROM user_constraints
              WHERE table_name = UPPER('guestLike') AND constraint_type = 'R'
        );
        
        --guestLike ���̺��� �����ϰ� �ִ� ���̺� ��� �� �θ��÷� ���(��� �θ� ���̺� ��� Ȯ��)
        SELECT fk.constraint_name, fk.table_name child_table, fc.column_name child_column,
                    pk.table_name parent_table, pc.column_name parent_column
        FROM all_constraints fk, all_constraints pk, all_cons_columns fc, all_cons_columns pc
        WHERE fk.r_constraint_name = pk.constraint_name
                   AND fk.constraint_name = fc.constraint_name
                   AND pk.constraint_name = pc.constraint_name
                   AND fk.constraint_type = 'R'
                   AND pk.constraint_type = 'P'
                   AND fk.table_name = UPPER('guestLike');

        -- ���̺� ���� ( > �ڽĺ���. ���� ���� �Ųٷ� ����� �� )
            DROP TABLE note PURGE;
            DROP TABLE guestLike PURGE;
            DROP TABLE guest PURGE;
            DROP TABLE member2 PURGE;
            DROP TABLE member1 PURGE;

            -- DROP TABLE member1 CASCADE CONSTRAINTS PURGE;
     ----------------------------------------------
      -- �ڱ� �ڽ� ���� : ��з�, �ߺз� ��
      CREATE TABLE test1(
        num NUMBER PRIMARY KEY,
        subject VARCHAR2(100) NOT NULL,
        snum NUMBER,
        FOREIGN KEY(sunm) REFERENCES test1(num)
      );
      
      DROP TABLE test1 PURGE;
     ----------------------------------------------
      -- ON DELETE CASCADE : �θ� ���̺��� �����Ͱ� �����Ǹ� �ڽ� ���̺��� �����͵� ����
      CREATE TABLE test1(
        sdate NUMBER(4),
        code VARCHAR2(10),
        subject VARCHAR2(100) NOT NULL,
        PRIMARY KEY(sdate,code)
      );
      
      CREATE TABLE test2(
        num NUMBER PRIMARY KEY,
        sdate NUMBER(4) NOT NULL,
        code VARCHAR2(10) NOT NULL,
        name VARCHAR2(100) NOT NULL,
        qty NUMBER DEFAULT 0,
        FOREIGN KEY(sdate, code) REFERENCES test1(sdate,code) ON DELETE CASCADE
      );
      
      INSERT INTO test1(sdate, code, subject) VALUES (2023,'a100','���α׷���');
      INSERT INTO test1(sdate, code, subject) VALUES (2023,'b100','�����ͺ��̽�');
      INSERT INTO test1(sdate, code, subject) VALUES (2023,'c100','��');
      
      INSERT INTO test2(num, sdate, code, name, qty) VALUES (1,2023,'a100','�ڹ�',0);
      INSERT INTO test2(num, sdate, code, name, qty) VALUES (2,2023,'a100','C',0);
      INSERT INTO test2(num, sdate, code, name, qty) VALUES (3,2023,'a100','���̽�',0);
         
      INSERT INTO test2(num, sdate, code, name, qty) VALUES (4,2023,'b100','����Ŭ',0);
      INSERT INTO test2(num, sdate, code, name, qty) VALUES (5,2023,'b100','�����Ƶ��',0);
      
      INSERT INTO test2(num, sdate, code, name, qty) VALUES (6,2023,'c100','HTML',0);
      
      SELECT * FROM test1;
      SELECT * FROM test2;
      
      DELETE FROM test1 WHERE sdate= 2023 AND code='a100';
      SELECT * FROM test1;
      SELECT * FROM test2;
      
      DROP TABLE test2 PURGE;
      DROP TABLE test1 PURGE;


     -- 2) �����ϴ� ���̺� FOREIGN KEY ���� ���� ����
       ------------------------------------------------------
       -- �⺻ ����
          ALTER TABLE ���̺��
              ADD [ CONSTRAINT �������Ǹ� ] FOREIGN KEY( �÷� [,�÷�] )
                     REFERENCES  ���������̺��(�÷� [,�÷�]);


     -- 3) FOREIGN KEY ���� ���� ����
      -------------------------------------------------------
      -- �⺻ ����
        ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�;





   -- �� ���� ���� Ȱ��ȭ �� ��Ȱ��ȭ
     -- 1) �����ϴ� ���̺��� ���� ���� �� Ȱ��ȭ
     -------------------------------------------------------
     --
      ALTER TABLE ���̺�� DISABLE CONSTRAINT �������Ǹ� [ CASCADE ];


     -- 2) ���̺��� ���� ���� Ȱ��ȭ
     -------------------------------------------------------
     --
       ALTER TABLE ���̺�� ENABLE CONSTRAINT �������Ǹ�;
 
    
     -------------------------------------------------------
     -- ���̺� �ۼ� : dept_test(�μ�)
        dept_id(�μ��ڵ�)      VARCHAR2(30)     �⺻Ű
        dept_name(�μ���)      VARCHAR2(50)     NOT NULL
        manager_id(�μ����ڵ�)  VARCHAR2(30)     NOT NULL
        
        CREATE TABLE dept_test (
            dept_id     VARCHAR2(30)  PRIMARY KEY,
            dept_name   VARCHAR2(50)  NOT NULL,
            manager_id  VARCHAR2(30)  NOT NULL
        );       


      -- ���̺� �ۼ� : emp_test(���)
        emp_id(������̵�)   VARCHAR2(30)    �⺻Ű
        name(�̸�)          VARCHAR2(50)    NOT NULL
        email(�̸���)       VARCHAR2(50)     NOT NULL
        dept_id(�μ��ڵ�)    VARCHAR2(30)    NOT NULL
        
        CREATE TABLE emp_test (
            emp_id        VARCHAR2(30)    PRIMARY KEY,
            name          VARCHAR2(50)     NOT NULL,
            email         VARCHAR2(50)     NOT NULL,
            dept_id       VARCHAR2(30)     NOT NULL
        );
         
        
      -- dept_test ���̺� ����Ű �߰�
        manager_id �÷��� emp_test ���̺��� emp_id�� ����
        
        ALTER TABLE dept_test
              ADD FOREIGN KEY ( manager_id )
                     REFERENCES  emp_test(emp_id);
                     
                     
      -- emp_test ���̺� ����Ű �߰�
        dept_id �÷��� dept_test ���̺��� dept_id �� ����
         
         ALTER TABLE emp_test
              ADD FOREIGN KEY( dept_id )
                     REFERENCES  dept_test(dept_id);


      -- ������ ������ �߰�  
        dept_test ���̺� : 'a1', '������', '1001'
        emp_test ���̺� : '1001', '�迵��', 'kim@test.com','a1'
        
        INSERT INTO dept_test (dept_id, dept_name, manager_id) VALUES ('a1', '������', '1001');
            -- ���� : �θ� ���̺� ���� ����   >> ���� �����ϰ� �ְ�, NOT NULL ����
            
        INSERT INTO emp_test (emp_id, name, email, dept_id) VALUES ('1001', '�迵��', 'kim@test.com','a1');
            -- ���� : �θ� ���̺� ���� ����        
        
        
      -- ����Ű�� ��Ȱ��ȭ
         SELECT * FROM user_constraints WHERE table_name = 'DEPT_TEST';
            -- R
         ALTER TABLE dept_test DISABLE CONSTRAINT SYS_C007819 CASCADE;
            
         SELECT * FROM user_constraints WHERE table_name = 'EMP_TEST';
            -- R
         ALTER TABLE emp_test DISABLE CONSTRAINT SYS_C007820 CASCADE;
         
      -- ��Ȱ��ȭ Ȯ��
         SELECT * FROM user_constraints WHERE table_name = 'DEPT_TEST';
         SELECT * FROM user_constraints WHERE table_name = 'EMP_TEST';
                -- status �÷� : DISABLE
        
      -- ����Ű�� ��Ȱ��ȭ �ϸ� ���� ������ �����ϴ� �����͵� �߰��� ����
         INSERT INTO dept_test (dept_id, dept_name, manager_id) VALUES ('a1', '������', '1001');
         INSERT INTO dept_test (dept_id, dept_name, manager_id) VALUES ('b1', '���ߺ�', '2001');
         INSERT INTO dept_test (dept_id, dept_name, manager_id) VALUES ('c1', '�ѹ���', '3001');
         SELECT * FROM dept_test;
         
         INSERT INTO emp_test (emp_id, name, email, dept_id) VALUES ('1001', '�迵��', 'kim@test.com','a1');
         INSERT INTO emp_test (emp_id, name, email, dept_id) VALUES ('2001', '������', 'lee@test.com','b1');
         SELECT * FROM emp_test;      
         
      -- ����Ű�� Ȱ��ȭ
         ALTER TABLE dept_test ENABLE CONSTRAINT SYS_C007819;
            -- ���� : �������� �����ϴ� �����Ͱ� ����  >> emp_test�� 3001���� ����.
            
        INSERT INTO emp_test (emp_id, name, email, dept_id) VALUES ('3001', '�ٴٴ�', 'da@test.com','c1');
         
        ALTER TABLE dept_test ENABLE CONSTRAINT SYS_C007819;
        ALTER TABLE emp_test ENABLE CONSTRAINT SYS_C007820;
         
      -- ���̺� ����
         DROP TABLE dept_test CASCADE CONSTRAINTS PURGE;
         DROP TABLE emp_test CASCADE CONSTRAINTS PURGE;
         
         
         
         
         
         
         
         
         
         
         