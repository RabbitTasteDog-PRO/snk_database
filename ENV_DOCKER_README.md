# Docker MySQL 명령어 정리

## 1. Docker 실행

Docker Desktop 실행

```bash
open -a Docker
```

Docker가 정상 실행되었는지 확인

```bash
docker ps
```

---

## 2. MySQL 컨테이너 시작

```bash
docker start mysql8
```

실행 확인

```bash
docker ps
```

예시

```bash
CONTAINER ID   IMAGE       STATUS
ed2c1849c0a4   mysql:8.0   Up
```

---

## 3. MySQL 접속

```bash
docker exec -it mysql8 mysql -u root -p
```

비밀번호 입력

---

## 4. 데이터베이스 조회

```sql
SHOW DATABASES;
```

---

## 5. 데이터베이스 선택

```sql
USE menudb;
```

---

## 6. 테이블 조회

현재 선택된 DB의 모든 테이블 조회

```sql
SHOW TABLES;
```

---

## 7. 현재 선택된 DB 확인

```sql
SELECT DATABASE();
```

---

## 8. 컨테이너 상태 확인

실행 중인 컨테이너

```bash
docker ps
```

전체 컨테이너

```bash
docker ps -a
```

---

## 9. 컨테이너 종료

```bash
docker stop mysql8
```

---

## 10. 컨테이너 재시작

```bash
docker restart mysql8
```

---

## 11. 컨테이너 로그 확인

```bash
docker logs mysql8
```

실시간 로그

```bash
docker logs -f mysql8
```

---

## 12. 컨테이너 내부 접속

Bash 접속

```bash
docker exec -it mysql8 bash
```

MySQL 접속

```bash
mysql -u root -p
```

---

## 13. 3306 포트 충돌 확인

```bash
sudo lsof -iTCP:3306 -sTCP:LISTEN
```

예시

```bash
COMMAND PID USER
mysqld 159 _mysql
```

---

## 14. 충돌 프로세스 종료

```bash
sudo kill PID
```

예시

```bash
sudo kill 159
```

---

## 15. Docker 학습 시 매일 사용하는 명령어

### Docker 실행

```bash
open -a Docker
```

### MySQL 컨테이너 시작

```bash
docker start mysql8
```

### 실행 확인

```bash
docker ps
```

### MySQL 접속

```bash
docker exec -it mysql8 mysql -u root -p
```

### DB 확인

```sql
SHOW DATABASES;
```

### 테이블 확인

```sql
SHOW TABLES;
```

---

## 16. 현재 컨테이너 정보 확인

```bash
docker inspect mysql8
```

환경 변수 확인

```bash
docker inspect mysql8 | grep MYSQL
```

루트 비밀번호 확인

```bash
docker inspect mysql8 | grep MYSQL_ROOT_PASSWORD
```
