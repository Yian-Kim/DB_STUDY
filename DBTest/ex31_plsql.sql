-- hr > ex31_plsql.sql

/*

PL/SQL
- Procedural Language Extensions to SQL > ANSI SQL + 프로그래밍 기능
- ANSI SQL : 비 절차성 언어(명령어들간의 순서가 없음. 연속적이지 않다. 독립적인 문장 단위 실행)
- ANSI SQL + 절차적 기능 추가 -> 오라클(PL/SQL)
- 추가된 부분 : 변수, 제어문, 함수 등..
- 오라클 전용 SQL

ANSI SQL 자료형 = PL/SQL 자료형 : 거의 유사함
ANSI SQL 문장 종결자 선택
PL/SQL 문장 종결자 필수


SQL 처리 과정 & 순서

1. ANSI SQL
    - 클라이언트 구문 작성(select 문) > 실행(Ctrl + Enter) > 네트워크를 통해 SQL(문자열)이
        DBMS에게 전달 > DBMS가 전달 받음 > 구문 분석(파싱) > 컴파일(인터프리터) > 기계어(명령어)
            > 실제 실행(CPU) > 결과 처리(ResultSet) > 클라이언트에게 반환
    - 동일한 쿼리를 다시 실행 > 위의 과정을 처음부터 끝까지 동일하게 실행(반복)

2. PL/SQL
    - 클라이언트 구문 작성(select 문) > 실행(Ctrl + Enter) > 네트워크를 통해 SQL(문자열)이
        DBMS에게 전달 > DBMS가 전달 받음 > 구문 분석(파싱) > 컴파일(인터프리터) 
        > 컴파일 결과를 서버에 저장 > 기계어(명령어) > 실제 실행(CPU) 
        > 결과 처리(ResultSet) > 클라이언트에게 반환
    - 동일한 쿼리를 다시 실행 > PL/SQL의 이름을 전송



프로시저, Procedure
- 메소드, 함수, 서브루틴 등..
- 특정 목적을 가지고 모인 순서대로 실행하는 명령어의 집합
- SQL의 집합

1. 익명 프로시저
- 이름 없음
- 재사용을 목적으로 하지 않는다. > 1회용
- 개발용(테스트용)
- 동작 방식이 ANSI-SQL과 거의 동일하다.

2. 실명 프로시저
- 이름 있음
- 재사용이 가능하다. > 여러번 반복해서 사용한다.
- 실무용(운영할때)
- 동작 방식이 PL/SQL 식으로 동작한다.(재사용할 수록 비용 절감)

*/
set serveroutput on; --접속할 때마다 실행

begin
    dbms_output.put_line('Hello'); --System.out.println("Hello");
end;


/*

PL/SQL 프로시저 블럭
1. 4개의 키워드(블럭)로 구성
    a. [declare]
    b. begin
    c. [exception]
    d. end;

2. declare
- 선언부, declare block, declare section
- 프로그램에서 사용하는 변수, 객체 등을 선언하는 영역
- 생략 가능

3. begin
- begin ~ end
- 실행부, 구현부, executable section(block)
- 프로그램에서 구현할 실제 SQL을 작성하는 영역(ANSI-SQL + PL/SQL)
- 생략 불가능

4. exception
- 예외 처리부, exceptoin section(block)
- catch 절 역할
- 예외 처리 코드를 작성하는 영역
- 생략 가능

5. end;
- 블럭의 종료
- 생략 불가능

6. PL/SQL 블럭 = 선언부 + 구현부 + 예외처리부

자바
{
    {
    
    }
}

오라클
begin
    begin
    
    end;
end;



자료형 & 변수

자료형
- 표준 SQL과 거의 동일

변수 선언하기
- 변수명 자료형 [not null] [default 값];
- 표준 SQL의 컬럼 정의와 유사한 문법 제공
- 변수의 역할 : 질의(select)의 결과를 저장 or 인자값을 저장

연산자
- 표준 SQL과 동일

표준 SQL 대입 연산자
- 컬럼명 = 값; -- update tblinsa set buseo = '영업부';
- 용도 : 컬럼값 대입

PL/SQL 대입 연산자
- 변수 := 값;
- 용도 : 변수값 대입

*/

-- 프로시저 선언
begin
    --1. ANSI-SQL
    --2. PL/SQL
end;



declare
    num number; --number : PL/SQL 자료형
    name varchar2(30);
    today date;
begin
    
    num := 10; --값 초기화, 10(정수형 상수 - 표준 SQL과 동일)
    dbms_output.put_line(num);
    
    name := '홍길동';
    dbms_output.put_line(name);
    
    today := sysdate;
    dbms_output.put_line(today);
    dbms_output.put_line(to_char(today, 'yyyy-mm-dd'));
    
    --ORA-06502: PL/SQL: numeric or value error: character string buffer too small
    name := '가나다라마바사아자차카타파하';
    dbms_output.put_line(name);
    
end;





declare
    num1 number;
    num2 number not null := 10; --PLS-00218: a variable declared NOT NULL must have an initialization assignment
    num3 number default 100; --변수 초기화 용도로 잘 사용한다.
    num4 number not null default 300; --num2보다 이 표현으로 초기화를 한다.
begin
    -- 변수를 초기화하지 않은 상태에서 호출 > 사용 가능(null)
    dbms_output.put_line('num1 : ' || num1);
    
    -- not null 선언 변수는 사용 유무와 상관없이 반드시 값을 가져야 한다.
    num2 := 20;
    dbms_output.put_line(num2);
    
    num3 := 200;
    dbms_output.put_line(num3);
    
    dbms_output.put_line(num4);
    
end;


-- 테이블에서 조회한 데이터를 변수에 담기
declare
    vbuseo varchar2(15);
begin

    --vbuseo := (select buseo from tblinsa where name = '홍길동');
    
    --select의 결과를 변수에 넣는 방법 > into
    select buseo into vbuseo from tblinsa where name = '홍길동';
    dbms_output.put_line(vbuseo);
    
end;


declare
    vcnt number;
