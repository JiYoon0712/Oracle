-- �� SQL �Լ�
 -- �� �м� �Լ�(analytic functions) �� ������ �Լ�(window functions)
    -- �� ���� ���� �Լ�
      -- 1) RANK() OVER() �Լ�
              -- "100,100,80" ������ "1,1,3"
            -- ��ü�� ������� ���� ���
               SELECT name, sal, RANK() OVER(ORDER BY sal) ����
               FROM emp; -- �޿� �������� ����

               SELECT name, sal, RANK() OVER(ORDER BY sal DESC) ����
               FROM emp; -- �޿� �������� ����
               
               SELECT name, sal, RANK() OVER(ORDER BY sal DESC, bonus DESC) ����
               FROM emp; -- �޿���������, �޿��� ������ ���ʽ� �������� ����
               
               -- �׷��� ������� ���� ��� : �μ��� ����
               SELECT name, dept, sal, RANK() OVER(PARTITION BY dept ORDER BY sal DESC) ����
               FROM emp; -- �μ��� �޿��������� ����
               
               -- �׷��� ������� ���� ��� : �μ��� ����, �μ��� ������ ����
               SELECT name, dept, pos, sal,
                    RANK() OVER(PARTITION BY dept ORDER BY sal DESC) �μ�����,
                    RANK() OVER(PARTITION BY dept,pos ORDER BY sal DESC) �μ���������
               FROM emp; -- �μ��� �޿��������� ����
               
               -- �޿� ���� : 1~10������� ���
               SELECT name, sal, 
                    RANK() OVER(ORDER BY sal DESC) ����
               FROM emp;
               
               SELECT name, sal, 
                    RANK() OVER(ORDER BY sal DESC) ����
               FROM emp
               WHERE RANK() OVER(ORDER BY sal DESC) <=10; -- ����.
               
               SELECT * FROM (
                    SELECT name, sal,
                    RANK() OVER(ORDER BY sal DESC) ����
                    FROM emp
               ) WHERE ���� <=10;  -- �������� �̿�
               
               -- �޿� ���� 10% ���(name, sal)
                SELECT name, sal FROM(
                    SELECT name, sal,
                    RANK() OVER(ORDER BY sal DESC) ����
                    FROM emp
                )WHERE ���� <= (SELECT COUNT(*) FROM emp)*0.1;
                
                -- dept�� �޿�(sal+bonus)�� ���� ���� name, dept, pos, sal, bonus ���
                SELECT name, dept, sal, bonus FROM(
                    SELECT name, dept, sal, bonus,
                    RANK() OVER(PARTITION BY dept ORDER BY sal+bonus DESC) ����
                    FROM emp
                ) WHERE ���� = 1;
                
                -- dept�� �����ο����� ���� ���� �μ��� �� �ο��� ���
                SELECT dept, �ο��� FROM(
                    SELECT dept, COUNT(*) �ο���,
                          RANK() OVER(ORDER BY COUNT(*) DESC) ����
                    FROM emp
                    WHERE MOD(SUBSTR(rrn,8,1),2)=0 
                    GROUP BY dept
                ) WHERE ���� = 1 ;
                
                      
      -- 2) DENSE_RANK() OVER() �Լ�
        -- "100,100,80" ������ "1,1,2"
        
        SELECT name, sal, RANK() OVER(ORDER BY sal DESC) rank����
        FROM emp;
        
        SELECT name, sal, DENSE_RANK() OVER(ORDER BY sal DESC) densc_rank����
        FROM emp;

      -- 3) ROW_NUMBER() OVER( ) �Լ�
        -- "100,100,80" ������ "1,2,3"
        SELECT name, sal, ROW_NUMBER() OVER(ORDER BY sal DESC) ROW_NUMBER����
        FROM emp;

     -- 4) RANK() WITHIN GROUP() �Լ� : ���ǰ��� ����
        -- sal�� 3000000�̸� ���?
        SELECT RANK(3000000) WITHIN GROUP(ORDER BY sal DESC) ����
        FROM emp;

