CREATE OR REPLACE PROCEDURE add_train(train_id INTEGER, dated VARCHAR, ac_coaches INTEGER, sl_coaches INTEGER)
    AS
    $$
    DECLARE
         ac_seats  INTEGER ;
         sl_seats  INTEGER ;
         cc  INTEGER ;
         ss INTEGER ;
         in_query  VARCHAR ;
         condition_check  VARCHAR ;
         checker   INTEGER ;
    BEGIN
        ac_seats = ac_coaches * 18 ;
        sl_seats = sl_coaches * 24 ;
        cc = 0 ;
        ss = 0 ;
        condition_check  = CONCAT('SELECT COUNT(*) FROM trains WHERE train_id = ', train_id, ' AND dated = ''',  dated, '''');
        EXECUTE condition_check INTO checker ;
        if(checker = 0) THEN 
            in_query = CONCAT('INSERT INTO trains(train_id, dated, total_ac_seats, total_sl_seats, total_ac_coach, total_sl_coach) VALUES (', train_id , ', ''' , dated, ''',', ac_seats, ',' , sl_seats, ',' , ac_coaches, ',', sl_coaches ,')');
            execute (in_query);
        END IF;

    END
    $$
LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE book_ticket(train_id INTEGER, dated VARCHAR, coach_type VARCHAR, passList character varying[], pnr INTEGER, tot_passenger INTEGER)
    AS $$
    DECLARE
        psname VARCHAR ;
        query1_trains VARCHAR;
        query2_seats VARCHAR;
        no_of_trains INTEGER;
        no_of_seats INTEGER;
        query_to_update VARCHAR;
        query_for_ac_coach VARCHAR;
        query_for_sl_coach VARCHAR;
        total_ac_coach INTEGER;
        total_sl_coach INTEGER;
        current_coach INTEGER;
        table_name VARCHAR;
        update_attr VARCHAR;
        current_coach_seats INTEGER;
        query_for_seats VARCHAR;
        query_avail VARCHAR;
        avail INTEGER;
        total_coaches INTEGER;
        current_seats_filled INTEGER;
        query_for_type VARCHAR;
        current_berth INTEGER;
        total_berth INTEGER;
        alloted_berth_id INTEGER;
        alloted_berth_type VARCHAR;
        insert_query VARCHAR;
        insert_query2 VARCHAR;
        current_pass INTEGER ;
        flag INTEGER; 
    BEGIN
        update_attr = CONCAT('total_', coach_type, '_seats');
        query_for_ac_coach = CONCAT('SELECT total_ac_coach FROM trains WHERE train_id = ', train_id , ' AND dated = ''', dated, '''');
        query_for_sl_coach = CONCAT('SELECT total_sl_coach FROM trains WHERE train_id = ', train_id , ' AND dated = ''', dated, '''');
        execute query_for_ac_coach into total_ac_coach; 
        execute query_for_sl_coach into total_sl_coach; 
        table_name = CONCAT('for', coach_type);
        query1_trains = CONCAT('SELECT COUNT(*) FROM trains WHERE train_id = ', train_id, ' AND dated = ''', dated, '''');
        no_of_seats = 0 ;
        EXECUTE query1_trains INTO no_of_trains;
        IF(no_of_trains = 0) THEN 
            raise notice 'No-of_trains : %', no_of_trains;
            return;
        ELSE IF(coach_type = 'AC') THEN
                query2_seats = CONCAT('SELECT SUM(total_ac_seats) FROM trains WHERE train_id =', train_id ,' AND dated =''' ,dated, '''');
                EXECUTE query2_seats INTO  no_of_seats ;
            ELSE 
                query2_seats = CONCAT('SELECT SUM(total_sl_seats) FROM trains WHERE train_id =', train_id ,' AND dated =''' ,dated, '''');
                EXECUTE query2_seats INTO  no_of_seats ;
            END IF;
        END IF;
        raise notice 'No-of_seats : %', no_of_seats;

        IF(tot_passenger > no_of_seats) THEN
            return ;
        -- Neeche wali transiction pe lock karna kisi tarah se dekhte hai baad me
        ELSE
            query_to_update = CONCAT('UPDATE trains SET ', update_attr, ' = ', update_attr, '-', tot_passenger , ' WHERE train_id = ', train_id , ' AND dated = ''', dated, '''');
            EXECUTE query_to_update;
        END IF;
    
        IF (coach_type = 'AC') THEN
                total_coaches = total_ac_coach ;
                total_berth = 18;
        ELSE 
                total_coaches = total_sl_coach ;
                total_berth = 24;
        END IF ;
        current_pass = 1;
        LOOP
            EXIT WHEN current_pass > tot_passenger;
            psname = passList[current_pass];
            current_coach = 1;
            flag = 0 ;
            LOOP
                EXIT WHEN current_coach > total_coaches;
                query_for_seats = CONCAT('SELECT COUNT(*) FROM bookings WHERE train_id = ', train_id , ' AND dated = ''', dated, ''' AND coach_id = ', current_coach, ' AND coach_type = ''', coach_type, '''');
                EXECUTE query_for_seats INTO current_seats_filled;
                IF (coach_type = 'AC' AND current_seats_filled = 18) THEN
                    current_coach = current_coach + 1;
                    CONTINUE;
                END IF ;
                IF (coach_type = 'SL' AND current_seats_filled = 24) THEN
                    current_coach = current_coach + 1;
                    CONTINUE;
                END IF ;
                    -- Now alloting berth_id
                    -- Now we know that current_coach has an available seat, so we select that birth_id
                    current_berth = 1 ;
                    LOOP
                        EXIT WHEN current_berth > total_berth;
                            -- Now check if current_coach and current_berth already has an entry in bookings table
                            query_avail = CONCAT('SELECT COUNT(*) FROM bookings WHERE train_id = ', train_id , ' AND dated = ''', dated, ''' AND coach_id = ', current_coach, ' AND berth_no = ', current_berth, ' AND coach_type = ''', coach_type, '''');
                            EXECUTE query_avail INTO avail;
                            if(avail <> 0)  THEN
                                current_berth = current_berth + 1 ;
                                CONTINUE;
                            END IF ;
                            -- Here simply allot this 
                            alloted_berth_id = current_berth ;
                            query_for_type = CONCAT('SELECT berth_type FROM ', table_name, ' WHERE berth_id = ', alloted_berth_id);
                            EXECUTE query_for_type INTO alloted_berth_type;
                            insert_query = CONCAT('INSERT INTO bookings(train_id, dated, coach_id, coach_type, berth_no, berth_type, pnr, pname) VALUES(', train_id, ',''', dated, ''',', current_coach , ',''' ,coach_type,''',' , current_berth, ',''' ,alloted_berth_type, ''', ', pnr, ',''' ,psname, ''')');
                            EXECUTE insert_query;
                            insert_query2 =  CONCAT('INSERT INTO passengers (pnr, pname) VALUES(', pnr, ',''' ,psname , ''')');
                            EXECUTE insert_query2;
                            flag = 1 ;
                            EXIT;
                    END LOOP;
                    IF(flag = 1) THEN
                    EXIT;
                    END IF ;
            END LOOP;
            current_pass = current_pass + 1 ;
        END LOOP;
    END
    $$
LANGUAGE plpgsql;
