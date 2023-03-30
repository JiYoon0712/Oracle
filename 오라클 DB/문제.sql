----- [ ����Ǯ�� - ������ ] ---

---- �� SELECT���� ������ �Լ�
----Q] sky ������ ��� ���̺��� ��� ���
        SELECT * FROM TAB;
        
        SELECT * FROM USER_TABLES;
        SELECT * FROM TABS;

--Q] emp ���̺��� �÷���� �� �÷��� Ÿ�Ե� ���̺��� ���� ���
        SELECT * FROM COL WHERE TNAME = 'EMP';

--Q] emp ���̺��� ��� �ڷ� ���
        SELECT * FROM emp;

--Q] emp ���̺�
--    �� ��� �÷� : empNo, name, city, dept, pos, sal, bonus, pay(sal+bonus)
--    �� ����
--      - pay�� 3500000�� �̻��� ����� ���
--      - pay ������������ �����ϰ� pay�� �����ϸ� sal �������� ����
        SELECT empNo, name, city, dept, pos, sal, bonus, sal+bonus AS pay
        FROM emp
        WHERE sal+bonus >=3500000
        ORDER BY pay DESC, sal DESC;

--Q] emp ���̺�
--    �� ��� �÷� : empNo, name, city, dept, pos, sal, bonus
--    �� ����
--        - city�� ���� ����߿��� name�� �达�� �̾��� ����� ���
        SELECT empNo, name, city, dept, pos, sal, bonus
        FROM emp
        WHERE city='����' AND (name LIKE'��%' OR name LIKE '��%');  -- LIKE ��� ����

--Q] emp ���̺�
--    �� ��� �÷� : empNo, name, hireDate
--    �� ����
--        - �Ի�⵵(hireDate)�� Ȧ���⵵�� ����� ���
        SELECT empNo, name, hireDate
        FROM emp
        WHERE MOD(SUBSTR(hireDate,1,2),2)=1;
    
--Q] emp ���̺�
--    �� ��� �÷� : empNo, name, hireDate
--    �� ����
--        - �Ի�⵵(hireDate)�� �������� ����� ���
--        - �Ի�⵵(hireDate)�� "�⵵4�ڸ�-��-�� ����" �������� ���
        --(1)
        SELECT empNo, name, TO_CHAR(hireDate,'YYYY-MM-DD DAY')
        FROM emp
        WHERE SUBSTR(TO_CHAR(hireDate,'YYYY-MM-DD DAY'),12,14)='������';
        
        --(2)
        SELECT empNo, name, TO_CHAR(hireDate,'YYYY-MM-DD DAY')
        FROM emp
        WHERE TO_CHAR(hireDate,'DAY')='������';
        
        --(�����)
        SELECT empNo, name, TO_CHAR(hireDate,'YYYY-MM-DD DAY')
        FROM emp
        WHERE TO_CHAR(hireDate,'D')=2;

--Q] emp ���̺� 990712-2
--    �� ��� �÷� : empNo, name, rrn, birth, age, �ټӳ��
--    �� ����
--        - �ټӳ���� 10�� �̻��� ����� ���
--        - birth�� rrn�� �̿��ϸ� �⵵4�ڸ�-��-�� ���
--        - age�� rrn�� �̿�
--        - �ټӳ�� �������� ���
--        - �ټӳ���� hireDate�� �̿�
           
           WITH tb AS(
            SELECT empNo, name, rrn,
                CASE 
                    WHEN SUBSTR(rrn,8,1) IN(1,2,5,6) THEN TO_DATE('19'||SUBSTR(rrn,1,6),'YYYYMMDD')
                    WHEN SUBSTR(rrn,8,1) IN(3,4,7,8) THEN TO_DATE('20'||SUBSTR(rrn,1,6),'YYYYMMDD')
                    ELSE TO_DATE('18'||SUBSTR(rrn,1,6),'YYYYMMDD')
                END birth
                , TRUNC(MONTHS_BETWEEN(SYSDATE,hireDate)/12) �ټӳ��
            FROM emp
            )SELECT empNo, name, rrn, TO_CHAR(birth,'YYYY-MM-DD') birth,
                TRUNC(MONTHS_BETWEEN(SYSDATE,birth)/12) age
                , �ټӳ��
            FROM tb
            ORDER BY �ټӳ�� DESC;


