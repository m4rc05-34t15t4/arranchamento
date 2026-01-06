--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.25
-- Dumped by pg_dump version 14.4

-- Started on 2026-01-06 11:16:44

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
    nome_guerra character varying(50),
    nome_completo character varying(150) NOT NULL,
    idt_mil character varying(30),
    cpf character(13),
    email character varying(150),
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
1	3º Centro de Geoinformação	3ºCGEO	[{"nome": "Oficiais", "patente": ["CEL", "TEN-CEL", "MAJ", "CAP", "1º TEN", "2º TEN", "ASP", "ST"], "servico": 1}, {"nome": "Sargentos", "patente": ["1º SGT", "2º SGT", "3º SGT", "SC"], "servico": 2}, {"nome": "Cbs / Sds", "patente": ["CB", "SD EP", "SD EV"], "servico": 18}, {"nome": "Externo", "patente": [], "servico": 0}]	{2,281}
\.


--
-- TOC entry 2142 (class 0 OID 181053)
-- Dependencies: 183
-- Data for Name: patentes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patentes (id, nome, ordem) FROM stdin;
1	SD EV	10
2	SD EP	20
3	CB	30
4	3º SGT	40
5	2º SGT	50
6	1º SGT	60
7	ST	70
8	ASP	80
9	2º TEN	90
10	1º TEN	100
11	CAP	110
12	MAJ	120
13	TEN-CEL	130
14	CEL	140
15	SC	0
\.


--
-- TOC entry 2144 (class 0 OID 181058)
-- Dependencies: 185
-- Data for Name: relatorios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.relatorios (id, data_relatorio, id_om, usuarios_refeicoes, data_atualizacao, id_responsavel) FROM stdin;
30	2026-01-06	1	{"2": "CA", "180": "CA", "181": "CA", "182": "CA", "183": "CA", "184": "CA", "185": "CA", "186": "CA", "187": "CA", "188": "CA", "189": "CA", "190": "CA", "191": "CA", "192": "CA", "193": "CA", "194": "CA", "195": "CA", "196": "CA", "197": "CA", "198": "CA", "199": "CA", "200": "CA", "201": "CA", "202": "CA", "203": "CA", "204": "CA", "205": "CA", "206": "CA", "207": "CA", "208": "CA", "209": "CA", "210": "CA", "211": "CA", "212": "CA", "213": "CA", "214": "CA", "215": "CA", "216": "CA", "217": "CA", "218": "CA", "219": "CA", "220": "CA", "221": "CA", "222": "CA", "223": "CA", "224": "CA", "225": "CA", "226": "CA", "227": "CA", "228": "CA", "229": "CA", "230": "CA", "231": "CA", "232": "CA", "233": "CA", "234": "CA", "235": "CA", "236": "CA", "237": "CA", "238": "CA", "239": "CA", "240": "CA", "241": "CA", "242": "CA", "243": "CA", "244": "CA", "245": "CA", "246": "CA", "247": "CA", "248": "CA", "249": "CA", "250": "CA", "251": "CA", "252": "CA", "253": "CA", "254": "CA", "255": "CA", "256": "CA", "257": "CA", "258": "CA", "259": "CA", "260": "CA", "261": "CA", "262": "CA", "263": "CA", "264": "CA", "265": "CA", "266": "CA", "267": "CA", "268": "CA", "269": "CA", "270": "CA", "271": "CA", "272": "CA", "273": "CA", "274": "CA", "275": "CA", "276": "CA", "277": "CA", "278": "CA", "279": "CA", "280": "CA", "281": "", "282": "CA", "283": "CA", "284": "CA", "285": "CA", "286": "CA", "287": "CA", "288": "CA", "289": "CA", "290": "CA", "291": "CA", "292": "CA", "293": "CA", "294": "CA", "295": "CA", "296": "CA", "297": "CA", "298": "CA", "299": "CA", "300": "CA", "301": "CA", "302": "CA", "303": "CA", "304": "CA", "305": "CA", "306": "CA", "307": "CA", "308": "CA", "309": "CA", "310": "CA", "311": "CA", "312": "CA", "313": "CA", "314": "CA", "315": "CA", "316": "CA", "317": "CA", "318": "CA", "319": "CA", "320": "CA", "321": "CA", "322": "CA", "323": "CA", "324": "CA", "325": "CA", "326": "CA", "327": "CA", "328": "CA", "329": "CA", "330": "CA", "331": "CA", "332": "CA", "333": "CA", "334": "CA", "335": "CA", "336": "CA", "337": "CA", "338": "CA", "339": "CA", "340": "CA", "341": "CA", "342": "CA", "343": "CA", "344": "CA", "345": "CA", "346": "CA", "347": "CA", "348": "CA", "349": "CA", "350": "CA", "351": "CA", "352": "CA", "353": "CA", "354": "CA", "355": "CA", "356": "CA", "357": "CA", "358": "CA", "359": "CA", "360": "CA", "361": "CA", "362": "CA", "363": "CA", "364": "CA", "365": "CA", "366": "CA", "367": "CA", "368": "CA", "369": "CA", "370": "CA", "371": "CA", "372": "CA", "373": "CA", "374": "CA", "375": "CA", "376": "CA", "377": "CA", "378": "CA", "379": "CA"}	2026-01-06 10:49:23.037237	281
\.


