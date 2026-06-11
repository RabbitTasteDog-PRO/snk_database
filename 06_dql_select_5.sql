### SET OPERATORS(집합연산)
# - 두 개 이상의 SELECT 문의 결과를 결합하여 중복된 레코드를 제거한 후 반환하는 SQL 연산자이다.
# Set 개념 (합집합)
SELECT menu_code,
       menu_name,
       menu_price,
       category_code,
       orderable_status
FROM tbl_menu
WHERE category_code = 10
UNION
SELECT menu_code,
       menu_name,
       menu_price,
       category_code,
       orderable_status
FROM tbl_menu
WHERE menu_price < 9000
order by menu_code;

# inersect : 교집합
# - 중복된 부분만 실행
SELECT menu_code,
       menu_name,
       menu_price,
       category_code,
       orderable_status
FROM tbl_menu
WHERE category_code = 10
INTERSECT
SELECT menu_code,
       menu_name,
       menu_price,
       category_code,
       orderable_status
FROM tbl_menu
WHERE menu_price < 9000
order by menu_code;

# union all : 합집합 + 교집합
SELECT menu_code,
       menu_name,
       menu_price,
       category_code,
       orderable_status
FROM tbl_menu
WHERE category_code = 10
union all
SELECT menu_code,
       menu_name,
       menu_price,
       category_code,
       orderable_status
FROM tbl_menu
WHERE menu_price < 9000
order by menu_code;

# Minus 차집합
# 동일한 내용을 제외하고 나머지값만 뽑아온다
# 교집합 빼고 가져온데이터
SELECT a.menu_code,
       a.menu_name,
       a.menu_price,
       a.category_code,
       a.orderable_status
FROM tbl_menu a
         LEFT JOIN (SELECT menu_code,
                           menu_name,
                           menu_price,
                           category_code,
                           orderable_status
                    FROM tbl_menu
                    WHERE menu_price < 9000) b on (a.menu_code = b.menu_code)
WHERE a.category_code = 10
  AND b.menu_code IS NULL;

-- ===================================
-- SUBQUERY
-- ===================================
-- 하나의 SQL문(main-query) 안에 포함되어 있는 또 다른 SQL문(sub-query)
-- 존재하지 않는 조건에 근거한 값들을 검색하고자 할때 사용.
-- 메인 쿼리가 서브 쿼리를 포함하는 종속적인 관계이다.
-- 메인 쿼리 실행중에 서브 쿼리를 실행해서 그 결과값을 다시 메인쿼리에 전달하는 방식이다.

# 서브쿼리(SUBQUERY) 유형
-- 1. 일반 서브쿼리
-- 2. 상관 서브쿼리
-- 3. 인라인뷰(파생테이블)

# 규칙
-- 서브쿼리는 반드시 소괄호로 묶어야 함 - (SELECT ... ) 형태
-- 서브쿼리는 연산자의 오른쪽에 위치 해야 함
-- 서브쿼리 내에서 order by 문법은 지원 안됨

# 1. 메뉴 테이블에서 '민트미역국'의 카테고리 코드 조회
select *
from tbl_menu as m
where menu_name = '민트미역국'
;
# 2. 메뉴 테이블에서 카테고리 테이블
select *
from tbl_menu as m
where category_code = 4
;

#3 메뉴 테이블에서
# 민트미역국과 같은 카테고리의 메뉴를 조회
select *
from tbl_menu as m
where category_code = (select category_code
                       from tbl_menu as m
                       where menu_name = '민트미역국');

# 메뉴 테이블에서 '민트미역국'보다 비싼 메뉴를
# 가격 내림 차순으로 조회
select *
from tbl_menu as m
where m.menu_price > (select m.menu_price
                      from tbl_menu as m
                      where menu_name = '민트미역국')
order by m.menu_price desc;


# -> 서브쿼리가 여러 개의 값을 반환
# 카테고리 테이블에서
# ref_category_code 값이 1인 카테고리 코드를 찾아
# 메뉴 테이블에서 같은 카테고리의 메뉴를 모두 조회
select category_code
from tbl_category as c
where c.ref_category_code = 1
;

select *
from tbl_menu
where category_code in (select category_code
                        from tbl_category as c
                        where c.ref_category_code = 1)
;

# 상관서브쿼리 (상호연관)
-- 메인쿼리의 값을 서브쿼리에 주고 서브쿼리를 수행한 다음
-- 그 결과를 다시 메인쿼리로 반환하는 방식으로 수행되는 서브쿼리

-- 서브쿼리의 WHERE 절 수행을 위해서는 메인쿼리가 먼저 수행되는 구조
-- 메인쿼리 테이블의 레코드(행)에 따라 서브쿼리의 결과값도 바뀜
-- 메인 쿼리에서 처리되는 각 행의 컬럼값에 따라 응답이 달라져야 하는 경우에 유용

# 구분
-- 메인쿼리에 있는 것을 서브쿼리에서 가져다 쓰면 상관 서브쿼리 (블럭 잡아 단독으로 실행할수 없다.)
-- 그렇지 않고 서브쿼리가 독단적으로 사용이 되면 일반 서브쿼리

# 카테고리별 가장 비싼 메뉴 조회

# 1. 4번 카테고리 메뉴 중 가낭 비산 메뉴 조회
select max(menu_price)
from tbl_menu
where category_code = 4
;

# 2. 카테고리별 가장 비싼 메뉴 조회
select m_m.*
from tbl_menu as m_m
where m_m.menu_price = (select max(m_s.menu_price)
                        from tbl_menu as m_s
                        where m_s.category_code = m_m.category_code)
;

select avg(m.menu_price)
from tbl_menu m
;
# 3. 카테고리별 평균 금액보다 비싼 메뉴만 조회
select mm.*
from tbl_menu mm
where mm.menu_price >
      (select avg(ms.menu_price)
       from tbl_menu ms
       where ms.category_code = mm.category_code)
;

# 스칼라 서브 쿼리
# - select 절에서 사용하는 결과값이 1개인 서브쿼리
select main.menu_name,
       main.category_code,
       (select sub.category_name
        from tbl_category sub
        where sub.category_code = main.category_code) as category_name
from tbl_menu main
;

# 인라인 뷰(inline view)
# view? :  읽기전용 가상 테이블
# from 절에 작성된 서브쿼리
# 원본 컬럼명 은닉 가능
select *
from (select m.menu_code     as 메뉴코드
           , m.menu_name     as 메뉴명
           , c.category_name as 카테고리명
      from tbl_menu m
               join tbl_category c
                    on m.category_code = c.category_code) as menu_view
where 카테고리명 = '한식'
;

select m.menu_code, m.menu_name, c.category_name
from tbl_menu m
         join tbl_category c
              on m.category_code = c.category_code;

#===========================================================================================================
# CTE : Common Table Expression
# 인라인 뷰로 사용할 서브커리를 별도의 테이블 변수에 저장하고
# 사용할 수 있게하는 문법

/*
[작성법]
1. with절 작성
with 변수명 as ( 서브쿼리 )

2. 작성된 with절 사용
select *
from 변수명
*/

-- with절 선언
with menu_view as (
    select m.menu_code     as 메뉴코드
           , m.menu_name     as 메뉴명
           , c.category_name as 카테고리명
      from tbl_menu m
               join tbl_category c
                    on m.category_code = c.category_code
)
-- 선언한 위드절 참조
select *
from menu_view
where 카테고리명 = '한식'
;



















