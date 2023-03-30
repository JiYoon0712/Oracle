-- �� SQL �Լ�

 -- �� ������ ���� �Լ�
    -- �� ���� �Լ� ����
       -- ABS(n) : ���밪
			SELECT ABS(20)  FROM emp;	-- emp 60���̹Ƿ� 60�� ���
			
			SELECT ABS(-20), ABS(20) FROM dual;

       -- SIGN(n) : ��� 1, 0�� 0, ���� -1
			SELECT SIGN(-20), SIGN(20) FROM dual;

       -- MOD(n2, n1): ������
	       -- ���� ���� : n2 - n1* FLOOR(n2/n1)   
       -- REMAINDER(n2, n1) 
		   -- ���ο��� : n2 - n1 * ROUND(n2/n1)
	   
			SELECT MOD(11,4) FROM dual;	-- 3
			
			SELECT 13-5 *FLOOR(13/5) FROM dual;  --3
			SELECT MOD(13,5) FROM dual;	--3

			SELECT 13-5 *ROUND(13/5) FROM dual;  --  -2
			SELECT REMAINDER(13,5) FROM dual;	--  -2

       -- CEIL(n) : n ���� ũ�ų� ���� ���� ���� ����
		    SELECT CEIL(20), CEIL(20.6), CEIL(-20.6) FROM dual;		-- 20, 21, -20

       -- FLOOR(n) : n ���� ���ų� ���� ���� ū ����
			SELECT FLOOR(20), FLOOR(20.6), FLOOR(-20.6) FROM dual;		-- 20, 20 , -21

       -- ROUND(n [, integer ]) : �ݿø�
			SELECT 10/3 FROM dual;		-- 3.33333333333333333333333333333333333333
 
			SELECT ROUND(15.673, 1) FROM dual;	--�Ҽ��� 1�ڸ� ���(�Ҽ��� ��°�ڸ����� �ݿø�)
								-- 15.7
			SELECT ROUND(15.673, 2) FROM dual;	-- 15.67
													
			SELECT ROUND(15.673) FROM dual;	-- �Ҽ��� ù°�ڸ����� �ݿø�
								-- 16
								
			SELECT ROUND(15.673, -1) FROM dual;		-- ���� �ڸ����� �ݿø�
								--20
								
       -- TRUNC(n1 [, n2 ]) : ����
			SELECT TRUNC(15.693,1) FROM dual;		-- �Ҽ��� ���� 1�ڸ� ǥ��. ��°�ڸ����� ����
								-- 15.6

			SELECT TRUNC(15.693,2) FROM dual;		-- 15.69
			SELECT TRUNC(15.693) FROM dual;		-- 15
			SELECT TRUNC(15.693,0) FROM dual;		-- 15
			SELECT TRUNC(15.693,-1) FROM dual;	-- 10, ���� �ڸ� ����
			
			SELECT name, sal, TRUNC(sal/10000) ������ FROM emp;
			
			-- emp : name, sal, 5������, 1������, ������ �ݾ�
			SELECT name, sal, 
				TRUNC (sal/10000) "5������", TRUNC (MOD(sal,50000)/10000) "1������",
				MOD(sal,10000) ������
			FROM emp;

			
       -- SIN(n), COS(n), TAN(n) ��
			SELECT SIN(30/180 * 3.141592) FROM dual;
--?????????????????????????????????????????????????????????????????????????????

       -- EXP(n), POWER(n2, n1), SQRT(n), LOG(n2, n1), LN(n) ��
		--    ����     �ŵ�����    ������      �α�         �ڿ��α� 



------------------------------------------------------------------------	
 -- �� ������ ���� �Լ�
    -- �� ���� �Լ� ����
       -- LOWER(char) : �����ڸ� ��� �ҹ��ڷ�   => ���
			SELECT LOWER('KOREA SEOUL') FROM dual;
			
			SELECT * FROM col WHERE tname = 'emp';		-- ���̺���� �빮�ڷ� ����Ǿ� �ƹ��͵� ��µ��� �ʴ´�.
			
			SELECT * FROM col WHERE LOWER(tname)= 'emp';	

			SELECT * FROM col WHERE tname= UPPER('emp');	


       -- UPPER(char) : �����ڸ� ��� �빮�ڷ�
			SELECT UPPER('korea seoul') FROM dual;


       -- INITCAP(char) : �� �ܾ��� ù���ڸ� �빮�ڷ�
			SELECT INITCAP('korea seoul') FROM dual;


       -- CHR(n [ USING NCHAR_CS ]) : ASCII ���� �ش��ϴ� ����
			SELECT CHR(65) || CHR(66) FROM dual;		-- AB


       -- ASCII(char) : ù������ ASCII �ڵ尪
			SELECT ASCII('ABC') FROM dual;	--65


       -- ASCIISTR(char)
			-- ���ڿ��� ASCII ���� ��ȯ. ��, �����ڴ� �״�� ����ϰ�, non ASCII ���ڴ� �����ڵ� ���
			SELECT ASCIISTR('ABC123'), ASCIISTR('����') FROM dual;


       -- SUBSTR(char, position [, substring_length ]) : �ε����� 1����
			SELECT SUBSTR('seoul korea',7,3) FROM dual;	-- kor, 7��°�������� 3��

			SELECT SUBSTR('seoul korea',-5,3) FROM dual;	-- kor, �ڿ������� 5��°���� 3�� 
			
			SELECT SUBSTR('seoul korea',7) FROM dual;	-- korea, 7��°�������� ����������
		
		-- 2000��� ��� ���(rrn�̿�) : emp ���̺� -  empNo, name, rrn, city
			SELECT empNo, name, rrn, city
			FROM emp
			WHERE SUBSTR(rrn,8,1) IN (3,4,7,8);

		-- ��������� 78~82����� ���(rrn�̿�) : emp ���̺� -  empNo, name, rrn, city
			SELECT empNo, name, rrn, city
			FROM emp
			WHERE SUBSTR(rrn,1,2) >=78 AND SUBSTR(rrn,1,2) <=82;
		
		-- city�� �����̸鼭 �达�� ��� : emp ���̺� -  empNo, name,  city
			SELECT empNo, name, city
			FROM emp
			WHERE city = '����' AND SUBSTR(name,1,1)='��';
		
		-- ��������� 80~89����� rrn �������� ���(rrn�̿�) : emp ���̺� -  empNo, name, rrn, city
			SELECT empNo, name, rrn, city
			FROM emp
			WHERE SUBSTR(rrn,1,1)= '8'	-- => �ڵ� ����ȯ�� �Ͼ�� '8'�� 8�� �ᵵ ���� 
			ORDER BY rrn;
	
		-- ��, ��, �� ���� ��� : emp ���̺� -  empNo, name,  city
			SELECT empNo, name, city
			FROM emp
			WHERE SUBSTR(name,1,1) IN ('��','��','��');
		
		-- Ȧ���޿� �¾ ����� sal �������� ���(rrn�̿�) : emp ���̺� -  empNo, name, rrn, city
			SELECT empNo, name, rrn, city
			FROM emp
			WHERE MOD(SUBSTR(rrn,3,2),2)=1
			ORDER BY sal DESC;


       -- INSTR(string , substring [, position [, occurrence ] ]) : ���ڸ� �˻��Ͽ� ��ġ�� ��ȯ. ������ 0
			SELECT INSTR('korea seoul', 'e') FROM dual;	--4
			SELECT INSTR('korea seoul', 'abc') FROM dual; --0
			SELECT INSTR('korea seoul', 'e',7) FROM dual;		--8(7��°���� �˻�)
			SELECT INSTR('korea seoul', 'e',1,2) FROM dual;		--8(1��°���� �˻��Ͽ� 2��° e�� ��ġ)
													
			-- �达
				SELECT empNo, name, city
				FROM emp
				WHERE INSTR(name,'��')=1;
			
			-- ������ �����Ͽ� �̸��� '��'�� �ִ� ���
				SELECT empNo, name, city
				FROM emp
				WHERE INSTR(name,'��')>0;	-- > 0�̸� ���ڰ� ���ٴ� ��				
			
			-- ��ȭ��ȣ �и�(02-333-3333, 010-1111-2222 ....) : �ڹٿ��� �и��ϴ°� ���� ( split )
				SELECT name, tel,
					SUBSTR(tel,1,INSTR(tel, '-')-1) ���񽺹�ȣ
				FROM emp;
			
       -- LENGTH(char)
			SELECT LENGTH('���ѹα�') FROM dual;	-- ���ڼ�. 4
			SELECT LENGTHB('���ѹα�') FROM dual;	-- ����Ʈ��. 12    > �ѱ��� �ѱ��ڿ� 3����Ʈ
			


       -- REPLACE(char, search_string [, replacement_string])
			SELECT REPLACE('seoul korea', 'seoul', 'busan') FROM dual;	-- busan korea
		
			SELECT REPLACE('1234565785','5') FROM dual;	-- 1234678. ��� 5����

			SELECT name, REPLACE(tel,'-') FROM emp;		-- ��ȭ��ȣ -����
		
			SELECT name, dept FROM emp;
			
			SELECT name, REPLACE(dept,'��','��') FROM emp;
						-- ��� �θ� ������ ����
						
			SELECT name, SUBSTR(dept,1,2) || '��' dept FROM emp;
						-- �μ����� �ױ��� �̻��̸� �̻��� ���
						
			SELECT name, SUBSTR(dept,1,LENGTH(dept)-1) || '��' dept FROM emp;
			
       -- CONCAT(char1, char2)
			SELECT CONCAT('����','�ѱ�') FROM dual;
			SELECT '����' || '�ѱ�' FROM dual;
			
			
       -- LPAD(expr1, n [, expr2])
       -- RPAD(expr1, n [, expr2])
			-- ���� ������ expr2�� ä��
		
			SELECT LPAD('korea', 12, '*') FROM dual;		-- *******korea
			SELECT RPAD('korea', 12, '*') FROM dual;		-- korea*******
			
			SELECT LPAD('korea', 3, '*') FROM dual;			-- kor
			SELECT LPAD('korea', 0, '*') FROM dual;			-- null

			SELECT LPAD('����', 6, '*') FROM dual;				--**����
					-- �ѱ��� �ѱ��ڸ� 2ĭ���� ó��


			-- name, rrn(�����������ʹ� *��)
			SELECT name, rrn FROM emp;
			
			SELECT name, SUBSTR(rrn,1,8)||'******' rrn FROM emp;
			
			SELECT name, RPAD(SUBSTR(rrn,1,8),14,'*') rrn FROM emp;
			
			-- name, tel(�� 3�ڸ��� *��. ��, 12,13�ڸ��� �� �ִ�.)
			SELECT name, RPAD(SUBSTR(tel,1,LENGTH(tel)-3), LENGTH(tel), '*') tel
			FROM emp;
            
			-- name, sal, �׷��� : �׷����� sal(�⺻��) 100000���� * �ϳ� ���
			SELECT name,sal,
				LPAD('*', TRUNC(sal/100000),'*') �׷���
			FROM emp;
            --???????????????????????????????????????????????????????????????
			
			
			-- last_name�� �� 9�ڸ��� ����ϸ�, ������ ���ڸ��� �ش� �ڸ����� �ش��ϴ� ���� ���
			-- ��� ��
				-- last_name change_name
				-- kim            kim456789
				-- -> ��Ʈ : SUBSTR,RPAD
				
				WITH tb AS(
					SELECT 'kim' last_name FROM dual
						UNION ALL
					SELECT 'seoul' last_name FROM dual
						UNION ALL
					SELECT 'haha' last_name FROM dual
				)
				SELECT last_name, RPAD(last_name, 9, SUBSTR('123456789',LENGTH(last_name)+1)) change_name
				FROM tb;


       -- LTRIM(char [,set])
       -- RTRIM(char [,set])
       -- TRIM([[LEADING | TRAILING | BOTH] trim_character FROM] trim_score)
		
			SELECT ':'  || LTRIM(' �츮 ���� ') ||':' FROM dual;
			SELECT ':'  || RTRIM(' �츮 ���� ') ||':' FROM dual;
			SELECT ':'  || TRIM(' �츮 ���� ') ||':' FROM dual;

			SELECT ':' || REPLACE(' �츮 ����  ',' ') ||':' FROM dual;
			
			SELECT LTRIM('AABBCBDEF','BA') FROM dual;	-- CBDEF
						-- �����ϴ� ��ġ�� B �Ǵ� A�� ������ ����
			SELECT RTRIM('������','��') FROM dual;	-- ����
						-- ������ ��ġ�� �� ����
			SELECT TRIM('A' FROM 'AABBCCAA') FROM dual;	-- BBCC
						-- �� �Ǵ� �� A����. ��, ���� ���ڴ� �ϳ��� ����
			
			SELECT name, RTRIM(dept, '��') || '��' dept FROM emp;


       -- TRANSLATE(expr, from_string, to_string) : ���� ����
			SELECT TRANSLATE('abcabccc', 'c', 'n') FROM dual;	-- abnabnnn
										-- c �� n���� ��ü
										
			SELECT REPLACE('abcabccc', 'c') FROM dual;	-- abab : c ����
			
			SELECT TRANSLATE('abcabcccx', 'abc', 'ab') FROM dual;	-- ababx
							-- c����. ababx
							-- a�� a, b�� b, c�� ����
	
			SELECT TRANSLATE('2KRW139', '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ', 
			'0123456789XXXXXXXXXXXXXXXXXXXXXXXXXX') FROM dual; -- 2XXX229

			SELECT TRANSLATE('2KRW139', '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ', 
			'0123456789') 
			FROM dual; -- 2139   --> ���ĺ��� ��� ����
			
    ------------------------------------------------------------------------	
    ------------------------------------------------------------------------	
 -- �� ������ ��¥ �Լ�
    -- ��  ��¥�� ������ ����
			-- ��¥ + ���� : ���ڸ�ŭ �� �� (�ϼ�)�� ����
			-- ��¥ - ���� : ���ڸ�ŭ �� �� (�ϼ�)�� ��
			-- ��¥ + ����/24 : ���ڸ�ŭ �ð��� ����
			-- ��¥1 - ��¥2 : ��¥1���� ��¥2�� ���� �� ��¥ ������ �ϼ��� ���´�.
			
			SELECT SYSDATE FROM dual; -- �ý��� ��¥ �� �ð�(�𺧷��� : 23/02/28 => RR/MM/DD)
			
			SELECT SYSDATE - 1 FROM dual;	-- ���ó�¥ �� �ð� - 1��
			SELECT SYSDATE - 1/24 FROM dual;	-- ���ó�¥ �� �ð� - 1�ð�
			SELECT SYSDATE - 1/24/60 FROM dual;	-- ���ó�¥ �� �ð� - 1��
			
			SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS' ) FROM dual;
						-- ��¥�� ���ڷ� ��ȯ.

			SELECT TO_DATE('2000-10-10','YYYY-MM-DD' ) FROM dual;
						-- ���ڸ� ��¥�� ��ȯ.
						
			-- 30�� �� 
			SELECT TO_CHAR(SYSDATE+30/24/60,'YYYY-MM-DD HH24:MI:SS' ) FROM dual;
						
			-- ��ƿ� �� �� 
			SELECT TRUNC(SYSDATE-TO_DATE('1999/07/12','YYYY/MM/DD'))FROM dual;
		
			-- ���� ��
			SELECT TO_DATE('2018/10/13','YYYY/MM/DD')+100 FROM dual;
			
			-- emp ���̺��� �Ի����� 100���� ���� �ʴ� ��� ���(name, hireDate, �ٹ��ϼ�)
			SELECT name, hireDate, TRUNC(SYSDATE - hireDate) �ٹ��ϼ�
			FROM emp
			WHERE SYSDATE - hireDate < 100;
			
			
	
    -- ��  INTERVAL Literals(���� ���ͷ�)�� �̿��� ��¥ ����
            -- 1���� ����
                SELECT SYSDATE  + (INTERVAL '1' YEAR) FROM dual;
        
            -- 1���� ����
                 SELECT SYSDATE  - (INTERVAL '1' YEAR) FROM dual;           
            
            SELECT SYSDATE + (INTERVAL '1' MONTH) FROM dual;
            SELECT SYSDATE + (INTERVAL '1' DAY) FROM dual;
            SELECT SYSDATE + (INTERVAL '1' HOUR) FROM dual;
            SELECT SYSDATE + (INTERVAL '1' MINUTE) FROM dual;
            SELECT SYSDATE + (INTERVAL '1' SECOND) FROM dual;
            SELECT SYSDATE + (INTERVAL '02:10' HOUR TO MINUTE) FROM dual;
            
            SELECT TO_CHAR(SYSDATE + (INTERVAL '02:10' HOUR TO MINUTE), 'YYYY-MM-DD HH24:MI:SS')FROM dual;

            SELECT TO_DATE('2023-03-31', 'YYYY-MM-DD') - (INTERVAL '1' MONTH) FROM dual;
                -- ����. 2�� 31�� ����
                
            SELECT TO_DATE('2023-03-31', 'YYYY-MM-DD') + (INTERVAL '1' DAY) FROM dual;
                -- 23/04/01
            ------------------------------------------------------
            -- emp ���� �ټӳ���� 1�� �̸��� ���(name, hireDate)
                SELECT name, hireDate
                FROM emp
                WHERE hireDate + (INTERVAL '1' YEAR) > SYSDATE;
            
            -- ������ 1�� 1��
                SELECT TRUNC(SYSDATE + (INTERVAL '1' YEAR),'YYYY') add_year
                FROM dual;  -- 24/01/01
                
                SELECT TO_CHAR(SYSDATE + (INTERVAL '1' YEAR),'YYYY')add_year
                FROM dual;  -- 2024
            
    -- ��  ��¥ �Լ� ����
       -- SYSDATE : ��ǻ�� �ý��� ��¥(YYYY-MM-DD HH24:MI:SS)
       -- CURRENT_DATE : ��ǻ�� �ý��� ��¥
       -- SYSTIMESTAMP : �и��ʱ��� ��ȯ
       
        SELECT SYSDATE, CURRENT_DATE FROM dual;  -- YYYY-MM-DD HH24:MI:SS
        SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') FROM dual;
        
        SELECT SYSTIMESTAMP FROM dual;      -- YYYY-MM-DD HH24:MI:SS.FF3;  --> �������� ���. FF�� ���� �Ҽ��� �ڸ� ����
        SELECT TO_CHAR(SYSTIMESTAMP,'YYYY-MM-DD HH24:MI:SS.FF3') FROM dual;

       -- EXTRACT( { YEAR | MONTH | DAY | HOUR | MINUTE | SECOND | TIMEZONE_HOUR | TIMEZONE_MINUTE | TIMEZONE_REGION | TIMEZONE_ABBR } FROM { expr } )
        -- ������ ��¥ �Ǵ� �ð� ����

        SELECT name, hireDate, EXTRACT(YEAR FROM hireDate) �Ի�⵵
        FROM emp;
        
        SELECT name, hireDate
        FROM emp
        WHERE EXTRACT(YEAR FROM hireDate) >=2010;
        
       -- MONTHS_BETWEEN(date1, date2) :  ��¥������ ���� ��ȯ     
    
            --  ���ڿ��� ��¥�� ��ȯ
                SELECT TO_DATE('2020-10-10','YYYY-MM-DD') FROM dual;   --> �Ʒ� ���� �̰� ����ؾ���.
                SELECT TO_DATE('2020-10-10') FROM dual; -- ȯ�漳���� ���� ������ ���� �� ����
                
            -- ��
                SELECT MONTHS_BETWEEN(TO_DATE('2021-05-20', 'YYYY-MM-DD'),
                        TO_DATE('2021-04-10','YYYY-MM-DD')) ����
                FROM dual;     -- 1.32258064516129032258064516129032258065
            
                SELECT MONTHS_BETWEEN(TO_DATE('2021-05-20', 'YYYY-MM-DD'),
                        TO_DATE('2021-04-20','YYYY-MM-DD')) ����
                FROM dual;      -- 1
                
                SELECT MONTHS_BETWEEN(TO_DATE('2021-05-19', 'YYYY-MM-DD'),
                        TO_DATE('2021-04-20','YYYY-MM-DD')) ����
                FROM dual;      -- 0.9677419354838709677419354838709677419355

            -- emp : name, hireDate, �ټӳ�� 
                SELECT name, hireDate,  TRUNC(MONTHS_BETWEEN(SYSDATE,hireDate)/12) �ټӳ��
                FROM emp;
    
            -- ����
                SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE('1999-07-12','YYYY-MM-DD'))/12) ����
                FROM dual;
                
            -- emp : empNo, name, rrn, birth, age, gender 
                SELECT empNo, name, rrn, TO_CHAR(TO_DATE(SUBSTR(rrn,1,6),'RRMMDD'),'YYYY-MM-DD') birth
                FROM emp;   -- RR�� ������ �߻��� �� �ִ�. ex) 49����� 2049�� ó��
                
                SELECT empNo,name,
                    CASE
                        WHEN SUBSTR(rrn,8,1) IN(1,2,5,6) THEN TO_DATE('19'||SUBSTR(rrn,1,6),'YYYYMMDD')
                        WHEN SUBSTR(rrn,8,1) IN(3,4,7,8) THEN TO_DATE('20'||SUBSTR(rrn,1,6),'YYYYMMDD')
                        ELSE TO_DATE('18'||SUBSTR(rrn,1,6),'YYYYMMDD')
                    END AS birth
                FROM emp;
                
                
               WITH tb AS(
                    SELECT empNo,name,rrn,
                        CASE
                            WHEN SUBSTR(rrn,8,1) IN(1,2,5,6) THEN TO_DATE('19'||SUBSTR(rrn,1,6),'YYYYMMDD')
                            WHEN SUBSTR(rrn,8,1) IN(3,4,7,8) THEN TO_DATE('20'||SUBSTR(rrn,1,6),'YYYYMMDD')
                            ELSE TO_DATE('18'||SUBSTR(rrn,1,6),'YYYYMMDD')
                        END birth  
                    FROM emp 
               ) 
               SELECT empNo, name, rrn, TO_CHAR(birth,'YYYY-MM-DD') birth,
                        TRUNC(MONTHS_BETWEEN(SYSDATE,birth)/12) age,
                        DECODE(MOD(SUBSTR(rrn,8,1),2),0,'����','����') gender
               FROM tb;
               
               
               -- emp ���̺��� ���� �������� ���� : name, rrn, birth
               WITH tb AS(
                    SELECT empNo,name,rrn,
                        CASE
                            WHEN SUBSTR(rrn,8,1) IN(1,2,5,6) THEN TO_DATE('19'||SUBSTR(rrn,1,6),'YYYYMMDD')
                            WHEN SUBSTR(rrn,8,1) IN(3,4,7,8) THEN TO_DATE('20'||SUBSTR(rrn,1,6),'YYYYMMDD')
                            ELSE TO_DATE('18'||SUBSTR(rrn,1,6),'YYYYMMDD')
                        END birth  
                    FROM emp 
               )  
               SELECT empNo, name, rrn, TO_CHAR(birth,'YYYY-MM-DD') birth
                FROM tb
                ORDER BY birth;
               
            
       -- ADD_MONTHS(date, integer) : d�� ����
            -- 2023-03-30 + 6���� =>  2023�� 9�� 30
            -- 2023-03-31 + 6���� =>  2023�� 9�� 30
            
            SELECT ADD_MONTHS(SYSDATE,1) ������ FROM dual;
            SELECT ADD_MONTHS(SYSDATE,-1) ������ FROM dual;
            SELECT ADD_MONTHS(TO_DATE('20230330','YYYYMMDD'),6),    -- �յ� ���� ���缭 YYYY-MM-DD / YYYYMMDD
                    ADD_MONTHS(TO_DATE('20230331','YYYYMMDD'),6)
            FROM dual;
            
            -- �ֱ� 6���� �̳��� �Ի��� ���(name, hireDate)
            SELECT name, hireDate
            FROM emp
            WHERE ADD_MONTHS(hireDate,6) > SYSDATE;


       -- LAST_DAY(date) : ���� ������ ��¥
            SELECT SYSDATE, LAST_DAY(SYSDATE) FROM dual;
            
            SELECT LAST_DAY(SYSDATE)- SYSDATE FROM duaL;    -- ������ ��¥���� ���� �ϼ�


       -- ROUND(date [, fmt ]) : ������ ������ ��¥�� �ݿø�
            -- �⵵ : 7�� 1�Ϻ��� �ݿø�
                SELECT ROUND(TO_DATE('2023-07-10','YYYY-MM-DD'),'YEAR') FROM dual;
                            -- 24/01/01
                SELECT ROUND(TO_DATE('2023-06-10','YYYY-MM-DD'),'YEAR') FROM dual;
                            -- 23/01/01
          
             -- �� : 16�� ����
                SELECT ROUND(TO_DATE('2023-07-20','YYYY-MM-DD'),'MONTH') FROM dual;
                            -- 23/08/01
                SELECT ROUND(TO_DATE('2023-07-10','YYYY-MM-DD'),'MONTH') FROM dual;
                            -- 23/07/01
                            
                            
       -- TRUNC(date [, fmt ]) : �ݳ��� 
                 SELECT TRUNC(TO_DATE('2023-07-10','YYYY-MM-DD'),'YEAR') FROM dual;
                             -- 23/01/01
                 SELECT TRUNC(TO_DATE('2023-07-20','YYYY-MM-DD'),'MONTH') FROM dual;
                             -- 23/07/01
                
                SELECT TRUNC(SYSDATE,'D') FROM dual;
                             -- 23/02/26.   D : �ָ� �������� ����.  �� ���� �Ͽ���
                
                SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')FROM dual;             
                SELECT TO_CHAR(TRUNC(SYSDATE), 'YYYY-MM-DD HH24:MI:SS')FROM dual;
                        -- �ú��ʰ� 0����
                        
                -- ���� 1�� 1�� ���� ���ñ��� ������ ��������?
                SELECT TRUNC(SYSDATE - TRUNC(SYSDATE,'YEAR'))
                FROM dual;
                
                -- ȫ�浿�� ������ 1995-10-15�� �Դϴ�. ���ϱ��� ���� �� ����?
                SELECT TRUNC(TO_DATE(EXTRACT(YEAR FROM SYSDATE) || SUBSTR('1995-10-15',5),
                            'YYYY-MM-DD') - TRUNC(SYSDATE)) �ϼ�
                FROM dual;
                
                -- emp : name, rrn, birth, ���ϱ��� ���� �� �� ( ��, ������ ���� ��� ������ϱ��� ���� �� �� )
                       WITH tb AS(
                SELECT empNo,name,rrn,
                    CASE--������ ���ϴ� ���ǹ�
                         WHEN SUBSTR(rrn,8,1)IN(1,2,5,6) THEN TO_DATE('19'||SUBSTR(rrn,1,6),'YYYYMMDD')--�ֹι�ȣ�� 1,2,5,6 �̸� 1900���
                         WHEN SUBSTR(rrn,8,1)IN(3,4,7,8) THEN TO_DATE('20'||SUBSTR(rrn,1,6),'YYYYMMDD')--�ֹι�ȣ�� 3,4,7,8 �̸� 1900���
                         ELSE TO_DATE('18'||SUBSTR(rrn,1,6),'YYYYMMDD')--������ 1800���
                     END  birth,--���ǹ� �� ����ο�
                    TO_DATE(EXTRACT(YEAR FROM SYSDATE)|| SUBSTR(rrn,3,4),'YYYYMMDD') sdate--���� ������
            FROM emp
            )
            SELECT empNo,name,rrn,TO_CHAR(birth,'YYYY-MM-DD')birth,
                CASE
                    WHEN TRUNC(SYSDATE)<= sdate THEN sdate - TRUNC(SYSDATE)
                    ELSE(sdate + (INTERVAL '1' YEAR)) - TRUNC(SYSDATE)
                END AS �����ϼ�
            FROM tb;
                
       -- NEXT_DAY(date, char) : date ������ char �̸����� ������ ù��° ������ ��¥ ��ȯ
            -- char�� ���ڵ� ����(1: �Ͽ���, ... 7:�����)
            
            -- ������ �������� ���� ����� �����
                SELECT SYSDATE, NEXT_DAY(SYSDATE,'�����') FROM dual;
                SELECT SYSDATE, NEXT_DAY(SYSDATE,7) FROM dual;

            -- ������ �������� ���� ����� ������
                SELECT SYSDATE, NEXT_DAY(SYSDATE,4) FROM dual;                

            -- ����, �̹��� �Ͽ���, �̹��� �����
                SELECT SYSDATE ��¥, 
                                NEXT_DAY(SYSDATE,1)-7 �Ͽ���,
                                NEXT_DAY(SYSDATE-1,7) �����
                FROM dual;
                

            -- 2023-03-04�� �ִ� ���� �Ͽ���,�����
                SELECT TO_DATE('2023-03-04', 'YYYY-MM-DD') ��¥, 
                                NEXT_DAY(TO_DATE('2023-03-04','YYYY-MM-DD'),1)-7 �Ͽ���,
                                NEXT_DAY(TO_DATE('2023-03-04','YYYY-MM-DD')-1,7) �����
                FROM dual;
                
                
 -------------------------------------------------------------------------------------------               
 -- �� ������ ��ȯ �Լ�
    -- �� �Ͻ���(implicitly) �� ��ȯ : �ڵ����� ����ȯ
        VARCHAR2, CHAR -> NUMBER
        VARCHAR2, CHAR -> DATE
        NUMBER -> VARCHAR2
        DATE -> VARCHAR2
        
        SELECT 30 + '30' FROM dual; -- �ڵ����� ���ڰ� ���ڷ� ��ȯ
        SELECT 30 + '1,000' FROM dual;   -- ����
        
        SELECT 30 || '30' FROM dual;    -- 3030, �ڵ����� ���ڰ� ���ڷ� ��ȯ
        SELECT 30 || '��' FROM dual;
        

    -- �� ��ȭ��ȣ, ��¥ �� ��� ����
      -- ��ȭ��ȣ, ��¥ ���� ��� ���� Ȯ��
         SELECT * FROM NLS_SESSION_PARAMETERS;


      -- ������ ���� ���� :  KOREAN���� ����
         ALTER SESSION SET NLS_LANGUAGE ='KOREAN';

      -- ��ȭ��ȣ ���� : �ܷ� ����
         ALTER SESSION SET NLS_CURRENCY ='��';

      -- ��¥ ��� ���� ���� : KOREAN �������� ����
         ALTER SESSION SET NLS_DATE_LANGUAGE ='KOREAN';

      -- ��¥ ��� ���� ����(����Ʈ : RR/MM/DD)
         ALTER SESSION SET NLS_DATE_FORMAT ='YYYY-MM-DD';
         SELECT SYSDATE FROM dual;

         ALTER SESSION SET NLS_DATE_FORMAT ='RR/MM/DD';
         SELECT SYSDATE FROM dual;


    -- �� ��ȯ �Լ�
       -- TO_CHAR(n [, fmt [, 'nlsparam' ] ])  : ���ڸ� ���Ŀ� ���� VARCHAR2�� ��ȯ        
        
            SELECT TO_CHAR(12345,'999,999') FROM dual;
            SELECT TO_CHAR(12345,'9,999') FROM dual;        -- > ######. ����!!!!!!!!!!!!! �ڸ��� �����ϸ� #. �ڸ��� �� ������

            SELECT TO_CHAR(12345,'9,999,999') FROM dual;   -- ����12,345
            SELECT TO_CHAR(12345,'0,999,999') FROM dual;   --  0,012,345

            SELECT TO_CHAR(12.67,'99') FROM dual;   -- 13
            SELECT TO_CHAR(12.37,'99') FROM dual;   -- 12
            
            SELECT TO_CHAR(12.667,'99.9') FROM dual;    -- 12.7
            
            SELECT TO_CHAR(0.03,'99.9') FROM dual;    --   .0
            SELECT TO_CHAR(0.03,'90.9') FROM dual;    --   0.0
            SELECT TO_CHAR(0.03,'90.0') FROM dual;    --   0.0            
            SELECT TO_CHAR(0.03,'99') FROM dual;    --   0
            
            SELECT TO_CHAR(-1234, '99999') FROM dual;   --   -1234
            SELECT TO_CHAR(1234,'99999MI') FROM dual;    --   1234  
            SELECT TO_CHAR(-1234,'99999MI') FROM dual;   --   1234-
            
            SELECT TO_CHAR(1234,'99999PR') FROM dual;    --   1234  
            SELECT TO_CHAR(-1234,'99999PR') FROM dual;    --   <1234>
            
            SELECT TO_CHAR(1234,'99999V9999') FROM dual;    --   12340000
            
            SELECT TO_CHAR(1234,'L9,999,999') FROM dual;    --   ��1,234 
            
            SELECT TO_CHAR(1234,'9,999,999')||'��' FROM dual;    --   1,234��

            SELECT name, TO_CHAR(sal+bonus, 'L9,999,999') pay              
            FROM emp;
            
            
       -- TO_CHAR({ datetime | interval } [, fmt [, 'nlsparam' ] ]) : ��¥�� VARCHAR2�� ��ȯ
          SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY HH24:MM:SS') FROM dual;
         
          SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DY HH24:MM:SS') FROM dual;
          
          -- 2020�� 10�� 10��
            SELECT name, TO_CHAR(hireDate, 'YYYY"��" MM"��" DD"��" DAY') hireDate  -- ""�� ���־���.
            FROM emp;
            
            SELECT name, hireDate
            FROM emp
            WHERE EXTRACT(YEAR FROM hireDate)=2023;     --> ����
            
            SELECT name, hireDate
            FROM emp
            WHERE TO_CHAR(hireDate,'YYYY')=2023;        --> ����. ����ȯ�� �Ǿ ����
            
           -- ���� �ѱ�, ����
           SELECT TO_CHAR(SYSDATE, 'MON DD DAY') ����Ʈ,
           TO_CHAR(SYSDATE, 'MON DD DAY', 'NLS_DATE_LANGUAGE=american')en,
           TO_CHAR(SYSDATE, 'MON DD DAY','NLS_DATE_LANGUAGE=korean') ko
           FROM dual;
           
           SELECT TO_CHAR(SYSDATE, 'MON DD DAY') ����Ʈ,
           TO_CHAR(SYSDATE, 'month DD dy', 'NLS_DATE_LANGUAGE=american')en,  -- ��ҹ��� �ٸ��� �ָ� �ٸ��� ����
           TO_CHAR(SYSDATE, 'Month DD Dy','NLS_DATE_LANGUAGE=american') en2
           FROM dual;
          
          -- w : ����������(1��~7�� : 1��, 8��~14�� : 2��...)
            -- ww : ���������(1�� 1��~ 1��7��: 1��...)
            -- iw : ���������(�ִ� �������� ����, ������ ù�ֿ��� 1�� 4���� ����, ������ �������� 1�� 1,2,3���� ���Ե� �� ����)
            SELECT SYSDATE ����,
                TO_CHAR(SYSDATE,'D') ���ڿ���,
                TO_CHAR(TRUNC(SYSDATE,'D'),'YYYY-MM-DD') �̹����Ͽ���,
                TO_CHAR(SYSDATE,'w') ����������,
                TO_CHAR(SYSDATE,'ww') ���������1,
                TO_CHAR(SYSDATE,'iw') ���������2
            FROM dual;
            
          -- emp ���̺�
            -- ȸ���� ������ 60���̴�. ���� ���̰� 60�� �ʰ��ϸ�  "�����ʰ�", ���� �����̸� "��������", 
                -- �׷��� ������ ���� �Ⱓ(�� : 20)�� ����Ѵ�.
            -- name, birth, age, ������� ���� �Ⱓ
           -- HINT: TO_CHAR, CASE
            WITH tb AS(
                    SELECT empNo,name,rrn,
                        CASE
                            WHEN SUBSTR(rrn,8,1) IN(1,2,5,6) THEN TO_DATE('19'||SUBSTR(rrn,1,6),'YYYYMMDD')
                            WHEN SUBSTR(rrn,8,1) IN(3,4,7,8) THEN TO_DATE('20'||SUBSTR(rrn,1,6),'YYYYMMDD')
                            ELSE TO_DATE('18'||SUBSTR(rrn,1,6),'YYYYMMDD')
                        END birth  
                    FROM emp 
               )  
               SELECT empNo, name, rrn, TO_CHAR(birth,'YYYY-MM-DD') birth,
                        TRUNC(MONTHS_BETWEEN(SYSDATE, birth)/12) age, 
                        CASE
                            WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, birth)/12) > 60 THEN '�����ʰ�'
                            WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, birth)/12) = 60 THEN '��������'
                            ELSE TO_CHAR(60 - TRUNC(MONTHS_BETWEEN(SYSDATE, birth)/12)) --> ���� ���ڷ� �������༭ �� �κе� ���ڷ�!
                        END ����
                FROM tb;
            
            
          
       -- TO_NUMBER(expr [ DEFAULT return_value ON CONVERSION ERROR ] [, fmt [, 'nlsparam' ] ])
            SELECT '23' + 12, TO_NUMBER('23') + 12 FROM dual;
            
            SELECT '1,234' + 12 FROM dual;  -- ����
            
            SELECT REPLACE ('1,234',',') +12 FROM dual;
            SELECT TO_NUMBER('1,234','99,999') + 12 FROM dual;
            
    
       -- TO_DATE(char [ DEFAULT return_value ON CONVERSION ERROR ] [, fmt [, 'nlsparam' ] ])
        -- ���ڸ� ��¥�� ��ȯ
            
            -- YY : �ý��� ��¥ ����
            SELECT TO_CHAR(TO_DATE('95-10-10','YY-MM-DD'),'YYYY-MM-DD') FROM dual;
                -- 2095-10-10   --> Y 1,2,3���Ἥ�� �ȵ�
             
             -- RR 
            SELECT TO_CHAR(TO_DATE('95-10-10','RR-MM-DD'),'YYYY-MM-DD') FROM dual;   
                -- 1995-10-10
            SELECT TO_CHAR(TO_DATE('48-10-10','RR-MM-DD'),'YYYY-MM-DD') FROM dual;
                -- 2048-10-10   --> ����...... RR�� ���� �ʳ�....  �׳� YYYY �� ���� ����
                
            SELECT TO_DATE('901010','RRMMDD') FROM dual;
            SELECT TO_DATE('991010') FROM dual; -- �ý����� ȯ���� ���� ������ �߻��� �� �ִ�.
            
            SELECT TO_DATE('1999-10-10','YYYY-MM-DD') FROM dual;
            SELECT TO_DATE('1999-10-10') FROM dual;
            
            -- '01-7��-08' (2008�� 7�� 1��)�� ��¥ �������� ��ȯ
            SELECT TO_DATE('01-7��-08','DD-MON-RR') FROM dual;

                
       -- TO_TIMESTAMP(char [ DEFAULT return_value ON CONVERSION ERROR ] [, fmt [, 'nlsparam' ] ])
           -- ���ڸ� TIMESTAMP�� ��ȯ
            SELECT SYSDATE, SYSTIMESTAMP
            FROM dual;
            
            SELECT TO_CHAR(SYSTIMESTAMP,'YYYY-MM-DD HH24:MI:SS.FF3')
            FROM dual;          
            
            SELECT TO_TIMESTAMP('2023-03-02 15:26:10.600','YYYY-MM-DD HH24:MI:SS.FF3') 
            FROM dual;
            

 -- �� NULL ���� �Լ�
    -- �� ����
        -- ���̰� 0�� ���ڵ� null
        -- null�� ���Ե� ������ ��� null�� �ȴ�.
           SELECT 10+NULL FROM dual;
        -- exrp IS [NOT] NULL : null���� Ȯ��

    -- �� NULL ���� �Լ�
       -- NVL(expr1, expr2) : expr1�� null�� �ƴϸ� expr1�� ��ȯ�ϰ� null�̸� expr2�� ��ȯ
       -- �̰� �˾ƾ���!!!!!!!!!!!!!!!!!!!!!!
            
            SELECT name, NVL(tel,',��ȭ����. ����') FROM emp;
            SELECT name, NVL(tel,',��ȭ����. ����') tel
            FROM emp
            WHERE tel IS NULL;

       -- userEx ���̺�
            CREATE TABLE userEx (
                 empNo  VARCHAR2(10) PRIMARY KEY,
                 name    VARCHAR2(30) NOT NULL,
                 sal        NUMBER(10)   NOT  NULL,
                 bonus   NUMBER(10)
            );
            INSERT INTO userEx(empNo, name, sal, bonus) VALUES ('1001', '����Ŭ', 2200000, 300000);
            INSERT INTO userEx(empNo, name, sal, bonus) VALUES ('1002', '������', 2300000, 200000);
            INSERT INTO userEx(empNo, name, sal, bonus) VALUES ('1003', '���ڹ�', 2300000, NULL);
            INSERT INTO userEx(empNo, name, sal, bonus) VALUES ('1004', '����', 1900000, 200000);
            INSERT INTO userEx(empNo, name, sal, bonus) VALUES ('1005', '����ũ', 1700000, NULL);
            COMMIT;

            SELECT * FROM tab;
            SELECT empNo, name, sal, bonus FROM userEx;
            
            -- userEx : empNo, name, sal, bonus, sal+bonus pay
             SELECT empNo, name, sal, bonus, sal+bonus pay FROM userEx;
            
             SELECT empNo, name, sal, bonus, sal+NVL(bonus,0) pay FROM userEx;
       
       
       -- NVL2(expr1, expr2, expr3)
            SELECT name, tel, NVL2(tel,'�ִ�', '����') FROM emp;
            SELECT name, tel, NVL2(tel,tel, '����') FROM emp;
            
       -- NULLIF(expr1, expr2) : expr1�� expr2�� ������ null
            SELECT NULLIF(1,1), NULLIF(1,2) FROM dual; -- null 1

       -- COALESCE(expr [, expr ]...) : null�� �ƴ� ù��° ��
            SELECT COALESCE(null,1,2) FROM dual;    -- 1 