begin
    select count(*) into vcnt from tblinsa where buseo = '기획부';
    dbms_output.put_line(vcnt);
end;




declare
    vbuseo varchar2(15);
    vname varchar2(15);
begin
    select buseo into vbuseo from tblinsa where name = '김영길';
    select name into vname from tblinsa where buseo = vbuseo and jikwi = '부장';
    dbms_output.put_line(vname);
end;


declare

begin  
    -- PLS-00428: an INTO clause is expected in this SELECT statement
    select name from tblinsa where num = 1001;
end;



declare
    vcnt varchar2(50); -- 형변환이 가능한 상황에서는 적당한 암시적 형변환이 발생한다.
begin
    select count(*) into vcnt from tblinsa;
    dbms_output.put_line(vcnt);
end;



declare
    vbuseo varchar2(5); --원래 buseo 컬럼의 길이가 생각이 안남;; > 적당히 100으로 잡음
begin
    -- '기획부' 9바이트 > vbuseo 100바이트 //문제 없음
    -- '기획부' 9바이트 > vbuseo 5바이트 //에러 발생
    select buseo into vbuseo from tblinsa where name = '홍길동';
    dbms_output.put_line(vbuseo);
end;


declare
    vname varchar2(15);
begin
    select name into vname from tblinsa; -- 결과셋의 레코드가 2개 이상일 때 에러 발생
    dbms_output.put_line(vname);
end;


declare
    변수???
begin
    select * from tblinsa where name = '홍길동';
end;








-- 프로시저(=메소드)
-- 반복해서 사용 쿼리 or 의미있는 쿼리 > 집합
-- ANSI-SQL에는 없었던 절차가 생겼음 > 쿼리의 실행 순서가 생김

set serveroutput on;

declare
    vcouple varchar2(30);
    vheight number;
begin
    
    select couple into vcouple from tblMen where name = '홍길동';
    dbms_output.put_line(vcouple);
    
    -- 질의 결과를 다른 질의에서 사용(PL/SQL 변수의 목적)
    select height into vheight from tblWomen where name = vcouple;
    dbms_output.put_line(vheight);
    
end;



-- 위의 쿼리(into 절)
-- : 질의의 결과가 단일행 + 단일컬럼이어야 한다.(=원자값)
-- : 단일행 + 단일컬럼 질의
--      a. PK 조건(유일한 행) + 단일컬럼(select 절) = 원자값 반환
--      b. 집계 함수 결과

-- 반환되는 컬럼의 개수를 여러개 받을 경우 + 행의 개수는 1개
-- : N개의 컬럼 => N개의 변수 //개수 일치!!!
-- : 컬럼집합 into 변수집합
-- : 각집합의 개수와 순서(*****)
declare
    vname varchar2(20);
    vbuseo varchar2(50);
    vjikwi varchar2(50);
    vbasicpay number;
    vcnt number;
begin
    select 
        name, buseo, jikwi, basicpay, (select count(*) from tblinsa where buseo = i.buseo)
        into 
        vname, vbuseo, vjikwi, vbasicpay, vcnt
    from tblinsa i where name = '홍길동';
    
    --dbms_output.put_line(buseo);
    dbms_output.put_line(vname);
    dbms_output.put_line(vbuseo);
    dbms_output.put_line(vjikwi);
    dbms_output.put_line(vbasicpay);
    dbms_output.put_line(vcnt);
end;








/*
참조형
- 원본(컬럼)의 자료형을 오라클이 참조해서 변수의 자료형으로 사용한다.
- 개발자가 원본(컬럼)의 자료형을 몰라도 된다.
- 유지 보수 유리

1. %type
- 대상 컬럼의 자료형과 길이를 참조

2. %rowtype
- 대상 테이블의 레코드를 참조(모든 컬럼)
- %type의 집합

*/
declare
    --vname varchar2(30);
    vname tblinsa.name%type;
    vbuseo tblinsa.buseo%type;
    vbasicpay tblinsa.basicpay%type;
begin
    select 
        name, buseo, basicpay
        into
        vname, vbuseo, vbasicpay
    from tblinsa
        where (basicpay + sudang) = (select min(basicpay + sudang) from tblinsa); --심심해
    
    dbms_output.put_line(vname);
    dbms_output.put_line(vbuseo);
    dbms_output.put_line(vbasicpay);
end;



-- tblinsa. 직원 중 일부에게 보너스 지급. 지급 후 지급 내역 보관
create table tblBonus
(
    seq number primary key, --일련번호(PK)
    insaseq number references tblInsa(num) not null, --직원 번호(FK)
    bonus number not null --보너스 금액
);
create sequence bonus_seq;

declare
    --vnum number;
    --vsudang number;
    vnum tblinsa.num%type;
    vsudang tblinsa.sudang%type;
begin
    
    --1. 지급할 특정 직원 검색(1명) : select
    select num, sudang into vnum, vsudang from tblinsa
        where city = '제주' and jikwi = '부장' and to_char(ibsadate, 'yyyy') = '2005';
    
    -- 수당, 직원번호
    --2. 직원 수당 * 3 -> 보너스로 지급 : insert
    insert into tblbonus (seq, insaseq, bonus) 
        values (bonus_seq.nextval, vnum, vsudang * 3);
    
    dbms_output.put_line('지급 완료');
    
end;

select * from tblbonus;

create view vwBonus
as
select i.name, i.buseo, i.jikwi, i.sudang, b.bonus from tblbonus b
    inner join tblinsa i
        on i.num = b.insaseq
            where b.seq = 1;





-- 할일들 > 가장 오랫동안 하지 않은 일 > 포기 > 삭제
select * from tbltodo;

select * from tbltodo where completedate is null;

--가장 오래된 일
--1. 서브쿼리
select * from tbltodo
    where adddate = (select min(adddate) from tbltodo where completedate is null);

--2. rownum
select a.*, rownum from
    (select * from tbltodo where completedate is null order by adddate asc) a
        where rownum = 1;


delete from tbltodo where seq = 6; --좀 있다가 실행

