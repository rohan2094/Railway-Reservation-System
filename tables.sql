-- This is for resetting the entire databse again :
-- Copy this code in psql server to reset the database entries.

DROP TABLE trains ;
DROP TABLE bookings ;
DROP TABLE passengers;
DROP TABLE forac ;
DROP TABLE forsl ;

-- For a single AC coach description
CREATE TABLE forac(
    berth_id INTEGER ,
    berth_type VARCHAR NOT NULL
);

-- For a single sleeper coach description
CREATE TABLE forsl(
    berth_id INTEGER NOT NULL,
    berth_type VARCHAR NOT NULL
);

-- Number of available trains in database comes through this table
CREATE TABLE trains(
    train_id INTEGER NOT NULL,
    dated VARCHAR(10) NOT NULL,
    total_ac_seats INTEGER NOT NULL,
    total_sl_seats INTEGER NOT NULL,
    total_ac_coach INTEGER NOT NULL,
    total_sl_coach INTEGER NOT NULL
);

-- Relation between trains and forac or forsl
-- This table links the train's seat with a particular passenger
CREATE TABLE bookings(
    train_id INTEGER NOT NULL,
    dated VARCHAR NOT NULL,
    coach_id INTEGER,
    coach_type VARCHAR NOT NULL,
    berth_no INTEGER NOT NULL,
    berth_type VARCHAR NOT NULL,
    pnr INTEGER NOT NULL,
    pname VARCHAR NOT NULL
);

-- List of all passengers with their pnr values
CREATE TABLE passengers(
    pnr INTEGER NOT NULL,
    pname VARCHAR NOT NULL
);

-- Adding ac coach seats into forac table
INSERT INTO forAC(berth_id, berth_type) VALUES (1,'LB');
INSERT INTO forAC(berth_id, berth_type) VALUES (2,'LB');
INSERT INTO forAC(berth_id, berth_type) VALUES (3,'UB');
INSERT INTO forAC(berth_id, berth_type) VALUES (4,'UB');
INSERT INTO forAC(berth_id, berth_type) VALUES (5,'SL');
INSERT INTO forAC(berth_id, berth_type) VALUES (6,'SU');
INSERT INTO forAC(berth_id, berth_type) VALUES (7,'LB');
INSERT INTO forAC(berth_id, berth_type) VALUES (8,'LB');
INSERT INTO forAC(berth_id, berth_type) VALUES (9,'UB');
INSERT INTO forAC(berth_id, berth_type) VALUES (10,'UB');
INSERT INTO forAC(berth_id, berth_type) VALUES (11,'SL');
INSERT INTO forAC(berth_id, berth_type) VALUES (12,'SU');
INSERT INTO forAC(berth_id, berth_type) VALUES (13,'LB');
INSERT INTO forAC(berth_id, berth_type) VALUES (14,'LB');
INSERT INTO forAC(berth_id, berth_type) VALUES (15,'UB');
INSERT INTO forAC(berth_id, berth_type) VALUES (16,'UB');
INSERT INTO forAC(berth_id, berth_type) VALUES (17,'SL');
INSERT INTO forAC(berth_id, berth_type) VALUES (18,'SU');

-- Adding sl coach seats into forac table
INSERT INTO forSL(berth_id, berth_type) VALUES (1,'LB');
INSERT INTO forSL(berth_id, berth_type) VALUES (2,'MB');
INSERT INTO forSL(berth_id, berth_type) VALUES (3,'UB');
INSERT INTO forSL(berth_id, berth_type) VALUES (4,'LB');
INSERT INTO forSL(berth_id, berth_type) VALUES (5,'MB');
INSERT INTO forSL(berth_id, berth_type) VALUES (6,'UB');
INSERT INTO forSL(berth_id, berth_type) VALUES (7,'SL');
INSERT INTO forSL(berth_id, berth_type) VALUES (8,'SU');
INSERT INTO forSL(berth_id, berth_type) VALUES (9,'LB');
INSERT INTO forSL(berth_id, berth_type) VALUES (10,'MB');
INSERT INTO forSL(berth_id, berth_type) VALUES (11,'UB');
INSERT INTO forSL(berth_id, berth_type) VALUES (12,'LB');
INSERT INTO forSL(berth_id, berth_type) VALUES (13,'MB');
INSERT INTO forSL(berth_id, berth_type) VALUES (14,'UB');
INSERT INTO forSL(berth_id, berth_type) VALUES (15,'SL');
INSERT INTO forSL(berth_id, berth_type) VALUES (16,'SU');
INSERT INTO forSL(berth_id, berth_type) VALUES (17,'LB');
INSERT INTO forSL(berth_id, berth_type) VALUES (18,'MB');
INSERT INTO forSL(berth_id, berth_type) VALUES (19,'UB');
INSERT INTO forSL(berth_id, berth_type) VALUES (20,'LB');
INSERT INTO forSL(berth_id, berth_type) VALUES (21,'MB');
INSERT INTO forSL(berth_id, berth_type) VALUES (22,'UB');
INSERT INTO forSL(berth_id, berth_type) VALUES (23,'SL');
INSERT INTO forSL(berth_id, berth_type) VALUES (24,'SU');