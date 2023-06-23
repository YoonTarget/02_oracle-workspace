/*
        <SELECT>
        데이터 조회할 때 사용되는 구문
        
        >> RESULT SET : SELECT문을 통해 조회된 결과물 (즉, 조회된 행들의 집합을 의미)
        
        [표현법]
        SELECT 조회하고자 하는 컬럼1, 컬럼2,...
        FROM 테이블명;
        
        * 반드시 존재하는 컬럼으로 써야한다!! 없는 컬럼 쓰면 오류 남!!
*/

-- EMPLOYEE 테이블의 모든 컬럼(*) 조회
--SELECT EMP_ID, EMP_NAME
SELECT *
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사번, 이름, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- JOB 테이블의 모든 컬럼 조회
SELECT *
FROM JOB;

-------------------------------------실습문제------------------------------------
-- 1. JOB 테이블의 직급명만 조회
SELECT JOB_NAME
FROM JOB;

-- 2. DEPARTMENT 테이블의 모든 컬럼 조회
SELECT *
FROM DEPARTMENT;

-- 3. DEPARTMENT 테이블의 부서코드, 부서명 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- 4. EMPLOYEE 테이블의 사원명, 이메일, 전화번호, 입사일, 급여 조회
SELECT *--EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

/*
    <컬럼값을 통한 산술연산>
    SELECT 절 컬럼명 작성 부분에 산술연산 기술 가능 (이때, 산술연산된 결과 조회)
*/
-- EMPLOYEE 테이블의 사원명, 사원의 연봉 (급여 * 12) 조회
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사원명, 급여, 보너스 조회
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사원명, 급여, 보너스, 연봉, 보너스 포함 연봉((급여 + (급여 * 보너스)) * 12) 조회
SELECT EMP_NAME, SALARY, BONUS, SALARY * 12, ((SALARY + (SALARY * BONUS)) * 12)
FROM EMPLOYEE;
--> 산술연산 과정 중 NULL 값이 존재할 경우 산술연산한 결과값 마저도 무조건 NULL로 나옴

-- EMPLOYEE 테이블의 사원명, 입사일
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE;

-- EMPLOYEE에 사원명, 입사일, 근무일수 (오늘 날짜 - 입사일)
-- DATE 형식끼리도 연산 가능!!
-- * 오늘 날짜 : SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;
-- DATE - DATE : 결과값은 일 단위가 맞음!!
-- 단, 값이 지저분한 이유는 DATE 형식 년/월/일/시/분/초 단위로 시간 정보까지도 관리를 하기 때문!!
-- 함수적용하면 깔끔한 결과 확인 가능 => 나중에 배움!!

-----------------------------------------------------------------------------------------------
/*
        <컬럼명에 별칭 지정하기>
        산술연산을 하게 되면 컬럼명 지저분함... 이때 컬럼명으로 별칭 부여해서 깔끔하게 보여줌
        
        [표현법]
        컬럼명 별칭 / 컬럼명 AS 별칭 / 컬럼명 "별칭" / 컬럼명 AS "별칭"
        
        AS 붙이든 안 붙이든 부여하고자 하는 별칭에 띄어쓰기 혹은 특수문자가 포함될 경우 반드시 쌍따옴표로 묶어야함
*/

SELECT EMP_NAME 사원명, SALARY AS 급여, SALARY * 12 "연봉(원)", (SALARY + (SALARY * BONUS)) * 12 AS "총 소득(보너스 포함)"
FROM EMPLOYEE;

-----------------------------------------------------------------------------------------------

/*
        <리터럴>
        임의로 지정한 문자열('')
        
        SELECT 절에 리터럴을 제시하면 마치 테이블상에 존재하는 데이터처럼 조회 가능
        조회된 RESULT SET의 모든 행에 반복적으로 같이 출력
*/

-- EMPLOYEE 테이블의 사번, 사원명, 급여 조회
SELECT EMP_NO, EMP_NAME, SALARY, '원' AS "단위"
FROM EMPLOYEE;

/*
        < 연결 연산자 : || >
        여러 컬럼값들을 마치 하나의 컬럼인 것처럼 연결하거나, 걸럼값과 리터럴을 연결할 수 있음
        
        System.out.println("num의 값 : " + num);
*/

-- 사번, 이름, 급여를 하나의 컬럼으로 조회
SELECT EMP_NO || EMP_NAME || SALARY
FROM EMPLOYEE;

-- 컬럼값과 리터럴값 연결
-- XXX의 월급은 XXX원 입니다. => 컬럼명 별칭 : 급여정보

SELECT EMP_NAME || '의 월급은 ' || SALARY || '원 입니다.' AS "급여정보"
FROM EMPLOYEE;

-------------------------------------------------------------------------------------------------

/*
            < DISTINCT >
            컬럼에 중복된 값들을 한 번씩만 표현하고자 할 때 사용
*/
-- 현재 우리 회사에 어떤 직급의 사람들이 존재하는지 궁금함.

SELECT JOB_CODE
FROM EMPLOYEE; -- 현재는 23명의 직급이 전부 다 조회가 됨.

-- EMPLOYEE에 직급 코드 (중복제거) 조회
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE; -- 중복 제거 돼서 7행만 조회

-- 사원들이 어떤 부서에 속해있는지 궁금하다
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE; -- NULL : 아직 부서배치 안된 사람

-- 유의 사항 : DISTINCT는 SELECT 절에 딱 한 번만 기술 가능
/* 구문 오류
SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE
FROM EMPLOYEE;
*/

SELECT DISTINCT JOB_CODE, DEPT_CODE
FROM EMPLOYEE;
-- (JOB_CODE, DEPT_CODE) 쌍으로 묶어서 중복 판별

=============================================================================

/*
        < WHERE 절 >
        조회하고자 하는 테이블로부터 특정 조건에 만족하는 데이터만을 조회하고자 할 때 사용
        이때, WHERE 절에 조건식을 제시하게 됨
        조건식에서는 다양한 연산자들 사용 가능!
        
        [표현식]
        SELECT 컬럼1, 컬럼2, ...
        FROM 테이블명
        WHERE 조건식;
        
        [비교연산자]
        >, <, >=, <=            => 대소비교
        =                          => 동등비교
        !=, ^=, <>               => 동등하지 않은지 비교
*/

-- EMPLOYEE에서 부서코드가 'D9'인 사원들만 조회 (이때, 모든 컬럼 조회)
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE에서 부서코드가 'D1'인 사원들의 사원명, 급여, 부서코드만 조회
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- EMPLOYEE에서 부서코드가 'D1'이 아닌 사원들의 사번, 사원명, 부서코드 조회
SELECT EMP_NO, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
-- WHERE DEPT_CODE != 'D1';
-- WHERE DEPT_CODE ^= 'D1';
WHERE DEPT_CODE <> 'D1';

-- 급여가 400만원 이상인 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;








