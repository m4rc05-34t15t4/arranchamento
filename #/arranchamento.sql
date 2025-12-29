--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.25
-- Dumped by pg_dump version 14.4

-- Started on 2025-12-29 11:49:58

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
-- TOC entry 181 (class 1259 OID 181045)
-- Name: om; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.om (
    id_om integer NOT NULL,
    nome_om character varying(150) NOT NULL,
    sigla_om character varying(20),
    ranchos jsonb,
    administradores integer[]
);


ALTER TABLE public.om OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 181051)
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
-- TOC entry 2154 (class 0 OID 0)
-- Dependencies: 182
-- Name: om_id_om_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.om_id_om_seq OWNED BY public.om.id_om;


--
-- TOC entry 183 (class 1259 OID 181053)
-- Name: patentes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patentes (
    id integer NOT NULL,
    nome character varying(30) NOT NULL,
    ordem integer NOT NULL
);


ALTER TABLE public.patentes OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 181056)
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
-- TOC entry 2155 (class 0 OID 0)
-- Dependencies: 184
-- Name: patentes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.patentes_id_seq OWNED BY public.patentes.id;


--
-- TOC entry 188 (class 1259 OID 181107)
-- Name: relatorios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.relatorios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.relatorios_id_seq OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 181058)
-- Name: relatorios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.relatorios (
    id integer DEFAULT nextval('public.relatorios_id_seq'::regclass) NOT NULL,
    data_relatorio date NOT NULL,
    id_om integer NOT NULL,
    usuarios_refeicoes jsonb NOT NULL,
    data_atualizacao timestamp without time zone DEFAULT now(),
    id_responsavel integer NOT NULL
);


ALTER TABLE public.relatorios OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 181065)
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
    ativo boolean DEFAULT true,
    excecao_manual jsonb
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 181072)
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
-- TOC entry 2156 (class 0 OID 0)
-- Dependencies: 187
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- TOC entry 2002 (class 2604 OID 181074)
-- Name: om id_om; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.om ALTER COLUMN id_om SET DEFAULT nextval('public.om_id_om_seq'::regclass);


--
-- TOC entry 2003 (class 2604 OID 181075)
-- Name: patentes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patentes ALTER COLUMN id SET DEFAULT nextval('public.patentes_id_seq'::regclass);


--
-- TOC entry 2007 (class 2604 OID 181076)
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- TOC entry 2140 (class 0 OID 181045)
-- Dependencies: 181
-- Data for Name: om; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.om (id_om, nome_om, sigla_om, ranchos, administradores) FROM stdin;
1	3º Centro de Geoinformação	3ºCGEO	[{"nome": "Oficiais", "patente": ["CEL", "TEN-CEL", "MAJ", "CAP", "1º TEN", "2º TEN", "ASP", "ST"], "servico": 1}, {"nome": "Sargentos", "patente": ["1º SGT", "2º SGT", "3º SGT", "SC"], "servico": 2}, {"nome": "Cbs / Sds", "patente": ["CB", "SD EP", "SD EV"], "servico": 18}, {"nome": "Externo", "patente": [], "servico": 6}]	{2}
\.


