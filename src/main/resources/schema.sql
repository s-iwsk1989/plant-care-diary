--マスタ系
CREATE TABLE IF NOT EXISTS mst_variety (
    variety_id SMALLSERIAL,
    genus_name VARCHAR(18) NOT NULL,
    variety_name TEXT NOT NULL,
    origin VARCHAR(16),
    CONSTRAINT variety_pk PRIMARY KEY(variety_id)
);

CREATE TABLE IF NOT EXISTS mst_increase_method (
    increase_method_id SMALLSERIAL,
    increase_method VARCHAR(18) NOT NULL,
    memo TEXT,
    CONSTRAINT increase_method_pk PRIMARY KEY(increase_method_id)
);

CREATE TABLE IF NOT EXISTS mst_soil (
    soil_id SMALLSERIAL,
    soil VARCHAR(18) NOT NULL,
    memo TEXT,
    CONSTRAINT soil_pk PRIMARY KEY(soil_id)
);

-- カレントテーブル系
CREATE TABLE IF NOT EXISTS tbl_note (
    note_id SMALLSERIAL,
    variety_id SMALLINT,
    name VARCHAR(20) NOT NULL,
    first_date DATE NOT NULL,
    increase_method_id SMALLINT,
    CONSTRAINT note_pk PRIMARY KEY(note_id),
    CONSTRAINT variety_fk FOREIGN KEY(variety_id) REFERENCES mst_variety(variety_id),
    CONSTRAINT increase_method_fk FOREIGN KEY(increase_method_id) REFERENCES mst_increase_method(increase_method_id)
);

CREATE TABLE IF NOT EXISTS tbl_nurture (
    nurture_id SMALLSERIAL,
    note_id SMALLINT,
    first_date DATE NOT NULL,
    end_date DATE NOT NULL,
    CONSTRAINT nurture_pk PRIMARY KEY(nurture_id),
    CONSTRAINT note_fk FOREIGN KEY(note_id) REFERENCES tbl_note(note_id)
);

CREATE TABLE IF NOT EXISTS tbl_potted_info (
    nurture_id SMALLINT,
    material VARCHAR(20),
    size SMALLINT,
    water_supply SMALLINT,
    location SMALLINT,
    soil_id SMALLINT,
    CONSTRAINT nurture_fk FOREIGN KEY(nurture_id) REFERENCES tbl_nurture(nurture_id),
    CONSTRAINT soil_fk FOREIGN KEY(soil_id) REFERENCES mst_soil(soil_id)
);

CREATE TABLE IF NOT EXISTS tbl_environment (
    date DATE,
    wether SMALLINT NOT NULL,
    humid SMALLINT,
    high_temperature SMALLINT,
    low_temperature SMALLINT,
    in_temparature SMALLINT,
    memo TEXT,
    CONSTRAINT date_pk PRIMARY KEY(date)
);

CREATE TABLE IF NOT EXISTS tbl_daily_note (
    note_id SMALLINT,
    date DATE,
    feed VARCHAR(20),
    feed_time SMALLINT,
    illuminance SMALLINT,
    memo TEXT,
--    CONSTRAINT daily_note_pk UNIQUE KEY(note_id, date),
    CONSTRAINT note_fk FOREIGN KEY(note_id) REFERENCES tbl_note(note_id),
    CONSTRAINT date_fk FOREIGN KEY(date) REFERENCES tbl_environment(date)
);
