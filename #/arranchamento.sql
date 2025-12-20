--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.1

-- Started on 2025-12-19 18:03:06

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 17031)
-- Name: om; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.om (
    id_om integer NOT NULL,
    nome_om character varying(150) NOT NULL,
    sigla_om character varying(20)
);


ALTER TABLE public.om OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 17034)
-- Name: om_id_om_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.om_id_om_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.om_id_om_seq OWNER TO postgres;

--
-- TOC entry 4940 (class 0 OID 0)
-- Dependencies: 218
-- Name: om_id_om_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.om_id_om_seq OWNED BY public.om.id_om;


--
-- TOC entry 219 (class 1259 OID 17035)
-- Name: patentes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patentes (
    id integer NOT NULL,
    nome character varying(30) NOT NULL,
    ordem integer NOT NULL
);


ALTER TABLE public.patentes OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17038)
-- Name: patentes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.patentes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.patentes_id_seq OWNER TO postgres;

--
-- TOC entry 4941 (class 0 OID 0)
-- Dependencies: 220
-- Name: patentes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.patentes_id_seq OWNED BY public.patentes.id;


--
-- TOC entry 224 (class 1259 OID 17074)
-- Name: relatorios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.relatorios (
    id integer NOT NULL,
    data_relatorio date NOT NULL,
    id_om integer NOT NULL,
    usuarios_refeicoes jsonb NOT NULL,
    data_atualizacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    id_responsavel integer NOT NULL
);


ALTER TABLE public.relatorios OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17073)
-- Name: relatorios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.relatorios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.relatorios_id_seq OWNER TO postgres;

--
-- TOC entry 4942 (class 0 OID 0)
-- Dependencies: 223
-- Name: relatorios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.relatorios_id_seq OWNED BY public.relatorios.id;


--
-- TOC entry 221 (class 1259 OID 17039)
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
-- TOC entry 222 (class 1259 OID 17045)
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_seq OWNER TO postgres;

--
-- TOC entry 4943 (class 0 OID 0)
-- Dependencies: 222
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- TOC entry 4757 (class 2604 OID 17046)
-- Name: om id_om; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.om ALTER COLUMN id_om SET DEFAULT nextval('public.om_id_om_seq'::regclass);


--
-- TOC entry 4758 (class 2604 OID 17047)
-- Name: patentes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patentes ALTER COLUMN id SET DEFAULT nextval('public.patentes_id_seq'::regclass);


--
-- TOC entry 4761 (class 2604 OID 17077)
-- Name: relatorios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relatorios ALTER COLUMN id SET DEFAULT nextval('public.relatorios_id_seq'::regclass);


--
-- TOC entry 4759 (class 2604 OID 17048)
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- TOC entry 4926 (class 0 OID 17031)
-- Dependencies: 217
-- Data for Name: om; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.om (id_om, nome_om, sigla_om) FROM stdin;
1	3º Centro de Geoinformação	3ºCGEO
\.


