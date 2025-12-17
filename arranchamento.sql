--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.25
-- Dumped by pg_dump version 14.4

-- Started on 2025-12-17 10:45:40

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

SET default_tablespace = '';

--
-- TOC entry 182 (class 1259 OID 172852)
-- Name: om; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.om (
    id_om integer NOT NULL,
    nome_om character varying(150) NOT NULL,
    sigla_om character varying(20)
);


ALTER TABLE public.om OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 172850)
-- Name: om_id_om_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.om_id_om_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.om_id_om_seq OWNER TO postgres;

--
-- TOC entry 2140 (class 0 OID 0)
-- Dependencies: 181
-- Name: om_id_om_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.om_id_om_seq OWNED BY public.om.id_om;


--
-- TOC entry 184 (class 1259 OID 172917)
-- Name: patentes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patentes (
    id integer NOT NULL,
    nome character varying(30) NOT NULL,
    ordem integer NOT NULL
);


ALTER TABLE public.patentes OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 172915)
-- Name: patentes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.patentes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.patentes_id_seq OWNER TO postgres;

--
-- TOC entry 2141 (class 0 OID 0)
-- Dependencies: 183
-- Name: patentes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.patentes_id_seq OWNED BY public.patentes.id;


--
-- TOC entry 186 (class 1259 OID 172952)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    nome_guerra character varying(50) NOT NULL,
    nome_completo character varying(150) NOT NULL,
    idt_mil character varying(30) NOT NULL,
    cpf character(11) NOT NULL,
    email character varying(150) NOT NULL,
    senha character varying(255) NOT NULL,
    id_om integer NOT NULL,
    id_patente integer NOT NULL,
    padrao_semanal jsonb,
    excecao_semanal jsonb,
    excecao_diaria jsonb,
    ativo boolean DEFAULT true
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 172950)
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuarios_id_seq OWNER TO postgres;

--
-- TOC entry 2142 (class 0 OID 0)
-- Dependencies: 185
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- TOC entry 1994 (class 2604 OID 172855)
-- Name: om id_om; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.om ALTER COLUMN id_om SET DEFAULT nextval('public.om_id_om_seq'::regclass);


--
-- TOC entry 1995 (class 2604 OID 172920)
-- Name: patentes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patentes ALTER COLUMN id SET DEFAULT nextval('public.patentes_id_seq'::regclass);


--
-- TOC entry 1996 (class 2604 OID 172955)
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- TOC entry 2129 (class 0 OID 172852)
-- Dependencies: 182
-- Data for Name: om; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.om (id_om, nome_om, sigla_om) FROM stdin;
\.


--
-- TOC entry 2131 (class 0 OID 172917)
-- Dependencies: 184
-- Data for Name: patentes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patentes (id, nome, ordem) FROM stdin;
1	SD EV	1
2	SD EP	2
3	CB	3
4	3º SGT	4
5	2º SGT	5
6	1º SGT	6
7	ST	7
8	ASP	8
9	2º TEN	9
10	1º TEN	10
11	CAP	11
12	MAJ	12
13	TEN-CEL	13
14	CEL	14
\.


--
-- TOC entry 2133 (class 0 OID 172952)
-- Dependencies: 186
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, nome_guerra, nome_completo, idt_mil, cpf, email, senha, id_om, id_patente, padrao_semanal, excecao_semanal, excecao_diaria, ativo) FROM stdin;
\.


--
-- TOC entry 2143 (class 0 OID 0)
-- Dependencies: 181
-- Name: om_id_om_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.om_id_om_seq', 1, false);


--
-- TOC entry 2144 (class 0 OID 0)
-- Dependencies: 183
-- Name: patentes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patentes_id_seq', 14, true);


--
-- TOC entry 2145 (class 0 OID 0)
-- Dependencies: 185
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 1, false);


--
-- TOC entry 1999 (class 2606 OID 172858)
-- Name: om om_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.om
    ADD CONSTRAINT om_pkey PRIMARY KEY (id_om);


--
-- TOC entry 2001 (class 2606 OID 172924)
-- Name: patentes patentes_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patentes
    ADD CONSTRAINT patentes_nome_key UNIQUE (nome);


--
-- TOC entry 2003 (class 2606 OID 172922)
-- Name: patentes patentes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patentes
    ADD CONSTRAINT patentes_pkey PRIMARY KEY (id);


--
-- TOC entry 2005 (class 2606 OID 172965)
-- Name: usuarios usuarios_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_cpf_key UNIQUE (cpf);


--
-- TOC entry 2007 (class 2606 OID 172967)
-- Name: usuarios usuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);


--
-- TOC entry 2009 (class 2606 OID 172963)
-- Name: usuarios usuarios_idt_mil_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_idt_mil_key UNIQUE (idt_mil);


--
-- TOC entry 2011 (class 2606 OID 172961)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 2012 (class 2606 OID 172968)
-- Name: usuarios fk_usuario_om; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT fk_usuario_om FOREIGN KEY (id_om) REFERENCES public.om(id_om) ON DELETE RESTRICT;


--
-- TOC entry 2013 (class 2606 OID 172973)
-- Name: usuarios fk_usuario_patente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT fk_usuario_patente FOREIGN KEY (id_patente) REFERENCES public.patentes(id) ON DELETE RESTRICT;


--
-- TOC entry 2139 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2025-12-17 10:45:40

--
-- PostgreSQL database dump complete
--

