-- �� EMP ���̺� : ���÷���(EMPLOYEE, ���) ������ ���� ���̺�
 -- �� �÷� ����
     empNo : �����ȣ
     name : �̸�
     rrn : �ֹι�ȣ
     hireDate : �Ի���
     city : ��ŵ�
     tel : ��ȭ��ȣ
     dept : �μ���
     pos : ����
     sal : �޿�
     bonus : ���ʽ�


-- �� SELECT ���� �̿��� ��ȸ
 -- �� SELECT ��
   -- �� ���̺� �Ǵ� ���� ��ü ���ڵ�(��) ���
     -- ������ ����
           SELECT 10*5 FROM dual;
           SELECT 10*5, 10/5 FROM emp;

           SELECT '��� : ' || 10*5 FROM dual;

     -- Ư�� �÷� �� ���(emp ���̺� : empNo, name, sal �÷�)
           SELECT �÷���, �÷��� FROM ���̺��;

     -- �÷�Ȯ��
           SELECT * FROM col WHERE tname = 'EMP';
           DESC emp;

     --  emp ���̺�
          SELECT empNo, name, sal FROM emp;          
          
          SELCET sal, name FROM emp;		

          SELCET no, name FROM emp;	--  ���� : ORA-00904  
        -- ????????????????????????????????????????????????????
        
        
     -- ���� ���
          SELECT empNo, name, sal+bonus From emp;
          SELECT name || '��', sal FROM emp;


     -- ��� �÷� ���(emp ���̺� : ��� �÷� ���)
          SELCET * FROM emp;


     -- �÷����� �����Ͽ� ���(emp ���̺� : empNo, name, sal �÷�)
          SELECT empNo AS ���, name AS �̸�, sal AS �⺻�� FROM emp;
          SELECT empNo ���, name �̸�, sal �⺻�� FROM emp;
          SELECT empNo "��  ��", name "��  ��", sal "�⺻��" FROM emp;
	     -- �÷����� ������ �ο��� �� AS�� ���� �����ϴ�.
	     -- �÷����� ������ �ο��� �� "(ū����ǥ)�� ����� �� �ִ�.
	     -- �÷����� ������ �ο��� �� '(��������ǥ)�� ����� �� ����.
	     -- �÷����� ������ �ο��Ҷ� ����, Ư������ ���� �����ϴ� ��쿡�� "(ū����ǥ)�� ����ؾ� �Ѵ�.
        
          -- �Ϲ������� ������ ����� �÷��� ������ �ο��Ѵ�. ������ �ο��ؾ� �ڹ� ��� ���� ���� �Ѱ� ���� �� �ִ�.
	SELECT empNo, name, sal, bonus, sal+bonus FROM emp;
 	SELECT empNo, name, sal, bonus, sal+bonus pay FROM emp;

     -- ���̺� �� ���� �ο�(emp ���̺� : ROWNUM�� ��� �÷� ���)
          -- ROWNUM : ������ ����� ������ ������ �࿡ ���� ���� ���� ��Ÿ���� �ǻ� �÷�

 	SELECT ROWNUM, empNo, name, sal FROM emp;
 	
 	SELECT ROWNUM, * FROM emp;    -- ���� : *�� �ٸ� �÷��� ���� ����� �� ����.


 	SELECT ROWNUM, emp.* FROM emp e;		-- ????????????????????????????????????????
 	SELECT ROWNUM, e.* FROM emp e;
	        -- ���̺� ���� �ο�
	        -- ���̺� ������ �ο��� ���� AS�� ����� �� ����


 -- �� ���ǽİ� ǥ����	
   -- SELECT �÷���, �÷��� FROM ���̺�� WHERE ����;

   -- �� �� ������ : =, >, <, <=, >=, <>, !=, ^=
     -- emp ���̺� : city�� ������ �ڷ� �� name, city �÷� ���
SELECT name, city
FROM emp 
WHERE city = '����'



     -- emp ���̺�: city�� ������ �ƴ� �ڷ� �� name, city �÷� ���(<>, !=, ^=)
