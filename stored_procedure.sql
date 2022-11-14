CREATE OR REPLACE add_train(train_id INTEGER, dated DATE, ac_coaches INTEGER, sl_coaches INTEGER)
    AS
    $$
    DECLARE
        INTEGER ac_seats;
        INTEGER sl_seats;
        INTEGER cc;
        INTEGER ss
        VARCHAR in_query;
    BEGIN
        SET ac_seats = ac_coaches * 18 ;
        SET sl_seats = sl_coaches * 24 ;
        SET cc = 0 ;
        SET ss = 0 ;
        in_query = CONCAT("INSERT INTO trains(train_id, total_ac_seats, total_sl_seats, total_ac_coach, total_sl_coach) values (", train_id , "," , ac_seats, "," , sl_seats, ",", ac_coaches, ",", sl_coaches);
        execute (in_query);
    END
    $$


LANGUAGE plpgsql;



CREATE OR REPLACE book_ticket(train_id INTEGER, dated DATE, coach_type VARCHAR, passenger_name VARCHAR, pnr INTEGER, total_AC_coach INTEGER, total_SL_coach INTEGER)
    AS
    $$
    DECLARE
        current_coach INTEGER;
        table_name VARCHAR;
        current_coach_seats INTEGER;
        query_for_seats VARCHAR;
        query_avail VARCHAR;
        avail INTEGER;
        total_coaches INTEGER;
        current_seats_filled INTEGER;
        query_for_btype VARCHAR;
        current_berth INTEGER;
        total_berth INTEGER;
        alloted_berth_id INTEGER;
        alloted_berth_type VARCHAR;
        insert_query VARCHAR;
        insert_query2 VARCHAR;
    BEGIN
        table_name = CONCAT("for", coach_type);
        IF (coach_type === 'AC') 
            BEGIN
                SET total_coaches = total_AC_coach ;
                SET total_berth = 18;
            END 
        ELSE BEGIN
                SET total_coaches = total_SL_coach ;
                SET total_berth = 24;
        END
        SET current_coach_seats = 1;
        LOOP
            query_for_seats = CONCAT('SELECT COUNT(*) FROM bookings WHERE train_id = ', train_id , ' AND dated = ', dated, ' AND coach_id = ', current_coach);
            EXIT WHEN current_coach > total_coaches;
            
            EXECUTE query_for_seats INTO current_seats_filled;
            IF (coach_type === 'AC' AND current_seats_filled === 18)
                current_coach = current_coach + 1;
                CONTINUE;
            IF (coach_type === 'SL' AND current_seats_filled === 24)
                current_coach = current_coach + 1;
                CONTINUE;
            END
                -- Now alloting berth_id
                -- Now we know that current_coach has an available seat, so we select that birth_id
                SET current_berth = 1 ;
                LOOP
                    EXIT WHEN current_berth > total_berth;
                        -- Now check if current_coach and current_berth already has an entry in bookings table
                        query_avail = CONCAT('SELECT COUNT(*) FROM bookings WHERE train_id = ', train_id , ' AND dated = ', dated, ' AND coach_id = ', current_coach, ' AND berth_no = ', current_berth);
                        EXECUTE query_avail INTO avail;
                        if(avail <> 0) 
                        BEGIN
                            current_berth = current_berth + 1 ;
                            CONTINUE;
                        END
                        -- Here simply allot this 
                        alloted_berth_id = current_berth ;
                        query_for_type = CONCAT('SELECT berth_type FROM ', table_name, ' WHERE berth_id = ', alloted_berth_id);
                        EXECUTE query_for_type INTO alloted_berth_type;
                        insert_query = CONCAT('INSERT INTO bookings( train_id, dated, coach_id, coach_type, berth_no, berth_type, pnr) VALUES(', train_id, ',', dated, ',' ,coach_type,',' , alloted_berth_id, ',' ,alloted_berth_type, ', ', pnr,  ')');
                        EXECUTE insert_query ;
                        insert_query2 =  CONCAT('INSERT INTO passengers (pnr, pname) VALUES(', pnr, ',' ,passenger_name , ')');
                        EXECUTE insert_query2 ;
                    EXIT;
                END LOOP
            EXIT;
        END LOOP
    END
    $$
LANGUAGE plpgsql;

