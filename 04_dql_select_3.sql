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

#==========================================================================================================
# group by
# 지정된 컬럼 값이 일치하는 행을 그룹화(grouping) 시키는 구분
select category_code,
       # null 제외한 category_code의 개수
       count(category_code) count,
       # 각 그룹의 모든 행의 개수
       count(*)             totlaCount,
       # 각 그룹의 메뉴 합계
       sum(menu_price)      sum,
       # 각 그룹의 평균
       avg(menu_price)      avg,
       #각 그룹의 최대값
       max(menu_price)      max,
       # 각 그룹의 최소값
       min(menu_price)      min
from tbl_menu
# 카테고리 코드의 같은 코드명들을 그룹화
group by category_code;


### group by 사용 시 주의사항
# 1. null도 그룹으로 포함
# 2. select 절에는 group by 기준이 된 컬럼 + 그룹 함수만 작성 가능함
select ref_category_code, category_name
from tbl_category
group by ref_category_code
;

# 그룹을 만들고 그 안에 하위그룹 구성 가능
select
    # category_code로 1차 그룹화 후
    category_code,
    # orderable_status가 같은 행끼리 2차 그룹화
    orderable_status,
    # 2차 그룹화된 그룹의 카운트
    count(*)
from tbl_menu
group by category_code, orderable_status
order by category_code asc
;


# where + group by : 필터링 된 행 중 컬럼값이 같은 행 그룹화
# - where : 지정된 테이블에서 행을 필터링
# - group by : 컬럼값이 같은 행을 그룹화

# 메뉴 테이블에서 카테고리별 개수, 합계
# 메뉴 가격이 10000원 이상인 메뉴
select m.category_code, count(*), sum(m.menu_price)
from tbl_menu as m
where m.menu_price >= 10000
group by m.category_code
;

# 메뉴 테이블에서
# 주문이 가능한  메뉴 중 카테고리 코드가 4,10인 메뉴의
# 카테고리별 개수
select *
from tbl_menu;

select c.category_name, count(*)
from tbl_menu as m
         join tbl_category as c
              on m.category_code = c.category_code
where m.category_code in (4, 10)
  and m.orderable_status = 'Y'
group by c.category_name
;


