--
-- TOC entry 4928 (class 0 OID 17035)
-- Dependencies: 219
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
-- TOC entry 4933 (class 0 OID 17074)
-- Dependencies: 224
-- Data for Name: relatorios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.relatorios (id, data_relatorio, id_om, usuarios_refeicoes, data_atualizacao, id_responsavel) FROM stdin;
1	2025-12-01	1	{"1": "CAJ", "2": "C", "3": "AJ", "4": "C", "5": "CAJ", "6": "AJ", "7": "CA", "8": "C", "9": "CAJ", "10": "AJ"}	2025-12-19 17:46:33.491439	1
2	2025-12-02	1	{"1": "CAJ", "2": "C", "3": "AJ", "4": "C", "5": "CAJ", "6": "AJ", "7": "CA", "8": "C", "9": "CAJ", "10": "AJ"}	2025-12-19 17:46:33.491439	1
3	2025-12-03	1	{"1": "CAJ", "2": "C", "3": "AJ", "4": "C", "5": "CAJ", "6": "AJ", "7": "CA", "8": "C", "9": "CAJ", "10": "AJ"}	2025-12-19 17:46:33.491439	1
4	2025-12-04	1	{"1": "CAJ", "2": "C", "3": "AJ", "4": "C", "5": "CAJ", "6": "AJ", "7": "CA", "8": "C", "9": "CAJ", "10": "AJ"}	2025-12-19 17:46:33.491439	1
5	2025-12-05	1	{"1": "CAJ", "2": "C", "3": "AJ", "4": "C", "5": "CAJ", "6": "AJ", "7": "CA", "8": "C", "9": "CAJ", "10": "AJ"}	2025-12-19 17:46:33.491439	1
6	2025-12-06	1	{"1": "CAJ", "2": "C", "3": "AJ", "4": "C", "5": "CAJ", "6": "AJ", "7": "CA", "8": "C", "9": "CAJ", "10": "AJ"}	2025-12-19 17:46:33.491439	1
7	2025-12-07	1	{"1": "CAJ", "2": "C", "3": "AJ", "4": "C", "5": "CAJ", "6": "AJ", "7": "CA", "8": "C", "9": "CAJ", "10": "AJ"}	2025-12-19 17:46:33.491439	1
8	2025-12-08	1	{"1": "CAJ", "2": "C", "3": "AJ", "4": "C", "5": "CAJ", "6": "AJ", "7": "CA", "8": "C", "9": "CAJ", "10": "AJ"}	2025-12-19 17:46:33.491439	1
9	2025-12-09	1	{"1": "CAJ", "2": "C", "3": "AJ", "4": "C", "5": "CAJ", "6": "AJ", "7": "CA", "8": "C", "9": "CAJ", "10": "AJ"}	2025-12-19 17:46:33.491439	1
10	2025-12-10	1	{"1": "CAJ", "2": "C", "3": "AJ", "4": "C", "5": "CAJ", "6": "AJ", "7": "CA", "8": "C", "9": "CAJ", "10": "AJ"}	2025-12-19 17:46:33.491439	1
\.


