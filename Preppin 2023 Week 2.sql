select 
CAST(('GB') as VARCHAR(255)) as Countrycode,
replace(sort_code,'-','') as sortcode,
cast(account_number as VARCHAR(255)) as AN,
Countrycode||check_digits||swift_code||sortcode||AN as IBAN
from
TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK02_TRANSACTIONS
as a
INNER JOIN TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK02_SWIFT_CODES as b
ON a.BANK = b.BANK