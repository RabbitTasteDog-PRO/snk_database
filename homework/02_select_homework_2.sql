### Q1.

# 상위 카테고리 코드가 null이 아닌 카테고리의 카테고리 코드와 카테고리명을 출력하세요.
# 단, 카테고리명을 기준으로 내림차순 정렬하여 출력하세요.

select * from employeedb.JOB;
# Q1.
# 재직 중이고 휴대폰 마지막 자리가 2인 직원 중
# 입사일이 가장 최근인 직원 3명의
# 사원번호, 직원명, 전화번호, 입사일, 퇴직여부를 출력하세요.
select e.EMP_ID, e.EMP_NAME,e.PHONE,e.HIRE_DATE,e.ENT_YN from employeedb.EMPLOYEE as e
where e.ENT_YN = 'N'
# and e.PHONE like '%__________2'
and e.PHONE like '%2'
# order by e.ENT_DATE desc limit 3
order by e.HIRE_DATE desc limit 3
;

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
     employeedb.JOB as j,
     employeedb.SAL_GRADE as s
where j.JOB_CODE = 'J6'
order by e.SALARY desc
;


select e.PHONE, e.ENT_YN from employeedb.EMPLOYEE as e, employeedb.JOB as j;