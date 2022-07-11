create database debit;

create schema machine;

use database debit;
use schema machine;


CREATE OR REPLACE TABLE debit.machine.raw_atm 
(
 atm_name         VARCHAR
,transaction_date      VARCHAR
,no_of_withdrawals					VARCHAR
,No_Of_XYZ_Card_Withdrawals				VARCHAR
,No_Of_Other_Card_Withdrawals  VARCHAR
,Total_amount_Withdrawn					VARCHAR
,Amount_withdrawn_XYZ_Card					VARCHAR
,Amount_withdrawn_Other_Card			VARCHAR
,weekday  VARCHAR
,Festival_Religion				VARCHAR
,Working_Day				VARCHAR
,Holiday_sequence				VARCHAR

) COMMENT = 'RAW ATM DATA ROLLED UP BY DATE AND MACHINE';


select count(*) from debit.machine.raw_atm; 
    --11,589 records
select * from debit.machine.raw_atm order by atm_name, transaction_date limit 100;


--build view and get data into proper type
CREATE OR REPLACE VIEW debit.machine.dl_atm AS
SELECT 
atm_name as atm_name
,IFF(  CONTAINS(transaction_date, '-') , to_date(transaction_date, 'DD-MM-YYYY') , to_date(transaction_date, 'MM/DD/YYYY')) as transaction_date
--,to_date(transaction_date, 'DD-MM-YYYY') as transaction_date
,no_of_withdrawals::integer as no_of_withdrawals
,No_Of_XYZ_Card_Withdrawals::integer as NO_OF_XYZ_CARD_WITHDRAWALS
,No_Of_Other_Card_Withdrawals::integer as no_of_other_card_withdrawals
,Total_amount_Withdrawn::integer as total_amount_withdrawn
,Amount_withdrawn_XYZ_Card::integer as Amount_withdrawn_XYZ_Card
,Amount_withdrawn_Other_Card::integer as amount_withdrawn_other_card
,weekday as weekday
,Festival_Religion as festival_religion
,Working_Day as working_day
,Holiday_sequence as holiday_sequence
from debit.machine.raw_atm;

select * from debit.machine.dl_atm order by atm_name, transaction_date limit 100;
--select IFF(  CONTAINS(transaction_date, '-') , to_date(transaction_date, 'DD-MM-YYYY') , to_date(transaction_date, 'MM/DD/YYYY')) from debit.machine.raw_atm;

select distinct(working_day) from debit.machine.dl_atm;


select current_user()
--LIST @~
--create or replace stage SP_stage

LIST @SP_STAGE~;

show stages;

show user functions
