# 내장 함수
# - mysql dbms에 이미 구현된 함수들
# - 문자, 숫자, 날짜형 함수등을 따로 제공
SELECT NOW();
SELECT DATE_FORMAT(NOW(), '%Y-%m-%d');
SELECT DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i:%s');

# 문자열 관련
SELECT ASCII('A'), CHAR(65);
SELECT CONCAT('호랑이', '기린', '토끼');
SELECT CONCAT_WS(',', '호랑이', '기린', '토끼');
SELECT CONCAT_WS('-', '2023', '05', '31');

# INSTR: 기준 문자열에서 부분 문자열의 시작 위치 반환
# INSTR(기준 문자열에서 부분 문자열의 시작 위치를 반환)
select instr('사과딸기바나나', '딸기');
select instr('사과딸기바나나', '포도');

select *
from tbl_menu
# where menu_name like '%마늘%'
where instr(menu_name, '마늘') != 0
;

# LPAD: 문자열을 길이만큼 왼쪽으로 늘린 후에 빈 곳을 문자열로 채운다.
# RPAD: 문자열을 길이만큼 오른쪽으로 늘린 후에 빈 곳을 문자열로 채운다.
SELECT LPAD('왼쪽', 6, '@'), RPAD('오른쪽', 6, '@');

# SUBSTRING: 시작 위치부터 길이만큼의 문자를 반환
SELECT SUBSTRING('안녕하세요 반갑습니다.', 7, 2);
# 길이를 생략하면 시작 위치부터 끝까지 반환
select SUBSTRING('안녕하세요 반갑습니다.', 7);

select instr('안녕하세요 반갑습니다.', '반갑');
select SUBSTRING('안녕하세요 반갑습니다.', instr('안녕하세요 반갑습니다.', '반갑'));

# 문자 인코딩 : 컴퓨터에서 문자를 표시하는 방법
# utf-8 : 아스키코드 1byte, 나머지는 3byte
# utf-16 : 모든 문자를 2byte(16bit)로 표시
SELECT menu_name,
       # 몇글잔가
       CHAR_LENGTH(menu_name),
       # 몇 바이트 인가? 길이 * 3byte (영어면 1byte)
       LENGTH(menu_name),
       # 몇 비트인가
       BIT_LENGTH(menu_name)
from tbl_menu;
#=============================================================================================================
# 숫자 관련
# CEILING: 올림값 반환
# FLOOR: 내림값 반환
# ROUND: 반올림값 반환
# TRUNCATE(숫자, 소수점 자리) : 버림
SELECT CEILING(1234.56), FLOOR(1234.56), ROUND(1234.56), truncate(1234.56, 0);


select ceiling(-1.5), FLOOR(-1.5), ROUND(-1.5), truncate(-1.5, 0);

select truncate(1234.56, 1);
select truncate(1234.56, 0);
select truncate(1234.56, -1);

select rand(), rand(100);

# 1~45 사이 난수
select truncate((rand() * 45) + 1, 0);

#=============================================================================================================
# 날짜
# ADDDATE: 날짜를 기준으로 차이를 더함
# SUBDATE: 날짜를 기준으로 날짜를 뺌

# now() : 현재시간
# adddate() : 기준 날짜 기준으로 +d
# subdate() : 기준 날짜 기준으로 -d

SELECT NOW(),
       ADDDATE(NOW(), 1),
       SUBDATE(NOW(), 1),
       # day, week, month, year
       ADDDATE(NOW(), interval 1 week),
       SUBDATE(NOW(), interval 1 month);

# DATEDIFF: 날짜1 - 날짜2의 일수를 반환
# TIMEDIFF: 시간1 - 시간2의 결과를 구함

SELECT DATEDIFF(NOW(), '2026-11-20'),
       TIMEDIFF(NOW(), '2023-05-31 12:00:00');

# extract(단위 from date)
# - 단위 : year, quarter, month, week, day, hour, minute, second
select extract(year from sysdate())    year
     , extract(quarter from sysdate()) quarter
     , extract(month from sysdate())   month
     , extract(week from sysdate())    week
     , extract(day from sysdate())     day
     , extract(HOUR from sysdate())    hour
     , extract(minute from sysdate())  minute
     , extract(second from sysdate())  second;

# date_format(datetime, 형식문자열) -> 문자열
select date_format(now(), '%y/%m/%d'),
       date_format(now(), '%Y/%m/%d'),
       date_format(now(), '%h:%i');

# str_to_date(문자열, 형식문자열) -> datetime
select str_to_date('25/04/21', '%y/%m/%d'),
       str_to_date('2025/04/21', '%Y/%m/%d'),
       cast('2025/04/21' as date);
-- 날짜시간형식 유추가 가능한 경우

# 기타함수
# null처리 함수 - ifnull(값, null일때 값)
select ifnull(category_code, '미지정') category_code
from tbl_menu;

# 삼항연산처리 - if(조건식, 참일때 값, 거짓일때 값)
select isnull(ref_category_code),
       if(isnull(ref_category_code), '미지정', ref_category_code) category_code
from tbl_category;

select menu_name,
       menu_price,
       if(menu_price < 10000, '싼', '비싼') price_clf
from tbl_menu;






