# 그룹 함수
# - 그룹의 통계를 반환하는 함수
# 숫자 데이터만 가능
# - sum, avg,
# - 숫자 뿐만 아니라 문자, 날짜 사용 가능
# - min, max,

# - count


# sum
# - null : 상태값
select sum(tbl_menu.menu_price)
from tbl_menu
;
# avg
select avg(tbl_menu.menu_price)
from tbl_menu
;

# 카테고리 코드가 10인 메뉴의 평군가
select avg(tbl_menu.menu_price)
from tbl_menu
where tbl_menu.category_code = 10
;

select max(tbl_menu.menu_price) as 최대치,
       min(tbl_menu.menu_price) as 최소치
from tbl_menu
;

select max(tbl_menu.menu_name), min(tbl_menu.menu_name)
from tbl_menu
;

# null 과 연산을 수행 시 모든 결과 = null
select 1 + null;


# count
# * 또는 컬럼명이 들어감
# count(*) :  null 값 포함하여 모든 행의 개수
select count(*)
from tbl_category
;

# count(컬럼명) : null 제외한 컬럼의 개수
select count(ref_category_code)
from tbl_category
;