--Q] emp ���̺�
--    �� ��� �÷� : empNo, name, city
--    �� ���� 
--       - name�� �̾��� �ƴ� �ڷḸ ���
        SELECT empNo, name, city
        FROM emp
        WHERE SUBSTR(name,1,1) != '��';
        
        --(�����)
        SELECT empNo, name, city
        FROM emp
        WHERE INSTR(name,'��') != 1;


--Q] emp ���̺�
--    �� ��� �÷� : empNo, name, dept, pos
--    �� ����
--       - �μ�(dept)�� ������������ ����ϰ� �μ��� ������ ����(pos)�� ���������� ���
--         ����, ����, �븮, ���
        SELECT empNo, name, dept, pos
        FROM emp
        ORDER BY dept,
            CASE pos
                WHEN '����' THEN 0
                WHEN '����' THEN 1
                WHEN '�븮' THEN 2
                ELSE 3
            END ;
    
--Q] emp ���̺�
--    �� ��� �÷� :  name, dept, sal, bonus, tot_pay, tax, pay
--    �� ����
--       - tot_pay = sal+bonus
--       - tax
--         tot_pay�� 300���� �̻��̸� tot_pay�� 3%
--         tot_pay�� 250���� �̻��̸� tot_pay�� 2%
--         �׷��� ������ 0
--         tax�� �Ҽ��� ù°�ڸ����� �ݿø� �Ѵ�.
--       - pay = tot_pay - tax
--       - pay�� ��ȭ��ȣ�� ���δ�.
--       - pay�� �����ڸ����� 1�� �̻��̸� ������ �ø���. --  4�� ���ؼ�
--         ���� ��� 1000002�̸� 1000010 ���
        WITH tb AS(
            SELECT name, dept, sal, bonus, sal+bonus tot_pay, 
                CASE
                    WHEN sal+bonus >= 3000000 THEN ROUND((sal+bonus)*0.03)
                    WHEN sal+bonus >= 2500000 THEN ROUND((sal+bonus)*0.02)
                    ELSE 0
                END AS tax
            FROM emp
            )
            SELECT name, dept, sal, bonus, tot_pay, tax, 
            TO_CHAR(ROUND((tot_pay-tax)+4,-1), 'L9,999,999') pay
            FROM tb;
    

--Q] emp ���̺�
--    �� ��� �÷� : empNo, name, dept, pos, ����
--    �� ����
--       - dept�� ���ߺ��̰� pos�� �����̰ų� dept�� �ѹ����̰� pos�� ������ ��� ���
--       - ������ rrn�� �̿��Ѵ�.
        --(1)
        SELECT empNo, name, dept, pos,
            CASE 
                WHEN MOD(SUBSTR(rrn,8,1),2)=1  THEN '����'
                ELSE '����'
            END ����
        FROM emp
        WHERE (dept='���ߺ�' AND pos = '����') OR (dept='�ѹ���' AND pos = '����');
      
        --(2)
        SELECT empNo, name, dept, pos,
            CASE 
                WHEN MOD(SUBSTR(rrn,8,1),2)=1  THEN '����'
                ELSE '����'
            END ����
        FROM emp
        WHERE (dept, pos) IN(('���ߺ�','����'),('�ѹ���','����'));  


--Q] emp ���̺�
--    �� ��� �÷� : empNo, name, sal
--    �� ����
--       - sal�� 2500000~3000000�� ����
        
        --(�����)
        SELECT empNo, name, sal
        FROM emp
        WHERE NOT(sal < 2500000 OR sal > 3000000);

        SELECT empNo, name, sal
        FROM emp
        WHERE NOT(sal >= 2500000 AND sal <= 3000000);   --NOT ����


--Q] emp ���̺�
--    �� ��� �÷� :  empNo, name, city
--    �� ����
--       - city�� '����', '��õ', '���' �� ����
--       - city ��������
        SELECT empNo, name, city
        FROM emp
        WHERE city NOT IN ('����', '��õ', '���')
        ORDER BY city;
        
        
