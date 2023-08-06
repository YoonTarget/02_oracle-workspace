-- 1. 사원 테이블의 모든열 출력
SELECT * FROM EMP;

-- 2. 사원테이블의 사원번호, 이름, 월급 출력 (별칭 지어서)
SELECT EMPNO AS "사원번호", ENAME AS "이름", SAL AS "월급" FROM EMP;

-- 3. 사원테이블의 이름과 월급을 서로 붙여서 출력 (출력예시 ) KING5000)
SELECT ENAME || SAL AS "사원 이름 + 월급" FROM EMP;

-- 4. 사원테이블의 이름과 월급을 서로 붙여서 출력 (출력예시) KING의 월급은 5000입니다.)
SELECT ENAME || '의 월급은 ' || SAL || '입니다.' AS "사원 이름 + 월급" FROM EMP;

-- 5. 사원테이블의 이름과 직업을 서로 붙여서 출력 (출력예시) KING의 직업은 PRESIDENT 입니다.)
SELECT ENAME || '의 직업은 ' || JOB || '입니다.' AS "사원 이름 + 직업" FROM EMP;

-- 6. 사원테이블에서 직업을 출력하는데 중복된 데이터를 제외하고 출력해보기 (두가지 버전)
-- 한가지 방법은 수업시간에 했지만, 다른방법은 수업시간에 안함 => 검색해서 찾아보기 
-- 6_1. DISTINCT 사용
SELECT DISTINCT JOB FROM EMP;

-- 6_2. GROUP BY 사용
SELECT JOB
FROM EMP
GROUP BY JOB;

-- 7. 이름과 월급을 출력하는데 월급이 낮은 사원부터 출력  
-- 7-1. 별칭붙이지 않은 버전
SELECT ENAME, SAL
FROM EMP
ORDER BY SAL;

-- 7_2. 별칭붙인버전 (ORDER BY 절에)
SELECT ENAME AS "사원명", SAL AS "월급"
FROM EMP
ORDER BY 월급;

-- 7_3. 컬럼순서로 정렬한 버전
SELECT ENAME, SAL
FROM EMP
ORDER BY 2;

-- 8. 월급이 3000인 사원의 이름과, 월급, 직업 출력
SELECT ENAME, SAL, JOB
FROM EMP
WHERE SAL = 3000;

-- 9. 월급이 3000이상인 사원의 이름과, 월급, 직업 출력
SELECT ENAME, SAL, JOB
FROM EMP
WHERE SAL >= 3000;

-- 10. 이름이 SCOTT인 사원의 이름, 월급, 직업, 입사일, 부서번호 출력
SELECT ENAME, SAL, JOB, HIREDATE, DEPTNO
FROM EMP
WHERE ENAME = 'SCOTT';

-- 11. 연봉이 3600 이상인 사원들의 이름과 연봉 출력
SELECT ENAME, SAL
FROM EMP
WHERE SAL >= 3600;

-- 12. 부서번호가 10번인 사원들의 이름, 월급, 커미션, 월급 + 커미션 출력
SELECT ENAME, SAL, COMM, SAL + NVL(COMM, 0)
FROM EMP
WHERE DEPTNO = '10';

-- 13. 월급이 1000에서 3000 사이인 사원들의 이름과 월급 출력 (비교연산자, BETWEEN AND 구문 두가지 버전 다 작성)
--13_1. 비교연산자 사용
SELECT ENAME, SAL
FROM EMP
WHERE SAL >= 1000 AND SAL <= 3000;

--13_2. BETWEEN AND 구문 사용
SELECT ENAME, SAL
FROM EMP
WHERE SAL BETWEEN 1000 AND 3000;

-- 14. 이름의 첫글자가 S로 시작하는 사원들의 이름과 월급 출력
SELECT ENAME, SAL
FROM EMP
WHERE ENAME LIKE 'S%';

-- 15. 이름의 두번째 철자가 M인 사원의 이름을 출력
SELECT ENAME
FROM EMP
WHERE ENAME LIKE '_M%';

-- 16. 이름의 끝 글자가 T로 끝나는 사원들의 이름을 출력
SELECT ENAME
FROM EMP
WHERE ENAME LIKE '%T';

-- 17. 이름에 A를 포함하고 있는 사원들의 이름 출력
SELECT ENAME
FROM EMP
WHERE ENAME LIKE '%A%';

-- 18. 커미션이 NULL인 사원들의 이름과 커미션 출력
SELECT ENAME, COMM
FROM EMP
WHERE COMM IS NULL;

