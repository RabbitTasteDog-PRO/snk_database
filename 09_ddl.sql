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
    name       varchar(100)        not null comment '상품명',
    price      int/* or decimal */ not null default 0 comment '상품 가격',
    created_at datetime                     default CURRENT_TIMESTAMP comment '상품등록일시'
);

select *
from product;
# 생성한 테이블 DDL 구문 확인
show create table product;

# 생성한 테이블 설명 조회
desc product;

# ddl 테이블의 메타 정보를 조회하는 구문
select *
from information_schema.tables
where table_schema = 'menudb'
  and table_name = 'product'
;

# product 테이블에 데이터 추가
insert into product(name)
values ('텀블러')
;
insert into product(name, price)
values ('머그컵', 5000)
;

select *
from product
;

delete
from product
where id = 2;
delete
from product
where id = 4;

commit;
rollback;

# ==============================================================================
### 제약조건(constraint)
# 테이블 컬럼에 붙어
# insert, update 시 각 컬럼에 기록되는 값에
# 조건을 설정하는 방법
# - 무결성을 보장하는 목적으로 사용
# - 종류 : not null, unique, primary key, foreign key, check
desc product;
# 제약 조건들 확인
select *
from information_schema.TABLE_CONSTRAINTS
where CONSTRAINT_SCHEMA = 'menudb'
  and TABLE_NAME = 'tbl_menu'
;

# not null : 지정된 컬럼은 null일 수 없다 == 값 필수
# unique : 지정된 컬럼에는 중복된값을 넣을수없다
DROP TABLE IF EXISTS user_unique;
CREATE TABLE IF NOT EXISTS user_unique
(
    user_no   INT          NOT NULL,
    user_id   VARCHAR(255) NOT NULL,
    user_pwd  VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender    VARCHAR(3),
    phone     VARCHAR(255) NOT NULL UNIQUE, # 컬럼레벨 제약조건
    email     VARCHAR(255)
# ,   UNIQUE (phone) # 테이블레벨 제약 조건
) ENGINE = INNODB;

