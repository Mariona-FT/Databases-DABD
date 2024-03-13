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
-- Name: adreces; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.adreces (
    address character varying(100) NOT NULL,
    phone integer NOT NULL
);


--
-- Data for Name: adreces; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.adreces (address, phone) VALUES ('Camino de Criptana 5, Argamasilla', 223233);
INSERT INTO public.adreces (address, phone) VALUES ('Regente de Nápoles 2, Zaragoza', 564534);
INSERT INTO public.adreces (address, phone) VALUES ('Molinos 2, Argamasilla', 223344);
INSERT INTO public.adreces (address, phone) VALUES ('Mayor 8, Argamasilla', 213243);
INSERT INTO public.adreces (address, phone) VALUES ('Avellaneda 2, Granada', 334455);
INSERT INTO public.adreces (address, phone) VALUES ('Huertos s/n, Ínsula Barataria', 514131);
INSERT INTO public.adreces (address, phone) VALUES ('Solares de Miranda s/n, Villarejo de Fuentes', 252627);
INSERT INTO public.adreces (address, phone) VALUES ('Plaza del Ayuntamiento 3, Quintanar', 253647);
INSERT INTO public.adreces (address, phone) VALUES ('Plaza Grande 1, Argamasilla', 212223);
INSERT INTO public.adreces (address, phone) VALUES ('Almacenes 3, Ínsula Barataria', 515253);
INSERT INTO public.adreces (address, phone) VALUES ('Camino Alcobendas 10, Baeza', 292827);
INSERT INTO public.adreces (address, phone) VALUES ('Camino de Criptana 2, Argamasilla', 223242);
INSERT INTO public.adreces (address, phone) VALUES ('Caserío Los Sanchos, Zubiarri', 313233);
INSERT INTO public.adreces (address, phone) VALUES ('Hospital de Osuna 1, Tirteafuera', 232425);
INSERT INTO public.adreces (address, phone) VALUES ('Corrales s/n, Argamasilla', 222333);
INSERT INTO public.adreces (address, phone) VALUES ('Revellón 14, Laredo', 414243);
INSERT INTO public.adreces (address, phone) VALUES ('Camí dels Lladres s/n, Oristà', 555453);
INSERT INTO public.adreces (address, phone) VALUES ('Ramblas 7, Barcelona', 544332);
INSERT INTO public.adreces (address, phone) VALUES ('Muro Blanco 2, El Toboso', 243546);
INSERT INTO public.adreces (address, phone) VALUES ('Venta del Ventero, Socuéllamos', 353334);
INSERT INTO public.adreces (address, phone) VALUES ('Ramblas 5, Barcelona', 545352);
INSERT INTO public.adreces (address, phone) VALUES ('Durabanca s/n, Galeras del Rey', 393735);
INSERT INTO public.adreces (address, phone) VALUES ('Mayor 11, Argamasilla', 234678);


--
-- Name: adreces adreces_phone_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adreces
    ADD CONSTRAINT adreces_phone_key UNIQUE (phone);


--
-- Name: adreces adreces_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adreces
    ADD CONSTRAINT adreces_pkey PRIMARY KEY (address);


--
-- PostgreSQL database dump complete
--