--
-- TOC entry 2142 (class 0 OID 181053)
-- Dependencies: 183
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
-- TOC entry 2144 (class 0 OID 181058)
-- Dependencies: 185
-- Data for Name: relatorios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.relatorios (id, data_relatorio, id_om, usuarios_refeicoes, data_atualizacao, id_responsavel) FROM stdin;
1	2025-12-01	1	{"1": "CAJ", "2": "C", "3": "AJ", "4": "C", "5": "CAJ", "6": "AJ", "7": "CA", "8": "C", "9": "CAJ", "10": "AJ"}	2025-12-19 17:46:33.491439	1
3	2025-12-03	1	{"1": "CAJ", "2": "C", "3": "AJ", "4": "C", "5": "CAJ", "6": "AJ", "7": "CA", "8": "C", "9": "CAJ", "10": "AJ"}	2025-12-19 17:46:33.491439	1
5	2025-12-05	1	{"1": "CAJ", "2": "C", "3": "AJ", "4": "C", "5": "CAJ", "6": "AJ", "7": "CA", "8": "C", "9": "CAJ", "10": "AJ"}	2025-12-19 17:46:33.491439	1
2	2025-12-02	1	{"1": "CAJ", "3": "AJ", "4": "C", "5": "CAJ", "6": "AJ", "7": "CA", "8": "C", "9": "CAJ", "10": "AJ", "20": "C"}	2025-12-19 17:46:33.491439	1
7	2025-12-07	1	{"1": "CAJ", "3": "AJ", "4": "C", "5": "CAJ", "6": "AJ", "7": "CA", "8": "C", "9": "CAJ", "10": "AJ", "20": "C"}	2025-12-19 17:46:33.491439	1
10	2025-12-10	1	{"1": "CAJ", "3": "AJ", "4": "C", "5": "CAJ", "6": "AJ", "7": "CA", "8": "C", "9": "CAJ", "10": "AJ", "20": "C"}	2025-12-19 17:46:33.491439	1
4	2025-12-04	1	{"1": "CAJ", "2": "CAJ", "3": "AJ", "4": "C", "5": "CAJ", "6": "AJ", "7": "CA", "8": "C", "9": "CAJ", "10": "AJ"}	2025-12-19 17:46:33.491439	1
6	2025-12-06	1	{"1": "CAJ", "2": "CJ", "3": "AJ", "4": "C", "5": "CAJ", "6": "AJ", "7": "CA", "8": "C", "9": "CAJ", "10": "AJ"}	2025-12-19 17:46:33.491439	1
13	2025-12-27	1	{"2": "CA", "3": "CJ", "4": "CJ", "5": "CJ", "6": "CJ", "7": "CJ", "8": "CJ", "9": "CJ", "10": "CJ", "11": "CJ", "12": "CJ"}	2025-12-26 14:14:39.689523	1
12	2025-12-26	1	{"2": "", "3": "A", "4": "CA", "5": "A", "6": "AJ", "7": "A", "8": "A", "9": "", "10": "", "11": "A", "12": "A"}	2025-12-26 13:59:56.555873	1
17	2025-11-19	1	{}	2025-12-26 16:49:14.561997	1
8	2025-12-08	1	{"1": "CAJ", "2": "C", "3": "AJ", "4": "C", "5": "CAJ", "6": "AJ", "7": "CA", "8": "C", "9": "CAJ", "13": "AJ"}	2025-12-19 17:46:33.491439	1
18	2025-12-29	1	{"2": "C", "3": "A", "4": "A", "5": "A", "6": "A", "7": "A", "8": "A", "9": "A", "10": "A", "11": "A", "12": "A"}	2025-12-29 09:03:22.504326	2
21	2025-12-31	1	{"2": "CAJ", "3": "A", "4": "A", "5": "A", "6": "A", "7": "A", "8": "A", "9": "A", "10": "A", "11": "A", "12": "A"}	2025-12-29 09:23:16.576653	2
22	2026-01-01	1	{"2": "CA", "3": "CJ", "4": "CJ", "5": "CJ", "6": "CJ", "7": "CJ", "8": "CJ", "9": "CJ", "10": "CJ", "11": "CJ", "12": "CJ"}	2025-12-29 09:23:42.094086	2
20	2025-12-30	1	{"2": "CA", "3": "CJ", "4": "CJ", "5": "CJ", "6": "CJ", "7": "CJ", "8": "CJ", "9": "CJ", "10": "CJ", "11": "CJ", "12": "CJ"}	2025-12-29 09:26:27.896985	2
\.