commit;
rollback;

declare
    vseq tbltodo.seq%type;
    vtitle tbltodo.title%type;
begin
    select seq, title into vseq, vtitle from tbltodo
        where adddate = (select min(adddate) from tbltodo where completedate is null);
    delete from tbltodo where seq = vseq;
    dbms_output.put_line(vtitle || ' - 삭제 완료');
end;

select * from tbltodo;

-- PL/SQL 프로시저 구성 블럭
-- 프로시저 변수 생성
-- select 결과 > 단일값 > 변수 대입(into)
-- select 결과 > 단일레코드 + 다중컬럼값 > 변수 대입(into)
-- 변수값을 여러 select, insert, update, delete문에 사용하기
-- 참조형 변수(변수명 테이블명.컬럼%type)

declare
    --참조형 변수 생성 + 컬럼 개수가 많을 경우
    --vnum tblinsa.num%type;
    --vname tblinsa.name%type;
    --vssn tblinsa.ssn%type;
    --7개 선언
    
    vrow tblinsa%rowtype; -- 행 전체를 담을 수 있는 변수(모든 컬럼)
    
begin
    --select num, name, ssn, city, tel, buseo, jikwi into vrow from tblinsa
    --    where num = 1001;
    select * into vrow from tblinsa
        where num = 1001;
    
    --dbms_output.put_line(vnum);
    --dbms_output.put_line(vname);
    
    --dbms_output.put_line(vrow);
    --dbms_output.put_line(vrow.요소명);
    --dbms_output.put_line(vrow.컬럼명);
    dbms_output.put_line(vrow.num);
    dbms_output.put_line(vrow.name);
    dbms_output.put_line(vrow.buseo);
    dbms_output.put_line(vrow.jikwi);
end;



declare
    vrow tblinsa%rowtype; --레코드 참조 변수
    vnum tblinsa.num%type; --컬럼 참조 변수
begin
    
    select num, name into vrow.num, vrow.name from tblinsa
        where name = '유관순'; --1011
    
    select * into vrow from tblinsa 
        where buseo = (select buseo from tblinsa where num = vnum) 
            and jikwi = '부장' and rownum = 1;
    
    dbms_output.put_line(vrow.name);
    dbms_output.put_line(vrow.jikwi);
    dbms_output.put_line(vrow.buseo);
    dbms_output.put_line(vrow.tel);
    
end;





/*
제어문
- 조건문 > if문
*/
set serveroutput on;

declare
    vnum number;
begin

    vnum := -10;
    
    if vnum > 0 then -- {
        dbms_output.put_line('양수');
    end if; -- }
    
    if vnum > 0 then   
        dbms_output.put_line('양수');
    else
        dbms_output.put_line('음수');
    end if;
    
    if vnum > 0 then
        dbms_output.put_line('양수');
    elsif vnum < 0 then -- else if (), elseif (), elsif ()
        dbms_output.put_line('음수');
    else
        dbms_output.put_line('0');
    end if;

end;


-- 남녀 커플의 나이합이 가장 많은 커플? > 남자 연상 | 여자 연상
select * from tblMen;
select * from tblWomen;

-- ANSI-SQL
select  
    case
        when m.age > w.age then '남자 연상'
        when m.age < w.age then '여자 연상'
        else '동갑내기'
    end
from tblMen m 
    inner join tblWomen w 
        on m.couple = w.name
            where m.age + w.age = (select max(m.age + w.age) from tblMen m 
                                                            inner join tblWomen w 
                                                                    on m.couple = w.name);


declare
    mage number; --tblMen.age%type
    wage tblWomen.age%type;
begin
    select m.age, w.age into mage, wage from tblMen m 
        inner join tblWomen w 
            on m.couple = w.name
                where m.age + w.age = (select max(m.age + w.age) from tblMen m 
                                                                inner join tblWomen w 
                                                                        on m.couple = w.name);
    dbms_output.put_line(mage);
    dbms_output.put_line(wage);
    
    if mage > wage then
        dbms_output.put_line('남자가 연상입니다.');
    elsif wage > mage then
        dbms_output.put_line('여자가 연상입니다.');
    else
        dbms_output.put_line('동갑내기입니다.');
    end if;
    
end;




-- 현재 시각이 홀수초면 유재석의 몸무게 +1kg 증가, 짝수초면 김숙의 몸무게 + 1kg 증가.
begin
    if mod(to_char(sysdate, 'ss'), 2) = 0 then
        dbms_output.put_line('짝수 ' || to_char(sysdate, 'ss'));
        update tblWomen set weight = weight + 1 where name = '장도연'; --55
    else
        dbms_output.put_line('홀수 ' || to_char(sysdate, 'ss'));
        update tblMen set weight = weight + 1 where name = '홍길동'; --70
    end if;
end;
select * from tblMen;
select * from tblWomen;


select * from tblBonus;

-- 특정 직원 > 부장,과장(수당 3배) or 대리,사원(수당 2배) > tblBonus insert
declare
    vnum tblInsa.num%type;
    vjikwi tblInsa.jikwi%type;
    vsudang tblInsa.sudang%type;
begin
    vnum := 1055; --1055번 직원
    
    select jikwi, sudang into vjikwi, vsudang from tblinsa where num = vnum;
    
    --if jikwi = '과장' or jikwi = '부장' then
    if vjikwi in ('과장', '부장') then
        dbms_output.put_line(vjikwi || ' 3배 지급');
    else
        dbms_output.put_line(vjikwi || ' 2배 지급');
    end if;
    
end;






/*

반복문
1. loop
- 조건 반복

2. for loop
- 지정 횟수 반복(자바 for문 유사)

3. while loop
- 조건 반복(자바 while문 유사)

*/

-- loop
begin
    
    loop
        dbms_output.put_line('현재 시각 : ' || to_char(sysdate, 'hh24:mi:ss'));
        --exit; --break
        --exit when 조건;
        exit when mod(to_char(sysdate, 'ss'), 2) = 1;
    end loop;
    
end;



