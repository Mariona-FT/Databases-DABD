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
-- Name: contractes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contractes (
    acc_id bigint NOT NULL,
    owner_id integer NOT NULL,
    owner character varying(40) NOT NULL
);


--
-- Data for Name: contractes; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (181473116846, 6543234, 'Caballero de la Triste Figura');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (147311412572, 6543234, 'Caballero de la Triste Figura');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (148452111241, 6873413, 'Pedro Noriz');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (122812616034, 6152436, 'María Tornes');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (108210513275, 6435323, 'Caballero de los Espejos');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (187672313913, 6677345, 'Diego de Miranda');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (198440815239, 6546561, 'Gaspar Gregorio');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (198270715673, 6425312, 'Teresa Panza');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (121601616158, 6788723, 'Guiomar de Quiñones');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (190341014619, 6812345, 'Roque Guinart');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (134300219657, 5645342, 'Sancho de Azpetia');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (142743815341, 6435323, 'Sansón Carrasco');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (161320011440, 6532345, 'Sancho Panza');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (104444810018, 6677345, 'Caballero del Verde Gabán');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (131004410694, 6435323, 'Caballero de los Espejos');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (101790319782, 6123456, 'Juan Haldudo');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (183384214435, 6788765, 'Pedro Pérez Mazorca');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (181473116846, 6435323, 'Caballero de la Blanca Luna');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (119774916201, 6656223, 'Alonso López');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (174604610317, 6123456, 'Juan Haldudo');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (161320011440, 6463525, 'Tomé Cecial');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (144721910292, 6112452, 'Álvaro Tarfe');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (104444810018, 4455336, 'Ginés de Pasamonte');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (100232512827, 6435323, 'Caballero de la Blanca Luna');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (119774916201, 6564321, 'Pedro Alonso');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (104310914895, 6564321, 'Pedro Alonso');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (128490611458, 6788765, 'Pedro Pérez Mazorca');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (120081517656, 6466543, 'Tomé Carrasco');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (173512714203, 4455336, 'Ginés de Pasamonte');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (190562015816, 6677345, 'Diego de Miranda');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (190562015816, 6788765, 'Pedro Pérez Mazorca');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (193024011713, 5645342, 'Sancho de Azpetia');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (177474119720, 6873413, 'Pedro Noriz');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (198440815239, 6554632, 'Lorenzo Corchuelo');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (132824513854, 5645342, 'Sancho de Azpetia');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (171174310952, 6435323, 'Caballero de la Blanca Luna');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (183384214435, 5463524, 'Vivaldo Cachopín');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (136123511800, 6554632, 'Lorenzo Corchuelo');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (166801814075, 6532345, 'Sancho Panza');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (144721910292, 6466543, 'Tomé Carrasco');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (189853916707, 6466543, 'Tomé Carrasco');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (185121112058, 6336262, 'Pedro Recio de Agüero');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (147311412572, 6871254, 'Antonio Moreno');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (185503612858, 6543234, 'Caballero de la Triste Figura');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (186341717529, 6435323, 'Caballero de la Blanca Luna');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (139840414160, 6543234, 'Alonso Quijano');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (122191313119, 6677345, 'Caballero del Verde Gabán');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (190341014619, 6677345, 'Caballero del Verde Gabán');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (164784718083, 6871254, 'Antonio Moreno');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (131603211155, 6783456, 'Diego de la Llana');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (189853916707, 6656223, 'Alonso López');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (124252919902, 6336262, 'Pedro Recio de Agüero');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (193024011713, 6677345, 'Diego de Miranda');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (112633718692, 6532345, 'Sancho Panza');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (133502416828, 6873413, 'Pedro Noriz');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (197733410308, 6554632, 'Lorenzo Corchuelo');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (101790319782, 6812345, 'Roque Guinart');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (155432214678, 4455336, 'Ginés de Pasamonte');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (112633718692, 6871254, 'Antonio Moreno');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (131603211155, 6336262, 'Pedro Recio de Agüero');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (111930116980, 6112452, 'Álvaro Tarfe');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (158063312140, 6123456, 'Juan Haldudo');
INSERT INTO public.contractes (acc_id, owner_id, owner) VALUES (120773016869, 6551234, 'Aldonza Nogales');


--
-- Name: contractes contractes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contractes
    ADD CONSTRAINT contractes_pkey PRIMARY KEY (acc_id, owner_id);


--
-- Name: contractes contractes_acc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contractes
    ADD CONSTRAINT contractes_acc_id_fkey FOREIGN KEY (acc_id) REFERENCES public.comptes(acc_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: contractes contractes_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contractes
    ADD CONSTRAINT contractes_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES public.titulars(owner_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

