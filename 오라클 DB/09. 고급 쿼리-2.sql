-- �� ��� ����
 -- �� ���Խ�(Regular Expression) - �ֿ� �Լ�
    -- 1) REGEXP_LIKE(source_char, pattern [, match_parameter ] )
       -- : ������ ���Ե� ���ڿ� �˻�
       ---------------------------------------
       -- 
       SELECT * FROM reg;
       
       -- �̸��� �� �Ǵ� ������ �����ϴ� ���ڵ�
       SELECT * FROM reg
       WHERE REGEXP_LIKE(name,'^[�ѹ�]');
       
       -- �̸��� �������� ���ϴ� ���ڵ�
       SELECT * FROM reg
       WHERE REGEXP_LIKE(name,'����$');   
       
       -- �̸����� com���� ������ ���ڵ�
       SELECT * FROM reg
       WHERE REGEXP_LIKE(email,'com$'); -- ��ҹ��� ����
       
       -- �̸����� com���� ������ ���ڵ�
       SELECT * FROM reg
       WHERE REGEXP_LIKE(email,'com$','i'); -- ��ҹ��� ���� ����
       
       -- �̸��Ͽ� kim �� ���Ե� ���ڵ�
       SELECT * FROM reg
       WHERE REGEXP_LIKE(email,'kim');

       SELECT * FROM reg
       WHERE email LIKE('%kim%');

       -- �̸����� "kim3" ������ �ϳ� �Ǵ� 0���� 3�� ������ 3�� �����ϴ� ���ڵ� 
       SELECT * FROM reg
       WHERE REGEXP_LIKE(email,'kim3?3');    
       
       --  �̸����� "kim" ������ 0~3 ������ ���ڰ� 2���̻� �ݺ��ϴ� ���ڵ�
       SELECT * FROM reg
       WHERE REGEXP_LIKE(email,'kim[0-3]{2}');       
        
       --  �̸����� "kim" ������ 2~3 ������ ���ڰ� 3~4�� �ݺ��ϴ� ���ڵ�
       SELECT * FROM reg
       WHERE REGEXP_LIKE(email,'kim[2-3]{3,4}');        
       
       -- ����
       SELECT * FROM reg
       WHERE REGEXP_LIKE(email,'kim[^1]');  -- kim ������ 1�� �ƴ�
       
       SELECT * FROM reg
       WHERE REGEXP_LIKE(email,'^[^k]'); -- k�� �������� �ʴ�
       
       -- �ѱ�
       SELECT * FROM reg
       WHERE REGEXP_LIKE(name, '^[��-�R]{1,10}$');
       
       -- ���ڰ� �ִ� �̸���
       SELECT * FROM reg
       WHERE REGEXP_LIKE(email, '[[:digit:]]');
       
       SELECT * FROM reg
       WHERE REGEXP_LIKE(email, '[0-9]');
       
       -- ������
       SELECT * FROM reg
       WHERE REGEXP_LIKE(name, '[a-z|A-Z]');       
       
       
    -- 2) REGEXP_REPLACE(source_char, pattern [, replace_string [, position [, occurrence[, match_parameter ] ] ] ])
       -- : ������ ���Ե� ���ڿ��� �ٸ� ���ڿ��� ġȯ
       ---------------------------------------
       --
       SELECT REGEXP_REPLACE('!1234^{}<>~12����,.Ư������_Test','[0-9]','')
       FROM dual;

       SELECT REGEXP_REPLACE('!1234^{}<>~12����,.Ư������_Test','[[:digit:]|[:punct:]]','')
       FROM dual;
            -- [:digit:] : ����, [:punct:] : Ư������
        
        SELECT name, rrn FROM emp;
        SELECT name, REGEXP_REPLACE(rrn,'[0-9]','*',9) rrn FROM emp;
                -- 9��° ���ں��� [0-9]���ڸ� *�� ġȯ
        



    -- 3) REGEXP_INSTR (source_char, pattern [, position [, occurrence [, return_option [, match_parameter ] ] ] ] )
       -- : ������ ���Ե� ���ڿ��� ��ġ ��ȯ
       ---------------------------------------
       --
       SELECT name, tel,REGEXP_INSTR(tel,'[-]') ��ġ FROM emp;
       SELECT name, tel,REGEXP_INSTR(tel,'[\-]') ��ġ FROM emp;

       SELECT name, tel
       FROM emp
       WHERE regexp_instr(name,'^[^�̱�]')=1;  -- �̾� �达 ����
        
        
        
    -- 4) REGEXP_SUBSTR(source_char, pattern [, position [, occurrence [, match_parameter ] ] ] )
       -- : ���ڿ��� �����ϴ� ���Ϲ��ڿ��� ��ȯ
       ---------------------------------------
       --


    -- 5) REGEXP_COUNT (source_char, pattern [, position [, match_param]])
       -- : ���ڿ��� �����ϴ� ���Ϲ��ڿ��� ���� ��ȯ
       ---------------------------------------
       --
       -- email ���� a ����
       SELECT email, REGEXP_COUNT(email,'a') FROM reg;