SELECT name, city
FROM emp 
WHERE city <> '����';

SELECT name, city
FROM emp 
WHERE city !='����';

SELECT name, city
FROM emp 
WHERE city ^='����';

     -- emp ���̺� : sal+bonus �� 2500000�� �̻��� �ڷ� �� name, sal, bonus �÷� ���
SELECT name, sal, bonus
FROM emp 
WHERE sal+bonus >=2500000;

     -- emp ���̺� : sal+bonus �� 2500000�� �̻��� �ڷ� �� name, sal, bonus, sal+bonus �÷� ���
	     -- sal+bonus ����� pay��� �̸����� ���
SELECT name, sal, bonus, sal+bonus pay
FROM emp 
WHERE pay >=2500000;	-- ���� : ORA-00904
    -- 1) FROM �����м�
    -- 2) WHERE �����м� -> emp ���̺��� pay�÷��� �����Ƿ� ����
    -- 3) SELECT �����м�

SELECT name, sal, bonus, sal+bonus pay
FROM emp 
WHERE sal+bonus >=2500000;




   -- �� �� ������ : AND, OR, NOT
     -- emp ���̺� : city�� �����̰� sal�� 2000000�� �̻��� �ڷ� �� empNo, name, city, sal �÷� ���
SELECT empNo, name, city, sal 
FROM emp 
WHERE city='����' and sal >=2000000;

     -- emp ���̺� : city�� ����, ���, ��õ�� �ڷ� �� empNo, name, city, sal �÷� ���
SELECT empNo, name, city, sal 
FROM emp 
WHERE city='����' OR city='���' OR city='��õ';         

     -- emp ���̺� : sal�� 2000000~3000000�� ������ �ڷ� �� empNo, name, sal �÷� ���
SELECT empNo, name, sal 
FROM emp          
WHERE (sal < 2000000) OR (sal >3000000);

SELECT empNo, name, sal 
FROM emp          
WHERE NOT(sal >=2000000 AND sal <=3000000);

 ---------------------------------------------------------------------------
     -- emp ���̺� : ������ '��'���� empNo, name, sal �÷� ���
SELECT empNo, name, city, sal 
FROM emp 
WHERE name > '��' AND name<'��';

     -- emp ���̺� : dept�� '���ߺ�' �̰� pos�� '����'�� empNo, name, dept, pos, sal �÷�
SELECT empNo, name, dept, pos, sal 
FROM emp 
WHERE dept='���ߺ�' AND pos='����'

     -- emp ���̺� : sal�� 2000000~3000000 �� ��� �� city�� ���� �Ǵ� ����� empNo, name, city, sal �÷�
SELECT empNo, name, city, sal 
FROM emp 
WHERE sal >=2000000 AND sal <=3000000 AND (city='����' or city='���')
					-- �ݵ�� ��ȣ AND�����ڰ� �켱������!

     -- emp ���̺� : dept�� '���ߺ�' ����� pos�� '�븮' �Ǵ� '����'�� empNo, name, dept, pos, sal �÷�
SELECT empNo, name, city, sal 
FROM emp 
WHERE dept='���ߺ�' and (pos = '�븮' OR  pos = '����');



   -- �� �׷� �� ������ : ANY(SOME), ALL
        -- ANY(SOME) : OR�� ����, ALL : AND ����

     -- emp ���̺� : city�� '����', '���', '��õ' �� �ڷ� �� empNo, name, city �÷� ���
SELECT empNo, name, city
FROM emp 
WHERE city = ANY('����', '���', '��õ'); 

     -- emp ���̺� : sal�� 2000000�� �̻��� �ڷ� �� empNo, name, sal �÷� ���
SELECT empNo, name, sal
FROM emp 
WHERE sal >= ANY(2000000, 25000000, 300000);  -- > ����?

