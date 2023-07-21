//scenario 1
select
split_part(transaction_code,'-',1) as Bank,
sum(value) as Total_value
from TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK01
GROUP BY Bank;

//scenario 2
select
split_part(transaction_code,'-',1) as Bank,
CASE
WHEN online_or_in_person = '1' then 'Online'
else 'in_person'
end,
dayname(to_date(split_part(transaction_date,' ',1),'DD/MM/YYYY')) as TD,
sum(value) as Total_value
from TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK01
GROUP BY Bank,TD,online_or_in_person;

//scenario 3
select
split_part(transaction_code,'-',1) as Bank,
sum(value) as Total_value,
customer_code
from TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK01
GROUP BY Bank,customer_code;