-- hr > ex29_hierarchicalQuery.sql

/*

계층형 쿼리, Hierarchical Query
- 오라클 전용
- 답변형 게시판, 카테고리 관리, BOM(자재 명세서) 등에 적용
- 부모와 자식으로 구성된 트리 구조의 데이터를 처리하는 질의

컴퓨터
    - 본체
        - 메인보드
        - 그래픽카드
        - 랜카드
        - 메모리
    - 모니터
        - 보호필름
    - 프린터
        - 잉크카트리지
        - A4용지

*/
create table tblComputer
(
    seq number primary key, --PK
    name varchar2(100) not null, --요소명
    qty number not null, --수량
    pseq number references tblComputer(seq) null --부모부품(FK)
);

drop table tblComputer;

insert into tblComputer values (1, '컴퓨터', 1, null); --루트 노드

insert into tblComputer values (2, '본체', 1, 1);
insert into tblComputer values (3, '모니터', 1, 1);
insert into tblComputer values (4, '프린터', 1, 1);

insert into tblComputer values (5, '메인보드', 1, 2);
insert into tblComputer values (6, '그래픽카드', 1, 2);
insert into tblComputer values (7, '랜카드', 1, 2);
insert into tblComputer values (8, '메모리', 2, 2);

insert into tblComputer values (9, '보호필름', 1, 3);

insert into tblComputer values (10, '잉크 카트리지', 3, 4);
insert into tblComputer values (11, 'A4 용지', 100, 4);

select * from tblComputer;

--1. 셀프 조인 > 부모 & 자식 밖에 표현 
select c2.name as 부품, c1.name as 부모부품 from tblComputer c1
    right outer join tblComputer c2
        on c1.seq = c2.pseq;

--2. 계층형 쿼리
-- start with 절 connect by 절
select * from tblComputer
    start with seq = 1
        connect by prior seq = pseq;

-- 계층형 쿼리 > 의사 컬럼(level)
select seq, name, qty, pseq, level from tblComputer
    start with seq = 1
        connect by prior seq = pseq;


select lpad(' ', (level-1) * 3) || name, prior name from tblComputer
    start with seq = 1 --루트 노드(출발점) 지정
        connect by prior seq = pseq; -- prior 컬럼 = 컬럼

select lpad(' ', (level-1) * 3) || name, prior name from tblComputer
    start with pseq is null --루트 노드(출발점) 지정
        connect by prior seq = pseq;

select * from tblBoard;

select lpad(' ', (level-1) * 5) || subject from tblBoard
    start with pseq is null
        connect by prior seq = pseq
            --order by seq desc;
            order siblings by seq desc;


select lpad(' ', (level-1)*3) || name from tblCategory
    start with pseq is null
        connect by prior seq = pseq
            order siblings by name asc;


select 
    
    lpad(' ', (level-1)*3) || name as "현재 카테고리",
    prior name as "부모 카테고리",
    connect_by_root name as "루트 카테고리",
    connect_by_isleaf,
    sys_connect_by_path(name, '▷')
    
    from tblCategory
    start with pseq is null
        connect by prior seq = pseq
            order siblings by name asc;



-- ANSI SQL //오늘까지
-- > 모델링(+정규화) //내일
-- > PL/SQL //프로젝트 중










































