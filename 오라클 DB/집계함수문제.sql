-- sal+bonus �� ����, ���, �ִ�, �ּҰ� ��� : emp ���̺�
    -- ����  ���  �ִ�  �ּ�
    SELECT SUM(sal+bonus) ����, AVG(sal+bonus) ���, MAX(sal+bonus) �ִ�, MIN(sal+bonus)�ּ�
    FROM emp;


-- ��ŵ�(city)�� ���ڿ� ���� �ο��� ��� : emp ���̺�
    -- city   ����   �ο���
    
    SELECT city, 
        CASE 
            WHEN MOD(SUBSTR(rrn,8,1),2)=1 THEN '����'
            WHEN MOD(SUBSTR(rrn,8,1),2)=0 THEN '����'
        END ����,
        COUNT(*) �ο���
    FROM emp
    GROUP BY city,MOD(SUBSTR(rrn,8,1),2)
    ORDER BY city,MOD(SUBSTR(rrn,8,1),2) ;

-- ��ŵ�(city)�� ���ڿ� ���� �ο��� ��� : emp ���̺�
    -- city   �����ο���  �����ο���
        SELECT city,
            COUNT(DECODE(MOD(SUBSTR(rrn,8,1),2),1,1)) "���� �ο���",
            COUNT(DECODE(MOD(SUBSTR(rrn,8,1),2),0,1)) "���� �ο���"
        FROM emp
        GROUP BY city, MOD(SUBSTR(rrn,8,1),2);


-- �μ�(dept)�� ���� �ο����� 7�� �̻��� �μ���� �ο��� ��� : emp ���̺�
    -- dept  �ο���
        SELECT dept, COUNT(*) �ο���
        FROM emp
        WHERE  MOD(SUBSTR(rrn,8,1),2)=1
        GROUP BY dept
        HAVING COUNT(*) >=7 ;

-- �μ�(dept)�� �ο����� �μ��� ������ ������ ����� �ο��� ��� : emp ���̺�
    -- dept  �ο��� M01  M02  M03 .... M12

       SELECT dept, COUNT(*) �ο���,
           COUNT(DECODE(SUBSTR(rrn,3,2),01,1)) "M01",
           COUNT(DECODE(SUBSTR(rrn,3,2),02,1)) "M02",
           COUNT(DECODE(SUBSTR(rrn,3,2),03,1)) "M03",
           COUNT(DECODE(SUBSTR(rrn,3,2),04,1)) "M04",
           COUNT(DECODE(SUBSTR(rrn,3,2),05,1)) "M05",
           COUNT(DECODE(SUBSTR(rrn,3,2),06,1)) "M06",
           COUNT(DECODE(SUBSTR(rrn,3,2),07,1)) "M07",
           COUNT(DECODE(SUBSTR(rrn,3,2),08,1)) "M08",
           COUNT(DECODE(SUBSTR(rrn,3,2),09,1)) "M09",
           COUNT(DECODE(SUBSTR(rrn,3,2),10,1)) "M10",
           COUNT(DECODE(SUBSTR(rrn,3,2),11,1)) "M11",
           COUNT(DECODE(SUBSTR(rrn,3,2),12,1)) "M12"
       FROM emp
       GROUP BY dept ;
  

-- sal�� ���� ���� �޴� ����� name, sal ��� : emp ���̺�
    -- name   sal
        SELECT name, sal
        FROM emp
        WHERE sal = ( SELECT MAX(sal) FROM emp );



-- ��ŵ�(city)�� ���� �ο����� ���� ���� ��ŵ� �� ���� �ο����� ��� : emp ���̺�
    -- city   �ο���

            SELECT city, COUNT(*) �����ο���
            FROM emp
            WHERE MOD(SUBSTR(rrn,8,1),2)=0
            GROUP BY city
            HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM emp WHERE MOD(SUBSTR(rrn,8,1),2)=0 GROUP BY city);

-- �μ�(dept)�� �ο��� �� �μ��� �ο����� ��ü �ο����� �� %���� ��� : emp
    -- dept  �ο���  �����
    SELECT dept, COUNT(*) �ο���, TRUNC(COUNT(*)/( SELECT COUNT(*) FROM emp)*100) "�����(%)"
    FROM emp
    GROUP BY dept;
    
-- �μ�(dept) ����(pos)�� �ο����� ����ϸ�, ���������� ������ ��ü �ο��� ��� : emp ���̺�
   -- ROLLUP�� ����ϸ�, �μ��� �������� ����
   -- ��� ��
    dept     pos    �ο���
    ���ߺ�    ����     2
    ���ߺ�    ���     9
    ���ߺ�    ����     1
    ���ߺ�    �븮     2
    ��ȹ��    ���     2
         :
             ���    32
             ����    7
             ����    8
             �븮    13
    
    SELECT NVL(dept,'(��ü)'),NVL(pos,'(��ü)'), COUNT(*) �ο���
    FROM emp
    GROUP BY ROLLUP(dept, pos) ;


-- �μ�(dept) ����(pos)�� �ο����� ��� : emp ���̺�
    -- ��� ��
dept       ����  ����  �븮  ���
�ѹ���    1       2      0      4
���ߺ�    1       2      2      9
            :

    SELECT dept,
            COUNT(DECODE(pos,'����',1)) ����,
            COUNT(DECODE(pos,'����',1)) ����,
            COUNT(DECODE(pos,'�븮',1)) �븮,
            COUNT(DECODE(pos,'���',1)) ���
    FROM emp
    GROUP BY dept
    ORDER BY dept;
    


-- �μ�(dept) ����(pos)�� �ο����� ����ϰ� �������� ������ �ο��� ��� : emp ���̺�
    -- ��� ��
dept       ����  ����  �븮  ���
���ߺ�    1       2      2      9
��ȹ��    2       0      3      2
            :
            7        8     13     32