--
-- TOC entry 4930 (class 0 OID 17039)
-- Dependencies: 221
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, nome_guerra, nome_completo, idt_mil, cpf, email, senha, id_om, id_patente, padrao_semanal, excecao_semanal, excecao_diaria, ativo) FROM stdin;
2	BATISTA	Marcos Batista da Silva	EB123456	12345678901	marcos.batista@eb.mil.br	123	1	11	[{"dia": "Segunda", "cafe": false, "janta": false, "almoco": true}, {"dia": "Terça", "cafe": true, "janta": false, "almoco": true}, {"dia": "Quarta", "cafe": true, "janta": false, "almoco": false}, {"dia": "Quinta", "cafe": true, "janta": false, "almoco": false}, {"dia": "Sexta", "cafe": true, "janta": false, "almoco": true}, {"dia": "Sábado", "cafe": false, "janta": false, "almoco": false}, {"dia": "Domingo", "cafe": false, "janta": false, "almoco": false}]	[{"fim": "2025-12-22", "obs": "", "modo": "semanal", "tipo": "Férias", "inicio": "2025-12-17", "configuracao": [{"dia": "Segunda", "cafe": false, "janta": true, "almoco": false}, {"dia": "Terça", "cafe": false, "janta": false, "almoco": false}, {"dia": "Quarta", "cafe": true, "janta": true, "almoco": false}, {"dia": "Quinta", "cafe": false, "janta": false, "almoco": true}, {"dia": "Sexta", "cafe": true, "janta": true, "almoco": false}, {"dia": "Sábado", "cafe": false, "janta": false, "almoco": true}, {"dia": "Domingo", "cafe": true, "janta": false, "almoco": false}]}]	[{"fim": "2025-12-27", "obs": "zsasf awarr awrAR", "modo": "individual", "tipo": "Férias", "inicio": "2025-12-25", "configuracao": [{"data": "2025-12-25", "ativo": true, "refeicao": "cafe"}, {"data": "2025-12-25", "ativo": false, "refeicao": "almoco"}, {"data": "2025-12-25", "ativo": false, "refeicao": "janta"}, {"data": "2025-12-26", "ativo": false, "refeicao": "cafe"}, {"data": "2025-12-26", "ativo": true, "refeicao": "almoco"}, {"data": "2025-12-26", "ativo": false, "refeicao": "janta"}, {"data": "2025-12-27", "ativo": false, "refeicao": "cafe"}, {"data": "2025-12-27", "ativo": false, "refeicao": "almoco"}, {"data": "2025-12-27", "ativo": true, "refeicao": "janta"}]}, {"fim": "2026-01-30", "obs": "", "modo": "individual", "tipo": "Férias", "inicio": "2026-01-22", "configuracao": [{"data": "2026-01-22", "ativo": false, "refeicao": "cafe"}, {"data": "2026-01-22", "ativo": false, "refeicao": "almoco"}, {"data": "2026-01-22", "ativo": false, "refeicao": "janta"}, {"data": "2026-01-23", "ativo": false, "refeicao": "cafe"}, {"data": "2026-01-23", "ativo": false, "refeicao": "almoco"}, {"data": "2026-01-23", "ativo": false, "refeicao": "janta"}, {"data": "2026-01-24", "ativo": true, "refeicao": "cafe"}, {"data": "2026-01-24", "ativo": true, "refeicao": "almoco"}, {"data": "2026-01-24", "ativo": true, "refeicao": "janta"}, {"data": "2026-01-25", "ativo": false, "refeicao": "cafe"}, {"data": "2026-01-25", "ativo": true, "refeicao": "almoco"}, {"data": "2026-01-25", "ativo": false, "refeicao": "janta"}, {"data": "2026-01-26", "ativo": false, "refeicao": "cafe"}, {"data": "2026-01-26", "ativo": true, "refeicao": "almoco"}, {"data": "2026-01-26", "ativo": false, "refeicao": "janta"}, {"data": "2026-01-27", "ativo": false, "refeicao": "cafe"}, {"data": "2026-01-27", "ativo": false, "refeicao": "almoco"}, {"data": "2026-01-27", "ativo": false, "refeicao": "janta"}, {"data": "2026-01-28", "ativo": true, "refeicao": "cafe"}, {"data": "2026-01-28", "ativo": false, "refeicao": "almoco"}, {"data": "2026-01-28", "ativo": false, "refeicao": "janta"}, {"data": "2026-01-29", "ativo": false, "refeicao": "cafe"}, {"data": "2026-01-29", "ativo": true, "refeicao": "almoco"}, {"data": "2026-01-29", "ativo": false, "refeicao": "janta"}, {"data": "2026-01-30", "ativo": false, "refeicao": "cafe"}, {"data": "2026-01-30", "ativo": false, "refeicao": "almoco"}, {"data": "2026-01-30", "ativo": false, "refeicao": "janta"}]}]	t
12	CB MORAES	Henrique Moraes Pacheco	MIL010	00000000010	moraes@exemplo.mil.br	hash123	1	1	{"qua": "AJ", "qui": "AJ", "seg": "AJ", "sex": "AJ", "ter": "AJ"}	\N	\N	t
3	CB SILVA	Carlos Alberto da Silva	MIL001	00000000001	silva@exemplo.mil.br	hash123	1	10	{"qua": "CAJ", "qui": "CAJ", "seg": "CAJ", "sex": "CAJ", "ter": "CAJ"}	\N	\N	t
4	SD SOUZA	João Pedro Souza	MIL002	00000000002	souza@exemplo.mil.br	hash123	1	8	{"qua": "CA", "qui": "CA", "seg": "CA", "sex": "CA", "ter": "CA"}	\N	\N	t
5	3º SGT LIMA	Marcos Lima Ferreira	MIL003	00000000003	lima@exemplo.mil.br	hash123	1	8	{"qua": "AJ", "qui": "AJ", "seg": "AJ", "sex": "AJ", "ter": "AJ"}	\N	\N	t
6	CB ROCHA	André Rocha Santos	MIL004	00000000004	rocha@exemplo.mil.br	hash123	1	7	{"qua": "C", "qui": "C", "seg": "C", "sex": "C", "ter": "C"}	\N	\N	t
7	SD COSTA	Lucas Costa Almeida	MIL005	00000000005	costa@exemplo.mil.br	hash123	1	6	{"qua": "AJ", "qui": "CAJ", "seg": "CAJ", "sex": "C", "ter": "CA"}	\N	\N	t
8	CB PEREIRA	Rafael Pereira Lima	MIL006	00000000006	pereira@exemplo.mil.br	hash123	1	5	{"qua": "AJ", "qui": "AJ", "seg": "AJ", "sex": "AJ", "ter": "AJ"}	\N	\N	t
9	SD OLIVEIRA	Felipe Oliveira Nunes	MIL007	00000000007	oliveira@exemplo.mil.br	hash123	1	4	{"qua": "CA", "qui": "CA", "seg": "CA", "sex": "CA", "ter": "CA"}	\N	\N	t
10	CB RIBEIRO	Thiago Ribeiro Melo	MIL008	00000000008	ribeiro@exemplo.mil.br	hash123	1	3	{"qua": "C", "qui": "C", "seg": "C", "sex": "C", "ter": "C"}	\N	\N	t
11	SD BARROS	Daniel Barros Teixeira	MIL009	00000000009	barros@exemplo.mil.br	hash123	1	2	{"qua": "CAJ", "qui": "CAJ", "seg": "CAJ", "sex": "CAJ", "ter": "CAJ"}	\N	\N	t
\.