-- 사원 번호 홀수인 직원에게만 보너스 지급. 1001 ~ 1060
declare
    vloop number;
begin
    vloop := 1001;
    
    loop
        dbms_output.put_line(vloop);
        
        if mod(vloop, 2) = 1 then
            insert into tblBonus (seq, insaseq, bonus)
                values (bonus_seq.nextval, vloop, 100000);
        end if;
        
        vloop := vloop + 1;
        exit when vloop > 1060;
    end loop;
    
end;

select * from tblBonus;



-- 2. for loop
-- : 문법상에서 루프 변수를 제공한다.
begin
    -- i : 루프 변수(따로 선언부를 가지지 않는다. 빌트인 변수)
    -- 변수 in 집합
    -- 1 : 초기값
    -- .. : 순차증가(i++)
    -- 10 : 최대값
--    for i in 1..10 loop
--        dbms_output.put_line(i);
--    end loop;

    for i in reverse 1..10 loop
        dbms_output.put_line(i);
    end loop;
    
end;


-- 3. while loop
declare
    vloop number;
begin
    
    vloop := 1;
    
    while vloop <= 10 loop -- 기본 loop의 exit when절과 동일
        dbms_output.put_line(vloop);
        vloop := vloop + 1;
    end loop;
    
end;


-- 구구단 테이블
create table tblGugudan
(
    --seq number primary key,
    dan number not null,    -- 2, 2, 2
    num number not null,    -- 1, 2, 3
    result number not null,  -- 2, 4, 5
    --복합키는 컬럼 수준의 정의를 못한다. 테이블 수준의 정의만 가능하다.
    constraint tblgugudan_dan_num_pk primary key(dan, num)
);

insert into tblGugudan values (2, 1, 2);
insert into tblGugudan values (2, 2, 4);
insert into tblGugudan values (2, 3, 6);

select * from tblGugudan;

rollback;

begin
    
    for dan in 2..9 loop
        for num in 1..9 loop   
            insert into tblGugudan values (dan, num, dan*num);
        end loop;
    end loop;
    
end;


declare
    vdan number;
    vnum number;
begin
    vdan := 2;
    while vdan <= 19 loop
        vnum := 1;
        while vnum <= 19 loop
            insert into tblGugudan values (vdan, vnum, vdan*vnum);
            vnum := vnum + 1;
        end loop;
        vdan := vdan + 1;
    end loop;
end;










select * from tblGugudan;



/*

select문을 사용해서 데이터 가져오기 + PL/SQL 변수에 넣기
1. select into 사용
    - 결과셋의 레코드가 1개일때만 사용 가능
    - PK 조건, 집계함수 사용 등
2. cursor 사용
    - 결과셋의 레코드가 1개 이상일 때 사용 가능


커서 구문

declare
    변수 선언;
    커서 선언;
begin
    커서 열기;
    loop
        커서를 사용해서 각각의 레코드를 접근(읽기)
    end loop;
    커서 닫기;
end;

*/

-- tblinsa. 60명 + 이름
declare
    vname tblInsa.name%type; --한사람의 이름을 담을 변수
    cursor vcursor 
    is 
    select name from tblinsa order by name asc; --선언O, 실행X
begin
    
    open vcursor; --커서 열기(select문 실행)
    
    loop
        
        fetch vcursor into vname; -- reader.readLine(); + iter.hasNext() > iter.next()
        
        --커서 내장 속성
        exit when vcursor%notfound; --다음 레코드가 존재하면(true), 존재하지 않으면(false) 
        
        dbms_output.put_line(vname);
        
    end loop;
    
    close vcursor; --커서 닫기(자원 해제)
    
end;


declare
    cursor vcursor is
        select first, last, height, weight from tblComedian; 
    vfirst tblComedian.first%type;
    vlast tblComedian.last%type;
    vheight tblComedian.height%type;
    vweight tblComedian.weight%type;
begin
    open vcursor;
    loop
        fetch vcursor into vfirst, vlast, vheight, vweight;
        exit when vcursor%notfound;
        dbms_output.put_line(vfirst || vlast);
        dbms_output.put_line(vheight);
        dbms_output.put_line(vweight);
    end loop;
    close vcursor;
end;





declare
    cursor vcursor is
        select * from tblComedian where gender = 'm';
    vrow tblComedian%rowtype; --레코드 참조 변수
begin
    open vcursor;
    loop
        fetch vcursor into vrow; --N : N 대입
        exit when vcursor%notfound; -- true, false
        dbms_output.put_line(vrow.first || vrow.last);
        dbms_output.put_line(vrow.height);
        dbms_output.put_line(vrow.weight);
        dbms_output.put_line(vrow.gender);
    end loop;
    close vcursor;
end;


-- select문(정리)

-- 1. 단일행 + 단일컬럼
--  : select into절 //단일 레코드 반환 + 변수 대입
--  : 테이블명.변수%type //컬럼 자료형 참조 > PL/SQL 변수 생성

set serveroutput on;

declare
    vcnt number;
    vname tblinsa.name%type; --컬럼 참조 변수
begin
    select count(*) into vcnt from tblinsa;
    select name into vname from tblinsa where num = 1001; --PK 조건
    dbms_output.put_line(vcnt);
    dbms_output.put_line(vname);
end;

-- 2. 단일행 + 복합컬럼
--  : select into 절 //레코드 1개
--  : 테이블명.변수%type x n개  or 테이블명%rowtype x 1개
declare
    vname tblinsa.name%type;
    vbuseo tblinsa.buseo%type;
    vjikwi tblinsa.jikwi%type;
    vcity tblinsa.city%type;
    vrow tblinsa%rowtype; --위의 4개 포함 + 6개 추가 생성
    vrownum number;
begin
    select name, jikwi, buseo, city into vname, vjikwi, vbuseo, vcity from tblinsa where num = 1001;
    dbms_output.put_line(vname || ', ' || vjikwi || ' ' || vbuseo || ' ' || vcity);
    
    select * into vrow from tblinsa where num = 1002;
    dbms_output.put_line(vrow.name || ', ' || vrow.jikwi);
    
    select name, rownum into vname, vrownum from tblinsa a where num = 1003;
    dbms_output.put_line(vname || ', ' || vrownum);
    
    
