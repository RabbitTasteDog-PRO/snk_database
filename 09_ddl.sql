# DDL (Data Definition Language)
# - 데이터베이스 스키마(객체,DB테이블) 를
#   만들고(create), 수정하고(update), 삭제(drop)하는 구문
# - DDL 구문은 실행 시 바로 DB에 반영된다

# ***[주의사항]***
# *** 절대 DML(transaction)과 DDL을 홍용해서 작성하면 안됨 ***
# 1. DML 구문 수행 -> 트랜잭션에 담김
# 2. 중간에 DDL 구문 수행
# 3. 트랜잭션 내용이 자동 COMMIT

# ==============================================================================
### create table
/* [작성법]
```sql
    create table if not exists {테이블명} (
        컬럼1 자료형 {제약조건|auto increment} {기본값} {comment}
        컬럼2 자료형 {제약조건} {기본값} {comment}
        컬럼3 자료형 {제약조건} {기본값} {comment}
        ...
   )
```
*/


create table if not exists product
(
#   컬럼 자료형 {제약조건|auto increment} {기본값} {comment}
#   auto_increment : 숫자 자동 증가, PK만 가능
    id         int primary key auto_increment comment '상품식별코드',
#   컬럼  자료형         {제약조건} {기본값} {comment}
    name       varchar(100) not null comment '상품명',
    price      int/* or decimal */ not null default 0 comment '상품 가격',
    created_at datetime default CURRENT_TIMESTAMP comment '상품등록일시'
);

select * from product;
# 생성한 테이블 DDL 구문 확인
show create table product;

# 생성한 테이블 설명 조회
desc product;

# ddl 테이블의 메타 정보를 조회하는 구문
select * from information_schema.tables
where table_schema = 'menudb'
and table_name = 'product'
;

# product 테이블에 데이터 추가
insert into product(name) values ('텀블러')
;
insert into product(name, price) values ('머그컵', 5000)
;

select * from product
;

delete from product where id = 2;
delete from product where id = 4;

commit;
rollback ;