--Q] emp ���̺�
--    �� ��� �÷� :  empNo, name, sal
--    �� ����
--       - sal �������� �����Ͽ� 11��°���� 20��° ���ڵ常 ���
        
        SELECT empNo, name, sal FROM(
            SELECT ROWNUM rnum, tb.* FROM(
                SELECT empNo, name, sal
                FROM emp
                ORDER BY sal DESC
            )tb WHERE ROWNUM <=20
        )WHERE rnum >=11;
   
    --> ROWNUM : WHERE ������ ũ�ٷ� �� X , 1�̻��� ���� ���� �� X

--Q] emp ���̺�
--    �� ��� �÷� :  empNo, name, sal
--    �� ����
--       - �̸�(������)�� '��' �̶�� �ܾ ���ԵǾ� �ִ� ��� ��� ���
      SELECT empNo, name, sal
      FROM emp
      WHERE INSTR(name, '��') > 0;


--Q] emp ���̺�
--    �� ��� �÷� :  dept, pos
--    �� dept, pos�� �ߺ��� �����Ͽ� ���
        SELECT DISTINCT dept, pos
        FROM emp;
        
--Q] emp ���̺�
--    �� ��� �÷� : name, city
--    �� LIKE�� �̿��Ͽ� �̾��� �ƴ� �ڷḸ ���
        SELECT name, city
        FROM emp
        WHERE name NOT LIKE ('��%');
        
--Q] emp ���̺�
--    �� ��� �÷� : name, city
--    �� INSTR�� �̿��Ͽ� �̾��� �ƴ� �ڷḸ ���
        SELECT name, city
        FROM emp
        WHERE INSTR(name,'��') != 1;


--Q] emp ���̺�
--    �� ��� �÷� : name, rrn, dept, sal
--    �� ���ڸ� ���� ����ϰ� ���ڸ� ����ϸ� ������ ������ sal ������������ ���
        SELECT name, rrn, dept, sal
        FROM emp
        ORDER BY MOD(SUBSTR(rrn,8,1),2) DESC, sal;
        
        
--Q] emp ���̺�
--    �� ��� �÷� : name, hireDate
--    �� city�� ������ ��� �� �ٹ� ���� ���� 60���� �̻��� ����� ���
        SELECT name,hireDate
        FROM emp
        WHERE city = '����' AND MONTHS_BETWEEN(SYSDATE, hireDate)>=60;
        
--Q] emp ���̺�
--    �� ��� �÷� : name, city, tel
--    �� tel�� NULL�� �ڷḸ ���
        SELECT name, city, tel
        FROM emp
        WHERE tel IS NULL;
    
    
--Q] emp ���̺�
--    �� ��� �÷� : name, city, tel
--    �� tel�� NULL�� ��� '000-0000-0000' ���� ���
        SELECT name,city, NVL(tel,'000-0000-0000') tel
        FROM emp;     
        
--Q] emp ���̺�
--    �� ��� �÷� : name, city, tel
--    �� tel�� NULL�� �ƴ� �ڷḸ ���
        SELECT name, city, tel
        FROM emp
        WHERE tel IS NOT NULL;
        
--Q] emp ���̺�
--    �� ��� �÷� : name, city, tel
--    �� tel�� null�� �ڷḦ ���� ���
        SELECT name, city, tel
        FROM emp
        ORDER BY tel NULLS FIRST;
        
--Q] emp ���̺�
--    �� ��� �÷� : name, hireDate
--    �� �Ի����ڰ� �������� ����� ���
        SELECT name, TO_CHAR(hireDate,'YYYY-MM-DD DAY')
        FROM emp
        WHERE TO_CHAR(hireDate,'DAY') = '������'; 
         
        --(2)        
        SELECT name, TO_CHAR(hireDate,'YYYY-MM-DD DAY')
        FROM emp
        WHERE TO_CHAR(hireDate,'D') = 2;
        
        --(3)
        SELECT name, TO_CHAR(hireDate,'YYYY-MM-DD DAY')
        FROM emp
        WHERE TO_CHAR(hireDate,'DY') = '��';
        
--Q] emp ���̺�
--    �� ��� �÷� : name, hireDate
--    �� �Ի������� ���ڰ� 1��~5���� ����� ���
        SELECT name, hireDate
        FROM emp
        WHERE TO_CHAR(hireDate,'DD')<=5;
        
        