end;

-- 3. 복합행 + 단일컬럼
--  : cursor + fetch into //복합행
--  : 변수 1개(1번 동일)
declare
    cursor vcursor is select name from tblCountry;
    vname tblCountry.name%type;
begin
    open vcursor;
    loop
        --레코드 1줄 가져오는 행동 x n회
        fetch vcursor into vname; --select name into vname 동일한 구문
        exit when vcursor%notfound; --커서 속성(= bool 변수)
        dbms_output.put_line(vname);
    end loop;
    close vcursor;
end;


-- 4. 복합행 + 복합컬럼
--  : cursor + fetch into //복합행
--  : 변수 N개(2번 동일)
declare
    cursor vcursor is select * from tblCountry;
    vrow tblCountry%rowtype;
begin
    open vcursor;
    loop
        --레코드 1줄 가져오는 행동 x n회
        fetch vcursor into vrow; --select * into vrow 동일한 구문
        exit when vcursor%notfound; --커서 속성(= bool 변수)
        dbms_output.put_line(vrow.name || ', ' || vrow.capital);
    end loop;
    close vcursor;
end;

/*

cursor 사용법
1. cursor + loop
    : 커서 객체 생성(declare + select 정의) > 커서 열기(open + select 실행) > 루프 
        > 레코드 단위 데이터 접근(fetch) + into 절(변수 대입) > 업무 > 커서 닫기(close)

2. cursor + for loop
    : 커서 처리 단순해짐

*/

-- ******  꼭 정리
declare
    cursor vcursor is 
        select * from tblinsa;
    --vrow tblinsa%rowtype; //생략
begin
    --open vcursor; //생략
    for vrow in vcursor loop -- loop + fetch into
        dbms_output.put_line(vrow.name);
    end loop;
    --close vcursor; //생략
end;



begin
    for vrow in (select * from tblinsa) loop
        dbms_output.put_line(vrow.name || ', ' || vrow.jikwi);
    end loop;
end;



/*
exception
- 예외 처리부
*/
declare
    vname number;
begin
    dbms_output.put_line('시작');
    select name into vname from tblinsa where num = 1001;
    dbms_output.put_line('끝');
exception --catch절
    when others then -- catch (Exception e)
        dbms_output.put_line('예외 처리');
end;


--예외 발생 기록(로그 테이블)
create table tblLog
(
    seq number primary key, --PK
    code varchar2(20) check (code in ('AAA001', 'AAA002', 'BBB001', 'CCC001')) not null,
    message varchar2(100) null, --상태 메시지
    regdate date default sysdate not null --발생 시작
);
create sequence log_seq;

select * from tblComedian;
delete from tblComedian;
rollback;

declare
    vbonus number;
    vname tblComedian.first%type;
begin
    --1.
    select 10000000 / count(*) into vbonus from tblComedian;
    dbms_output.put_line(vbonus);
    
    --2.
    select first into vname from tblComedian;
    
exception
    when zero_divide then
        dbms_output.put_line('tblComedian 테이블에 레코드가 없습니다.');
        insert into tblLog 
            values (log_seq.nextval, 'AAA001', 'tblComedian 테이블에 레코드가 없습니다.', default);
    
    when too_many_rows then
        dbms_output.put_line('가져온 코메디언이 너무 많습니다.');
        insert into tblLog 
            values (log_seq.nextval, 'BBB001', '가져온 코메디언이 너무 많습니다.', default);
    
    when others then --기타 등등
        dbms_output.put_line('오류 발생');
        insert into tblLog 
            values (log_seq.nextval, 'CCC001', '오류 발생', default);

end;

select * from tblLog;


commit;
rollback;

-- PL/SQL 트랜잭션 처리(*****) + 예외처리와 같이
select * from hr.tblMen where name = '정형돈'; --정형돈
select * from hr.tblWomen where name = '박나래'; --박나래



begin
    --1.
    update hr.tblMen set couple = '박나래' where name = '정형돈';
    --2.
    update hr.tblWomen set couple = '가가가가가가가가가가가가가' where name = '박나래';
    
end;




declare
    vmen varchar2(20);
    vwomen varchar2(20);
begin
    vmen := '정형돈';
    vwomen := '박나래';
    
    --1.
    update tblMen set couple = vwomen where name = vmen;
    
    --2.
    update tblWomen set couple = '가가가가가가가가가가가가가' where name = vwomen;
    
    commit; --*** 위치 + 역할
    
exception
    when others then
        dbms_output.put_line('');
        rollback; --*** 위치 + 역할
    
end;



/*

PL/SQL 블록 > 프로시저
1. 익명 프로시저
    - 재사용 불가
    - 매번 동일한 비용 발생(실행할 때마다 컴파일)
2. 실명 프로시저
    - 재사용 가능
    - 첫번째만 비용 발생(컴파일) > 이후 실행 컴파일 과정 생략
    - 저장 프로시저 > "Stored Procedure"


저장 프로시저 구문

create [or replace] procedure 프로시저명
is(=as)
    [선언부;]
begin
    구현부;
[exception
    예외처리부;]
end [프로시저명];

*/

set serverout on;

-- 저장 프로시저 정의
create or replace procedure procTest
is --declare 역할
    vnum number;
begin
    vnum := 10;
    dbms_output.put_line(vnum);
end procTest;



/*
저장 프로시저 호출하기
1. PL/SQL 블록내에서 호출하기*********
- 프로그래밍 방식
- 주로 사용되는 방식
- 프로그램에 적용

2. 스크립트 환경에서 호출하기(ANSI-SQL에서)
- 관리자 운영
*/

--ANSI -> (모름) -> PL/SQL
--PL/SQL -> (앎) -> ANSI
-- 1번 방식으로 실행(익명 프로시저에서 호출)
begin
    procTest();
    procTest;
end;

