# 새로운 사용자 생성
create user skn_ai@'%' identified by '1234';

# 데이터베이스
create database menudb;

grant all privileges on menudb.* to skn_ai@'%';

show
databases;

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