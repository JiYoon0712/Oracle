-- �� SQL*Plus
 -- �� sqlplus ����
   -- ������ �������� sqlplus ����
      cmd> sqlplus sys/"�н�����" AS SYSDBA

      �Ǵ�
      cmd> sqlplus  / AS SYSDBA
           -- �� ����� ��쿡 ���� ���� ���� ���� �� �ִ�.

      SQL> SHOW USER    -- ���� ����� Ȯ��

   -- �Ϲ� ����� �������� sqlplus ����
      cmd> sqlplus ������/"�н�����"
      SQL> SHOW USER

      cmd> sqlplus sky/"java$!"
      SQL> SHOW USER
      SQL> SELECT name FROM emp;

      SQL> conn hr/HR				//  > ó�� ���鶧�� sqlplus ���, ���߿� ���� conn ���
      SQL> SHOW USER

 -- �� SQL*Plus �⺻ ��ɾ�
    -- �� CONNECT 
       -- ������ �������� ����
           SQL> CONN sys/"�н�����" AS SYSDBA
           SQL> SHOW USER 

       -- �Ϲ� ����� �������� �������� ����
           SQL> CONN ������/"�н�����"
           SQL> SHOW USER


    -- �� EXIT
       - SQLPLUS ����

      SQL> EXIT


-- �� SQL �⺻���
 -- �� ��� ������ �� ���� ������
     -- �� ��� ������   

    -- �� ���� ������



 -- �� DUAL ���̺�� ���̺� ��� �� ���̺� ����
    -- ��  DUAL ���̺�
 	SELECT * FROM dual;

    -- �� ���̺� ���
      -- 1) USER_TABLES(TABS) ��ųʸ�
           -- ��� �� : ����ڰ� ������ ���̺��� ���̺��� ���̺����̽� ��ȸ

            SELECT * FROM USER_TABLES;
            SELECT * FROM TABS;

      -- 2) TAB ��(VIEW)
           -- ��� �� : ���� ����ڰ� ������ ���̺� ��� ��ȸ
             SELECT * FROM TAB;

      -- 3) ALL_TABLES
          -- ��� �� : HR ������ ���̺� ���� ���� ��ȸ
          -- ������ ����
                 SELECT * FROM ALL_TABLES WHERE owner = 'HR';

    -- �� ���̺� ����
      -- 1) USER_TAB_COLUMNS(COLS) ��ųʸ�
          -- ��� �� : EMP ���̺� �����ϴ� ��� �÷� ��, ������ Ÿ��, ������ ���� ��ȸ

          -- ��� ���̺��� ��� �÷� ���
		SELECT * FROM USER_TAB_COLUMNS;
		SELECT * FROM COLS;

          -- emp ���̺��� ��� �÷� ���
		SELECT * FROM USER_TAB_COLUMNS WHERE table_name = 'EMP';
		SELECT * FROM COLS WHERE table_name = 'EMP';

      -- 2) COL ��(VIEW)
           -- ��� �� : EMP ���̺� �����ϴ� ��� �÷� ��, ������ Ÿ��, ������ ���� ��ȸ
		   --emp ���̺��� ��� �÷����
				SELECT * FROM col WHERE tname = 'EMP';

      -- 3) DESCRIBE(DESC)
	  	--emp ���̺��� ��� �÷� ���
		DESC emp;



---------------------------------------------------------------
> ����� ����
 SELECT * FROM dual;
 
 SELECT * FROM USER_TABLES;
 SELECT * FROM TABS;
 
 SELECT * FROM TAB;
 
 SELECT * FROM USER_TAB_COLUMNS;
 SELECT * FROM COLS;
 
 SELECT * FROM USER_TAB_COLUMNS WHERE table_name = 'EMP';
 SELECT * FROM COLS WHERE table_name = 'EMP';
 
 SELECT * FROM col WHERE tname = 'EMP';
 DESC emp; 