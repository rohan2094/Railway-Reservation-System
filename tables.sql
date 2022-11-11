CREATE TABLE hasAC (
    acoach_id SERIAL NOT NULL, 
    aavail_seats INTEGER NOT NULL,
    aberth_id INTEGER NOT NULL,
    adated DATE NOT NULL,
    atrain_id INTEGER
);

CREATE TABLE hasSL (
    scoach_id SERIAL NOT NULL, 
    savail_seats INTEGER NOT NULL,
    sberth_id INTEGER NOT NULL,
    sdated DATE NOT NULL,
    strain_id INTEGER NOT NULL 
);

CREATE TABLE acdesc(
    aberth_id SERIAL PRIMARY KEY ,
    aberth_type VARCHAR(10) PRIMARY KEY NOT NULL,
    aberth_id REFERENCES hasAC(aberth_id)
);

CREATE TABLE sleeperdesc(
    sberth_id INTEGER PRIMARY KEY ,
    sberth_type VARCHAR(10) NOT NULL,
    sberth_id REFERENCES hasSL(sberth_id)
);

CREATE TABLE passenger(
    pid SERIAL NOT NULL,
    pname VARCHRA(50) NOT NULL,
    pcoach_id INTEGER NOT NULL,
    pberth_id INTEGER NOT NULL,
    pberth_type VARCHAR(10) NOT NULL,
    pcoach_type CHAR NOT NULL,
    PRIMARY KEY(pid)
);

CREATE TABLE ticket(
    ticket_id SERIAL NOT NULL,
    pid INTEGER NOT NULL
);