--
-- TOC entry 2145 (class 0 OID 181065)
-- Dependencies: 186
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, nome_guerra, nome_completo, idt_mil, cpf, email, senha, id_om, id_patente, padrao_semanal, excecao_semanal, excecao_diaria, ativo, excecao_manual) FROM stdin;
3	CB SILVA	Carlos Alberto da Silva	mil01	00000000001	silva@exemplo.mil.br	$2y$10$LjAF1JQ1Kgjt0yr8Ocfs0.XrHyHSu0DMFeCeEx1TcXiFUGBTPoS4q	1	10	{"Sexta": "A", "Quarta": "A", "Quinta": "CJ", "Terça": "CJ", "Domingo": "A", "Segunda": "A", "Sábado": "CJ"}	[{"fim": "2025-12-22", "obs": "", "modo": "semanal", "tipo": "Férias", "inicio": "2025-12-17", "configuracao": [{"dia": "Segunda", "cafe": false, "janta": true, "almoco": false}, {"dia": "Terça", "cafe": false, "janta": false, "almoco": false}, {"dia": "Quarta", "cafe": true, "janta": true, "almoco": false}, {"dia": "Quinta", "cafe": false, "janta": false, "almoco": true}, {"dia": "Sexta", "cafe": true, "janta": true, "almoco": false}, {"dia": "Sábado", "cafe": false, "janta": false, "almoco": true}, {"dia": "Domingo", "cafe": true, "janta": false, "almoco": false}]}]	\N	t	\N
12	CB MORAES	Henrique Moraes Pacheco	MIL010	00000000010	moraes@exemplo.mil.br	hash123	1	1	{"Sexta": "A", "Quarta": "A", "Quinta": "CJ", "Terça": "CJ", "Domingo": "A", "Segunda": "A", "Sábado": "CJ"}	\N	\N	t	\N
4	SD SOUZA	João Pedro Souza	MIL002	00000000002	souza@exemplo.mil.br	hash123	1	8	{"Sexta": "A", "Quarta": "A", "Quinta": "CJ", "Terça": "CJ", "Domingo": "A", "Segunda": "A", "Sábado": "CJ"}	\N	\N	t	\N
5	3º SGT LIMA	Marcos Lima Ferreira	MIL003	00000000003	lima@exemplo.mil.br	hash123	1	8	{"Sexta": "A", "Quarta": "A", "Quinta": "CJ", "Terça": "CJ", "Domingo": "A", "Segunda": "A", "Sábado": "CJ"}	\N	\N	t	\N
6	CB ROCHA	André Rocha Santos	MIL004	00000000004	rocha@exemplo.mil.br	hash123	1	7	{"Sexta": "A", "Quarta": "A", "Quinta": "CJ", "Terça": "CJ", "Domingo": "A", "Segunda": "A", "Sábado": "CJ"}	\N	\N	t	\N
7	SD COSTA	Lucas Costa Almeida	MIL005	00000000005	costa@exemplo.mil.br	hash123	1	6	{"Sexta": "A", "Quarta": "A", "Quinta": "CJ", "Terça": "CJ", "Domingo": "A", "Segunda": "A", "Sábado": "CJ"}	\N	\N	t	\N
8	CB PEREIRA	Rafael Pereira Lima	MIL006	00000000006	pereira@exemplo.mil.br	hash123	1	5	{"Sexta": "A", "Quarta": "A", "Quinta": "CJ", "Terça": "CJ", "Domingo": "A", "Segunda": "A", "Sábado": "CJ"}	\N	\N	t	\N
9	SD OLIVEIRA	Felipe Oliveira Nunes	MIL007	00000000007	oliveira@exemplo.mil.br	hash123	1	4	{"Sexta": "A", "Quarta": "A", "Quinta": "CJ", "Terça": "CJ", "Domingo": "A", "Segunda": "A", "Sábado": "CJ"}	\N	\N	t	\N
10	CB RIBEIRO	Thiago Ribeiro Melo	MIL008	00000000008	ribeiro@exemplo.mil.br	hash123	1	3	{"Sexta": "A", "Quarta": "A", "Quinta": "CJ", "Terça": "CJ", "Domingo": "A", "Segunda": "A", "Sábado": "CJ"}	\N	\N	t	\N
11	SD BARROS	Daniel Barros Teixeira	MIL009	00000000009	barros@exemplo.mil.br	hash123	1	2	{"Sexta": "A", "Quarta": "A", "Quinta": "CJ", "Terça": "CJ", "Domingo": "A", "Segunda": "A", "Sábado": "CJ"}	\N	\N	t	\N
2	BATISTA	Marcos Batista da Silva	0700849375	09443729458	mbsj2007@hotmail.com	$2y$10$LjAF1JQ1Kgjt0yr8Ocfs0.XrHyHSu0DMFeCeEx1TcXiFUGBTPoS4q	1	11	{"Sexta": "C", "Quarta": "CA", "Quinta": "J", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	[{"fim": "2025-12-25", "obs": "hhhh", "tipo": "Dispensa", "inicio": "2025-12-21", "configuracao": {"Sexta": "A", "Quarta": "A", "Quinta": "CJ", "Terça": "C", "Domingo": "", "Segunda": "J", "Sábado": ""}}, {"fim": "2026-01-04", "obs": "", "tipo": "Dispensa", "inicio": "2025-12-29", "configuracao": {"Sexta": "", "Quarta": "", "Quinta": "", "Terça": "C", "Domingo": "", "Segunda": "", "Sábado": ""}}]	[{"fim": "2025-12-24", "obs": "ccc", "tipo": "Dispensa", "inicio": "2025-12-23", "configuracao": {"2025-12-23": "CJ", "2025-12-24": "A"}}]	t	{"2025-12-26": "J", "2025-12-27": "CA", "2025-12-28": "J", "2025-12-29": "C", "2025-12-31": "CAJ", "2026-01-02": "CA", "2026-01-25": "A", "2026-02-09": ""}
\.


--
-- TOC entry 2157 (class 0 OID 0)
-- Dependencies: 182
-- Name: om_id_om_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.om_id_om_seq', 1, true);


--
-- TOC entry 2158 (class 0 OID 0)
-- Dependencies: 184
-- Name: patentes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patentes_id_seq', 14, true);


--
-- TOC entry 2159 (class 0 OID 0)
-- Dependencies: 188
-- Name: relatorios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.relatorios_id_seq', 22, true);


--
-- TOC entry 2160 (class 0 OID 0)
-- Dependencies: 187
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 12, true);