--
-- TOC entry 2145 (class 0 OID 181065)
-- Dependencies: 186
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, nome_guerra, nome_completo, idt_mil, cpf, email, senha, id_om, id_patente, padrao_semanal, excecao_semanal, excecao_diaria, ativo, excecao_manual) FROM stdin;
381	José	João José de Lima Filho	\N	0081485      	\N	$2y$10$Ljaf1jq1kgjt0yr8ocfs0.Xrhyhsu0dmfeceex1tcxifugbtpos4q	1	15	\N	\N	\N	t	\N
382	Joaquim	Joaquim André Alves da Silva	\N	0080707      	\N	$2y$10$Ljaf1jq1kgjt0yr8ocfs0.Xrhyhsu0dmfeceex1tcxifugbtpos4q	1	15	\N	\N	\N	t	\N
383	Everaldo	José Everaldo de Brito Leite	\N	1110547      	\N	$2y$10$Ljaf1jq1kgjt0yr8ocfs0.Xrhyhsu0dmfeceex1tcxifugbtpos4q	1	15	\N	\N	\N	t	\N
384	Balbino	José Francisco Balbino Filho	\N	0080710      	\N	$2y$10$Ljaf1jq1kgjt0yr8ocfs0.Xrhyhsu0dmfeceex1tcxifugbtpos4q	1	15	\N	\N	\N	t	\N
385	Henrique	José Henrique Campelo Sobral	\N	0080711      	\N	$2y$10$Ljaf1jq1kgjt0yr8ocfs0.Xrhyhsu0dmfeceex1tcxifugbtpos4q	1	15	\N	\N	\N	t	\N
386	Lenita	Lenita Muniz da Silva	\N	0080826      	\N	$2y$10$Ljaf1jq1kgjt0yr8ocfs0.Xrhyhsu0dmfeceex1tcxifugbtpos4q	1	15	\N	\N	\N	t	\N
387	Carlos	Luiz Carlos dos Santos	\N	0080827      	\N	$2y$10$Ljaf1jq1kgjt0yr8ocfs0.Xrhyhsu0dmfeceex1tcxifugbtpos4q	1	15	\N	\N	\N	t	\N
388	Graças Melo	Maria das Graças Cavalcanti de Melo	\N	0077359      	\N	$2y$10$Ljaf1jq1kgjt0yr8ocfs0.Xrhyhsu0dmfeceex1tcxifugbtpos4q	1	15	\N	\N	\N	t	\N
389	Rita	Rita de Cássia Almeida da Silva	\N	0080848      	\N	$2y$10$Ljaf1jq1kgjt0yr8ocfs0.Xrhyhsu0dmfeceex1tcxifugbtpos4q	1	15	\N	\N	\N	t	\N
390	Silvana	Silvana Ferraz Machado	\N	1107243      	\N	$2y$10$Ljaf1jq1kgjt0yr8ocfs0.Xrhyhsu0dmfeceex1tcxifugbtpos4q	1	15	\N	\N	\N	t	\N
281	Da Silva	Erick Da Silva Lima	0709313472	70766425495  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	[{"fim": "2026-05-06", "obs": "", "tipo": "Dispensa", "inicio": "2026-04-06", "configuracao": {"Sexta": "", "Quarta": "", "Quinta": "", "Terça": "", "Domingo": "", "Segunda": "", "Sábado": ""}}]	[]	t	{"2026-01-07": "A", "2026-01-09": "A"}
315	\N	Allyson Venancio Da Silva	0708452479	\N	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
316	\N	Cristovao Henrique Calaca Ferreira	0708452370	\N	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
317	\N	Danilo Alves Pereira	0708314075	\N	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
318	\N	Elmir De Santana Moreira	0708313978	\N	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
319	\N	Joao Vitor Rocha Da Silva	0708313572	\N	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
320	\N	Lucas Tenorio De Santana Franca	0708406178	\N	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
321	\N	Marcilio Alexandrino Do Nascimento Junior	0708452974	\N	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
322	\N	Milton Vinicius De Souza Santos Da Silva	0708453071	\N	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
323	\N	Rivanildo De Macedo Oliveira Filho	0708314372	\N	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
326	\N	Aurelino Neto Jardim De Lorena	0713691178	\N	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
180	Morita	Carlos Yoshio Morita	1275403135	25332025840  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	14	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
181	Augusto	Augusto Toscano Espínola Neto	0131796641	01304264408  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	12	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
182	Franck	Franck Rosa Da Silva	0100940451	05360207795  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	12	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
183	Elisa Zorn	Elisa Ruzicka Zorn	0119500759	10291335730  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	12	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
187	Buarque	Daniel Cavalcanti Buarque Moreira	0107844979	08850358440  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	11	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
184	Prudêncio	Tiago Prudencio Silvano	0116270554	05891467771  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	11	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
185	Átila	Átila Pereira Ricarte	0101187474	02839669390  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	11	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
186	De Lima	Lucas Lago De Lima	0101175479	13154965777  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	11	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
189	Geová	Geová Alves Da Silva	0112031943	01992755485  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	11	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
188	Azevedo	Dací Araújo De Azevedo	0112026745	76206637468  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	11	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
190	Mauro Maia	Reinaldo Mauro Maia	0112044243	85112003472  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	11	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
191	Francisco Cláudio	Francisco Cláudio Almeida Da Silva Júnior	0110886777	06294876346  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	11	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
192	Tavares Paz	João Victor Tavares Rodrigues Paz	0110886074	60745265324  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	10	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
193	Campos	Matheus Campos Ferraz	0114035470	14724303794  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	10	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
194	Yamamoto	Felipe Yamamoto Ferreira Aguiar	0115494775	16906041746  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	10	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
196	Danilo	Danilo Romeu Farias De Souza	0115495178	03474648314  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	10	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
195	Arthur	Arthur De Andrade Rodrigues Santos	0117728972	61862641307  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	10	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
197	Nojima	Daniel Masaaki Nojima	0119221778	11136511482  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	10	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
198	Reginaldo Silva	Reginaldo Pereira Da Silva Filho	0119063279	09650528423  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	10	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
199	Jefter	Jefter Andre Da Silva Dos Santos	0706812377	11892344408  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	10	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
200	Christopher	Marcos Christopher De Sousa Martins	0711020479	11328359417  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	9	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
201	Israel	Israel De Melo Cavalcanti	0114627847	86411071420  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	9	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
202	Campos Junior	Ivaldo Camara Campos Junior	0114644040	92298362491  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	9	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
204	Juliane Cabral	Juliane Pereira Cabral De Freitas	1102713177	08935891444  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	9	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
203	Possidio	Guilherme Duarte Muniz Possidio Marques	0713315778	03932254538  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	9	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
205	Freire	André Freire Tabosa	0196022834	02373945703  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	7	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
206	Jonas	Jonas Weinert De Campos	0332181148	71374868000  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	7	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
207	Alves Neto	Severino Alves Neto	0130101447	87736829420  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	7	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
208	Alexsandro	Alexsandro Soares De Albuquerque	0130041841	93435479434  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	7	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
209	Evangelista	João Evangelista Dos Santos Batista	1240433944	61226874215  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	7	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
210	Nascimento	Marivaldo Pereira Do Nascimento	0737307843	88146987400  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	7	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
211	Leonardo	Leonardo Nunes Da Silva	0131843849	04214343417  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	7	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
212	Souza Alves	Paulo Roberto De Souza Alves	0130035140	07641410740  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	7	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
213	Diego Ivison	Diego Ivison Silva De Lima	0101969855	04979472427  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	6	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
214	Breno	Breno Marcelo Valença Bandeira	0101970655	10119879700  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	6	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
215	Do Vale	Fábio Henrique Santos Do Vale	0100734359	03778141481  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	6	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
216	Raoni	Raoni Celestino De Abreu	0100734458	06471302460  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	6	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
217	Delano	Emanuel Delano Pinheiro Almeida	0114855950	01927091357  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	6	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
218	Paschual	Thomas Jefferson Paschual	0114873755	35773217848  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	6	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
219	Charles	Charles Edmilson Caetano Alves De Assis	0115843856	06208782406  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	6	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
220	Thiago Ramos	Thiago Ramos Da Silva	0115846859	04666021469  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	6	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
222	Wellington Araújo	Wellington Araujo Do Amaral	0117460550	07732754441  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	6	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
221	Augusto	Augusto César Valeriano Dos Santos	0117406959	05761582406  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	6	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
223	Joel	Joel Borges Dos Passos	0118564657	02878242505  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	5	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
226	Arruda	Thiago Arruda Silva	0100014877	06200254419  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	5	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
224	Nilo	Jose Nilo Gomes De Souza	0100006378	05445842444  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	5	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
225	Muller	Müller Da Silva Santos	0100006774	09507489606  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	5	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
228	Bruno Jose	Bruno Jose Pereira	0102409778	07396629454  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	5	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
229	Clebson	Clebson Da Silva Lima Nascimento	0102409679	08511660402  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	5	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	[]	[]	t	[]
230	Thiago Cesar	Thiago Cesar Da Silva Ramos	0102408671	08414261477  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	5	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
227	Miguel	Anderson Miguel Vieira De Andrade	0102408473	07407843406  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	5	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
2	Marcos Batista	Marcos Batista da Silva	0700849375	09443729458  	mbsj2007@hotmail.com	$2y$10$LjAF1JQ1Kgjt0yr8Ocfs0.XrHyHSu0DMFeCeEx1TcXiFUGBTPoS4q	1	5	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	[{"fim": "2025-12-25", "obs": "hhhh", "tipo": "Dispensa", "inicio": "2025-12-21", "configuracao": {"Sexta": "A", "Quarta": "A", "Quinta": "CJ", "Terça": "C", "Domingo": "", "Segunda": "J", "Sábado": ""}}, {"fim": "2026-01-04", "obs": "", "tipo": "Dispensa", "inicio": "2025-12-29", "configuracao": {"Sexta": "", "Quarta": "", "Quinta": "", "Terça": "C", "Domingo": "", "Segunda": "", "Sábado": ""}}]	[{"fim": "2025-12-24", "obs": "ccc", "tipo": "Dispensa", "inicio": "2025-12-23", "configuracao": {"2025-12-23": "CJ", "2025-12-24": "A"}}]	t	{"2025-12-26": "J", "2025-12-27": "CA", "2025-12-28": "J", "2025-12-29": "C", "2025-12-31": "CAJ", "2026-01-02": "CA", "2026-01-25": "A", "2026-02-09": ""}
231	Henrique	Anderson Henrique Magalhaes De Souza	0700800477	07741350420  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	5	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
234	Rômulo Pereira	Rômulo Pereira Rodrigues	0700873375	06291217457  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	5	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
232	Raoni Barros	Raoni Barros De Sousa	0701900656	05416874414  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	5	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
233	Albuquerque	Ricardo Jorge Soares De Albuquerque Filho	0800495178	08906069430  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	5	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
235	Enio Veras	Enio José Veras Neto	0701987174	08553640418  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	5	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
237	Osvaldo	Osvaldo Pinheiro Neto Bastos	0502922776	06189269419  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	5	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
236	Souza Mendes	Fernando De Souza Mendes	0502929375	07031330980  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	5	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
238	Wictor	João Wictor Amorim Maia Silva	1001481975	09382696407  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	5	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
239	Wellison	Wellison Francisco Da Cruz Silva	1100452471	06045004329  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	5	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
241	Josiel	Josiel Negrão Brito Pereira	0704926278	06012194579  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	5	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
240	Cavalcanti	Guilherme Rodrigo Cavalcanti Santos	0704927474	10655382437  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	5	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
242	Pietro	Pietro Angelo De Lima Tavares	0704924679	09338982408  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	5	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
244	Irlan	Irlan Pereira De Souza	0802525378	10402544463  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	5	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
245	Garcia	Marcilio Cardoso Garcia Filho	0705883874	08366964418  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	5	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
243	D Moura	Davi Amaral De Moura	0802535476	02956743260  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	5	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
247	Rebôlo	Matheus Domingos Rebôlo	0706997079	01321814607  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	4	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
246	Caio César	Caio César Da Silva	0707000675	08982975403  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	4	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
248	Samuel Silva	Samuel Silva De Lima	0701943979	10514346450  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	4	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
249	Leocádio	Glauber Leocádio Da Silva	0702644279	09803999478  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	4	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
250	Leal	Paulo Henrique Leal De Almeida Paiva	1113995870	12754040730  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	4	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
252	João Pedro	João Pedro Da Silva Dos Santos Peres	0404974875	17788647756  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	4	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
253	Peres	Kelly Da Costa Peres Dos Santos	0301566253	04655457180  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	4	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
251	Jorge Silva	Hyelton Jorge Santana Da Silva	0709074777	10156677407  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	4	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
254	Costa Neto	Delmari Silvestre Costa Neto	0710985276	05288327432  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	4	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
255	Ravena	Jéssica Ravena Santiago Gois	0405666777	08045955341  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	4	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
256	Wagner	Wagner Rodolfo De Araujo	0712014174	09302958469  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	4	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
257	Venâncio	Altair Medeiros Dos Santos Venancio	0325407674	16615264706  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	4	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
258	Alcântara	Fellipe De Alcantara Silva	0711528679	06311124483  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	4	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
259	Rezende	Vinicius Henrique Diniz Rezende	1119267472	70498054160  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	4	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
262	Ítalo	Italo Da Silva Santos	0711383679	12883259402  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	4	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
260	Caio Silva	Caio Henrique Batista Da Silva	0712887777	08375004278  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	4	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
261	Belém	Thiago Dos Santos Belem	0713321370	00949333409  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	4	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
263	Abdias	Abdias Silva De Souza	0707637179	11973211440  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	3	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
264	Adson	Adson Rodrigues Fernandes Campos	0707636973	70185465404  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	3	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
265	Andrade	Daniel Pinheiro De Andrade Souza	0707633475	12453976486  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	3	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
267	Igor	Igor Brito Sales Souza	0707633079	12313796426  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	3	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
272	Pereira	Edvirkson Galdino Pereira	0708312772	71068012404  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	3	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
266	Hiago	Hiago Vinicius Da Silva	0708500376	70523028458  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	3	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
268	Magno	Magno Rhyquelme Santos Cunha	0708311972	12723744400  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	3	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
270	Moises	Lucas Moises Da Silva	0709311674	71401746446  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	3	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
273	Machado	Micael Machado Da Silva	0709311070	12542786488  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	3	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
271	Melo	Natanael De Melo Lima	0709310973	13300945496  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	3	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
269	Jadilson	Jadilson Carlos Santiago Da Silva	0710484775	70922964475  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	3	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
278	Marques	Victor Marques Ferreira Dos Santos	0709206973	71146968418  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	3	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
274	Carlos Silva	Carlos Vinicius Nascimento Silva	0710483975	71484791428  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	3	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
275	De Paula	Gabriel Rodrigo Silva De Paula	0710485673	15106553440  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	3	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
276	Lima	Lucas Albuquerque De Lima	0710013475	12679442423  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	3	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
277	Vinícios	Thiago Vinicios De Santana Marques	0710481474	71310977488  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	3	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
279	Wadson	Wadson Rodrigues De Souza	0710481177	71151421499  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	3	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
280	Soares	Breno Washigton Soares Dos Santos	0708384375	12870116403  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
285	Thalison	Thalison Henrique Xavier De Santana	0710481672	13785477481  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
286	Wallace	Wallace Jose De Araujo	0710481078	15824323410  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
283	Alan	Jefferson Alan De Melo	0710484577	15543890460  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
282	Mendes	Jedyson Mendes Sobreira De Albuquerque	0710484676	15405617474  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
284	Jerônimo	Lucas Jeronimo Xavier	0710483074	13373888409  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
287	Nazário	Artur Nazario Pereira Da Silva	0711385872	71939094445  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
288	Alves Neto	Dayvid Alves Dos Santos	0711385377	14102797408  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
289	Matos	Gabriel Matos Bastos	0711384271	11901108490  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
290	\N	Joao Italo Alves De Mendonca	0711383273	71386177474  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
291	Faria	Matheus Faria Santos	0711381673	71121642497  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
292	Moutinho	Matheus Henrique De Lima Moutinho	0711381574	08744454422  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
293	Masson	Pedro Henrique Braz Masson	0711381178	10619449489  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
294	Adryan	Adryan Lucas Silva Dos Santos	0712356179	71304237494  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
295	Ruan	Caio Ruan Alves Dos Santos	0712357771	13203052458  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
307	Lopes	Claudio Henrique Lopes Do Nascimento	0712355577	16737808492  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
296	Gabriel	Gabriel Machado Da Silva	0712357375	12542804486  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
297	Cabral	Henrique Costa Cabral Brito	0712357276	71158228406  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
298	Batista	Hyago Alves Batista Costa	0712357177	13514446466  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
299	\N	Joao Pedro Souza Muniz	0712354174	14274119483  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
300	Firmino	Jose Vinicius Firmino Bezerra	0712357078	12708880489  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
301	Dos Anjos	Kauan Araujo Dos Anjos	0712353572	15764717485  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
302	Cardoso	Lucas Alexandre Marques Cardoso	0712356872	14965959477  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
303	Silva Filho	Luciano Gomes Da Silva Filho	0712352970	71377588432  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
304	Matheus	Matheus Henrique Silva De Franca	0712352376	14948334413  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
305	Juliano	Mathews Gomes Juliano	0712352277	13590306467  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
306	Miguel	Renato Miguel Araujo Dos Anjos	0712356773	71691180416  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
308	Gomes	Emerson Gomes Da Silva	0712887173	71771242418  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
309	Medeiros	Guilherme Medeiros De Moura	0712886472	71727273478  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
310	Moraes	Italo Caua Lopes De Moraes	0712830470	13411097477  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
311	\N	Joao Marques De Maria Neto	0712886175	10293704430  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
312	Kayo	Kayo Miguel Silva Dos Santos	0712852375	71946232424  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
313	Costa	Paulo Eduardo Costa Da Silva	0712839174	59020908812  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
314	Rafael	Rafael Silva De Santana	0712836378	14049460475  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	2	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
324	Teles	Alan Alexandre Teles Leal	0713691376	15949344448  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
325	\N	Alex Gomes Nazario Coutinho	0713691277	16455846400  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
327	\N	Bruno Rafael Jose Da Silva	0713691079	71871736447  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
328	Gonçalves	Carlos Henrique Gonçalves Da Silva	0713690972	10811380416  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
329	Queiroz	Cauã Queiroz Da Silva	0713690873	16500395492  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
330	Barbosa	Clebson Barbosa Da Silva	0713686970	17552653442  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
331	Cristiano	Cristiano Da Silva Alves Filho	0713690774	71943506450  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
332	\N	Dalton Antonio Pereira Da Silva	0713690675	10804974470  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
333	Davi	Davi Francisco Da Silva	0713690576	16137672425  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
334	Douglas	Douglas Dos Santos Barbosa	0713690477	71849358451  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
335	Filho	Edherval Jose Da Silva Filho	0713690378	18095049450  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
336	Edson	Edson Miguel Rodrigues Silva	0713690279	13150517451  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
337	Patrick	Eduardo Patrick Santos Da Silva	0713685774	14216553494  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
338	Emanuel	Emanuel Da Silva Pereira	0713690170	71736258400  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
339	Eric	Eric Soares Da Silva	0713690071	71761239422  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
340	Jonata	Erick Jonata Gomes Veridiano	0713689974	15531345402  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
341	Pontes	Everton Fernandes Pontes Da Silva	0713689875	15242474483  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
342	Gabriel	Gabriel Vitor Silva De Souza	0713689776	16794539470  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
343	Gênesis	Gênesis Cristiano Dos Santos	0713689677	70551092483  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
344	George	George Nascimento Ferreira	0713689578	71712043404  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
345	Venceslau	Igor Matheus Venceslau Moura	0713686772	71475499450  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
346	Galvão	Jackson José Freitas Galvão Da Silva	0713689479	71569457425  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
347	Cruz	Jackson Keven Santos Da Cruz	0713686673	15941297467  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
348	Ramos	Jadson Ramos De Santana	0713689370	15485094422  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
349	Jean	Jean Miguel Andrade De Lima	0713689271	71501443496  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
350	\N	Joao Pedro Miranda Vieira	0713686574	70899048498  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
351	Victor	João Victor Matos De Araújo	0713689172	15497052452  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
352	Reis	Joas Carlos Souza Reis	0713689073	71511011475  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
353	Silva	Jose Davi Da Silva	0713686475	71400671477  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
354	\N	Jose Rodrigo Da Silva Goncalves	0713686376	71551971496  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
355	Neves	Kauan Vinicius Neves Da Silva	0713685675	15180266483  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
356	Luan	Luan Erone Da Silva	0713686277	0188825444   	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
357	Ezequiel	Lucas Ezequiel Da Silva	0713686178	71577749413  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
358	Rodrigues	Luiz Fernando Rodrigues Cunha Cavalcanti	0713685576	12334116408  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
359	Costa Silva	Maisson Douglas Costa Da Silva	0713688877	11989417400  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
360	Marllon	Marllon Alves De Azevedo	0713686079	71398819441  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
361	Coragem	Matheus Alisson Garcia Coragem	0713688778	71185571450  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
362	Carneiro	Matheus Carneiro Da Silva	0713688679	71798574403  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
363	Mayke	Mayke Do Nascimento Santos	0713688570	17288995402  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
364	Mikael	Mikael Francisco Soares	0713688471	71709777451  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
365	Pedro	Pedro Henrique Da Silva	0713688372	71868268497  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
366	Henrique	Pedro Henrique Matos De Araújo	0713688174	15497016499  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
367	Lucas	Pedro Lucas Ferreira Do Nascimento	0713685972	71364914441  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
368	Renato	Pedro Renato Silva Costa	0713688075	12667416406  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
369	Renan	Renan De Melo Santos	0713687978	15390166418  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
370	Carmo	Rodney Do Carmo	0713685477	17508507452  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
371	Fraga	Rodrigo Fraga De Oliveira	0713687879	16951524769  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
372	Roger	Roger De Lima Leitão	0713687770	15759258427  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
373	Ronaldo	Ronaldo Patrocinio Soares Silva	0713687671	70501046470  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
374	Braz	Rubens Kauann Alves Braz De Oliveira	0702121377	71838037403  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
375	Samuel	Samuel Antônio Dos Santos Costa	0713685279	71960711407  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
376	Romilson	Thiago Romilson Souza Do Nascimento	0713687473	71235901475  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
377	Negromonte	Weslley Filipi Negromonte Da Silva	0713687275	16280648460  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
378	Lisboa	Weslley Vitor Lisboa Da Silva	0713687176	12892757428  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
379	William	William Gabriel Souza Da Silva	0713685378	71339577445  	\N	$2y$10$Gk8wFNiU.5h7FKga.ptnmuTri1hN8xYCq1uSeiDqbXJtgZ4T/LAvm	1	1	{"Sexta": "C", "Quarta": "CA", "Quinta": "CA", "Terça": "CA", "Domingo": "", "Segunda": "A", "Sábado": ""}	{}	{}	t	{}
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

SELECT pg_catalog.setval('public.patentes_id_seq', 15, true);


--
-- TOC entry 2159 (class 0 OID 0)
-- Dependencies: 188
-- Name: relatorios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.relatorios_id_seq', 31, true);


--
-- TOC entry 2160 (class 0 OID 0)
-- Dependencies: 187
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 390, true);


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
-- TOC entry 2017 (class 2606 OID 189236)
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


-- Completed on 2026-01-06 11:16:44

--
-- PostgreSQL database dump complete
--

