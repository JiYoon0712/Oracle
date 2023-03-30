-- �� Ʈ�����
 -- �� Ʈ�����(Transaction)
   -- �� COMMIT �� ROLLBACK
    
    CREATE TABLE guest( 
        num NUMBER PRIMARY KEY,
        name VARCHAR2(30) NOT NULL,
        content VARCHAR2(4000) NOT NULL,
        reg_date DATE DEFAULT SYSDATE
    );
    
    CREATE SEQUENCE guest_seq
    START WITH 1
    INCREMENT BY 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;
    
    
    SELECT * FROM tab;
    SELECT * FROM seq;
    
    INSERT INTO guest(num,name,content, reg_date) VALUES (guest_seq.NEXTVAL,'a','aa',SYSDATE);
    INSERT INTO guest(num,name,content, reg_date) VALUES (guest_seq.NEXTVAL,'b','bb',SYSDATE);
    SELECT * FROM guest;
  --  
    SAVEPOINT a; -- Ʈ����� ���� ����
    INSERT INTO guest(num, name, content, reg_date) VALUES(guest_seq.NEXTVAL,'c','cc',SYSDATE);
    
    SELECT * FROM guest;
    
    ROLLBACK TO a;  -- ������ INSERT �� �ѹ�
    SELECT * FROM guest;
    
    ROLLBACK; -- ��� �ѹ�
    SELECT * FROM guest;
    
    INSERT INTO guest(num, name, content, reg_date) VALUES(guest_seq.NEXTVAL,'a','aa',SYSDATE);
    COMMIT;     -- COMMIT �Ǵ� DDL�� ������ Ŀ��(Ʈ����� �Ϸ�)
    
    ROLLBACK ;  -- COMMIT ������ ROLLBACK�� �ǹ̾���
    
    SELECT * FROM guest;
 
    INSERT INTO guest(num, name, content, reg_date) VALUES(guest_seq.NEXTVAL,'a','aa',SYSDATE);
    COMMIT;




   -- �� Ʈ����� ���� ����
     -- 1) SET TRANSACTION : �پ��� Ʈ����� �Ӽ��� ����

     -- 2) LOCK TABLE
        -- : ���� Ʈ������� ����ǰ� �ִ� �����Ϳ� ���� �ٸ� �ٸ� Ʈ������� �˻��̳� ������ ���� ���� Ʈ������� ���ÿ� ���� �����͸� ����ϵ��� ����
        
        -- SQL Developer
           SELECT * FROM guest;
           
           INSERT INTO guest(num, name, content, reg_date) VALUES(guest_seq.NEXTVAL,'e','ee',SYSDATE);
           SELECT * FROM guest;
           
        -- VS Code
           SELECT * FROM guest;
                    -- e�� ��� �ȵ� > �翬�� Ŀ�� ����;;;
        
        -- SQL Developer       
           COMMIT;
           
        -- VS Code 
           SELECT * FROM guest;
                -- e ���
   
   
      -------------------------------------------------------
      -- VS Code
         SET TRANSACTION READ ONLY;
                -- SELECT �� ����(INSERT, UPDATE, DELETE �Ұ���)
         SELECT * FROM guest;

         DELETE * FROM guest;  -- ����
         ROLLBACK;
         
         SET TRANSACTION READ WRITE;
         
         DELETE FROM guest;
         SELECT * FROM guest;
         
         ROLLBACK;
         SELECT * FROM guest;
 
      -------------------------------------------------------
      -- SQL Developer
        LOCK TABLE guest IN EXCLUSIVE MODE;
                --EXCLUSIVE: ��� ���̺��� SELECT �� ���
        INSERT INTO guest(num,name,content,reg_date) VALUES(guest_seq.NEXTVAL,'f','ff',SYSDATE);
      
      -- VS Code
         DELETE FROM guest;
         
      -- SQL Developer    
         ROLLBACK;
      
      -- VS Code
        -- ��� ���߰� DELETE ����
        ROLLBACK;
        
      -- SQL Developer 
        DROP TABLE guest PURGE;
        DROP SEQUENCE guest_seq;
          
          select * from tab;

   -- �� COMMIT�� ���� �ʴ� ���� Ȯ��
      -------------------------------------------------------
      -- ������(sys �Ǵ� system) �������� Ȯ��
        SELECT s.inst_id inst, s.sid||','||s.serial# sid, s.username,
                    s.program, s.status, s.machine, s.service_name,
                    '_SYSSMU'||t.xidusn||'$' rollname, --r.name rollname, 
                    t.used_ublk, 
                   ROUND(t.used_ublk * 8192 / 1024 / 1024, 2) used_bytes,
                   s.prev_sql_id, s.sql_id
        FROM gv$session s,
                  --v$rollname r,
                  gv$transaction t
        WHERE s.saddr = t.ses_addr
        ORDER BY used_ublk, machine;