-- 1번 방식으로 실행(실명 프로시저에서 호출)
create or replace procedure procHello
is
begin
    dbms_output.put_line('다른 프로시저 호출하기');
    procTest();
end procHello;


begin
    procHello();
end;


-- 2번 방식
exec procTest;
exec procTest();
execute procTest;
call procTest;
call procTest(); --나중에 사용(Java와 연동할 때)






-- 프로시저 : 인자와 반환값

-- 매개변수가 있는 저장 프로시저
create or replace procedure procTest(pnum number)
is
    vresult number;
begin
    vresult := pnum * pnum;
    dbms_output.put_line(vresult);
end procTest;

begin
    procTest(5);
end;




create or replace procedure procTest
(
    pwidth number, --매개변수는 자료형과 관계없이 길이를 표현할 수 없다.(*****) 
    pheight number
) 
is
    varea number(10);
begin
    varea := pwidth * pheight;
    dbms_output.put_line(varea);
end procTest;


begin
    procTest(100, 50);
end;




create or replace procedure procTest
(
    pname varchar2, --길이 표현X
    pwidth number default 100,
    pheight number default 50
) 
is
    varea number;
begin
    varea := pwidth * pheight;
    dbms_output.put_line(pname || ':' || varea);
end procTest;

begin
    procTest('사각형A', 300, 150);
    procTest('사각형B', 70); --70은 width로 사용
    --procTest('사각형C', default, 70);
    procTest('사각형D');
end;





-- D:\class\oracle\ex31_plsql.sql 열기
-- 실명 프로시저 > 저장 프로시저(Stored Procedure) //자바의 메소드(정의, 호출, 매개변수, 반환값)
create or replace procedure procTest
(
    x number, --길이를 정할 수 없다.
    y number
) --헤더
is --목
    result number; --길이를 정할 수 있다.
begin --몸통
    result := x * y;
    dbms_output.put_line(result);
end;


-- 호출
set serveroutput on;

begin
    procTest(10, 20);
end;


/*
매개변수의 작동(동작) 모드
- 매개변수가 전달되는 방법
1. in : 기본값. 원래 우리가 알고 있는 매개변수 역할(외부에서 메소드에게 값을 전달하는 역할)
2. out : 성질은 변수. 반환값 역할을 한다. 반환값 표현 사용 금지
3. in out : 사용 X
*/
create or replace procedure procTest
(
    a in number,
    b number, -- b in number //in parameter
    c out number, --out parameter
    d out varchar2
)
is
    result number;
begin
    result := a + b;
    dbms_output.put_line(result);
    
    c := a * b;
    
    if a > b then
        d := '크다';
    else
        d := '작다';
    end if;
end;   


declare
    vtemp number;
    vtemp2 varchar2(100);
begin
    procTest(10, 20, vtemp, vtemp2);
    dbms_output.put_line(vtemp);
    dbms_output.put_line(vtemp2);
end;



-- 메모 추가하기 프로시저
create or replace procedure procAddMemo
(
    pname varchar2,
    pmemo varchar2,
    ppriority number,
    presult out number -- 업무 성공 유무(executeUpdate()의 반환값과 유사)
)
is
    --?
begin
    insert into tblMemo (seq, name, memo, priority, regdate)
        values (memo_seq.nextval, pname, pmemo, ppriority, default);
    presult := 1;
exception
    when others then
        presult := 0;
end;


declare
    vresult number(1);
begin
    procAddMemo('홍길동', '프로시저 테스트입니다.', 1, vresult);
    
    if vresult = 1 then
        dbms_output.put_line('입력 완료');
    else
        dbms_output.put_line('입력 실패');
    end if;
end;

select * from tblMemo;







-- 회원가입 > 회원 정보 테이블(주요 정보 + 보조 정보)
-- 1. insert
-- 2. select
-- 3. insert

-- 주요 정보
create table tblMain
(
    seq number primary key,
    id varchar2(30) not null,
    pw varchar2(30) not  null,
    name varchar2(30) not null,
    constraint tblmain_id_pk primary key(id)
);

-- 보조 정보
create table tblSub
(
    age number null,
    tel varchar2(15) null,
    email varchar2(50) not null,
    id varchar2(30) not null,
    constraint tblsub_id_pk primary key(id),
    constraint tblsub_id_fk foreign key(id) references tblMain(seq)
);


-- 회원 가입 프로시저
create or replace procedure procRegister
(
    pid varchar2,
    ppw varchar2,
    pname varchar2,
    page number,
    ptel varchar2,
    pemail varchar2
)
is
begin
    --1. tblMain에 추가하기
    insert into tblMain (id, pw, name) values (pid, ppw, pname);
    
    --2. tblSub에 추가하기
    insert into tblSub(age, tel, email, id) values (page, ptel, pemail, pid);
    
    
    
        
    --1. tblMain에 추가하기
    insert into tblMain (seq, id, pw, name) values (mseq.nextval, pid, ppw, pname);
    
    -- 15, hong, 1111, 홍길동
    -- 20, 010-111-1111, hong@gmail.com, 15
    
    --1.5 위에서 가입할 때 사용한 마지막 seq를 알아내기
    select max(seq) into vseq from tblMain;
    
    --2. tblSub에 추가하기
    insert into tblSub(age, tel, email, pseq) values (page, ptel, pemail, vseq);
    
end;



-- 저장 프로그램
-- 1. 저장 프로시저
--  : 메소드
--  : in 매개변수 개수 자유(0~마음대로)
--  : out 매개변수 개수 자유(0~마음대로)

-- 2. 저장 함수
--  : 메소드
--  : in 매개변수 개수 자유
--  : out 매개변수 사용 금지
--  : return 문 사용 > 반환값 1개(**********)

create or replace procedure procAAA
(
    pnum1 in number,
    pnum2 in number,
    presult out number
)
is
begin
    presult := pnum1 + pnum2;
end;


create or replace function fnBBB
(
    pnum1 number,
    pnum2 number
) return number -- public int fnBBB(int a, int b)
is
begin

    return pnum1 + pnum2;
end;


