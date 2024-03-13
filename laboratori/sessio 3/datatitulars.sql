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
-- Name: titulars; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.titulars (
    owner_id integer NOT NULL,
    address character varying(100) NOT NULL
);


--
-- Data for Name: titulars; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.titulars (owner_id, address) VALUES (5463524, 'Revellón 14, Laredo');
INSERT INTO public.titulars (owner_id, address) VALUES (5645342, 'Caserío Los Sanchos, Zubiarri');
INSERT INTO public.titulars (owner_id, address) VALUES (4455336, 'Durabanca s/n, Galeras del Rey');
INSERT INTO public.titulars (owner_id, address) VALUES (6554632, 'Muro Blanco 2, El Toboso');
INSERT INTO public.titulars (owner_id, address) VALUES (6788765, 'Almacenes 3, Ínsula Barataria');
INSERT INTO public.titulars (owner_id, address) VALUES (6112452, 'Avellaneda 2, Granada');
INSERT INTO public.titulars (owner_id, address) VALUES (6812345, 'Camí dels Lladres s/n, Oristà');
INSERT INTO public.titulars (owner_id, address) VALUES (6152436, 'Venta del Ventero, Socuéllamos');
INSERT INTO public.titulars (owner_id, address) VALUES (6677345, 'Solares de Miranda s/n, Villarejo de Fuentes');
INSERT INTO public.titulars (owner_id, address) VALUES (6551234, 'Muro Blanco 2, El Toboso');
INSERT INTO public.titulars (owner_id, address) VALUES (6466543, 'Camino de Criptana 5, Argamasilla');
INSERT INTO public.titulars (owner_id, address) VALUES (6336262, 'Hospital de Osuna 1, Tirteafuera');
INSERT INTO public.titulars (owner_id, address) VALUES (6435323, 'Mayor 11, Argamasilla');
INSERT INTO public.titulars (owner_id, address) VALUES (6123456, 'Plaza del Ayuntamiento 3, Quintanar');
INSERT INTO public.titulars (owner_id, address) VALUES (6463525, 'Camino de Criptana 2, Argamasilla');
INSERT INTO public.titulars (owner_id, address) VALUES (6543234, 'Mayor 8, Argamasilla');
INSERT INTO public.titulars (owner_id, address) VALUES (6425312, 'Corrales s/n, Argamasilla');
INSERT INTO public.titulars (owner_id, address) VALUES (6564321, 'Molinos 2, Argamasilla');
INSERT INTO public.titulars (owner_id, address) VALUES (6546561, 'Plaza Grande 1, Argamasilla');
INSERT INTO public.titulars (owner_id, address) VALUES (6532345, 'Corrales s/n, Argamasilla');
INSERT INTO public.titulars (owner_id, address) VALUES (6656223, 'Camino Alcobendas 10, Baeza');
INSERT INTO public.titulars (owner_id, address) VALUES (6783456, 'Huertos s/n, Ínsula Barataria');
INSERT INTO public.titulars (owner_id, address) VALUES (6873413, 'Ramblas 7, Barcelona');
INSERT INTO public.titulars (owner_id, address) VALUES (6788723, 'Regente de Nápoles 2, Zaragoza');
INSERT INTO public.titulars (owner_id, address) VALUES (6871254, 'Ramblas 5, Barcelona');


--
-- Name: titulars titulars_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.titulars
    ADD CONSTRAINT titulars_pkey PRIMARY KEY (owner_id);


--
-- Name: titulars titulars_address_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.titulars
    ADD CONSTRAINT titulars_address_fkey FOREIGN KEY (address) REFERENCES public.adreces(address) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