-- 19. 직업이 SALESMAN, ANALYST, MANAGER인 사원들의 이름, 월급,직업 출력 => (OR, IN 사용 두가지버전으로)
-- 19_1. OR 사용
SELECT ENAME, SAL, JOB
FROM EMP
WHERE JOB = 'SALESMAN' OR JOB = 'ANALYST' OR JOB = 'MANAGER';

-- 19_2. IN 사용
SELECT ENAME, SAL, JOB
FROM EMP
WHERE JOB IN ('SALESMAN', 'ANALYST', 'MANAGER');

-- 20. 직업이 SALESMAN이고 월급이 1200 이상인 사원들의 이름, 월급, 직업 출력
SELECT ENAME, SAL, JOB
FROM EMP
WHERE JOB = 'SALESMAN' AND SAL >= 1200;

-- 21. 사원테이블의 이름 출력시 첫번째 컬럼은 이름을 대문자로 출력하고, 두번째 컬럼은 이름을 소문자로 출력하고, 세번째 컬럼은 이름의 첫 번째 철자는 대문자로 하고 나머지는 소문자로 출력
SELECT UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
FROM EMP;

-- 22. 이름이 soctt 인 사원의 이름과 월급을 조회하는 쿼리 => where절에 scott 글자를 소문자로 작성할 것! 1행 나와야함
SELECT LOWER(ENAME), SAL
FROM EMP
WHERE LOWER(ENAME) = 'scott';

-- 23. 영어단어 SMITH에서 SMI만 잘라서 추출
SELECT SUBSTR('SMITH', 1, 3) FROM DUAL;

-- 24. 사원들의 이름과 이름의 철자개수를 출력
SELECT ENAME, LENGTH(ENAME)
FROM EMP;

-- 25. 가나다라마 의 글자수 출력
SELECT LENGTH('가나다라마')
FROM DUAL;

-- 26. 가나다라마의 바이트 수 출력
SELECT LENGTHB('가나다라마')
FROM DUAL;

-- 27. 사원이름 SMITH에서 알파벳 철자 M이 몇번째 자리에 있는지 출력
SELECT INSTR(ENAME, 'M')
FROM EMP
WHERE ENAME = 'SMITH';

-- 28. abcdefg@naver.com 이메일에서 naver.com만 출력 (INSTR , SUBSTR 두가지 버전)
-- 28_1. INSTR
SELECT SUBSTR('abcdefg@naver.com',INSTR('abcdefg@naver.com', 'naver.com'))
FROM DUAL;

-- 28_2. SUBSTR
SELECT SUBSTR('abcdefg@naver.com', 9) FROM DUAL;

-- 29. 이름과 월급을 출력하는데, 월급을 출력할 때 숫자 0을 *(별표)로 출력 (KING, 5***) 
SELECT ENAME, REPLACE(SAL, 0, '*')
FROM EMP;

-- 30. TEST_ENAME 이라는 테이블 생성 (컬럼 1개 : ENAME VARCHAR2(10) )
CREATE TABLE TEST_ENAME(
    ENAME VARCHAR2(10)
);

-- 31. TEST_ENAME 이라는 테이블에 3개의 샘플데이터 넣기 (김시연, 차은우, 주지훈)
INSERT INTO TEST_ENAME VALUES('김시연');
INSERT INTO TEST_ENAME VALUES('차은우');
INSERT INTO TEST_ENAME VALUES('주지훈');

-- 32. COMMIT; 실행
SELECT * FROM TEST_ENAME;

-- 33. 이름의 두번째 자리의 한글을 *로 출력 (김*연, 차*우, 주*훈)
SELECT REPLACE(ENAME, SUBSTR(ENAME, 2, 1), '*')
FROM TEST_ENAME;

-- 34. 이름과 월급을 출력하는데 월급컬럼의 자리수를 10자리로 하여 월급 출력하고, 남은자리는 *로 채워서 출력
SELECT ENAME, RPAD(SAL, 10, '*')
FROM EMP;

-- 35. 첫번째 컬럼은 smith 철자를 출력하고, 두번째 컬럼은 영어단어 smith에서 s를 잘라서 출력하고, 세번째 컬럼은 smith에서 h잘라서 출력하고
--     네번째 컬럼은 영어단어 smiths의 양쪽 s를 제거하여 출력 ( smith, mith, smit, mith ) =>  배웠던 함수 활용
SELECT 'smith', LTRIM('smith', 's'), RTRIM('smith', 'h'), TRIM('s' FROM 'smiths')
FROM DUAL;

-- 36. 이름이 JACK인 사원의 이름과 월급을 조회 = >안나옴.. 왜안나올까? 공백이있음 => 나오게 출력 
SELECT ENAME, SAL
FROM EMP
WHERE TRIM(ENAME) = 'JACK';

