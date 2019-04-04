-- hr > ex05_operator.sql

/*

연산자

1. 산술 연산자
- +, -, *, /
- %(없음) -> 함수로 제공(mod())

2. 문자열 연산자
- + > ||(concat)

3. 비교 연산자
- >, >=, <, <=
- =(==), <>(!=)
- 논리값을 결과값으로 반환
- 비교 연산자의 결과는 컬럼 리스트에 들어갈 수 없다.(출력 못함 - boolean 자료형이 없기 때문에)
- SQL 자료형에는 boolean이 없다.
- 조건절에서 사용한다.(where 절)

4. 논리 연산자
- and(&&), or(||), not(!)
- 조건절에서 사용한다.
- 컬럼리스트에 넣을 수 없다.

5. 대입 연산자
- 없음
- 있음(변수 대신에 컬럼이 존재) > 컬럼을 대상으로 수정 작업할 때 사용 > update문
- 컬럼명(셀값) = 새로운 값
- 복합 대입 연산자(+=, -= 등등) 없음 > weight += 1 (X) > weight = weight + 1 (O)

6. 3항 연산자
- 없음
- 제어문이 없음
- 비슷한 행동을 하는 함수 몇개가 제공

7. 증감 연산자
- 없음
- ++num (X) -> num = num + 1 (O)

8. SQL 연산자(절)
- 자바 : instanceof
- in, between, like, is, any, all 등..

*/
select * from tblcomedian;

select last, first, weight + 5, height * 2, weight / (height * height) * 10000 from tblcomedian;

-- ORA-01722: invalid number
select last + first, weight + 5, height * 2, weight / (height * height) * 10000 from tblcomedian;
select last || first, weight + 5, height * 2, weight / (height * height) * 10000 from tblcomedian;

-- 컬럼 별칭(Alias) 만들기
-- : 식별자로 유효한 컬럼명 만들기
-- : 별명(X) > 개명(O) : 이전 컬럼명은 더이상 사용되지 않는다.(******)
select 
    last || first as fullname, 
    weight + 5 as weight, --원본 테이블의 컬럼명과 동일 > 아무 상관없음. 
    height * 2 as height, 
    weight / (height * height) * 10000 as BMI
from tblcomedian;

select nick as 별명 from tblcomedian; -- 가공되지 않은 컬럼에도 별칭 가능

select nick as 개그맨 별명 from tblcomedian; -- 식별자에 공백 불가능
select nick as 개그맨_별명 from tblcomedian;
select nick as "개그맨 별명" from tblcomedian; -- 사용 비권장
select "개그맨 별명" from 결과테이블;
select nick as "select" from tblcomedian; -- 절대 비권장


select height > weight from tblcomedian;






















































