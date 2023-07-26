WITH TE AS(
SELECT 
SUM(VALUE) AS TOTAL_VALUE,
SPLIT_PART(TRANSACTION_CODE,'-',1) AS BANK,
TO_CHAR(TO_DATE(SPLIT_PART(TRANSACTION_DATE,' ',1),'DD/MM/YYYY'),'MON') AS MONTH_NAME,
RANK() OVER (PARTITION BY MONTH_NAME ORDER BY SUM(VALUE) DESC) AS RAN
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK01
GROUP BY BANK,MONTH_NAME)

, TE2 AS (
SELECT * 
FROM(
SELECT 
SUM(VALUE) AS TOTAL_VALUE,
SPLIT_PART(TRANSACTION_CODE,'-',1) AS BANK,
TO_CHAR(TO_DATE(SPLIT_PART(TRANSACTION_DATE,' ',1),'DD/MM/YYYY'),'MON') AS MONTH_NAME,
RANK() OVER (PARTITION BY MONTH_NAME ORDER BY SUM(VALUE) DESC) AS RAN
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK01
GROUP BY BANK,MONTH_NAME)
HAVING RAN < 4)

SELECT * FROM
(SELECT *
FROM
(SELECT  AVG(RAN),BANK
FROM TE
GROUP BY BANK) AS A
INNER JOIN TE2 ON A.BANK = TE2.BANK) AS C

INNER JOIN


(SELECT AVG(TOTAL_VALUE), RAN AS RAN2
FROM TE
GROUP BY RAN2)

ON C.RAN = RAN2