SELECT empNo, name, sal
FROM emp 
WHERE sal >= 2000000; 

     -- emp ���̺� : sal�� 3000000�� �̻��� �ڷ� �� empNo, name, sal �÷� ���
SELECT empNo, name, sal
FROM emp 
WHERE sal >= ALL(2000000,2500000,3000000);          

SELECT empNo, name, sal
FROM emp 
WHERE sal >= 3000000; 


   -- �� SQL ������
     -- 1) BETWEEN ���ǽ�
         -- emp ���̺� : sal�� 2000000~3000000 ���� �� �ڷ� �� name, sal �÷� ���
SELECT name, sal
FROM emp
WHERE sal >=2000000 AND sal <=3000000;

SELECT name, sal
FROM emp
WHERE sal BETWEEN 2000000 AND 3000000;

         -- emp ���̺� : sal�� 2000000~3000000�� ������ �ڷ� �� name, sal �÷� ���
SELECT name, sal
FROM emp
WHERE NOT sal BETWEEN 2000000 AND 3000000;	// > ���ϰ� ��¥ ���ϴ�.

SELECT name, sal
FROM emp
WHERE sal < 2000000 OR sal > 3000000;

         -- emp ���̺� : hireDate�� 2022�⵵�� �ڷ��� name, hireDate �÷� ���
SELECT name, hireDate
FROM emp
WHERE hireDate BETWEEN '2022-01-01' AND '2022-12-31';

-- �̰� ���� ����� ���� ��.
SELECT name, hireDate
FROM emp
WHERE TO_CHAR(hireDate, 'YYYY') = 2022;


     -- 2) IN ���ǽ� : list�� �ִ� �� �� �ϳ��� ��ġ�ϸ� TRUE

         -- emp ���̺� : city�� '����', '��õ', '���' ��  �ڷ� �� name, city �÷� ���
SELECT empNo, name, city
FROM emp 
WHERE city = '����' OR city = '��õ' OR city = '���';

SELECT name, city
FROM emp 
WHERE city IN('����', '���', '��õ'); 

         -- emp ���̺� : city�� '����', '��õ', '���' �� ������  �ڷ� �� name, city �÷� ���
SELECT name, city
FROM emp 
WHERE city NOT IN('����', '���', '��õ');  

         -- emp ���̺� : city�� pos�� '����  �̸鼭 '����'�̰ų� '���' �̸鼭 '����' �� �ڷ� �� name, city, pos �÷� ���
SELECT name, city, pos
FROM emp 
WHERE (city ='����' AND pos = '����') OR (city ='���' AND pos = '����');

SELECT name, city, pos
FROM emp 
WHERE (city, pos) IN (('����','����'),('���','����'));


         -- emp ���̺� : city�� pos�� '����' �̸鼭 '����' �� �ڷ� �� name, city, pos �÷� ���(subquery)