--------------------------------------

    -- �� COUNT() OVER(), SUM() OVER(), AVG() OVER(), MAX() OVER(), MIN() OVER() �Լ� : ������ ���
      -- 1) COUNT() OVER() �Լ�
            SELECT name, dept, sal, COUNT(*)
            FROM emp; -- ����
      
            SELECT name, dept, sal,
                COUNT(*) OVER(ORDER BY empNo) cnt
            FROM emp; 
                  -- �� ������� ����
                  -- 1 2 3 4 ... ���� ���
                  -- �� �ο��� ����(empNo�� ��� �ٸ� ���̱� ������ 1 2 3 4 ... �� ���)
            
            SELECT name, dept, sal,
                COUNT(*) OVER(ORDER BY dept) cnt
            FROM emp;      
                -- ������ �μ��� ������ �ο���
                -- ���� �μ��� �� �μ��� �ο����� ����
                -- 14 14 ... 14 21 21  ... 21 37...

        -- OVER()�� �ƹ��͵� ������� ������ ��ü �ο����� ���
            SELECT name, dept, sal,
                COUNT(*) OVER() cnt
            FROM emp;  
            
        -- �׷캰 : �μ��� �ο���
            SELECT name, dept, sal,
                COUNT(*) OVER(PARTITION BY dept) cnt
            FROM emp; 
                -- 14 14 .. 14 7 7 ... 16..
                -- �� �μ� �ο����� �������� ����
                
            SELECT name, dept, pos, sal,
                COUNT(*) OVER(PARTITION BY dept) cnt,
                COUNT(*) OVER(PARTITION BY dept ORDER BY empNo) cnt2
            FROM emp; 
            
            SELECT name, dept, pos, sal,
                COUNT(*) OVER(PARTITION BY dept) cnt,
                COUNT(*) OVER(PARTITION BY dept ORDER BY sal) cnt2
            FROM emp; 
            
            SELECT name, dept, pos, sal,
                COUNT(*) OVER(ORDER BY empNo) cnt
            FROM emp
            WHERE dept='���ߺ�'; 
        
        
      -- 2) SUM() OVER() �Լ�
            -- name, dept, sal, sal��ü��
                SELECT name, dept, sal, SUM(sal) �� FROM emp; --����
                
                SELECT name, dept, sal, (SELECT SUM(sal)FROM emp) �� FROM emp; 
                SELECT name, dept, sal, SUM(sal) OVER() FROM emp;
                            -- OVER()�� �ƹ��͵� ������� ������ ��ü ��
                
                SELECT name, dept, sal, SUM(sal) OVER(ORDER BY empNo) FROM emp;
                            -- �� sal ���� ����
                            -- empNo�� ������ ���� �����Ƿ� ������ ���� ��µ��� ����
                            
                SELECT name, dept, sal, SUM(sal) OVER(ORDER BY dept) FROM emp;
                            -- ���� �μ��� ������ ��
                            -- ���� �μ��� �պμ� ���� ����
                 
            -- �׷캰 ��
                SELECT name, dept, sal, SUM(sal) OVER(PARTITION BY dept) FROM emp;

                SELECT name, dept, sal, SUM(sal) OVER(PARTITION BY dept ORDER BY empNo) FROM emp;
            
            -- �μ���  ����  �ο��� �μ������������
               ���ߺ�  ����  5      50%
               ���ߺ�  ����  5      50%
                    :
                SELECT dept, DECODE(MOD(SUBSTR(rrn,8,1),2),1,'����','����') ����,
                        COUNT(*) �ο���
                FROM emp
                GROUP BY dept, MOD(SUBSTR(rrn,8,1),2);                
                -----
                SELECT dept, DECODE(MOD(SUBSTR(rrn,8,1),2),1,'����','����') ����,
                        COUNT(*) �ο���,
                        SUM(COUNT(*)) OVER(PARTITION BY dept) �μ��ο�
                FROM emp
                GROUP BY dept, MOD(SUBSTR(rrn,8,1),2);
                -----
                SELECT dept, DECODE(MOD(SUBSTR(rrn,8,1),2),1,'����','����') ����,
                        COUNT(*) �ο���,
                        SUM(COUNT(*)) OVER(PARTITION BY dept) �μ��ο�,
                        ROUND(COUNT(*)/SUM(COUNT(*)) OVER(PARTITION BY dept) *100) ||'%' �����
                FROM emp
                GROUP BY dept, MOD(SUBSTR(rrn,8,1),2);
                
                -- �������� �̿�
                  SELECT dept, ����, �ο���
                  FROM(
                    SELECT dept, DECODE(MOD(SUBSTR(rrn,8,1),2),1,'����','����') ����,
                            COUNT(*) �ο���,
                            SUM(COUNT(*)) OVER(PARTITION BY dept) �μ��ο�
                    FROM emp
                    GROUP BY dept, MOD(SUBSTR(rrn,8,1),2)
                    );
                    
                  SELECT dept, ����, �ο���, SUM(�ο���) OVER(PARTITION BY dept) �μ��ο�
                  FROM(
                    SELECT dept, DECODE(MOD(SUBSTR(rrn,8,1),2),1,'����','����') ����,
                            COUNT(*) �ο���,
                            SUM(COUNT(*)) OVER(PARTITION BY dept) �μ��ο�
                    FROM emp
                    GROUP BY dept, MOD(SUBSTR(rrn,8,1),2)
                    );
                    
                    
      -- 3) AVG() OVER() �Լ� >  ����������
            -- name, dept, sal, ��ü��ձ޿�
            SELECT name, dept, sal,
                ROUND(AVG(sal) OVER()) ���
            FROM emp;
            
            -- name, dept, sal, ��ü��ձ޿��� ����
            SELECT name, dept, sal,
                sal - ROUND(AVG(sal) OVER())
            FROM emp;
            
            -- name, dept, sal, �μ�����ձ޿�
            SELECT name, dept, sal,
                ROUND(AVG(sal) OVER(PARTITION BY dept)) �μ����
            FROM emp;

      -- 4) MAX() OVER()�� MIN() OVER() �Լ�
            -- name, dept, sal, �ִ�޿��� ����
                SELECT name, dept, sal, 
                    ROUND(MAX(sal)OVER())-sal ����
                FROM emp;
                
            -- name, dept, sal, �ּұ޿��� ����
                SELECT name, dept, sal, 
                    sal-ROUND(MIN(sal)OVER()) ����
                FROM emp;    

    -- �� RATIO_TO_REPORT() OVER() �Լ�
        SELECT dept, COUNT(*)
        FROM emp
        GROUP BY dept;

        SELECT dept, ROUND(COUNT(*)/(SELECT COUNT(*) FROM emp) *100) ����
        FROM emp
        GROUP BY dept;
 
        SELECT dept, ROUND(RATIO_TO_REPORT(COUNT(*)) OVER()*100) ����
        FROM emp
        GROUP BY dept;        
        
    -- �� LISTAGG () WITHIN GROUP() �Լ� : �÷����� ���� > ���
        -- �μ��� ��� �̸��� ,�� �����Ͽ� ����
        -- �μ��� �����
            SELECT dept,
                    LISTAGG(name,',') WITHIN GROUP(ORDER BY empNo) �μ������
            FROM emp
            GROUP BY dept;      -- GROUP BY ���� �Ұ�


    -- �� LAG () OVER() �Լ���  LEAD() OVER()  �Լ� : ������ ���� ���� ����
        -- LAG () OVER() : ���� ������
        -- LEAD() OVER() : ���� ������
            
            SELECT name, sal,
                    LAG(sal,1,0) OVER(ORDER BY sal DESC) lag
            FROM emp;
                -- LAG(sal,1,0) -> sal : ����÷�, 1:1�پ� �з��� ���(3�� �ָ� 3�پ� �и�), 0:�и��ڸ��� ����� ��

            SELECT name, sal,
                    LEAD(sal,1,0) OVER(ORDER BY sal DESC) lead
            FROM emp;

    �� NTILE() OVER() �Լ� : �׷� ������
        SELECT name, sal,
            NTILE(6) OVER(ORDER BY sal DESC) �׷�
        FROM emp;
        
        SELECT name, sal,
            NTILE(7) OVER(ORDER BY sal DESC) �׷�
        FROM emp;
    


    -- �� ������ ��(window clause) : �κ� ������ ����� ����
      -- ����
