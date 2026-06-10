# 새로운 사용자 생성
create user skn_ai@'%' identified by '1234';

# 데이터베이스
create database menudb;

grant all privileges on menudb.* to skn_ai@'%';