INSERT INTO user_unique
    (user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
       (2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

# unique 제약조건 위배
INSERT INTO user_unique
    (user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES (3, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com');

# unique 값 변경 -> phone 값 변경
# + not null 제약조건 위배
INSERT INTO user_unique
    (user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES (3, null, 'pass03', '이순신', '남', '010-8888-8888', 'lee222@gmail.com');

# unique  및  not null 제약조건 충족
INSERT INTO user_unique
    (user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES (3, 'user03', 'pass03', '이순신', '남', '010-8888-8888', 'lee222@gmail.com');


SELECT *
FROM user_unique;

# primary key
# - 테이블 내 행을 구별하기 위한
#   식별자 역할의 컬럼에 추가하는 제약조건
# not null + unique : 중복되지 않는값이 필수
# 테이블에서 1개만 설정 가능
# 단, PK 설정이 적용되는 컬럼은 1개 또는 여러 개 묶음
DROP TABLE IF EXISTS user_primarykey;
CREATE TABLE IF NOT EXISTS user_primarykey
(
--     user_no INT PRIMARY KEY,
    user_no   INT,
    user_id   VARCHAR(255) NOT NULL,
    user_pwd  VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender    VARCHAR(3),
    phone     VARCHAR(255) NOT NULL,
    email     VARCHAR(255),
    PRIMARY KEY (user_no)
) ENGINE = INNODB;

INSERT INTO user_primarykey
    (user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
       (2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT *
FROM user_primarykey;

desc user_primarykey;

# primary key 제약조건 에러 발생(null값 적용)
INSERT INTO user_primarykey
    (user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES (null, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com');

# primary key 제약조건 에러 발생(중복값 적용)
INSERT INTO user_primarykey
    (user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES (2, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com');

# 정상코드
INSERT INTO user_primarykey
    (user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES (3, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com');


# PK 복합 키
create table order_composite_pk (
    user_id int,
    prod_id int,
    count int default 1,
    ordered_at datetime default (current_timestamp),
    primary key(user_id, prod_id, ordered_at)
);

desc order_composite_pk;

insert into order_composite_pk
values (1, 1, 10, now());
insert into order_composite_pk
values (2, 1, 5, now());
insert into order_composite_pk
values (3, 100, default, now());

select * from order_composite_pk;

# pk 컬럼 3개 밧이 모두 일차하는 중복 데이터 삽입
insert into order_composite_pk
    (
     select * from order_composite_pk
              where user_id = 1
    );


# FOREIGN KEY(외래키)
# - 참조된 (reference) 참조된 다른 테이블에서 제공하는 값만 사용 가능
# - 참조 무결성을 위배하지 않기 위해 사용
# - 다른 테이블의 pk 또는 unique가 설정된 컬럼만 참조 가능하다
# - FK 제약 조건 설정 시 두 테이블간의 관가(relationship)이 형성된다
#   - 부모 테이블 : 참조를 당해서 컬럼값을 제공하는 테이블
#   - 자식 테이블 : 참조를 통해 다른 테이블의 컬럼값을 사용하는 테이블
# - 제공되는 값 외에 null 가능

DROP TABLE IF EXISTS user_grade;
CREATE TABLE IF NOT EXISTS user_grade (
    grade_code INT NOT NULL UNIQUE,
    grade_name VARCHAR(255) NOT NULL
) ENGINE=INNODB;

INSERT INTO user_grade
VALUES
(10, '일반회원'),
(20, '우수회원'),
(30, '특별회원');

SELECT * FROM user_grade;

DROP TABLE IF EXISTS user_foreignkey1;
CREATE TABLE IF NOT EXISTS user_foreignkey1 (
    user_no INT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    grade_code INT ,
    FOREIGN KEY (grade_code)
		REFERENCES user_grade (grade_code)
) ENGINE=INNODB;

INSERT INTO user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com', 20);

SELECT * FROM user_foreignkey1;


# 부모 테이블에서 제공하지 않는값(50) 삽입
INSERT INTO user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(3, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com', 50);


### FK 삭제 옵션 설정
# - 기본값 : 부모 컬럼 값을 자식이 참조 중이면 변경, 삭제 불가능
# - UPDATE/DELETE SET NULL :
#   부모 컬람값을 자식이 참조 중이면 변경 삭제 시
#   자식 컬럼 값을 null로 세팅한다

# - UPDATE/DELETE CASCADE :
#   부모 컬람값을 자식이 참조 중이면 변경 삭제 시
#   자식 테이블에서 참조 값이 포함된 모든 행을 삭제
DROP TABLE IF EXISTS user_foreignkey2;

CREATE TABLE IF NOT EXISTS user_foreignkey2 (
    user_no INT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    grade_code INT ,
    FOREIGN KEY (grade_code)
		REFERENCES user_grade (grade_code)
        ON UPDATE SET NULL
        ON DELETE SET NULL
) ENGINE=INNODB;

INSERT INTO user_foreignkey2
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com', 20);

SELECT * FROM user_foreignkey2;

DROP TABLE IF EXISTS user_foreignkey1;

UPDATE user_grade
SET grade_code = 50
WHERE grade_code = 10;

-- 자식 테이블의 grade_code가 10이 었던 회원의 grade_code값이 NULL이 된 것을 확인
SELECT * FROM user_foreignkey2;

DELETE FROM user_grade
WHERE grade_code = 20;

-- 자식 테이블의 grade_code가 20이 었던 회원의 grade_code값이 NULL이 된 것을 확인
SELECT * FROM user_foreignkey2;


# CHECK 제약 조건
# 컬럼에 삽입될수 있는 값에 대한 조건을 설정
DROP TABLE IF EXISTS user_check;
CREATE TABLE IF NOT EXISTS user_check (
    user_no INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3) CHECK (gender IN ('남','여')),
    age INT CHECK (age >= 19)
) ENGINE=INNODB;

INSERT INTO user_check
VALUES
    (null, '홍길동', '남', 25),
    (null, '이순신', '남', 33);

SELECT * FROM user_check;
# gender 컬럼의 CHECK 제약 조건 에러 발생(성별이 두 글자)
INSERT INTO user_check
VALUES (null, '안중근', '남성', 27);
# age 컬럼의 CHECK 제약 조건 에러 발생(나이가 19세 미만)
INSERT INTO user_check
VALUES (null, '유관순', '여', 17);





