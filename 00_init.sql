SHOW DATABASES;
# 데이터 테이블 확인
SELECT user, host
FROM mysql.user;

# 새로운 사용자 생성
create user skn_ai@'%' identified by '1234';

# 데이터베이스
# MySQL에서는 database와 schema로 같은 의미로 사용
# - database(창고)
# - schema(창고 설계도, 명세서)
# database(데이터 창고)
create database menudb; # 데티어베이스 생성
create schema employeedb; # 스키마 생성

# 권한부여
grant all privileges on menudb.* to skn_ai@'%';
grant all privileges on employeedb.* to skn_ai@'%';

# skn_ai 계정에 부여된 권한 테이블 확인
show grants for skn_ai@'%';


show databases;

select user(), current_user();

# 도커 실행
# open -a Docker

# 도커 연결 확인
# docker ps

# root 계정 연결
# docker exec -it mysql8 mysql -u root -p
# pw : 1234

# 사용자 계정 연결
# docker exec -it mysql8 mysql -u skn_ai -p
# pw : 1234


# DB 연결
/*
docker run --name mysql8 \
  -e MYSQL_ROOT_PASSWORD=1234 \
  -e MYSQL_DATABASE=menudb \
  -e MYSQL_USER=skn_ai \
  -e MYSQL_PASSWORD=1234 \
  -p 3306:3306 \
  -d mysql:8.0
*/

# select * from menudb;
SELECT * FROM tbl_category;

SELECT DATABASE();

USE menudb;
SHOW TABLES;

SELECT t.* FROM menudb.tbl_order t;



CREATE USER IF NOT EXISTS 'skn_ai'@'%' IDENTIFIED BY '1234';

CREATE DATABASE IF NOT EXISTS menudb;
CREATE DATABASE IF NOT EXISTS employeedb;

GRANT ALL PRIVILEGES ON menudb.* TO 'skn_ai'@'%';
GRANT ALL PRIVILEGES ON employeedb.* TO 'skn_ai'@'%';

FLUSH PRIVILEGES;

SHOW DATABASES;
SELECT user, host FROM mysql.user;
SHOW GRANTS FOR 'skn_ai'@'%';