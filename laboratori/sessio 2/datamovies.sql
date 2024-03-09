--
-- PostgreSQL database dump
--

-- Dumped from database version 12.18 (Ubuntu 12.18-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.18 (Ubuntu 12.18-0ubuntu0.20.04.1)

-- SET statement_timeout = 0;
-- SET lock_timeout = 0;
-- SET idle_in_transaction_session_timeout = 0;
-- SET client_encoding = 'UTF8';
-- SET standard_conforming_strings = on;
-- SELECT pg_catalog.set_config('search_path', '', false);
-- SET check_function_bodies = false;
-- SET xmloption = content;
-- SET client_min_messages = warning;
-- SET row_security = off;

-- SET default_table_access_method = heap;

--
-- Name: movies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE movies (
    name text,
    year integer,
    director text,
    score integer
);


--
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO movies (name, year, director, score) VALUES ('the shining', 1980, 'Stanley Kubrick', 8);
INSERT INTO movies (name, year, director, score) VALUES ('2001 a space odyssey', 1968, 'Stanley Kubrick', 9);
INSERT INTO movies (name, year, director, score) VALUES ('Operation Lune', 2002, 'Stanley Kubrick', 7);
INSERT INTO movies (name, year, director, score) VALUES ('Room 237', 2012, 'Stanley Kubrick', 6);
INSERT INTO movies (name, year, director, score) VALUES ('The hateful eight', 2015, 'Quentin Tarantino', 8);
INSERT INTO movies (name, year, director, score) VALUES ('Once upon a time in hollywood', 2019, 'Quentin Tarantino', 7);
INSERT INTO movies (name, year, director, score) VALUES ('Jackie Brown', 1997, 'Quentin Tarantino', 8);
INSERT INTO movies (name, year, director, score) VALUES ('From dusk till dawn', 1996, 'Quentin Tarantino', 7);
INSERT INTO movies (name, year, director, score) VALUES ('Pulp Fiction', 1994, 'Quentin Tarantino', 10);


--
-- PostgreSQL database dump complete
--

