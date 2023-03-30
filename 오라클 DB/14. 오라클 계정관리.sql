-- �� ����Ŭ ��������
 -- �� ��������
    -- �� ����


    -- �� ���� ���� �� ����
         ---------------------------------------------------------
         -- ��� ��
         -- ���� ���� ����
           CREATE USER ����ڸ�
               IDENTIFIED BY �н�����
               [ DEFAULT TABLESPACE tablespace_name ]
               [ TEMPORARY TABLESPACE temp_tablespace_name ]
               [ QUOTA  { size_clause | UNLIMITED } ON tablespace_name ]
               ;

         -- ���� ���� ����
           ALTER USER ����ڸ�
               IDENTIFIED BY �н�����
               | DEFAULT TABLESPACE tablespace_name
               | TEMPORARY TABLESPACE temp_tablespace_name
               | QUOTA  { size_clause | UNLIMITED } ON tablespace_name
               | ACCOUNT { LOCK | UNLOCK };

         -- ���� ���� ����
           DROP USER ����ڸ� [CASCADE];


         ---------------------------------------------------------
         -- ���� ��ȸ  - ������ ���� : sys �Ǵ� system
           SELECT * FROM all_users;
           SELECT username, default_tablespace, temporary_tablespace FROM dba_users;
           SELECT object_name, object_type FROM dba_object  WHERE OWNER='����ڸ�'; 


         ---------------------------------------------------------
         -- 


 -- �� ����(Privilege)�� ��(ROLE)
    -- �� �ý��� ����(System Privilege)
         ---------------------------------------------------------
         -- ��� ��
         -- �ý��� ���� �ο� ����
            GRANT �ý���_����
                TO { ����ڸ� | PUBLIC }
                [WITH ADMIN OPTION];

         -- �ý��� ���� ȸ�� ����
             REVOKE �ý���_���� FROM { ����ڸ� | PUBLIC  };

         -- ��ü �ý��� ���� ��� Ȯ�� - ������ ���� : sys �Ǵ� system
            SELECT * FROM system_privilege_map;

         -- ��� ������ �ο��� ��� �ý��� ���� ��ȸ  - ������ ���� : sys �Ǵ� system
           SELECT * FROM dba_sys_privs;

         -- ������� �ý��� ����(privilege) Ȯ��(�Ϲ� ����)
           SELECT * FROM user_sys_privs; 

         -- ������ SESSION ���� �Ҵ�� ���� ��ȸ
           SELECT * FROM session_privs;


         ---------------------------------------------------------
         -- 



    -- �� ������Ʈ ����(Object Privilege)
         ---------------------------------------------------------
         -- ��� ��
         -- ������ �ִ� ��ü ���� Ȯ��(��ü ������ ������, ��ü ���� �ο���, ��ü ���� �Ǻο���)
           SELECT * FROM user_tab_privs;

         -- �ٸ� ����ڷ� ���� ���� ��ü ���� Ȯ��
           SELECT * FROM user_tab_privs_recd;

         -- ����ڰ� �ο��� ��� ��ü ����
            SELECT * FROM user_tab_privs_made;


         ---------------------------------------------------------
         -- 




    -- �� ��(ROLE)
         ---------------------------------------------------------
         -- ��� ��
         -- ROLE Ȯ��  - ������ ���� : sys �Ǵ� system
            SELECT * FROM dba_roles;

         -- ������ �ο��� ��(����) Ȯ��
            SELECT * FROM user_role_privs;

         -- �Ѿ��� �� Ȯ��
             SELECT * FROM role_role_privs WHERE role='��_�̸�';

         -- ���� �ý��� ���� Ȯ��
            SELECT * FROM role_sys_privs WHERE role='��_�̸�';


         ---------------------------------------------------------
         -- 

