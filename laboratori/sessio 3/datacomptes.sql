--
-- PostgreSQL database dump
--

-- Dumped from database version 12.18 (Ubuntu 12.18-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.18 (Ubuntu 12.18-0ubuntu0.20.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_table_access_method = heap;

--
-- Name: comptes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comptes (
    acc_id bigint NOT NULL,
    balance real,
    type character(1) NOT NULL
);


--
-- Data for Name: comptes; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.comptes (acc_id, balance, type) VALUES (104310914895, 808.38, 'P');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (187672313913, 825.69, 'C');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (148452111241, 3190.55, 'P');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (171174310952, 28.89, 'C');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (190562015816, 1985.52, 'P');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (119774916201, 9818.59, 'C');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (186341717529, 796.13, 'C');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (131603211155, 1155.01, 'A');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (173512714203, 1562.46, 'A');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (155432214678, 1551.99, 'C');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (139840414160, 2088.97, 'C');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (120081517656, 93.15, 'P');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (185121112058, 1720.68, 'A');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (193024011713, 168.6, 'A');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (198440815239, 1271.18, 'A');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (112633718692, 873.11, 'L');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (142743815341, 4641.28, 'C');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (144721910292, 1280.74, 'P');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (120773016869, 1642.59, 'C');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (104444810018, 8510.36, 'C');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (122191313119, 2187.9, 'P');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (111930116980, 1564.27, 'C');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (189853916707, 2236.17, 'L');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (158063312140, 3162.25, 'C');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (161320011440, 1763.68, 'P');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (185503612858, 2442.98, 'L');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (124252919902, 2178.41, 'P');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (108210513275, 713.77, 'C');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (177474119720, 4047.35, 'A');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (136123511800, 1848.48, 'P');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (133502416828, 803.25, 'P');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (121601616158, 1212.5, 'L');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (181473116846, 152.57, 'L');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (166801814075, 1270.14, 'L');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (147311412572, 2140.72, 'L');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (198270715673, 1680.24, 'C');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (134300219657, 1438.91, 'C');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (122812616034, 687.78, 'P');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (183384214435, 1243.68, 'C');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (197733410308, 8061.95, 'C');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (100232512827, 1838.25, 'L');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (190341014619, 446.45, 'P');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (174604610317, 1678.59, 'A');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (131004410694, 9180.13, 'C');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (128490611458, 1273.05, 'L');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (164784718083, 2404.47, 'P');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (132824513854, 2531.55, 'P');
INSERT INTO public.comptes (acc_id, balance, type) VALUES (101790319782, 1915.02, 'L');


--
-- Name: comptes comptes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comptes
    ADD CONSTRAINT comptes_pkey PRIMARY KEY (acc_id);


--
-- PostgreSQL database dump complete
--