--
-- TOC entry 4944 (class 0 OID 0)
-- Dependencies: 218
-- Name: om_id_om_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.om_id_om_seq', 1, true);


--
-- TOC entry 4945 (class 0 OID 0)
-- Dependencies: 220
-- Name: patentes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patentes_id_seq', 14, true);


--
-- TOC entry 4946 (class 0 OID 0)
-- Dependencies: 223
-- Name: relatorios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.relatorios_id_seq', 10, true);


--
-- TOC entry 4947 (class 0 OID 0)
-- Dependencies: 222
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 12, true);


--
-- TOC entry 4764 (class 2606 OID 17050)
-- Name: om om_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.om
    ADD CONSTRAINT om_pkey PRIMARY KEY (id_om);


--
-- TOC entry 4766 (class 2606 OID 17052)
-- Name: patentes patentes_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patentes
    ADD CONSTRAINT patentes_nome_key UNIQUE (nome);


--
-- TOC entry 4768 (class 2606 OID 17054)
-- Name: patentes patentes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patentes
    ADD CONSTRAINT patentes_pkey PRIMARY KEY (id);


--
-- TOC entry 4778 (class 2606 OID 17082)
-- Name: relatorios relatorios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relatorios
    ADD CONSTRAINT relatorios_pkey PRIMARY KEY (id);


--
-- TOC entry 4770 (class 2606 OID 17056)
-- Name: usuarios usuarios_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_cpf_key UNIQUE (cpf);


--
-- TOC entry 4772 (class 2606 OID 17058)
-- Name: usuarios usuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);


--
-- TOC entry 4774 (class 2606 OID 17060)
-- Name: usuarios usuarios_idt_mil_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_idt_mil_key UNIQUE (idt_mil);


--
-- TOC entry 4776 (class 2606 OID 17062)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 4779 (class 2606 OID 17063)
-- Name: usuarios fk_usuario_om; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT fk_usuario_om FOREIGN KEY (id_om) REFERENCES public.om(id_om) ON DELETE RESTRICT;


--
-- TOC entry 4780 (class 2606 OID 17068)
-- Name: usuarios fk_usuario_patente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT fk_usuario_patente FOREIGN KEY (id_patente) REFERENCES public.patentes(id) ON DELETE RESTRICT;


--
-- TOC entry 4939 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2025-12-19 18:03:06

--
-- PostgreSQL database dump complete
--

