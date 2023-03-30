-- �� SQL �Լ�
 -- �� ���� �Լ�(Aggregate Function)�� GROUP BY ��
    -- �� ���� �Լ�(Aggregate Function) ����
       -- COUNT( * ) : ���� 
       -- COUNT( DISTINCT | ALL ] expr )
          
          SELECT COUNT(*) FROM emp; -- ��ü���, 60
          SELECT COUNT(empNo) FROM emp;  -- 60
                -- empNo : �⺻Ű, NOT NULL �Ӽ��� �÷�                
          SELECT COUNT(tel) FROM emp;      -- 57. NULL�� ī��Ʈ���� �ʴ´�.
            -- ��ü ����� ���ϱ� ���ؼ��� COUNT�� *�� ����ϰų� NOT NULL �Ӽ��� �÷��� ����Ͽ� ����Ѵ�.
          
          SELECT empNo, COUNT(empNo) FROM emp; -- ����. �Ϲ��÷��� �����Լ��� �Բ� ����� �� ����.
          
          SELECT * FROM emp WHERE 1=2;  -- ���ٵ� ��µ��� ����
          SELECT COUNT(*) FROM emp WHERE 1=2;  -- 0, �����Ͱ� ��� COUNT�� 0�� ��ȯ
          
          -- ������ �ο���
          SELECT COUNT(*) FROM emp 
          WHERE city='����'; 
          
          -- ��ü �μ���
          SELECT dept FROM emp;
          SELECT DISTINCT dept FROM emp;
          
          SELECT COUNT(DISTINCT dept) FROM emp ;  -- �ߺ��� �����Ͽ� COUNT
          
          -- ��ü�ο���, �����ο���, �����ο���
          SELECT name, rrn, 
            DECODE(MOD(SUBSTR(rrn,8,1),2),1,'��'),
            DECODE(MOD(SUBSTR(rrn,8,1),2),0,'��')
          FROM emp;
          
          SELECT COUNT(*) ��ü,
          COUNT(DECODE(MOD(SUBSTR(rrn,8,1),2),1,'��')) ��,
          COUNT(DECODE(MOD(SUBSTR(rrn,8,1),2),0,'��')) ��
          FROM emp;
          
          SELECT COUNT(*) ��ü,
          COUNT(DECODE(MOD(SUBSTR(rrn,8,1),2),1,1)) ��,
          COUNT(DECODE(MOD(SUBSTR(rrn,8,1),2),0,1)) ��
          FROM emp;
          
          -- NULLIF(a,b) : a=b �̸� NULL, �׷��� ������ b
          SELECT name, rrn, MOD(SUBSTR(rrn,8,1),2),
                NULLIF(MOD(SUBSTR(rrn,8,1),2),1),
                NULLIF(MOD(SUBSTR(rrn,8,1),2),0)
          FROM emp;
          
          SELECT COUNT(*) ��ü,
                COUNT(NULLIF(MOD(SUBSTR(rrn,8,1),2),1)) ��,
                COUNT(NULLIF(MOD(SUBSTR(rrn,8,1),2),0)) ��
          FROM emp;
          
          -- �������� �����ο���
          --(1) WHERE���� �� �ĳ��� �̾Ƴ��� �ϴ°� ���� ����
          SELECT COUNT(*) ���ﳲ�ڼ�
          FROM emp
          WHERE city='����' AND (MOD(SUBSTR(rrn,8,1),2))=1;
          
          --(2)
          SELECT COUNT(DECODE(MOD(SUBSTR(rrn,8,1),2),1,1)) ���ﳲ�ڼ�
          FROM emp
          WHERE city='����';


          -- ��ü�ο���, �����ο���, �����ο���
             ����    �ο�
             ��ü    60
             ����    31
             ����    29
             
             SELECT '��ü' ����, COUNT(*)�ο� FROM emp
                UNION ALL
             SELECT '����' ����, COUNT(*) �ο� FROM emp WHERE MOD(SUBSTR(rrn,8,1),2)=1
                UNION ALL
             SELECT '����' ����, COUNT(*) �ο� FROM emp WHERE MOD(SUBSTR(rrn,8,1),2)=0
             ORDER BY �ο� DESC;
             
          
       -- MAX([ DISTINCT | ALL ] expr) : �ִ밪
       -- MIN([ DISTINCT | ALL ] expr) : �ּҰ�
        
        SELECT MAX(sal), MIN(sal) FROM emp;
        
        SELECT empNo, name, sal
        FROM emp
        WHERE sal = MAX(sal);   -- ����. �����Լ��� WHERE������ ����� �� ����.
        
        SELECT MAX(sal) FROM emp;
        
        SELECT empNo, name, sal
        FROM emp
        WHERE sal = (SELECT MAX(sal) FROM emp);    -- ��������
    

       -- AVG([ DISTINCT | ALL ] expr) : ���
       -- SUM([ DISTINCT | ALL ] expr): ��

            SELECT COUNT(sal),AVG(sal), SUM(sal), MAX(sal), MIN(sal) FROM emp;
            
            SELECT sal FROM emp WHERE 2 = 1; -- �� �ٵ� ��¾ȵ�
            
            SELECT COUNT(*) FROM emp WHERE 2 = 1;   -- 0
            SELECT SUM(sal) FROM emp WHERE 2 = 1;   -- NULL
            SELECT AVG(sal) FROM emp WHERE 2 = 1;   -- NULL
            
            SELECT NVL(AVG(sal),0) FROM emp WHERE 2=1; -- 0
            
            -- ��ü, ����, ���� �޿���
            SELECT SUM(sal) ��ü,    
                SUM(DECODE(MOD(SUBSTR(rrn,8,1),2),1,sal)) ��,
                SUM(DECODE(MOD(SUBSTR(rrn,8,1),2),0,sal)) ��
            FROM emp;
            
            SELECT AVG(sal) ��ü,    
                SUM(DECODE(MOD(SUBSTR(rrn,8,1),2),1,sal)) ��,
                SUM(DECODE(MOD(SUBSTR(rrn,8,1),2),0,sal)) ��
            FROM emp;
            
            -- �Ʒ��� ���� ������. ��, ����� 1���ڸ� ����
--                ����  ���
--                ��ü  ...
--                ����  ...
--                ����  ...
                
            SELECT '��ü' ����, TRUNC(AVG(sal),-1) ��� FROM emp
                UNION ALL
            SELECT '����' ����, TRUNC(AVG(sal),-1) ��� FROM emp WHERE MOD(SUBSTR(rrn,8,1),2)=1
                UNION ALL
            SELECT '����' ����, TRUNC(AVG(sal),-1) ��� FROM emp WHERE MOD(SUBSTR(rrn,8,1),2)=0;
            
            
            -- ���� �Ի��ο��� ���ϱ�
--                ��ü 1�� 2�� ... 12��
--                ..  ..  ..      ..
                SELECT COUNT(*) ��ü,
                    COUNT(DECODE(TO_CHAR(hireDate,'MM'),1,1)) "1��" ,
                    COUNT(DECODE(TO_CHAR(hireDate,'MM'),2,1)) "2��" ,
                    COUNT(DECODE(TO_CHAR(hireDate,'MM'),3,1)) "3��" ,
                    COUNT(DECODE(TO_CHAR(hireDate,'MM'),4,1)) "4��" ,
                    COUNT(DECODE(TO_CHAR(hireDate,'MM'),5,1)) "5��" ,
                    COUNT(DECODE(TO_CHAR(hireDate,'MM'),6,1)) "6��" ,
                    COUNT(DECODE(TO_CHAR(hireDate,'MM'),7,1)) "7��" ,
                    COUNT(DECODE(TO_CHAR(hireDate,'MM'),8,1)) "8��" ,
                    COUNT(DECODE(TO_CHAR(hireDate,'MM'),9,1)) "9��" ,
                    COUNT(DECODE(TO_CHAR(hireDate,'MM'),10,1)) "10��" ,
                    COUNT(DECODE(TO_CHAR(hireDate,'MM'),11,1)) "11��" ,
                    COUNT(DECODE(TO_CHAR(hireDate,'MM'),12,1)) "12��"  
                FROM emp;

                
            -- ��ձ޿����� ���� �޴� ����� empNo, name, sal �÷� ���
                SELECT empNo, name, sal
                FROM emp
                WHERE sal< ( SELECT AVG(sal) FROM emp );
            
            -- ���� ��� �ο��� �� �޿���� ���
                SELECT COUNT(*) �������ο���, AVG(sal) �޿����
                FROM emp
                WHERE city='����';


       -- VARIANCE([ DISTINCT | ALL ] expr) : �л�
       -- STDDEV([ DISTINCT | ALL ] expr) : ǥ������

------ ���� �ʼ�----------
 -- �� GROUP BY ���� HAVING ��
        -- FROM �� -> WHERE �� -> GROUP BY �� -> HAVING �� -> SELECT ��-> ORDER BY ��
   
    -- �� GROUP BY �� ��� ��
        -- �� 
            SELECT SUM(sal) FROM emp;  -- ��ü �޿� ��
            
        -- �μ��� �޿� ��
            SELECT dept, SUM(sal) FROM emp; -- ����
            
            SELECT dept, SUM(sal)
            FROM emp
            GROUP BY dept;  -- �׷캰 �հ�. GROUP BY���� ����� �÷��� �����Լ��� �Բ� ��� ����
   
   

      -- dept�� pos�� �޿� ����			
            SELECT dept, pos, SUM(sal)
            FROM emp
            GROUP BY dept,pos
            ORDER BY dept,pos;
            
        -- �μ��� �ο���
            SELECT dept, COUNT(*) "�μ��� �ο���"
            FROM emp
            GROUP BY dept;
        
        -- �μ��� ���� �ο��� : ���� �ο����� ���� �μ��� ��µ��� ����.
            SELECT dept, COUNT(*) "�μ��� ���� �ο���"
            FROM emp
            WHERE MOD(SUBSTR(rrn,8,1),2)=0 
            GROUP BY dept;
            
            SELECT DISTINCT dept FROM emp;
            
        -- �μ��� ���� �ο��� : ���� �ο����� ���� �μ��� ���
            SELECT dept, COUNT(DECODE(MOD(SUBSTR(rrn,8,1),2),0,1))�����ο���
            FROM emp
            GROUP BY dept;
            
        -- �μ��� ��ü�ο���, ����, ���� �ο���
            -- �μ��� ��ü ���� ����
            SELECT dept, COUNT(*)��ü, 
                   COUNT(DECODE(MOD(SUBSTR(rrn,8,1),2),1,1)) ����, 
                   COUNT(DECODE(MOD(SUBSTR(rrn,8,1),2),0,1)) ����
            FROM emp
            GROUP BY dept;
        
        
        -- �μ��� ���ڿ� ���� ����(�μ����)
            -- �μ��� ���ں��� ���ں���    
            SELECT dept, ROUND(COUNT(DECODE(MOD(SUBSTR(rrn,8,1),2),1,1))*100/COUNT(*)) ���ں���,
                         ROUND(COUNT(DECODE(MOD(SUBSTR(rrn,8,1),2),0,1))*100/COUNT(*)) ���ں���
            FROM emp
            GROUP BY dept;

        -- �μ��� ���ڿ� ���ں� �޿� �հ� ��� : �μ���������, �μ� ������ ���� ��������
            --�μ���  ����  ��
            --���ߺ�  ����  ...
            --���ߺ�  ����  ...
            
            SELECT dept,DECODE(MOD(SUBSTR(rrn,8,1),2),1,'����','����')����
            FROM emp;
            
            SELECT dept, DECODE(MOD(SUBSTR(rrn,8,1),2),1,'����','����')����, 
                   SUM(sal) ��,ROUND(AVG(sal)) ���
            FROM emp
            GROUP BY dept,MOD(SUBSTR(rrn,8,1),2)    -- > decode �Ⱦ��� �� �κи� �����͵� ���� �÷� ��� ����
            ORDER BY dept, ���� DESC;
            
        
    -- �� HAVING �� ��� ��
        -- �μ��� �ο���
            SELECT dept, COUNT(*)"�μ��� �ο���"
            FROM emp
            GROUP BY dept;
            
        -- �μ��� �ο����� 7�� �̻�
            -- HAVING : GROUP BY�� ����� ���� ����
            SELECT dept, COUNT(*)
            FROM emp
            GROUP BY dept
            HAVING COUNT(*) >=7;
            
        -- �μ��� ���� �ο����� 5���̻�
            SELECT dept, COUNT(*)
            FROM emp
            WHERE MOD(SUBSTR(rrn,8,1),2)=0
            GROUP BY dept
            HAVING COUNT(*) >=5;
        
        ---------------------------------------
        -- subquery
            -- SELECT ��, INSERT ��, UPDATE ��, DELETE �� ��� ���Ǵ� SELECT ��
            -- SELECT ���� SELECT ��, FROM ��, WHERE ������ ��� ����
                -- SELECT������ ����ϴ� ��� �ϳ��� �÷��� �ϳ��� ���� ����� ����
                -- WHERE ������ ����ϴ� ��� IN �������� �������� ��µǾ ����������, =,<,> ���� ���꿡���� �ϳ��� �ุ ����
            -- subquery�� �ܵ� ���� ����
            
        -- empNo, name, sal, �ִ�޿�-sal
            SELECT MAX(sal) FROM emp;   -- ���� �� �÷�
            
            SELECT empNo, name, sal, (SELECT MAX(sal) FROM emp) - sal ����
            FROM emp;
            
        -- �߸� ���� ��
            SELECT empNo, name, sal
            FROM emp
            WHERE sal >( SELECT MAX(sal), MIN(sal) FROM emp); -- ����. ���������� �÷��� �ΰ� ����

            SELECT empNo, name, sal
            FROM emp
            WHERE sal >( SELECT sal FROM emp WHERE city='����');  -- ����. �������� ����� ������

        -- IN������ ��������
            SELECT sal FROM emp WHERE city='��õ';
            
            SELECT empNo, name, sal
            FROM emp
            WHERE sal IN (SELECT sal FROM emp WHERE city='��õ'); -- IN�� ���Ҷ��� �������� ����� �������̾ ����
            
            SELECT empNo, name, sal
            FROM emp
            WHERE sal IN(4550000,3365000,1500000);
        
        -- empNo, name, sal, sal-��ձ޿� 
            SELECT empNo, name, sal ,sal-(SELECT AVG(sal) FROM emp) "sal-��ձ޿�"
            FROM emp;
            
        -- sal+bonus�� ���� ���� �޴� ��� : empNo, name, sal, bonus, sal+bonus
            SELECT empNo,name,sal, bonus, sal+bonus
            FROM emp
            WHERE sal+bonus = (SELECT MAX(sal+bonus) FROM emp);
                     
                        
        -- ������ �޿�(sal)�� ���� ���� �޴� ��� : empNo, name, sal
             SELECT empNo, name, sal
             FROM emp
             WHERE MOD(SUBSTR(rrn,8,1),2)=0 AND 
                sal = (SELECT MAX(sal) FROM emp WHERE MOD(SUBSTR(rrn,8,1),2)=0);      
        
        -- ��ձ޿�(sal)���� ���� �޴� ��� : empNo, name, sal
            SELECT empNo, name, sal
            FROM emp
            WHERE sal > (SELECT AVG(sal) FROM emp);
        
    
        -- �μ��� �ο����� ���� ���� �μ��� �� �ο���
            SELECT dept, COUNT(*)
            FROM emp
            GROUP BY dept
            HAVING COUNT(*)=(SELECT MAX(COUNT(*))
            FROM emp
            GROUP BY dept);
            
              --(2)
            WITH tb AS(
                SELECT dept, COUNT(*) cnt FROM emp GROUP BY dept
            )SELECT dept, cnt
             FROM tb
             WHERE cnt = (SELECT MAX(cnt) FROM tb);
            
        -- �Ի�⵵�� �Ի��ο����� ���� ���� �⵵ �� �ο�
            -- �Ի�⵵�� �ο���
            SELECT TO_CHAR(hireDate,'YYYY') �⵵ , COUNT(*)�ο���
            FROM emp
            GROUP BY TO_CHAR(hireDate,'YYYY')
            HAVING COUNT(*) = (SELECT MAX (COUNT(*))
                               FROM emp
                               GROUP BY TO_CHAR(hireDate,'YYYY'));
          
          --(2)
            WITH tb AS(
                SELECT TO_CHAR(hireDate,'YYYY') �⵵, COUNT(*) cnt 
                FROM emp 
                GROUP BY TO_CHAR(hireDate,'YYYY')
            )SELECT �⵵, cnt
             FROM tb
             WHERE cnt = (SELECT MAX(cnt) FROM tb);
            
            
        -- ������ ������ ����� 2�� �̻��� ����� name,birth ���. ��, birth�� rrn�� �̿��ϰ� ��¥������ RRMMDD �̿�
            SELECT name, TO_DATE(SUBSTR(rrn,1,6),'RRMMDD')birth
            FROM emp
            WHERE SUBSTR(rrn,3,4) IN(
                        SELECT SUBSTR(rrn,3,4)
                        FROM emp
                        GROUP BY SUBSTR(rrn,3,4)
                        HAVING COUNT(*)>=2
            )
            ORDER BY TO_CHAR(birth,'MMDD');
            
            

 -- �� ROLLUP ���� CUBE ��
    -- �� ROLLUP �� ��
         -- GROUP BY ROLLUP(a, b)
            a+b    => a �� b�� �Ұ� : GROUP BY a, b �� ���
            a       => a �� �Ұ�
            ��ü   => �������� �ѹ�

         -- GROUP BY x, ROLLUP(a, b)
            x+a+b
            x+a
            x

         -- GROUP BY x, ROLLUP(a)
            x+a
            x

       -- dept�� pos�� sal �Ұ�, dept���Ұ�, �������� �Ѱ� ���
            SELECT dept, pos, SUM(sal)
            FROM emp
            GROUP BY dept, pos; -- �μ��� ���� ������ �հ�
            
            
            SELECT dept, pos, SUM(sal)
            FROM emp
            GROUP BY ROLLUP(dept, pos);
                -- ǥ���� 2�� -> 3�������� ǥ��
                -- 3���� : �μ��� ������ �Ұ�, 2���� : �μ��� �Ұ�, 1���� : ��ü�Ұ�
           
           -- ��ü ��¼��..... 16:16 (14:00)
            SELECT dept, pos, SUM(sal)
            FROM emp
            GROUP BY dept, ROLLUP( pos );
                -- ǥ���� 1�� -> 2����
                -- 2���� : �μ��� ������ �Ұ�, 1���� : �μ��� �Ұ�
           
            -- dept�� �ο��� �� �������� ��ü �ο��� ���
                SELECT dept, COUNT(*)
                FROM emp
                GROUP BY dept;  -- �μ��� �ο���
                
                SELECT dept, COUNT(*)
                FROM emp
                GROUP BY ROLLUP(dept);  -- �μ��� �ο��� �� �������� ��ü �ο���
                
             -- 
                SELECT city, dept, pos, SUM(sal)
                FROM emp
                GROUP BY city, ROLLUP(dept,pos);
                

       -- dept�� pos�� sal �Ұ�, dept�� �Ұ� ����ϸ� �������� �Ѱ�� ������� �ʴ´�.


    �� CUBE �� ��
       -- dept�� pos�� sal �Ұ�, dept�� �Ұ�, pos�� �Ұ�, �������� �Ѱ� ���
            SELECT dept, pos, SUM(sal)
            FROM emp
            GROUP BY CUBE(dept,pos)
            ORDER BY dept,pos;

            SELECT dept, pos, SUM(sal)
            FROM emp
            GROUP BY CUBE(pos, dept)
            ORDER BY dept,pos;
            
         --
            SELECT city, dept, pos, SUM(sal)
            FROM emp
            GROUP BY CUBE(city,dept,pos)
            ORDER BY city,dept,pos;

            SELECT city, dept, pos, SUM(sal)
            FROM emp
            GROUP BY city, CUBE(dept,pos)
            ORDER BY city,dept,pos;
            
 -- �� GROUPING �Լ��� GROUP_ID �Լ�
    -- �� GROUPING �Լ�
        -- GROUPING(�÷�) : ����� 0�̸� �ش� �÷��� ROLLUP ���꿡 ���� ���̸�, 1�̸� ������ ����
            SELECT dept, pos, GROUPING(dept), GROUPING(pos), TRUNC(AVG(sal))
            FROM emp
            GROUP BY ROLLUP(dept, pos);
            
            SELECT dept, pos, TRUNC(AVG(sal))
            FROM emp
            GROUP BY ROLLUP(dept, pos)
            HAVING GROUPING(pos)=1; 

            -- �μ��� ��� �� ��ü ���
            SELECT dept, TRUNC(AVG(sal))
            FROM emp
            GROUP BY ROLLUP(dept, pos)
            HAVING GROUPING(pos)=1;
            
            SELECT dept, TRUNC(AVG(sal))
            FROM emp
            GROUP BY ROLLUP(dept);
            
            
    -- �� GROUP_ID �Լ�
        -- empNo name dept sal : ���� �޿� �� �μ��� �޿���, ��ü��
            SELECT empNo, name, dept, SUM(sal) sal
            FROM emp 
            GROUP BY ROLLUP(dept, (empNo, name));
        
            SELECT empNo, name, dept, GROUP_ID(), SUM(sal) sal
            FROM emp
            GROUP BY dept, ROLLUP(dept, (empNo, name));
            
            SELECT empNo, name, dept, GROUP_ID(), SUM(sal) sal
            FROM emp
            GROUP BY dept, ROLLUP(dept, (empNo, name))
            ORDER BY dept, GROUP_ID(),empNo;
            
            -- ���, �̸�, �μ�, �޿����
            -- �μ��� ��������, �μ��� ����Ǹ� �μ��� �հ�, �μ��� ��� ���
            SELECT empNo,
                DECODE(GROUP_ID(), 0, NVL(name, '--�հ�--'),'--���--') name,
                dept,
                DECODE(GROUP_ID(),0,SUM(sal), ROUND(AVG(sal))) sal
            FROM emp
            GROUP BY dept, ROLLUP(dept, (empNo,name))
            ORDER BY dept, GROUP_ID(),empNo;


 -- �� GROUPING SETS - - �� ��


