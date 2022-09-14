# DataQualityChecks
### Run additional queries on cdm

------------------------
### Queries
#### Query1. Person Id - Visit Occurrence Id
```
Visit Occurrence Table의 Person_ID 와 각 Table의 Person_ID 비교
```


#### Query2. Visit Start Date Table Date
```
Visit Occurrence Table의 visit_start_date 와 각 Table의 Start_Date 비교
```


#### Query3. Source Value Concept Id
```
SourceValue에 대하여 매핑된 ConceptId의 정확성 검토
```


#### Query4. Duplicated data Detect
```
데이터 이관 과정에서 발생한 중복 데이터 탐지  
```

--------------------
## How to Run
### 1. Make a python 
build_config.py 또는 build_config.ipynb 실행하여 config.ini 생성
(Postgres 에서만 실행됨)
```
1) DB 정보 입력
 - Host:
 - DB name: postgres
 - Port: 
 - Username:
 - Password:
 
2) 디렉토리 정보 입력
 - DQD directory : 미입력시 현재 디렉토리
 - outputFolder : 미입력시 result_날짜
```

### 2. Run queries
execute.py 또는 execute.ipynb 실행하여 result 생성
```
Query4의 그룹 컬럼 선택을 위해 처음으로 실행시(query4.csv의 columnlist 열이 비어있으면)
subquery를 실행하여 query4.csv파일이 수정됨 -> query4.csv의 columnlist 열이 채워짐
```

--------------------
## Required Packages
```
psycopg2
pandas  
```