--       { ROWS | RANGE }
--         { BETWEEN
--               { UNBOUNDED PRECEDING  | CURRENT ROW | value_expr { PRECEDING | FOLLOWING } } 
--              AND
--              { UNBOUNDED FOLLOWING | CURRENT ROW | value_expr { PRECEDING | FOLLOWING } }
--         | { UNBOUNDED PRECEDING | CURRENT ROW | value_expr PRECEDING }
--        }


    -- �� FIRST_VALUE() OVER()
        -- �̸�, �⺻��, ���μ��� �ִ�޿�
        SELECT name, sal, FIRST_VALUE(sal) OVER(PARTITION BY dept ORDER BY sal DESC)
        FROM emp;
        
        SELECT name, dept, sal, MAX(sal) OVER(PARTITION BY dept)
        FROM emp;
        
        -- �̸�, �⺻��, �ִ�޿��� ����
        SELECT name, sal, FIRST_VALUE(sal) OVER(PARTITION BY dept ORDER BY sal DESC)-sal ����
        FROM emp;

        
        
    -- �� LAST_VALUE() OVER() �Լ�
       -- ��
         -- LAST_VALUE �Լ��� ���������� �������� ������ ����Ʈ��
            RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW �� ����Ǿ�
            �������� �����Ǿ� ���� �����Ƿ� ����ġ �ʴ� ����� ��� �ǹǷ� �ݵ�� ���������� �����ؾ� �Ѵ�.
        
         -- ���������� ū ������
            SELECT name, dept, sal, LAST_VALUE(sal) OVER(ORDER BY sal)
            FROM emp;
            
            SELECT name, dept, sal, LAST_VALUE(sal) OVER(ORDER BY sal
                  RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) ũ���
            FROM emp;
         
         -- ����� �Ź� �޶��� �� ������, ��������� �ٸ� �� ����
            SELECT name, dept, sal, LAST_VALUE(sal) OVER()
            FROM emp;
            
         -- ���� ū���� ��� : FOLLOWING �ɼ��� ���
            SELECT name, dept, sal, 
                LAST_VALUE(sal) OVER(ORDER BY sal RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) �ְ�
            FROM emp;
         