declare
    vresult1 number;
    vresult2 number;
    vbasicpay1 number;
begin
    
    procAAA(30, 40, vresult1);
    dbms_output.put_line(vresult1);
    
    -- vresult1의 값을 홍길동의 급여에 더하기
    select basicpay into vbasicpay1 from tblinsa where num = 1001;
    dbms_output.put_line(vbasicpay1 + vresult1);
    
    
    
    vresult2 := fnBBB(50, 60);
    dbms_output.put_line(vresult2);
    
    select basicpay into vbasicpay1 from tblinsa where num = 1001;
    dbms_output.put_line(vbasicpay1 + vresult2);
    
    select basicpay + fnBBB(50, 60) into vbasicpay1 from tblinsa where num = 1001;
    dbms_output.put_line(vbasicpay1);
    
end;



select name, 
    case
        when substr(ssn, 8, 1) = '1' then '남자'
        when substr(ssn, 8, 1) = '2' then '여자'
    end
from tblinsa;


-- 프로시저는 PL/SQL에서만 사용이 가능하다.(ANSI에서는 사용이 불가능하다.)
-- 함수는 거의 ANSI에서 사용하기 위해서 만든다.
select name, procGender(ssn, vgender) from tblinsa; --사용 불가능(100%)
select name, fnGender(ssn) from tblinsa;


create or replace procedure procGender
(
    pssn varchar2,
    pgender out varchar2
)
is
begin
    if substr(pssn, 8, 1) = '1' then
        pgender := '남자';
    elsif substr(pssn, 8, 1)  = '2' then
        pgender := '여자';
    end if;
end;




create or replace function fnGender
(
    pssn varchar2
) return varchar2
is
begin
    if substr(pssn, 8, 1) = '1' then
        return '남자';
    elsif substr(pssn, 8, 1)  = '2' then
        return '여자';
    end if;
    
    return null;
end;



/*

트리거, Trigger
- 저장 프로시저의 일종
- 특정 테이블에 특정 사건이 발생하면 자동으로 실행되는 저장 프로시저
- 개발자 호출X, DBMS 호출O
- 특정 사건이 언제 발생??? -> 실시간 감시 -> 사건 발생 -> 프로시저 호출
- 특정 사건(테이블 조작 : insert, update, delete)
- 자주 사용하면 안됨 : 고비용(실시간 감시)
    a. 트리거 처리
    b. 프로시저 처리


트리거 구문

create or replace trigger 트리거명
    - 트리거 동작 옵션
    before | after --언제 실행? 사건 발생 전? 후?
    insert | update | delete --사건의 종류
    on 테이블명 -- 감시 대상 테이블
    [for each row] 
declare
    선언부
begin
    구현부
exception
    예외부
end;

*/

-- 메모장. 목요일에는 글을 삭제를 못하게 싶습니다.
create or replace trigger trgDeleteMemo
    before
    delete
    on tblMemo
begin
    dbms_output.put_line('trgDeleteMemo 실행되었습니다.');    
    
    if to_char(sysdate, 'd') = 5 then
        -- 강제로 에러 발생 //throw new Exception();
        -- raise_application_error(에러번호, 메시지)
        -- 에러번호 : -20000 ~ 29990
        raise_application_error(-20000, '목요일에는 메모를 삭제할 수 없습니다.');
    end if;
end;

select * from tblMemo;
delete from tblMemo where seq = 3;
select to_char(sysdate, 'd')  from dual;

-- 트리거 사용 예
-- 1. 부모 삭제(삭제 before 트리거) > 자식 삭제
-- 2. 게시판 글쓰기(등록 after 트리거) > 포인트 업데이터
-- 3. 로그 기록(각종 테이블, insert, update, delete 트리거) > 로그 테이블 기록


-- 이번 프로젝트 : ANSI-SQL 사용 + 자바
--      : JAVA + ANSI + JDBC
-- 다음 프로젝트 : 웹사이트 : ANSI + PL/SQL(저장 프로시저, 함수, 트리거, 인덱스 등..)
--      : JAVA + ANSI + PL/SQL + JDBC 
--      + HTML + CSS + Javascript + jQuery + Bootstrp + JSP + Servlet + Ajax


select * from tblLog;

-- 로그 트리거
-- : tblMemo을 대상으로 변화가 생기면(DML) 나중에 관리자가 볼 수 있게 로그를 기록
create or replace trigger trgMemo
    after
    insert or update or delete
    on tblMemo
    for each row --사건이 적용되는 레코드마다 프로시저를 호출해라~~ N회 반복
declare
    vmessage varchar2(100);
begin
    -- 사건의 종류??
    --dbms_output.put_line(inserting); --boolean > 오라클 논리값 출력이 불가능하다.
    if inserting then
        vmessage := 'tblMemo에 새로운 레코드가 추가되었습니다.';
        dbms_output.put_line(vmessage);
    elsif updating then
        vmessage := 'tblMemo에 레코드 수정이 발생했습니다.';
        dbms_output.put_line(vmessage);
    elsif deleting then
        vmessage := 'tblMemo에 레코드가 삭제되었습니다.';
        dbms_output.put_line(vmessage);
    end if;
    
    -- 로그 기록
    insert into tblLog(seq, code, message, regdate)
        values (log_seq.nextval, 'BBB001', vmessage, default);
    
end;

-- 테이블 1개에 여러개의 트리거를 매핑할 수 있다.(단 ********* 트리거 간에 서로 영향을 주는 업무 구현X)
-- 우리가 어제 만든 tblMemo에 걸린 트리거 1개
-- 방금 만든 tblMemo에 건 트리거 1개

commit;
rollback;

select * from tblMemo;

set serveroutput on;

insert into tblMemo values (memo_seq.nextval, '아무개', '메모', 1, default);
update tblMemo set memo = 'testing..' where seq = 63;
delete from tblMemo where seq = 63;

delete from tblMemo;

select * from tblLog;

