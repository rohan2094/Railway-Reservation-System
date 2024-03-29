-- CREATE OR REPLACE PROCEDURE add_train(train_id INTEGER, dated VARCHAR, ac_coaches INTEGER, sl_coaches INTEGER)
-- CREATE OR REPLACE  PROCEDURE check_availability(train_id INTEGER, dated VARCHAR, coach_type VARCHAR, tot_passenger INT, INOUT return_val INTEGER)
-- CREATE OR REPLACE PROCEDURE book_ticket(train_id INTEGER, dated VARCHAR, coach_type VARCHAR, passenger_name VARCHAR, pnr INTEGER, total_ac_coach INTEGER, total_sl_coach INTEGER)

 
call add_train(1234, '2023-09-12', 1, 1);
call check_availability(1232, '12-12-2002', 'AC', 10, 0);
call check_availability(1232, '12-14-2002', 'AC', 10000, 0);
call check_availability(1232, '12-14-2002', 'AC', 10, 0);
call check_availability(1232, '12-14-2002', 'AC', 10000, 0);
call check_availability(1232, '12-14-2002', 'SL', 10, 0);
call check_availability(1232, '12-14-2002', 'SL', 10, 0);
call check_availability(1232, '12-14-2002', 'SL', 240, 0);
call check_availability(1232, '12-14-2002', 'SL', 10000, 0);

-- CREATE OR REPLACE PROCEDURE book_ticket(train_id INTEGER, dated VARCHAR, coach_type VARCHAR, tot_passenger INTEGER, passList character varying[], pnr INTEGER)


call book_ticket(1234, '2023-09-12', 'SL', array['Raghav', 'Rohan', 'Shyam', 'Vijay', 'Janmeet', 'Aakash', 'Sushil'], 24, 7);
select * from trains ;
call book_ticket(1232, '12-14-2002', 'AC', 'Shyam', 2, 10, 10);
call book_ticket(1232, '12-14-2002', 'SL', 'Vijay', 2, 10, 10);
call book_ticket(1232, '12-14-2002', 'SL', 'Rohan', 2, 10, 10);
call book_ticket(6909, '2023-01-11', 'SL', 'Janmeet', 32, 10);