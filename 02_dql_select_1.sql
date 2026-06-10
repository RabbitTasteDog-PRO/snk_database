/*
# SQL(Structured Query Language)
- 구조화된 질의 언어
- RDBMS(관계형 DB)에서 저장된 데이터를 관리, 조작하거나
  DB 구조를 제어할 때 사용하는 언어


# SQL 종류
- DQL(Data Query Language)
    - 데이터 질의어
    - 테이블의 데이터를 검색, 조회
    - select
- DML(Data Manipulation Language)
    - 데이터 조작어
    - 테이블에 저장된 값을 삽입,삭제,수정
    - insert, delete, update
- DDL(Data Definition Language)
    - 데이터 정의어
    -
- DCL(Data Control Language)
    - 데이터 제어어
    -
- TCL(Transaction Control Language)
    - 트랜젝션 제어어
    -
*/

# DQL구조
/*
    select 컬럼명 (5)  -- 필수
    from 테이블 (1)  -- 필수
    where 조건절(필터링) (2)
    group by 그룹핑 (3)
    having 조건절(그룹핑에 대해 필터링) (4)
    order by 정렬기준 (6)
    limit 행수제한

    1. SELECT : 조회하고자 하는 컬럼명을 기술함. 여러개를 기술하고자 하면 쉼표(,)로 구분하고 모든 컬럼 조회시 '*'을 사용
    2. FROM : 조회 대상 컬럼이 포함된 테이블명을 기술
    3. WHERE :
        행을 선택하는 조건을 기술함.
        여러 개의 제한 조건을 포함할 수 있으며, 각각의 제한 조건은 논리 연산자로 연결함
        제한조건을 만족시키는 행들만 Result Set에 포함됨
    4. ORDER BY : 정렬할 컬럼을 기준으로 오름/내림차순 지정
    5. GROUP BY : 행을 그룹핑함
    6. HAVING : 그룹핑된 행을 선택하는 조건을 기술함의
*/

select * from tbl_menu;

select
    t.menu_code  as '메뉴코드',
    t.menu_price as '가격'
from tbl_menu as t;

# 조회되는 컬럼의 연산 사능
# 메뉴 테이블에서 메뉴명, 가격, 부가세(10%), 부가세 포함 가격

# ===============================================
# ResultSet : select 조회 결고 행의 집합
# 컬럼명 as 별칭 : resultSet에 표기 되는 컬럼명의 별칭(alias) 가능
# ===============================================
select
    menu.menu_name                       as 메뉴명,
    menu.menu_price                      as "메뉴 가격",
    menu.menu_price * 0.1                    부가세, -- as 생략
    menu.menu_price + (menu_price * 0.1) as "부가세포함 가격"
from tbl_menu as menu;

# 산술연산
select
    10 + 3,
    10 - 3,
    10 * 3,
    10 / 3,
    10 div 3, -- 몫 구하기
    10 % 3,
    10 mod 3 -- 나머지 구하기
;

# 문자열 연결 처리
# 'abc' + 'def' = 'abcdef' -- 안됨
# concat('abc',',','def') = 'abc,def'
# 메뉴 테이블에서 메뉴명, 메뉴가격(원)
select
    menu.menu_name                       as 메뉴명,
    concat(menu.menu_price, '원')       as "메뉴 가격(원)"
from tbl_menu as menu;

# DISTINCT 컬럼값 중복 제거
# 지정된 컬럼값의 중복값의 컬럼을 제거
select m.category_code from tbl_menu as m;
select distinct m.category_code from tbl_menu as m;



