SELECT name, city, pos
FROM emp
WHERE (city,pos) IN (('����','����'))


     -- 3) LIKE ���ǽ�
             -- �־��� ���ڿ��� ���ϰ� ��ġ�ϴ��� ���� Ȯ��
             -- '%' : �������� ����(0~N),  '_' : �ѹ��� ����
             -- ���ڿ� ó���� ����Ŭ ���� �˰���� LIKE ���ٴ� INSTR()�� �� ������ ó��


         -- emp ���̺� : name�� '��'����  �ڷ� �� empNo, name �÷� ���
                SELECT empNo, name
                FROM emp
                WHERE name LIKE '��%';

         -- emp ���̺� : LIKE ��           
                SELECT empNo, name,tel
                FROM emp
                WHERE tel LIKE '%3%';	-- 3 �� �����ϴ� ��ȭ��ȣ

                SELECT empNo, name,tel
                FROM emp
                WHERE tel LIKE '%3';		-- 3���� ������ ��ȭ��ȣ

                SELECT empNo, name, rrn
                FROM emp
                WHERE rrn LIKE '_0%';	-- ������Ͽ��� �⵵�� 10�� ����� ���

                SELECT empNo, name, tel
                FROM emp
                WHERE tel LIKE '%3%' OR tel LIKE '%5%';	-- 3�Ǵ� 5�� �ִ� ��ȭ��ȣ


         -- �ֹι�ȣ(rrn)�� �̿��Ͽ� 3���� ����� ����, ��� ���(name, rrn, city)
                SELECT name, rrn, city
                FROM emp
                WHERE rrn LIKE'__03%' AND (city IN('����','���'));
            

         -- ESCAPE
               --  '%' �� '_'�� ���Ե� �����͸� �˻��� �� ���
              
              SELECT �÷���, �÷���
              FROM ���̺��
              WHERE �÷��� LIKE '%_%';	// 1���ڴ� �ݵ�� �־����.

              SELECT �÷���, �÷���
              FROM ���̺��
              WHERE �÷��� LIKE '%#_%' ESCAPE '#'  	-- _�� ������ �ƴ�.     -- WHERE �÷��� LIKE '%@_%' ESCAPE '@'�� ���� �ǹ�
	-- ESCAPE�� ������ '#' �ڿ� ���� ���Ϲ��ڸ� �Ϲ� ���ڷ� �ؼ��Ѵ�.				
	-- '%#_%'���� _�� ������ �ƴ� �˻��� ����
	-- ESCAPE�� ����� ���ڴ� 1byte �ƹ��ų� ��� ����
   
         -- WITH : �ݺ������� ���Ǵ� ������ ��ȭ �� ��� ���
            WITH tb AS (
                SELECT '������' name, '�츮_����' content  FROM dual
                UNION ALL
                SELECT '������' name, '�ڹ�%������' content  FROM dual
                UNION ALL
                SELECT '�ٴٴ�' name, '�츮����' content  FROM dual
                UNION ALL
                SELECT '����' name, '�����' content  FROM dual
                UNION ALL
                SELECT '������' name, '�ȵ���̵�%�����' content  FROM dual
            ) 
            SELECT * FROM  tb;

         --  content�� '��%'�� �ִ� ���ڵ� �˻�
            WITH tb AS (
                SELECT '������' name, '�츮_����' content  FROM dual
                UNION ALL
                SELECT '������' name, '�ڹ�%������' content  FROM dual
                UNION ALL
                SELECT '�ٴٴ�' name, '�츮����' content  FROM dual
                UNION ALL
                SELECT '����' name, '�����' content  FROM dual
                UNION ALL
                SELECT '������' name, '�ȵ���̵�%�����' content  FROM dual
            ) 
            SELECT * FROM  tb
            WHERE  content LIKE '%��#%%' ESCAPE '#' ;


            WITH tb AS (
                SELECT '������' name, '�츮_����' content  FROM dual
                UNION ALL
                SELECT '������' name, '�ڹ�%������' content  FROM dual
                UNION ALL
                SELECT '�ٴٴ�' name, '�츮����' content  FROM dual
                UNION ALL
                SELECT '����' name, '�����' content  FROM dual
                UNION ALL
                SELECT '������' name, '�ȵ���̵�%�����' content  FROM dual
            ) 
            SELECT * FROM  tb
            WHERE  INSTR (content,'��%') >=1 ;	-- ����Ŭ �ε����� 1���� ����



