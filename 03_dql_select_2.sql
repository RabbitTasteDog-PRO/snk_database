-- =============================
-- JOIN
-- =============================
-- 두개 이상의 테이블의 레코드를 연결해서 가상테이블(relation) 생성
-- 연관성을 가지고 있는 컬럼을 기준(데이터)으로 조합

# relation을 생성하는 2가지 방법
-- 1. join : 특정컬럼 기준으로 행과 행을 연결한다. (가로)
-- 2. union : 컬럼과 컬럼을 연결한다.(세로)
-- join은 두 테이블의 행사이의 공통된 데이터를 기준으로 **선을 연결해서** 새로운 하나의 행을 만든다.

# JOIN 구분
-- 1. Equi JOIN : 일반적으로 사용하는 Equality Condition(=)에 의한 조인
-- 2. Non-Equi JOIN : 동등조건(=)이 아닌 BETWEEN AND, IS NULL, IS NOT NULL, IN, NOT IN, !=  등으로 사용.

# EQUI JOIN 구분
-- 1. INNER JOIN(내부 조인) : 교집합 (일반적으로 사용하는 JOIN)
-- 2. OUTER JOIN(외부 조인) : 합집합
-- LEFT (OUTER) JOIN (왼쪽 외부 조인)
-- RIGHT (OUTER) JOIN (오른쪽 외부 조인)
-- 3. CROSS JOIN
-- 4. SELF JOIN(자가 조인)
-- 5. MULTIPLE JOIN(다중 조인)


# inner join : 내부 조인
# - 두 테이블의 교집합을 반환하는 SQL JOIN 유형
# - join에 사용된 두 테이블의 특정 행만 join(합침)

# tbl_menu, tbl_category 두 테이블을 join
# 조건 : 카테고리 값만 같은 값들만 join
select *
from tbl_menu a
         inner join tbl_category b
                    on
                        a.category_code = b.category_code
;

# 메뉴명, 가격, 카테고리 가격 내림차순 조회
select b.menu_name, b.menu_price, a.category_name
from tbl_category a
         join tbl_menu b
              on a.category_code = b.category_code
order by b.menu_price desc
;
# =============================================================================================
# outer join
# - 좌/우측 기준 데이터의 모든 행을 relation에 포함하는 join
# left [outer] join
# right [outer] join

# INSERT INTO tbl_menu(menu_name, menu_price, category_code, orderable_status)
# VALUES ('초콜릿 덮밥',10000,7,'Y')
# ;
# commit ;

select e.EMP_NAME, e.DEPT_CODE
from employeedb.EMPLOYEE as e
;

select *
from EMPLOYEE
;

# employee 테이블과 department 테이블 inner join
# -> employee(23행), department(9행)
# -> but join결과는 21행
# -> 원인 : employee.dept_code에 값이 없는 (null)행
#           하동운, 이오리 두 행이 조인 결과(relation) 포함되지 않음
select a.EMP_ID,
       a.EMP_NAME,
       a.DEPT_CODE,
       b.DEPT_ID,
       b.DEPT_TITLE
from EMPLOYEE as a
         join DEPARTMENT as b
              on a.DEPT_CODE = b.DEPT_ID
order by a.EMP_ID asc
;

select a.EMP_ID,
       a.EMP_NAME,
       a.DEPT_CODE,
       b.DEPT_ID,
       b.DEPT_TITLE
from EMPLOYEE as a, DEPARTMENT as b
where a.DEPT_CODE = b.DEPT_ID
order by a.EMP_ID asc
;

# left outer join
# join 구문 기준 왼쪽에 작성된 테이블에
# 모든 행이 relation에 포함되게 하기
select a.EMP_ID,
       a.EMP_NAME,
       a.DEPT_CODE,
       b.DEPT_ID,
       b.DEPT_TITLE
from EMPLOYEE as a
         left join DEPARTMENT as b
              on a.DEPT_CODE = b.DEPT_ID
order by a.EMP_ID asc
;

# right outer join
# join 구문 기준 왼쪽에 작성된 테이블에
# 모든 행이 relation에 포함되게 하기
# inner join 결과 21행 + department join 안된 3행 = 24행
select a.EMP_ID,
       a.EMP_NAME,
       a.DEPT_CODE,
       b.DEPT_ID,
       b.DEPT_TITLE
from EMPLOYEE as a
         right join DEPARTMENT as b
              on a.DEPT_CODE = b.DEPT_ID
order by a.EMP_ID asc
;

# menudb 계정
# cross join(카테시안곱, 곱집합)
# 조인 되는 두 테이블의 모든 경우의 수를 처리한 것
select count(*) from tbl_menu -- 22 햏
;

select count(*) from tbl_category -- 12행
;

select * from tbl_menu
    cross join tbl_category
;

# self join
# - 하나의 테이블에서
# - 한 행이 다른 행을 참조하는 관계가 있는 경우
# 같은 테이블끼리 조인하는것
# [tip] 똑같은 테이블이 2개 있다고 생각하면 쉬움
select child.category_code
     , child.category_name
     , parent.category_name as "상위 카테고리"

from tbl_category child
         join tbl_category parent
              on child.ref_category_code = parent.category_code
where parent.category_name = '식사'
;

# multiple join
-- 3개 이상의 테이블을 조인하는것
-- join 순서가 중요함
-- ex) a join b join c
--  -> (a+b) join c
--  -> (a+b+c)

select * from tbl_order
;

select * from tbl_order_menu
;

select * from tbl_menu
;

# multiple join : menudb
select *
from menudb.tbl_order as o
join menudb.tbl_order_menu as om
on o.order_code = om.order_code # o + om합쳐진 관계생성
right join menudb.tbl_menu as m
    on m.menu_code = om.menu_code
;


# multiple join : emploeedb
select * from EMPLOYEE as e
join DEPARTMENT as d
    on e.DEPT_CODE = d.DEPT_ID
join LOCATION l
on d.LOCATION_ID = l.LOCAL_CODE
;