-- 37. 876.567 숫자 출력시 소수점 두 번째 자리인 6에서 반올림해서 출력
SELECT ROUND(876.567, 1) FROM DUAL;

-- 38. 876.567 숫자 출력시 소수점 두 번째 자리인 6과 그 이후의 숫자들을 모두 버리고 출력
SELECT TRUNC(876.567, 1) FROM DUAL;

-- 39. 숫자 10을 3으로 나눈 나머지값 구하기
SELECT MOD(10, 3) FROM DUAL;

-- 40. 이름을 출력하고 입사한 날짜부터 오늘까지 총 몇달을 근무했는지 출력
SELECT ENAME, '약 ' || CEIL(MONTHS_BETWEEN(SYSDATE, HIREDATE)) || '개월' AS "근무 개월"
FROM EMP;

-- 50. 2023년 6월 30일로부터 100달 뒤의 날짜는 어떻게 되는지 출력
SELECT ADD_MONTHS('23/06/30', 100)
FROM DUAL;

-- 51. 2023년 1월 1일 부터 바로 돌아올 월요일의 날짜가 어떻게 되는지 출력
SELECT NEXT_DAY('23/01/01', '월')
FROM DUAL;

-- 52. 오늘부터 앞으로 돌아올 화요일의 날짜를 출력
SELECT NEXT_DAY(SYSDATE, '화')
FROM DUAL;

-- 53. 오늘부터 100달 뒤에 돌아오는 월요일의 날짜를 출력
SELECT NEXT_DAY(ADD_MONTHS(SYSDATE, 100), '월')
FROM DUAL;

-- 54. 1990년 5월 22일 해당 달의 마지막 날짜가 어떻게 되는지 출력
SELECT LAST_DAY('90/05/22')
FROM DUAL;

-- 55. 오늘부터 이번달 말일까지 총 며칠 남았는지 출력
SELECT LAST_DAY(SYSDATE) - SYSDATE
FROM DUAL;

-- 56. 이름이 KING인 사원의 이름, 입사일, 입사한 달의 마지막 날짜 출력
SELECT ENAME, HIREDATE, LAST_DAY(HIREDATE)
FROM EMP
WHERE ENAME = 'KING';

-- 57. 이름이 SCOTT인 사원의 이름과 입사한 요일을 출력하고 SCOTT의 월급에 천 단위를 구분할 수 있는 콤마(,) 붙여서 출력
SELECT ENAME, TO_CHAR(HIREDATE, 'DAY'), TO_CHAR(SAL,'999,999')
FROM EMP
WHERE ENAME = 'SCOTT';

-- 58. 1981년도에 입사한 사원의 이름과 입사일 출력 => TO_CHAR 이용하여
SELECT ENAME, HIREDATE
FROM EMP
WHERE TO_CHAR(HIREDATE, 'YYYY') = '1981';

-- 59. 전체사원의 이름과, 입사연도, 입사달, 입사요일 출력
SELECT ENAME, TO_CHAR(HIREDATE, 'YYYY') || '년', TO_CHAR(HIREDATE, 'MON'), TO_CHAR(HIREDATE, 'DAY')
FROM EMP;

-- 60. 전체사원의 이름과, 월급*200 출력 => 콤마찍어서
SELECT ENAME, TO_CHAR(SAL * 200, '999,999,999')
FROM EMP;

-- 61. 위의 예제에다가 원화붙여서 출력
SELECT ENAME, TO_CHAR(SAL * 200, 'L999,999,999')
FROM EMP;

-- 62. 이름과 커미션 출력. 커미션 NULL일 경우 0으로 출력
SELECT ENAME, NVL(COMM, 0)
FROM EMP;

-- 63. 사원번호와 사원번호가 짝수인지 홀수인지 출력 (7839, 홀수)
SELECT EMPNO, DECODE(MOD(EMPNO, 2), 0, '짝수', 1, '홀수')
FROM EMP;

-- 64. 사원의 이름과 직업과 보너스를 출력. 직업이 SALESMAN이면 보너스를 5000이라고 출력하고 그 외는 2000이라고 출력 
SELECT ENAME, JOB, DECODE(JOB, 'SALESMAN', 5000, 2000) AS "BONUS"
FROM EMP
ORDER BY JOB;

-- 65. 이름, 직업,월급, 보너스 출력. 보너스는 월급이 3000이상이면 500. 2000이상~3000 보다 작으면 300. 월급이 1000이상~2000 보다 작으면 200 나머지는 0 => CASE WHEN THEN 구문
SELECT ENAME, JOB,
        CASE    WHEN SAL >= 3000 THEN 500
                WHEN SAL >= 2000 AND SAL < 3000 THEN 300
                WHEN SAL >= 1000 AND SAL < 2000 THEN 200
                ELSE 0
        END AS "BONUS"
