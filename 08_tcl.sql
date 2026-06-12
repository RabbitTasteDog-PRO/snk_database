# TCL (Transaction Control Language)
# - 트랜잭션 제어 언어
# - commit, rollback, savepoint

# transaction 이란?
# - 한번에 수행될 DML 논리적 작업 단위
#   한번에 완료 또는 취소할 수 있게하기 위해 사용

# MySQL은 기본적으로 Autocommit 활성화 상태
# set autocommit = ON;
set autocommit = Off;

# commit : DML로 인한 변경 사항(transaction)을 DB에 반영
# rollback : DML 변경 사항을 취소 (transaction 내부 내용 폐기)

SELECT @@autocommit;

# 트랜잭션 시작 == 이후 실행되는 DML구문을 트랜잭션에 저장
# 트랜잭션 종료 == commit, rollback
start transaction; # autocommit이 활성화 되어도 사용 가능

select *
from tbl_menu
where menu_code = 21;

# 판개가능 여부 Y -> N
update tbl_menu
set orderable_status = 'N'
where menu_code = 21;

# 수정 사항 확인 됨
# 실제 DB 반영은 안됐지만 조회 시
# 트랜잭션에 저장된 DML 구문을 반영해서 보여줌
select *
from tbl_menu
where menu_code = 21;
# 수정사항을 되돌리려면 변경사항 폐기
rollback;
# 수정사항을 적용할거면 : 변경사항 적용
commit;

delete
from tbl_menu
where menu_code = 100;

insert into tbl_menu
values ( null
       , '트랜잭션 테스트'
       , 3000
       , 5
       , 'Y')
;

select *
from tbl_menu
;

rollback ;

commit ;