--Q] dual ���̺�
--    �� ��� �÷� : ����
--    �� ����ð����� '2023-04-12 09:00:00' ������ ���̸� ������ ȯ���Ͽ� ���
        SELECT TRUNC((TO_DATE('2023-04-12 09:00:00','YYYY-MM-DD HH24:MI:SS')-SYSDATE)*24*60)||'��' ����
        FROM dual;
        
--Q] dual ���̺�
--    �� ��� �÷� : ���۳�¥
--    �� ������ ���۳��� ���(������ 1�� 0�� 0�� 0��)
--    �� ��� �� : 2023/04/01 00:00:00
        SELECT TO_CHAR(TRUNC((SYSDATE+(INTERVAL '1'MONTH)),'MONTH'),'YYYY-MM-DD HH24:MI:SS') ���۳�¥
        FROM dual;
   
        --(�����)
        SELECT TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,1),'MM'),'YYYY-MM-DD HH24:MI:SS') ���۳�¥
        FROM dual;    
--Q] tbs ���̺�
--    �� ��� �÷� : name, tel
--    �� ���� �������� name�� ù���ڿ� ������ ���ڸ� ������ ������ ���ڴ� *�� ġȯ�Ͽ� ����ϵ��� ������ ����
--       : "��ȣ" ó�� �̸��� ������ ���� "��*ȣ" ó�� ����ϰ� �������� �ش� ���ڸ�ŭ *�� ġȯ�Ѵ�.
--       : "��ȣȣ��"�� "��**��"ó�� ����Ѵ�.
           
           
     -- NVL ����ؼ� �ٽ� Ǯ��� --       
WITH tbs AS (
   SELECT '��ȣ' name, '010-1234-4125' tel FROM dual UNION ALL
   SELECT '�����ѹα�' name, '010-1234-6524' tel FROM dual UNION ALL
   SELECT '������' name, '010-485-8574' tel FROM dual UNION ALL
   SELECT 'ȫ�浿' name, '02-235-4125' tel FROM dual UNION ALL
   SELECT '�̹�' name, '031-4582-4125' tel FROM dual
)
SELECT
CASE 
    WHEN LENGTH(name)<=2 THEN SUBSTR(name,1,1)||'*'||SUBSTR(name,LENGTH(name),1)
    WHEN LENGTH(name)>2 THEN SUBSTR(name,1,1)||LPAD('*',LENGTH(name)-2,'*')||SUBSTR(name,LENGTH(name),1)
END �̸�

, tel FROM tbs;




--Q] tbs ���̺�
--    �� ��� �÷� : name, tel
--    �� ���� �������� tel�� ������ �ڸ��� ��ŭ *�� ġȯ�Ͽ� ����ϵ��� ������ �����Ѵ�.
--    �� ���� ��� "010-1111-1111"�� "010-****-1111"�� ����Ѵ�.       

WITH tbs AS (
   SELECT '��ȣ' name, '010-1234-4125' tel FROM dual UNION ALL
   SELECT '�����ѹα�' name, '010-1234-6524' tel FROM dual UNION ALL
   SELECT '������' name, '011-485-8574' tel FROM dual UNION ALL
   SELECT 'ȫ�浿' name, '02-235-4125' tel FROM dual UNION ALL
   SELECT '�̹�' name, '031-4582-4125' tel FROM dual
)
SELECT name, 
SUBSTR(tel,1,INSTR(tel,'-'))||TRANSLATE(SUBSTR(tel,INSTR(tel,'-',1,1)+1,INSTR(tel,'-',1,2)- INSTR(tel,'-',1,1)-1),'0123456789','**********')
|| SUBSTR(tel,INSTR(tel,'-',1,2)) "������ *�� ġȯ�� ��ȣ"
FROM tbs;

--Q] emp ���̺�
--    �� ��� �÷� : name, rrn
--    �� rrn�� ���� �������ʹ� *�� ���
--       SUBSTR(), LPAD() �Լ��� �̿�
--    �� rrn�� ���� �������ʹ� *�� ���. ���� ��� "010101-1111111" �� "010101-1******"      
        SELECT name,
            RPAD(SUBSTR(rrn,1,8),14,'*')
        FROM emp;

--Q] emp ���̺�
--    �� ��� �÷� : name, tel
--    �� tel �� ��ȭ��ȣ ������(-)�� ������� �ʴ´�.
        SELECT name, REPLACE(tel,'-')
        FROM emp;