FROM EMP
ORDER BY BONUS DESC;

-- 66. 직업이 SALESMAN인 사원들 중 최대월급 출력
SELECT MAX(SAL)
FROM EMP
WHERE JOB = 'SALESMAN';

-- 67. 각 부서별 최대 급여 출력
SELECT DEPTNO, MAX(SAL)
FROM EMP
GROUP BY DEPTNO;

-- 68. 직업, 직업별 최소 월급 출력. 단, SALESMAN은 제외하고, 직업별 최소월급이 높은것 부터 출력
SELECT JOB, MIN(SAL)
FROM EMP
WHERE JOB != 'SALESMAN'
GROUP BY JOB
ORDER BY MIN(SAL) DESC;

-- 69. 직업과 직업별 월급의 총합을 출력. 단, SALESMAN은 제외하고,  총월급이 4000 이상인 직업만 출력
SELECT JOB, SUM(SAL)
FROM EMP
WHERE JOB != 'SALESMAN'
GROUP BY JOB
HAVING SUM(SAL) >= 4000;

-- 70. 직업이 ANALYST, MANAGER 인 사원들의 이름, 직업, 월급, 월급의 순위 출력 (1위가 2명일시 다음은 바로 3위)
SELECT ENAME, JOB, SAL, RANK() OVER(ORDER BY SAL DESC)
FROM EMP
WHERE JOB IN ('ANALYST', 'MANAGER');

-- 71. 직업이 ANALYST, MANAGER 인 사원들의 이름, 직업, 월급, 월급의 순위 출력 (1위가 2명일시 다음은 바로 2위)
SELECT ENAME, JOB, SAL, DENSE_RANK() OVER(ORDER BY SAL DESC)
FROM EMP
WHERE JOB IN ('ANALYST', 'MANAGER');

-- 72. 사원테이블에서 사원번호, 이름, 직업, 월급을 출력. 단, 월급높은 상위 5개의 행만 출력
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
ORDER BY SAL DESC;

SELECT *
FROM (SELECT EMPNO, ENAME, JOB, SAL
        FROM EMP
        ORDER BY SAL DESC)
WHERE ROWNUM <= 5;

-- 73. 사원테이블과 급여테이블을 조인하여 사원명, 급여, 급여등급 출력 (ANSI, ORACLE)
-- ORACLE
SELECT ENAME, SAL, GRADE
FROM EMP, SALGRADE
WHERE SAL BETWEEN LOSAL AND HISAL;

-- ANSI
SELECT ENAME, SAL, GRADE
FROM EMP
JOIN SALGRADE ON (SAL BETWEEN LOSAL AND HISAL);

-- 74. 사원테이블과 부서테이블을 조인하여 이름과 부서위치 출력(단, BOSTON 도 같이 출력되게 해볼 것)(ANSI, ORACLE)
SELECT * FROM DEPT;

-- ORACLE
SELECT NVL(ENAME, '해당인원 없음') AS "이름", LOC AS "부서위치"
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;

-- ANSI
SELECT NVL(ENAME, '해당인원 없음') AS "이름", LOC AS "부서위치"
FROM EMP
RIGHT JOIN DEPT USING (DEPTNO);

-- 75. 사원 테이블을 셀프조인 하여 이름, 직업, 해당사원의 관리자 이름과 관리자의 직업 출력(ANSI, ORACLE)
SELECT * FROM EMP;

-- ORACLE
SELECT E.ENAME, E.JOB, P.ENAME, P.JOB
FROM EMP E, EMP P
WHERE E.MGR = P.EMPNO;

-- ANSI
SELECT E.ENAME, E.JOB, P.ENAME, P.JOB
FROM EMP E
JOIN EMP P ON (E.MGR = P.EMPNO);

-- 76. 사원테이블과 부서테이블 조인하여 이름, 직업,월급,부서위치 출력 (단, 사원명 JACK의 데이터와 부서위치 BOSTON의 데이터 둘다 나와야함)
SELECT * FROM EMP WHERE TRIM(ENAME) = 'JACK';
SELECT * FROM DEPT WHERE LOC = 'BOSTON';

SELECT NVL(TRIM(ENAME), '해당인원 없음') AS "이름", NVL(JOB, ' ') AS "직업", NVL(SAL, 0) AS "월급", LOC AS "부서위치"
FROM EMP
FULL JOIN DEPT USING (DEPTNO);