/*
[for each row]

1. 생략
    - 문장 단위 트리거
    - 트리거 실행 횟수 1회
    - DML에 의해서 적용된 행의 개수와 무관하게 단 1회 실행
    - 행동 자체가 중요한 트리거(어떤 레코드가 적용되었는지는 중요하지 않다.)

2. 사용
    - 행 단위 트리거
    - 트리거 실행 횟수 N회
    - N : DML에 의해서 적용된 행의 개수
    - 상관 관계 변수 지원
        a. :old
        b. :new

2.1 insert 발생
    - 트리거에서 방금 insert된 행의 컬럼값을 접근할 수 있다.
    - insert된 데이터를 가져올 수 있다.(새값)
    - :new 사용이 가능하다. > 방금 추가된 레코드 참조 변수 > :new.컬럼명
    - :old 사용이 불가능하다.(기존 행이라는 의미)
    - after 트리거에서만 사용 가능. before 트러기에서는 사용 불가능(확인;;;)
2.2 update 발생
    - 트리거에서 방금 update된 행의 컬럼값(수정된 전 값 :old, 수정된 후 값 :new)을 접근할 수 있다.
    - :new > 수정된 행 정보
    - :old > 수정되기 전 행 정보
2.3 delete 발생
    - 트리거에서 방금 delete된 행의 컬럼값을 접근할 수있다.
    - :old > 방금 삭제된 행
    - :new 사용 안함
*/
create or replace trigger trgInsertTodo
    before
    insert
    on tblTodo
    for each row
begin
    dbms_output.put_line(:new.title); --vrow tblTod%rowtype;
    --dbms_output.put_line(:old.title); --사용 금지(null)
end;

select * from tblTodo;

insert into tblTodo values (50, '프로시저 만들기', sysdate, null);
insert into tblTodo values (51, '강아지 목욕시키기', sysdate, null);
insert into tblTodo values (53, '햄스터 목욕시키기', sysdate, null);
insert into tblTodo values (54, '햄스터2 목욕시키기', sysdate, null);



create or replace trigger trgUpdateTodo
    after
    update
    on tblTodo
    for each row
begin
    dbms_output.put_line(:old.title);
    dbms_output.put_line(:new.title);
end;

select * from tblTodo;
update tblTodo set title = '트리거 만들기' where seq = 50;



create or replace trigger trgDeleteTodo
    before
    delete
    on tblTodo
    for each row
begin
    dbms_output.put_line(:old.title);
    --dbms_output.put_line(:new.title);
end;

delete from tblTodo where seq = 50;
delete from tblTodo where completedate is not null;

rollback;




--1. 게시판
drop table tblBoard;
create table tblBoard
(
    seq number primary key, --글번호(PK)
    subject varchar2(100) not null, --제목
    regdate date default sysdate not null --작성일
);

create table tblComment
(
    seq number primary key, --댓글번호(PK)
    subject varchar2(100) not null, --댓글제목
    regdate date default sysdate not null, --작성일
    bseq number not null references tblBoard(seq) --부모글번호(FK)
);

insert into tblBoard values (1, '게시판 테스트입니다.', default);
insert into tblBoard values (2, '안녕하세요~~', default);

insert into tblComment values (1, '댓글입니다.', default, 1);
insert into tblComment values (2, '댓글입니다.', default, 1);
insert into tblComment values (3, '댓글입니다.', default, 1);

insert into tblComment values (4, '네 반갑습니다~', default, 2);
insert into tblComment values (5, '안녕~', default, 2);


select * from tblBoard;
select * from tblComment;

delete from tblComment where bseq = 1; --FK 레코드 삭제
delete from tblBoard where seq = 1; --child record found

-- 게시판 테이블 > 삭제 > 삭제할 번호 알아내서 > 댓글 삭제 : 트리거
create or replace trigger trgDeleteBoard
    before
    delete
    on tblBoard
    for each row
begin
    delete from tblComment where bseq = :old.seq; --부모글번호
end;


delete from tblBoard where seq = 2;




--2. 회원 글작성 + 포인트 누적
drop table tblComment;
drop table tblBoard;

create table tblUser
(
    id varchar2(50) primary key, --PK(id)
    name varchar2(20) not null, --이름
    point number default 1000 not null --포인트
);

create table tblBoard
(
    seq number primary key, --글번호(PK)
    subject varchar2(100) not null, --제목
    regdate date default sysdate not null, --작성일
    id varchar2(50) not null references tblUser(id) --작성자(id)
);

insert into tblUser values ('hong', '홍길동', default);
select * from tblUser;

insert into tblBoard values (1, '안녕하세요', default, 'hong'); --100pt 누적 트리거 생성
update tblUser set point = point + 100 where id = 'hong'; --하드 코딩(XXX)
select * from tblBoard;

--글 쓰면 +100pt
--글 지우면 -50pt
create or replace trigger trgInsertBoard
    after
    insert
    on tblBoard
    for each row --id를 알아내기 위해서
begin
    update tblUser set
        point = point + 100
            where id = :new.id;--게시판 글쓴 회원의 포인트 누적
end;

insert into tblBoard values (2, '반갑습니다.', default, 'hong'); 
select * from tblUser;
select * from tblBoard;
commit;

create or replace trigger trgDeleteBoard
    after
    delete
    on tblBoard
    for each row --글삭제한 회원 id 알아내려고
begin
    update tblUser set
        point = point - 50
            where id = :old.id; --글삭제한 회원의 정보를 찾아 포인트 감소
end;

delete from tblBoard where seq = 1;
select * from tblUser;

-- 하면 안되는 행동 : 트리거 대상 테이블 건드리는 행동을 하지 말것!!!!!!!
create or replace trigger trgInsertBoard
    after
    insert
    on tblBoard
    for each row
begin
    --insert into tblBoard values (3, '반갑습니다.', default, 'hong'); 
    insert into tblComment values (5, '댓글', default, 'hong');
end;


create or replace trigger trgInsertComment
    after
    insert
    on tblComment
    for each row
begin
    insert into tblBoard values (3, '반갑습니다.', default, 'hong'); 
end;


insert into tblBoard values (4, '반갑습니다.', default, 'hong'); 


