-- (2023-02-28)  --
   -- �� NULL
	   -- '' �� null
       -- emp ���̺� : tel�� NULL �� �ڷ� �� name, tel �÷� ���
		   SELECT name, tel FROM emp WHERE tel = NULL; (X)
		   
		   SELECT name, tel FROM emp WHERE tel IS NULL;
	
       -- emp ���̺� : tel�� NULL �ƴ� �ڷ� �� name, tel �÷� ���
		   SELECT name, tel FROM emp WHERE tel IS NOT NULL;
		
	   -- ���ǻ���
			SELECT 10+NULL FROM dual ;
			  -- null

   -- �� CASE ǥ����(Expressions) �� DECODE �Լ�
      -- 1) CASE ǥ����
	        -- ���ǿ� ���� �ٸ� ����� ��ȯ.
			-- DECODE ���� ������ ���  

      -- 2) ����1 : ������ CASE ǥ����
          SELECT name, rrn, SUBSTR(rrn, 8, 1) FROM emp;
		  SELECT MOD(14,8) FROM dual; -- ������

		  SELECT name, rrn, 
		    CASE SUBSTR(rrn, 8, 1)   -- > �ڹ��� switch ���� ����
			   WHEN '1' THEN '����'		 -- WHEN 1�� ����(Ÿ���� ��ġ�ؾ� ��)  > ���ڷ� ǥ�� ����
			   WHEN '2' THEN '����'		
			   WHEN '3' THEN '����'
			   WHEN '4' THEN '����'
			END AS ����
		  FROM emp;
		
		SELECT name, rrn,		
		CASE MOD(SUBSTR(rrn, 8, 1),2)   
			   WHEN 0 THEN '����'	
			   WHEN 1 THEN '����'		
			END AS ����
		  FROM emp;
		  
      -- 3) ����2 : ���� CASE ǥ����
          -- ���(empNo), name, sal+bonus, tax
		     -- ���� : �� �޿��� 3000000 �̻��̸� 3%, �� �޿��� 2500000 �̻��̸� 2%, ������ 0
			
			SELECT empNo, name, sal+bonus ��ü�޿�, 
				CASE
					WHEN  sal+bonus >= 3000000 THEN (sal+bonus) *0.03
					WHEN  sal+bonus >= 2500000 THEN (sal+bonus) *0.02
					ELSE 0
				END "����"
			FROM emp;
			 
		  
     -- 4) DECODE �Լ�
			-- DECODE(a, 'b', 1)
				- a �׸� ���� 'b' �̸� 1�� ��ȯ�ϰ� 'b'�� �ƴϸ� NULL�� ��ȯ
			-- DECODE(a, 'b', 1, 2)
				- a �׸� ���� 'b' �̸� 1�� ��ȯ�ϰ� 'b'�� �ƴϸ� 2�� ��ȯ
			-- DECODE(a, 'b', 1, 'c', 2)
				- a �׸� ���� 'b' �̸� 1�� ��ȯ�ϰ� 'c'�̸� 2�� ��ȯ�ϸ� 'b'�Ǵ� 'c'�� �ƴϸ� NULL�� ��ȯ
			-- DECODE(a, 'b', 1, 'c', 2, 3)
				- a �׸� ���� 'b' �̸� 1�� ��ȯ�ϰ� 'c'�̸� 2�� ��ȯ�ϸ� 'b'�Ǵ� 'c'�� �ƴϸ� 3�� ��ȯ
	
			SELECT name, rrn, DECODE(SUBSTR(rrn,8,1),1,'����') ���� FROM emp;
					-- ������ 1�̸� ����, �׷��� ������ NULL
			
			SELECT name, rrn, DECODE(SUBSTR(rrn,8,1),1,'����','����') ���� FROM emp;
					-- ������ 1�̸� '����', �׷��� ������ '����' , ���� 3�� '����'
					
			SELECT name, rrn, DECODE(SUBSTR(rrn,8,1),1,'����',2,'����',3,'����',4,'����') ���� FROM emp;
					-- ���� 5,6,7,8�� null		
						
			SELECT name, rrn, DECODE(MOD(SUBSTR(rrn,8,1),2),1,'����','����') ���� FROM emp;		
					
 -- �� SELECT ������ ALL �� DISTINCT �ɼ�
   -- �� ALL �ɼ� : ���õ� ��� �� ��ȯ, ���� ����
		SELECT ALL dept FROM emp;
		SELECT dept FROM emp;

   -- �� DISTINCT | UNIQUE �ɼ� : ���õ� �� �߿��� �ߺ����� ���� �ϳ��� ��ȯ
		SELECT DISTINCT dept FROM emp;
		SELECT UNIQUE dept FROM emp;

		SELECT DISTINCT dept,pos FROM emp;

 -- �� SELECT ������ ORDER BY ��
	 -- ASC : ��������(���� ����), DESC : ��������

     -- ���� ��
		SELECT name, dept, sal FROM emp;
		
		SELECT name, dept, sal FROM emp ORDER BY sal; -- ��������
		SELECT name, dept, sal FROM emp ORDER BY sal ASC; -- sal ��������
		SELECT name, dept, sal FROM emp ORDER BY sal DESC;  -- sal ��������
		
     -- dept �������� �����ϰ� dept�� ������ sal �������� ��� : name, rrn, dept, sal
	 		SELECT name, rrn, dept, sal FROM emp ORDER BY dept,sal DESC;
	 
	 -- dept �������� �����ϰ� dept�� ������ sal �������� ��� : name, rrn, dept, sal
	 		SELECT name, rrn, dept, sal FROM emp ORDER BY dept DESC,sal DESC;
	
	 -- dept �������� �����ϰ� dept�� ������ sal �������� ��� : name, rrn, dept, sal
	 		SELECT name, rrn, dept, sal FROM emp ORDER BY dept DESC,sal;		
			
	 -- sal+bonus �������� ��� : name, rrn, dept, sal, bonus, sal+bonus pay
			SELECT name, rrn, dept, sal, bonus, sal+bonus pay
			FROM emp
			ORDER BY sal+bonus ASC;
			
			SELECT name, rrn, dept, sal, bonus, sal+bonus pay
			FROM emp
			ORDER BY pay DESC;
				-- FROM -> WHERE -> SELECT -> ORDER BY ���� ������ �����ϹǷ� �������� ���� ����
				-- > ORDER BY�� �ڴϱ� ! WHERE�� ���� ��� �ȵ�.
		
			SELECT name, rrn, dept, sal, bonus, sal+bonus pay
			FROM emp
			ORDER BY 6 DESC;	--> ���� �ᵵ ����. (6��° : sal+bonus)
			
	 -- ���� �� city ��������, city�� ������ sal �������� : name, rrn, city, dept, sal, bonus
			SELECT name, rrn, city, dept, sal, bonus
			FROM emp
			WHERE MOD(SUBSTR(rrn, 8, 1), 2) =1
			ORDER BY city, sal DESC;
	
	 -- dept �������� �����ϰ� dept�� ������ ���ڸ� ���� ��� : name, rrn, dept, sal	
			SELECT name, rrn, dept, sal
			FROM emp
			ORDER BY dept, MOD(SUBSTR(rrn, 8, 1), 2) DESC;
	
	 -- dept�� �����θ� ���� ��� : name, dept
			SELECT name, dept, CASE WHEN dept = '������' THEN 0 END
			FROM emp
			ORDER BY dept;
	 
			SELECT name, dept
			FROM emp
			ORDER BY CASE WHEN dept = '������' THEN 0 END;
				-- �������� ���Ŀ��� NULL�� �Ʒ� ���
	
     -- pos �� ����, ����, �븮, ��������� ��� : name, dept, pos
			SELECT name, dept, pos
			FROM emp
			ORDER BY
				CASE  
					WHEN pos ='����' THEN 1
					WHEN pos ='����' THEN 2
					WHEN pos ='�븮' THEN 3
					WHEN pos ='���' THEN 4
				END;
				
			SELECT name, dept, pos
			FROM emp
			ORDER BY DECODE(pos,'����',0,'����',1,'�븮',2,'���',3);

     -- ���ڸ� ���� ����ϰ� ������ �����ϸ� sal �������� : name, rrn, sal
			SELECT name, rrn, sal
			FROM emp
			ORDER BY MOD(SUBSTR(rrn,8,1),2), sal DESC;

     -- ���� ����� ����ϸ�, �⺻��+���� ������������ ���� : name, city, sal+bonus
			SELECT name, city, sal+bonus pay
			FROM emp
			WHERE city = '����'
			ORDER BY pay DESC;

     -- ���ڸ� ����ϸ�, �μ������������� �����ϰ� �μ��� ������ �⺻�� �������� ���� : name, rrn, dept, sal
			SELECT name, rrn, dept, sal
			FROM emp
			WHERE MOD(SUBSTR(rrn, 8,1),2) =0
			ORDER BY dept, sal DESC;

		
     -- ��ȭ��ȣ�� NULL �� �����͸� ���� ���
			SELECT name, tel FROM emp;
			SELECT name, tel FROM emp ORDER BY tel NULLS FIRST;

     -- ��ȭ��ȣ�� NULL �� �����͸� ���߿� ���
			SELECT name, tel FROM emp ORDER BY tel NULLS LAST;

	 -- �����θ� ���� �������� ��� : name, dept, pos
			SELECT name, dept, pos
			FROM emp
			ORDER BY CASE WHEN dept='������' THEN 0 END DESC;
			
			SELECT name, dept, pos
			FROM emp
			ORDER BY CASE WHEN dept='������' THEN 0 END NULLS FIRST;

			SELECT name, dept, pos
			FROM emp
			ORDER BY DECODE(dept,'������',0) NULLS FIRST;
                      -- dept�� �����θ� 0 ��ȯ
			
	--------------------------------------------------------------
	 -- ���� �߻�
		SELECT DBMS_RANDOM.VALUE FROM dual;
			
	 -- ������ ������ �ٸ� ���
		SELECT empNo, name, dept, pos 
		FROM emp 
		ORDER BY DBMS_RANDOM.VALUE;
	 
	 -- �����ϰ� 5���� �����ϱ� : �̺�Ʈ ��÷
		SELECT * FROM(
			SELECT empNo,name,dept,pos 
			FROM emp 
			ORDER BY DBMS_RANDOM.VALUE
		)WHERE ROWNUM<=5;--����Ŭ 11G���

		SELECT empNo,name,dept,pos 
		FROM emp 
		ORDER BY DBMS_RANDOM.VALUE
		FETCH FIRST 5 ROWS ONLY;--����Ŭ12C�̻�
	 
	 
 -- �� ���� ������(Set Operators)
     -- UNION : ������, �������� �� ���� ���
		SELECT name, city, dept FROM emp WHERE dept='���ߺ�'
			UNION 
		SELECT name, city, dept FROM emp WHERE city = '��õ';
        
     -- UNION ALL
		SELECT name, city, dept FROM emp WHERE dept='���ߺ�'
			UNION ALL
		SELECT name, city, dept FROM emp WHERE city = '��õ'
		ORDER BY city;
		
		-- �÷��� ����, �� �÷��� �ڷ����� ��ġ�ϸ� ����
		SELECT name, city, dept, sal FROM emp WHERE dept='���ߺ�'
			UNION ALL
		SELECT name, city, dept, bonus FROM emp WHERE city = '��õ'
		ORDER BY city;
				-- >  ���� �÷��� �����ְ� sal �κп� �Ʒ��� bonus �� ��

     -- MINUS : ������
		SELECT name, city, dept FROM emp WHERE dept='���ߺ�'
			MINUS
		SELECT name, city, dept FROM emp WHERE city = '��õ';
	 

     -- INTERSECT
		SELECT name, city, dept FROM emp WHERE dept='���ߺ�'
			INTERSECT
		SELECT name, city, dept FROM emp WHERE city = '��õ';

 -- �� pseudo �÷�(�ǻ� �÷�) : ����Ŭ ���������� ���Ǵ� �÷�
   -- �� ROWID : �࿡ ���� �ּ�, ���� �����ϰ� �ĺ�
		SELECT ROWID, name FROM emp;

   -- �� ROWNUM : ������ ����� ������ ��鿡 ���� ���� ��. ���� �÷� -> �� ���
            --> �տ� 1,2,3,4 �����°�
		
	-- ������ ����� ����
		SELECT empNo, name, sal FROM emp;
		
		SELECT empNo, name, sal FROM emp WHERE ROWNUM < 11;
					-- �տ� 10���� ���
		
	--���� �������� ū ROWNUM�� �׻� �����̴�.
		SELECT empNO, name, sal FROM emp WHERE ROWNUM > 1; 	-- �ƹ��͵� ��µ��� �ʴ´�.
																			--> ROWNUM�� ũ�ٷ� ���ؼ��� �ȵ�. �����͸� ������ �� �Ŀ� �����Ǳ� ����
	-- ORDER BY ���� �ִ� �������� ROWNUM�� ���ǿ� ����ϸ� �ǵ��ϴ� ����� ������ �ʴ´�.
		SELECT empNo, name, sal FROM emp
		WHERE ROWNUM < 11
		ORDER BY sal;	-- �̷��� �ϸ� �ȵ�
		
	-- ������������ ORDER BY ���� �����Ű�� ROWNUM ������ �ֻ��� �������� �����ϸ� ����
		SELECT * FROM (
			SELECT empNo, name, sal FROM emp
			ORDER BY sal
		) WHERE ROWNUM < 11;
										
	-- �������
		FROM�� -> WHERE �� -> ROWNUM �Ҵ� -> GROUP BY �� -> HAVING �� -> SELECT �� -> ORDER BY ��
		
		SELECT empNo,name, sal FROM emp;
		
		SELECT empNo,name, sal FROM emp WHERE ROWNUM > 10;	-- �ϳ��� ��� �ȵ�
		SELECT empNo,name, sal FROM emp WHERE ROWNUM = 10;	-- �ϳ��� ��� �ȵ�
        -- ????????????????????????????? �Ʒ���  ���� �޶� ???????????????????????????????
        
		SELECT empNo,name, sal FROM emp WHERE ROWNUM =1;	-- ����
		SELECT empNo,name, sal FROM emp WHERE ROWNUM <=10;	-- ����
		
	-- sal �������� �����ؼ� 10���� ��������
		SELECT * FROM(
			SELECT empNo, name, sal FROM emp
			ORDER BY sal DESC
		)WHERE ROWNUM <=10;
		
	-- sal �������� �����ؼ� 11~20��° ���ڵ� ��������
		SELECT empNo,name, sal FROM emp
		ORDER BY sal DESC;
		
		SELECT * FROM (
			SELECT empNo, name, sal FROM emp
			ORDER BY sal DESC
		) WHERE ROWNUM >=11 AND ROWNUM <=20;  -- �ϳ��� ��� �ȵ�
		
		SELECT ROWNUM rnum, tb.* FROM (
			SELECT empNo, name, sal FROM emp
			ORDER BY sal DESC
		) tb;
		
		SELECT ROWNUM rnum, tb.* FROM (
			SELECT empNo, name, sal FROM emp
			ORDER BY sal DESC
		) tb WHERE ROWNUM <=20;	-- ����
		
		
		=> �ݵ�� �ϱ�!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		=> ORDER BY���� ROWNUM ���� ��� X
		SELECT * FROM (				
			SELECT ROWNUM rnum, tb.* FROM(
				SELECT empNo, name, sal
				FROM emp
				ORDER BY sal DESC
			)tb WHERE ROWNUM <=20
		)WHERE rnum >=11;		--> rrum���� ���ͼ� >= ����
			-- ����Ŭ ����¡ ó�� ���, ������ ���
--------------------------------

-- > 2/27
SELECT 10*5 FROM emp;
SELECT 10*5 FROM dual;
SELECT 10*5, 10/5 FROM emp;

SELECT '��� : ' || 10*5 FROM dual;

SELECT * FROM col WHERE tname = 'EMP';
DESC emp;

SELECT empNo, name, sal FROM emp;     
SELECT sal, name FROM emp;
SELECT no, name FROM emp;

