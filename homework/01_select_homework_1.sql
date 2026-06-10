### Q1.
# 상위 카테고리 코드가 null이 아닌 카테고리의 카테고리 코드와 카테고리명을 출력하세요.
# 단, 카테고리명을 기준으로 내림차순 정렬하여 출력하세요.
select c.category_code, c.category_name from tbl_category as c
where c.category_code is not null
order by c.category_name desc
;

### Q2.
# 메뉴명에 '밥'이 포함되고, 가격이 20,000원 이상 30,000원 이하인 메뉴의 메뉴명과 가격을 출력하세요.
select m.menu_name, m.menu_price from tbl_menu as m
where m.menu_name like '%밥%'
and m.menu_price between 20000 and 30000
;

### Q3.
# 가격이 10,000원 미만이거나, 메뉴명에 김치가 포함되는 메뉴의 모든 컬럼을 출력하세요.
# 단, 가격을 기준으로 오름차순 정렬하고, 추가로 메뉴명을 기준으로 내림차순 정렬하여 출력하세요.
# select m.menu_name, m.menu_price from tbl_menu as m
select m.* from tbl_menu as m
# where m.menu_price < 10000  like '%김치%' order by m.menu_name desc
where m.menu_price < 10000
and m.menu_name like '%김치%'
order by m.menu_price asc, m.menu_name desc
;

# Q1에서 출력한 카테고리명 결과를 참고하여,
# 카테고리가 ,기타,  쥬스, 커피에 해당하지 않는 메뉴 중 메뉴 가격이 13,000원인 메뉴의 모든 컬럼을 출력하세요.
# 단, 주문이 불가능한 상품은 출력하지 않습니다.
# - 참고 1. Q1 에서 출력한 결과
# - 참고 2. orderable_status의 컬럼값이 N이면 주문 불가
select distinct m.* from tbl_menu as m
where m.orderable_status = 'Y'
and m.category_code not in (10,8,9)
and m.menu_price = 13000
;


