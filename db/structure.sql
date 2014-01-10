--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: asocieri; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE asocieri (
    id integer NOT NULL,
    curs_id integer,
    grupa_id integer,
    an integer,
    semestru integer,
    formular_id integer
);


--
-- Name: asocieri_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE asocieri_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: asocieri_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE asocieri_id_seq OWNED BY asocieri.id;


--
-- Name: cursuri; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cursuri (
    id integer NOT NULL,
    nume character varying(255),
    tip character varying(255),
    profesor_id integer
);


--
-- Name: cursuri_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cursuri_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cursuri_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cursuri_id_seq OWNED BY cursuri.id;


--
-- Name: data_evaluari; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE data_evaluari (
    id integer NOT NULL,
    grupa_terminal boolean,
    data date,
    last_refresh date
);


--
-- Name: data_evaluari_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE data_evaluari_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: data_evaluari_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE data_evaluari_id_seq OWNED BY data_evaluari.id;


--
-- Name: eval_completate; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE eval_completate (
    id integer NOT NULL,
    curs_id integer,
    incognito_user_token character varying(255),
    timp integer,
    continut hstore,
    data date,
    semestru integer,
    an integer
);


--
-- Name: eval_completate_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE eval_completate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: eval_completate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE eval_completate_id_seq OWNED BY eval_completate.id;


--
-- Name: eval_disponibile; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE eval_disponibile (
    id integer NOT NULL,
    curs_id integer,
    grupa_nume integer,
    formular_id integer,
    semestru integer
);


--
-- Name: eval_disponibile_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE eval_disponibile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: eval_disponibile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE eval_disponibile_id_seq OWNED BY eval_disponibile.id;


--
-- Name: formulare; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE formulare (
    id integer NOT NULL,
    continut text,
    an integer,
    semestru integer,
    stadiu character varying(255),
    specializare character varying(255),
    tip_curs character varying(1) DEFAULT 'c'::character varying
);


--
-- Name: formulare_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE formulare_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: formulare_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE formulare_id_seq OWNED BY formulare.id;


--
-- Name: grupe; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE grupe (
    id integer NOT NULL,
    nume integer,
    studenti integer,
    terminal boolean,
    an integer,
    serie integer,
    specializare character varying(255),
    domeniu character varying(255),
    zi_id character varying(2),
    lmd character varying(1)
);


--
-- Name: grupe_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE grupe_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: grupe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE grupe_id_seq OWNED BY grupe.id;


--
-- Name: incognito_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE incognito_users (
    id integer NOT NULL,
    token character varying(255),
    grupa_nume integer
);


--
-- Name: incognito_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE incognito_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: incognito_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE incognito_users_id_seq OWNED BY incognito_users.id;


--
-- Name: profesori; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE profesori (
    id integer NOT NULL,
    nume character varying(255),
    prenume character varying(255),
    departament character varying(255)
);


--
-- Name: profesori_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE profesori_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: profesori_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE profesori_id_seq OWNED BY profesori.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: sesiune_active; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sesiune_active (
    id integer NOT NULL,
    incognito_user_token character varying(255),
    incepere_data timestamp without time zone
);