--
-- TOC entry 2009 (class 2606 OID 181078)
-- Name: om om_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.om
    ADD CONSTRAINT om_pkey PRIMARY KEY (id_om);


--
-- TOC entry 2011 (class 2606 OID 181080)
-- Name: patentes patentes_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patentes
    ADD CONSTRAINT patentes_nome_key UNIQUE (nome);


--
-- TOC entry 2013 (class 2606 OID 181082)
-- Name: patentes patentes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patentes
    ADD CONSTRAINT patentes_pkey PRIMARY KEY (id);


--
-- TOC entry 2015 (class 2606 OID 181084)
-- Name: relatorios relatorios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relatorios
    ADD CONSTRAINT relatorios_pkey PRIMARY KEY (id);


--
-- TOC entry 2017 (class 2606 OID 181086)
-- Name: usuarios usuarios_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_cpf_key UNIQUE (cpf);


--
-- TOC entry 2019 (class 2606 OID 181088)
-- Name: usuarios usuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);


--
-- TOC entry 2021 (class 2606 OID 181090)
-- Name: usuarios usuarios_idt_mil_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_idt_mil_key UNIQUE (idt_mil);


--
-- TOC entry 2023 (class 2606 OID 181092)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 2024 (class 2606 OID 181093)
-- Name: usuarios fk_usuario_om; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT fk_usuario_om FOREIGN KEY (id_om) REFERENCES public.om(id_om) ON DELETE RESTRICT;


--
-- TOC entry 2025 (class 2606 OID 181098)
-- Name: usuarios fk_usuario_patente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT fk_usuario_patente FOREIGN KEY (id_patente) REFERENCES public.patentes(id) ON DELETE RESTRICT;


--
-- TOC entry 2153 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2025-12-29 11:49:58

--
-- PostgreSQL database dump complete
--

