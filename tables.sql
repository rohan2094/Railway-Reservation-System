CREATE TABLE trains(
    train_id INTEGER NOT NULL,
    dated DATE NOT NULL,
    total_ac_seats INTEGER NOT NULL,
    total_sl_seats INTEGER NOT NULL,
    total_ac_coach INTEGER NOT NULL,
    total_sl_coach INTEGER NOT NULL,
);

CREATE TABLE bookings(
    train_id INTEGER NOT NULL,
    dated DATE NOT NULL,
    coach_id INTEGER,
    coach_type VARCHAR NOT NULL,
    berth_no INTEGER NOT NULL,
    berth_type VARCHAR NOT NULL,
    pnr INTEGER NOT NULL,
    FOREIGN KEY train_id REFERENCES trains(train_id);
    FOREIGN KEY dated REFERENCES trains(dated);
    FOREIGN KEY pnr REFERENCES passengers(pnr);
);

CREATE TABLE forAC(
    berth_id INTEGER ,
    berth_type VARCHAR NOT NULL
);

CREATE TABLE forSL(
    berth_id INTEGER NOT NULL,
    berth_type VARCHAR NOT NULL
);

CREATE TABLE passengers(
    pnr INTEGER NOT NULL,
    pname VARCHAR NOT NULL,
);

INSERT INTO forAC(aberth_id, aberth_type) VALUES (1,'LB');
INSERT INTO forAC(aberth_id, aberth_type) VALUES (2,'LB');
INSERT INTO forAC(aberth_id, aberth_type) VALUES (3,'UB');
INSERT INTO forAC(aberth_id, aberth_type) VALUES (4,'UB');
INSERT INTO forAC(aberth_id, aberth_type) VALUES (5,'SL');
INSERT INTO forAC(aberth_id, aberth_type) VALUES (6,'SU');
INSERT INTO forAC(aberth_id, aberth_type) VALUES (7,'LB');
INSERT INTO forAC(aberth_id, aberth_type) VALUES (8,'LB');
INSERT INTO forAC(aberth_id, aberth_type) VALUES (9,'UB');
INSERT INTO forAC(aberth_id, aberth_type) VALUES (10,'UB');
INSERT INTO forAC(aberth_id, aberth_type) VALUES (11,'SL');
INSERT INTO forAC(aberth_id, aberth_type) VALUES (12,'SU');
INSERT INTO forAC(aberth_id, aberth_type) VALUES (13,'LB');
INSERT INTO forAC(aberth_id, aberth_type) VALUES (14,'LB');
INSERT INTO forAC(aberth_id, aberth_type) VALUES (15,'UB');
INSERT INTO forAC(aberth_id, aberth_type) VALUES (16,'UB');
INSERT INTO forAC(aberth_id, aberth_type) VALUES (17,'SL');
INSERT INTO forAC(aberth_id, aberth_type) VALUES (18,'SU');


INSERT INTO forSL(sberth_id, sberth_type) VALUES (1,'LB');
INSERT INTO forSL(sberth_id, sberth_type) VALUES (2,'MB');
INSERT INTO forSL(sberth_id, sberth_type) VALUES (3,'UB');
INSERT INTO forSL(sberth_id, sberth_type) VALUES (4,'LB');
INSERT INTO forSL(sberth_id, sberth_type) VALUES (5,'MB');
INSERT INTO forSL(sberth_id, sberth_type) VALUES (6,'UB');
INSERT INTO forSL(sberth_id, sberth_type) VALUES (7,'SL');
INSERT INTO forSL(sberth_id, sberth_type) VALUES (8,'SU');
INSERT INTO forSL(sberth_id, sberth_type) VALUES (9,'LB');
INSERT INTO forSL(sberth_id, sberth_type) VALUES (10,'MB');
INSERT INTO forSL(sberth_id, sberth_type) VALUES (11,'UB');
INSERT INTO forSL(sberth_id, sberth_type) VALUES (12,'LB');
INSERT INTO forSL(sberth_id, sberth_type) VALUES (13,'MB');
INSERT INTO forSL(sberth_id, sberth_type) VALUES (14,'UB');
INSERT INTO forSL(sberth_id, sberth_type) VALUES (15,'SL');
INSERT INTO forSL(sberth_id, sberth_type) VALUES (16,'SU');
INSERT INTO forSL(sberth_id, sberth_type) VALUES (17,'LB');
INSERT INTO forSL(sberth_id, sberth_type) VALUES (18,'MB');
INSERT INTO forSL(sberth_id, sberth_type) VALUES (19,'UB');
INSERT INTO forSL(sberth_id, sberth_type) VALUES (20,'LB');
INSERT INTO forSL(sberth_id, sberth_type) VALUES (21,'MB');
INSERT INTO forSL(sberth_id, sberth_type) VALUES (22,'UB');
INSERT INTO forSL(sberth_id, sberth_type) VALUES (23,'SL');
INSERT INTO forSL(sberth_id, sberth_type) VALUES (24,'SU');