--
-- Name: sesiune_active_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sesiune_active_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sesiune_active_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sesiune_active_id_seq OWNED BY sesiune_active.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY asocieri ALTER COLUMN id SET DEFAULT nextval('asocieri_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cursuri ALTER COLUMN id SET DEFAULT nextval('cursuri_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY data_evaluari ALTER COLUMN id SET DEFAULT nextval('data_evaluari_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY eval_completate ALTER COLUMN id SET DEFAULT nextval('eval_completate_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY eval_disponibile ALTER COLUMN id SET DEFAULT nextval('eval_disponibile_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY formulare ALTER COLUMN id SET DEFAULT nextval('formulare_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY grupe ALTER COLUMN id SET DEFAULT nextval('grupe_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY incognito_users ALTER COLUMN id SET DEFAULT nextval('incognito_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY profesori ALTER COLUMN id SET DEFAULT nextval('profesori_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sesiune_active ALTER COLUMN id SET DEFAULT nextval('sesiune_active_id_seq'::regclass);


--
-- Name: asocieri_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY asocieri
    ADD CONSTRAINT asocieri_pkey PRIMARY KEY (id);


--
-- Name: cursuri_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cursuri
    ADD CONSTRAINT cursuri_pkey PRIMARY KEY (id);


--
-- Name: data_evaluari_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY data_evaluari
    ADD CONSTRAINT data_evaluari_pkey PRIMARY KEY (id);


--
-- Name: evaluare_completate_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY eval_completate
    ADD CONSTRAINT evaluare_completate_pkey PRIMARY KEY (id);


--
-- Name: evaluare_disponibile_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY eval_disponibile
    ADD CONSTRAINT evaluare_disponibile_pkey PRIMARY KEY (id);


--
-- Name: formulare_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY formulare
    ADD CONSTRAINT formulare_pkey PRIMARY KEY (id);


--
-- Name: grupe_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY grupe
    ADD CONSTRAINT grupe_pkey PRIMARY KEY (id);


--
-- Name: incognito_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY incognito_users
    ADD CONSTRAINT incognito_users_pkey PRIMARY KEY (id);


--
-- Name: profesori_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY profesori
    ADD CONSTRAINT profesori_pkey PRIMARY KEY (id);


--
-- Name: sesiune_active_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sesiune_active
    ADD CONSTRAINT sesiune_active_pkey PRIMARY KEY (id);


--
-- Name: eval_comp_continut; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX eval_comp_continut ON eval_completate USING gin (continut);


--
-- Name: idx_grupe_nume; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_grupe_nume ON grupe USING btree (nume);


--
-- Name: idx_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_token ON incognito_users USING btree (token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20130331142225');

INSERT INTO schema_migrations (version) VALUES ('20130331142405');

INSERT INTO schema_migrations (version) VALUES ('20130331142448');

INSERT INTO schema_migrations (version) VALUES ('20130331143452');

INSERT INTO schema_migrations (version) VALUES ('20130331144319');

INSERT INTO schema_migrations (version) VALUES ('20130331144727');

INSERT INTO schema_migrations (version) VALUES ('20130331144751');

INSERT INTO schema_migrations (version) VALUES ('20130331144820');

INSERT INTO schema_migrations (version) VALUES ('20130331144906');

INSERT INTO schema_migrations (version) VALUES ('20130403224144');

INSERT INTO schema_migrations (version) VALUES ('20130404213017');

INSERT INTO schema_migrations (version) VALUES ('20130411205405');

INSERT INTO schema_migrations (version) VALUES ('20130411210220');

INSERT INTO schema_migrations (version) VALUES ('20130412181910');

INSERT INTO schema_migrations (version) VALUES ('20130412182042');

INSERT INTO schema_migrations (version) VALUES ('20130412204509');

INSERT INTO schema_migrations (version) VALUES ('20130412204552');

INSERT INTO schema_migrations (version) VALUES ('20130414152009');

INSERT INTO schema_migrations (version) VALUES ('20130414153338');

INSERT INTO schema_migrations (version) VALUES ('20130428195326');

INSERT INTO schema_migrations (version) VALUES ('20130428195714');

INSERT INTO schema_migrations (version) VALUES ('20130428195922');

INSERT INTO schema_migrations (version) VALUES ('20130428201019');

INSERT INTO schema_migrations (version) VALUES ('20130428201656');

INSERT INTO schema_migrations (version) VALUES ('20130428202648');

INSERT INTO schema_migrations (version) VALUES ('20130428205855');

INSERT INTO schema_migrations (version) VALUES ('20130428221820');

INSERT INTO schema_migrations (version) VALUES ('20130503140357');

INSERT INTO schema_migrations (version) VALUES ('20130503154501');

INSERT INTO schema_migrations (version) VALUES ('20130504124114');

INSERT INTO schema_migrations (version) VALUES ('20130504130222');

INSERT INTO schema_migrations (version) VALUES ('20130504180205');

INSERT INTO schema_migrations (version) VALUES ('20130504180315');

INSERT INTO schema_migrations (version) VALUES ('20130506164903');

INSERT INTO schema_migrations (version) VALUES ('20130506182721');

INSERT INTO schema_migrations (version) VALUES ('20130507070003');

INSERT INTO schema_migrations (version) VALUES ('20130512172545');

INSERT INTO schema_migrations (version) VALUES ('20130529141936');