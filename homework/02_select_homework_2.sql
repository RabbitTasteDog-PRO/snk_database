### Q1.

# 상위 카테고리 코드가 null이 아닌 카테고리의 카테고리 코드와 카테고리명을 출력하세요.
# 단, 카테고리명을 기준으로 내림차순 정렬하여 출력하세요.

select *
from employeedb.JOB;
# Q1.
# 재직 중이고 휴대폰 마지막 자리가 2인 직원 중
# 입사일이 가장 최근인 직원 3명의
# 사원번호, 직원명, 전화번호, 입사일, 퇴직여부를 출력하세요.
select e.EMP_ID, e.EMP_NAME, e.PHONE, e.HIRE_DATE, e.ENT_YN
from employeedb.EMPLOYEE as e
where e.ENT_YN = 'N'
# and e.PHONE like '%__________2'
  and e.PHONE like '%2'
# order by e.ENT_DATE desc limit 3
order by e.HIRE_DATE desc
limit 3
;


select e.PHONE, e.ENT_YN
from employeedb.EMPLOYEE as e,
     employeedb.JOB as j;


### Q2.
# 재직 중인 ‘대리’들의 직원명, 직급명, 급여, 사원번호, 이메일, 전화번호, 입사일을 출력하세요.
# 단, 급여를 기준으로 내림차순 출력하세요.
select distinct e.EMP_NAME
              , j.JOB_NAME
              , e.SALARY
              , e.EMP_ID
              , e.EMAIL
              , e.PHONE
              , e.HIRE_DATE
from employeedb.EMPLOYEE as e,
     employeedb.JOB as j
where j.JOB_CODE = 'J6'
and e.ENT_YN = 'N'
order by e.SALARY desc
;

### Q2. join 활용
# 재직 중인 ‘대리’들의 직원명, 직급명, 급여, 사원번호, 이메일, 전화번호, 입사일을 출력하세요.
# 단, 급여를 기준으로 내림차순 출력하세요.
select e.EMP_NAME 이름
     , j.JOB_NAME 직급
     , e.SALARY 급여
     , e.EMP_ID 사번
     , e.EMAIL 메일
     , e.PHONE 전화번호
     , e.HIRE_DATE 입사일
from employeedb.EMPLOYEE as e
         join employeedb.JOB as j on e.JOB_CODE = j.JOB_CODE
where e.ENT_YN = 'N'
and j.JOB_NAME = '대리'
order by e.SALARY desc
;

select * from employeedb.EMPLOYEE as e
where e.JOB_CODE = 'J6'
;

SHOW TABLES FROM menudb;
show tables from employeedb;

### Q2.
# 재직 중인 ‘대리’들의 직원명, 직급명, 급여, 사원번호, 이메일, 전화번호, 입사일을 출력하세요.
# 단, 급여를 기준으로 내림차순 출력하세요.
select
    e.emp_name as 직원명,
    j.job_name as 직급명,
    e.salary as 급여,
    e.emp_id as 사번,
    e.email as 이메일,
    e.phone as 전화번호,
    e.hire_date as 입사일
from
    employeedb.EMPLOYEE e
join
    employeedb.JOB j
on
    e.job_code = j.job_code
where
    j.job_name = '대리'
and
    e.ent_yn = 'N'
order by
    e.salary desc;