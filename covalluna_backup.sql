--
-- PostgreSQL database dump
--

\restrict vgSraNK642ZFITjLPixYqXPpDrmafx36cZXnnhFuqTEuOeTFJQoE43TwotnJlas

-- Dumped from database version 16.14
-- Dumped by pg_dump version 16.14

-- Started on 2026-06-08 22:50:49

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

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16395)
-- Name: agencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agencia (
    codigo_agencia integer NOT NULL,
    nombre character varying(100) NOT NULL,
    direccion character varying(150) NOT NULL,
    municipio character varying(80) NOT NULL,
    telefono character varying(20),
    fecha_apertura date NOT NULL,
    estado character varying(20) NOT NULL,
    CONSTRAINT agencia_estado_check CHECK (((estado)::text = ANY ((ARRAY['Activa'::character varying, 'Inactiva'::character varying])::text[])))
);


ALTER TABLE public.agencia OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16420)
-- Name: asociado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asociado (
    cedula character varying(20) NOT NULL,
    nombre character varying(50) NOT NULL,
    apellido character varying(50) NOT NULL,
    fecha_nacimiento date NOT NULL,
    direccion character varying(150) NOT NULL,
    municipio character varying(80) NOT NULL,
    telefono character varying(20),
    correo character varying(100),
    fecha_afiliacion date NOT NULL,
    tipo_vinculacion character varying(30) NOT NULL,
    estado character varying(20) NOT NULL,
    CONSTRAINT asociado_estado_check CHECK (((estado)::text = ANY ((ARRAY['Activo'::character varying, 'Suspendido'::character varying, 'Retirado'::character varying])::text[])))
);


ALTER TABLE public.asociado OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16440)
-- Name: beneficiario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.beneficiario (
    documento_beneficiario character varying(20) NOT NULL,
    nombre character varying(100) NOT NULL,
    parentesco character varying(50) NOT NULL,
    telefono character varying(20),
    porcentaje_participacion numeric(5,2),
    estado character varying(20),
    cedula_asociado character varying(20) NOT NULL,
    CONSTRAINT beneficiario_porcentaje_participacion_check CHECK (((porcentaje_participacion > (0)::numeric) AND (porcentaje_participacion <= (100)::numeric)))
);


ALTER TABLE public.beneficiario OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16473)
-- Name: bitacora; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bitacora (
    id_bitacora integer NOT NULL,
    fecha_hora timestamp without time zone NOT NULL,
    direccion_ip character varying(45) NOT NULL,
    tipo_operacion character varying(50) NOT NULL,
    descripcion character varying(300),
    id_usuario integer NOT NULL
);


ALTER TABLE public.bitacora OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16472)
-- Name: bitacora_id_bitacora_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bitacora_id_bitacora_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bitacora_id_bitacora_seq OWNER TO postgres;

--
-- TOC entry 5008 (class 0 OID 0)
-- Dependencies: 222
-- Name: bitacora_id_bitacora_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bitacora_id_bitacora_seq OWNED BY public.bitacora.id_bitacora;


--
-- TOC entry 226 (class 1259 OID 16521)
-- Name: credito; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credito (
    numero_radicado integer NOT NULL,
    valor_solicitado numeric(15,2) NOT NULL,
    plazo_meses integer NOT NULL,
    linea_credito character varying(50) NOT NULL,
    fecha_solicitud date NOT NULL,
    fecha_aprobacion date,
    valor_aprobado numeric(15,2),
    estado character varying(20) NOT NULL,
    cedula_asociado character varying(20) NOT NULL,
    cedula_codeudor character varying(20),
    codigo_agencia integer NOT NULL,
    CONSTRAINT credito_estado_check CHECK (((estado)::text = ANY ((ARRAY['En estudio'::character varying, 'Aprobado'::character varying, 'Rechazado'::character varying])::text[]))),
    CONSTRAINT credito_plazo_meses_check CHECK ((plazo_meses > 0)),
    CONSTRAINT credito_valor_aprobado_check CHECK ((valor_aprobado >= (0)::numeric)),
    CONSTRAINT credito_valor_solicitado_check CHECK ((valor_solicitado > (0)::numeric))
);


ALTER TABLE public.credito OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16484)
-- Name: cuenta_ahorro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuenta_ahorro (
    numero_cuenta character varying(20) NOT NULL,
    fecha_apertura date NOT NULL,
    estado character varying(20) NOT NULL,
    cedula_asociado character varying(20) NOT NULL,
    codigo_agencia integer NOT NULL,
    CONSTRAINT cuenta_ahorro_estado_check CHECK (((estado)::text = ANY ((ARRAY['Activa'::character varying, 'Inactiva'::character varying])::text[])))
);


ALTER TABLE public.cuenta_ahorro OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16545)
-- Name: cuota; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuota (
    numero_radicado integer NOT NULL,
    numero_cuota integer NOT NULL,
    fecha_vencimiento date NOT NULL,
    fecha_real_pago date,
    valor_pagado numeric(12,2),
    estado_pago character varying(30) NOT NULL,
    CONSTRAINT cuota_estado_pago_check CHECK (((estado_pago)::text = ANY ((ARRAY['A tiempo'::character varying, 'Pagado con mora'::character varying, 'Pendiente'::character varying])::text[]))),
    CONSTRAINT cuota_valor_pagado_check CHECK ((valor_pagado >= (0)::numeric))
);


ALTER TABLE public.cuota OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16401)
-- Name: empleado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empleado (
    cedula character varying(20) NOT NULL,
    nombre character varying(50) NOT NULL,
    apellido character varying(50) NOT NULL,
    cargo character varying(50) NOT NULL,
    fecha_ingreso date NOT NULL,
    salario_base numeric(12,2) NOT NULL,
    correo_corporativo character varying(100) NOT NULL,
    estado character varying(20) NOT NULL,
    cedula_supervisor character varying(20),
    codigo_agencia integer NOT NULL,
    CONSTRAINT empleado_estado_check CHECK (((estado)::text = ANY ((ARRAY['Activo'::character varying, 'Inactivo'::character varying])::text[]))),
    CONSTRAINT empleado_salario_base_check CHECK ((salario_base > (0)::numeric))
);


ALTER TABLE public.empleado OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16430)
-- Name: fundador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fundador (
    cedula character varying(20) NOT NULL,
    numero_acta integer NOT NULL,
    anio_reconocimiento integer NOT NULL,
    beneficios character varying(300)
);


ALTER TABLE public.fundador OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16500)
-- Name: movimiento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movimiento (
    numero_transaccion bigint NOT NULL,
    fecha_hora timestamp without time zone NOT NULL,
    tipo character varying(30) NOT NULL,
    valor numeric(12,2) NOT NULL,
    canal character varying(30),
    numero_cuenta character varying(20) NOT NULL,
    cuenta_origen character varying(20),
    cuenta_destino character varying(20),
    CONSTRAINT movimiento_valor_check CHECK ((valor > (0)::numeric))
);


ALTER TABLE public.movimiento OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16557)
-- Name: solicitud_actualizacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.solicitud_actualizacion (
    id_solicitud integer NOT NULL,
    telefono_nuevo character varying(20),
    correo_nuevo character varying(100),
    direccion_nueva character varying(150),
    fecha_solicitud date NOT NULL,
    estado character varying(20) NOT NULL,
    motivo_rechazo character varying(300),
    cedula_asociado character varying(20) NOT NULL,
    cedula_empleado character varying(20) NOT NULL,
    CONSTRAINT solicitud_actualizacion_estado_check CHECK (((estado)::text = ANY ((ARRAY['Pendiente'::character varying, 'Aprobada'::character varying, 'Rechazada'::character varying])::text[])))
);


ALTER TABLE public.solicitud_actualizacion OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16452)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id_usuario integer NOT NULL,
    nombre_usuario character varying(50) NOT NULL,
    contrasena character varying(255) NOT NULL,
    fecha_creacion date NOT NULL,
    estado character varying(20) NOT NULL,
    rol character varying(30) NOT NULL,
    cedula_asociado character varying(20),
    cedula_empleado character varying(20),
    CONSTRAINT usuario_estado_check CHECK (((estado)::text = ANY ((ARRAY['Activo'::character varying, 'Inactivo'::character varying])::text[]))),
    CONSTRAINT usuario_rol_check CHECK (((rol)::text = ANY ((ARRAY['Administrador'::character varying, 'Asesor/Cajero'::character varying, 'Asociado'::character varying])::text[])))
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16451)
-- Name: usuario_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_id_usuario_seq OWNER TO postgres;

--
-- TOC entry 5009 (class 0 OID 0)
-- Dependencies: 220
-- Name: usuario_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_id_usuario_seq OWNED BY public.usuario.id_usuario;


--
-- TOC entry 4781 (class 2604 OID 16476)
-- Name: bitacora id_bitacora; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitacora ALTER COLUMN id_bitacora SET DEFAULT nextval('public.bitacora_id_bitacora_seq'::regclass);


--
-- TOC entry 4780 (class 2604 OID 16455)
-- Name: usuario id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuario_id_usuario_seq'::regclass);


--
-- TOC entry 4989 (class 0 OID 16395)
-- Dependencies: 215
-- Data for Name: agencia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.agencia (codigo_agencia, nombre, direccion, municipio, telefono, fecha_apertura, estado) FROM stdin;
1	Tuluá Centro	Calle 25 # 26-31	Tuluá	3156789012	1991-03-15	Activa
2	Riofrío	Carrera 5 # 10-20	Riofrío	3167890123	1995-06-01	Activa
3	Trujillo	Calle 8 # 5-15	Trujillo	3178901234	1998-09-10	Activa
\.


--
-- TOC entry 4991 (class 0 OID 16420)
-- Dependencies: 217
-- Data for Name: asociado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asociado (cedula, nombre, apellido, fecha_nacimiento, direccion, municipio, telefono, correo, fecha_afiliacion, tipo_vinculacion, estado) FROM stdin;
10000001	Luis	Rentería	1965-04-12	Cra 10 # 5-20	Tuluá	3101234567	luis.renteria@gmail.com	1991-03-15	Fundador	Activo
10000002	Emilce	García	1960-08-23	Calle 12 # 3-10	Tuluá	3112345678	emilce.garcia@gmail.com	1991-03-15	Fundador	Activo
10000003	Jorge	Caicedo	1970-11-05	Cra 8 # 15-30	Riofrío	3123456789	jorge.caicedo@gmail.com	1993-06-20	Fundador	Activo
10000004	María	López	1978-02-14	Calle 20 # 10-5	Trujillo	3134567890	maria.lopez@gmail.com	2000-01-10	Regular	Activo
10000005	Pedro	Vargas	1985-07-30	Cra 15 # 8-25	Tuluá	3145678901	pedro.vargas@gmail.com	2005-03-15	Regular	Activo
10000006	Ana	Martínez	1990-09-18	Calle 5 # 2-10	Tuluá	3156789012	ana.martinez@gmail.com	2010-07-20	Regular	Activo
10000007	Ricardo	Ospina	1982-03-25	Cra 3 # 6-15	Riofrío	3167890123	ricardo.ospina@gmail.com	2012-11-05	Regular	Activo
10000008	Sandra	Herrera	1975-12-10	Calle 18 # 9-30	Trujillo	3178901234	sandra.herrera@gmail.com	2015-04-18	Regular	Suspendido
10000009	Felipe	Castro	1995-06-22	Cra 12 # 4-20	Tuluá	3189012345	felipe.castro@gmail.com	2018-08-30	Regular	Activo
10000010	Gloria	Muñoz	1968-01-15	Calle 8 # 7-12	Tuluá	3190123456	gloria.munoz@gmail.com	2020-02-14	Regular	Retirado
\.


--
-- TOC entry 4993 (class 0 OID 16440)
-- Dependencies: 219
-- Data for Name: beneficiario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.beneficiario (documento_beneficiario, nombre, parentesco, telefono, porcentaje_participacion, estado, cedula_asociado) FROM stdin;
20000001	Rosa Rentería	Cónyuge	3201234567	60.00	Activo	10000001
20000002	Juan Rentería	Hijo/a	3212345678	40.00	Activo	10000001
20000003	Carlos García	Hijo/a	3223456789	100.00	Activo	10000002
20000004	Marta López	Cónyuge	3234567890	100.00	Activo	10000004
\.


--
-- TOC entry 4997 (class 0 OID 16473)
-- Dependencies: 223
-- Data for Name: bitacora; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bitacora (id_bitacora, fecha_hora, direccion_ip, tipo_operacion, descripcion, id_usuario) FROM stdin;
\.


--
-- TOC entry 5000 (class 0 OID 16521)
-- Dependencies: 226
-- Data for Name: credito; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credito (numero_radicado, valor_solicitado, plazo_meses, linea_credito, fecha_solicitud, fecha_aprobacion, valor_aprobado, estado, cedula_asociado, cedula_codeudor, codigo_agencia) FROM stdin;
1001	5000000.00	24	Libre inversión	2024-01-05	2024-01-10	5000000.00	Aprobado	10000001	10000002	1
1002	15000000.00	36	Vivienda	2024-02-01	2024-02-10	14000000.00	Aprobado	10000004	10000003	2
1003	3000000.00	12	Educativo	2024-03-15	\N	\N	En estudio	10000005	\N	1
1004	8000000.00	24	Agropecuario	2024-01-20	2024-01-25	8000000.00	Aprobado	10000006	10000007	3
\.


--
-- TOC entry 4998 (class 0 OID 16484)
-- Dependencies: 224
-- Data for Name: cuenta_ahorro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cuenta_ahorro (numero_cuenta, fecha_apertura, estado, cedula_asociado, codigo_agencia) FROM stdin;
CA-001	2020-01-15	Activa	10000001	1
CA-002	2020-03-20	Activa	10000002	1
CA-003	2021-06-10	Activa	10000004	2
CA-004	2022-09-05	Activa	10000005	1
CA-005	2023-02-28	Activa	10000006	3
\.


--
-- TOC entry 5001 (class 0 OID 16545)
-- Dependencies: 227
-- Data for Name: cuota; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cuota (numero_radicado, numero_cuota, fecha_vencimiento, fecha_real_pago, valor_pagado, estado_pago) FROM stdin;
1001	1	2024-02-10	2024-02-09	208333.00	A tiempo
1001	2	2024-03-10	2024-03-10	208333.00	A tiempo
1001	3	2024-04-10	2024-04-15	208333.00	Pagado con mora
1001	4	2024-05-10	\N	\N	Pendiente
1002	1	2024-03-10	2024-03-08	388888.00	A tiempo
1002	2	2024-04-10	2024-04-10	388888.00	A tiempo
1002	3	2024-05-10	\N	\N	Pendiente
1004	1	2024-02-25	2024-02-24	333333.00	A tiempo
1004	2	2024-03-25	2024-04-01	333333.00	Pagado con mora
1004	3	2024-04-25	\N	\N	Pendiente
\.


--
-- TOC entry 4990 (class 0 OID 16401)
-- Dependencies: 216
-- Data for Name: empleado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.empleado (cedula, nombre, apellido, cargo, fecha_ingreso, salario_base, correo_corporativo, estado, cedula_supervisor, codigo_agencia) FROM stdin;
11111111	Hernando	Muñoz	Director Regional	2000-01-15	4500000.00	h.munoz@coovalluna.com	Activo	\N	1
22222222	Gustavo	Erazo	Director Agencia	2005-03-01	3800000.00	g.erazo@coovalluna.com	Activo	11111111	1
33333333	Andrea	Castaño	Director Agencia	2008-07-15	3800000.00	a.castano@coovalluna.com	Activo	11111111	3
44444444	Patricia	Salcedo	Coordinadora Sistemas	2010-02-20	3200000.00	p.salcedo@coovalluna.com	Activo	22222222	1
55555555	Carlos	Restrepo	Asesor/Cajero	2015-08-10	2000000.00	c.restrepo@coovalluna.com	Activo	22222222	1
66666666	Lucia	Parra	Asesor/Cajero	2018-04-05	2000000.00	l.parra@coovalluna.com	Activo	33333333	3
\.


--
-- TOC entry 4992 (class 0 OID 16430)
-- Dependencies: 218
-- Data for Name: fundador; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fundador (cedula, numero_acta, anio_reconocimiento, beneficios) FROM stdin;
10000001	1	1991	Exención parcial cuota sostenimiento, acceso preferencial créditos bajo interés, voz y voto asamblea extraordinaria
10000002	1	1991	Exención parcial cuota sostenimiento, acceso preferencial créditos bajo interés, voz y voto asamblea extraordinaria
10000003	2	1993	Exención parcial cuota sostenimiento, acceso preferencial créditos bajo interés
\.


--
-- TOC entry 4999 (class 0 OID 16500)
-- Dependencies: 225
-- Data for Name: movimiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movimiento (numero_transaccion, fecha_hora, tipo, valor, canal, numero_cuenta, cuenta_origen, cuenta_destino) FROM stdin;
1	2024-01-10 09:00:00	Depósito	500000.00	Presencial	CA-001	\N	\N
2	2024-01-15 10:30:00	Depósito	300000.00	Aplicación móvil	CA-001	\N	\N
3	2024-01-20 14:00:00	Retiro	100000.00	Cajero automático	CA-001	\N	\N
4	2024-02-05 09:15:00	Depósito	800000.00	Presencial	CA-002	\N	\N
5	2024-02-10 11:00:00	Transferencia saliente	200000.00	Aplicación móvil	CA-002	CA-002	CA-003
6	2024-02-10 11:00:00	Transferencia entrante	200000.00	Aplicación móvil	CA-003	CA-002	CA-003
7	2024-02-20 16:00:00	Depósito	1000000.00	Presencial	CA-003	\N	\N
8	2024-03-01 08:30:00	Depósito	450000.00	Cajero automático	CA-004	\N	\N
9	2024-03-05 13:00:00	Retiro	150000.00	Presencial	CA-004	\N	\N
10	2024-03-10 10:00:00	Depósito	600000.00	Aplicación móvil	CA-005	\N	\N
11	2024-03-15 15:30:00	Depósito	250000.00	Presencial	CA-001	\N	\N
12	2024-03-20 09:00:00	Retiro	80000.00	Cajero automático	CA-002	\N	\N
13	2024-04-01 11:00:00	Depósito	700000.00	Presencial	CA-003	\N	\N
14	2024-04-05 14:00:00	Transferencia saliente	300000.00	Aplicación móvil	CA-004	CA-004	CA-005
15	2024-04-05 14:00:00	Transferencia entrante	300000.00	Aplicación móvil	CA-005	CA-004	CA-005
\.


--
-- TOC entry 5002 (class 0 OID 16557)
-- Dependencies: 228
-- Data for Name: solicitud_actualizacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.solicitud_actualizacion (id_solicitud, telefono_nuevo, correo_nuevo, direccion_nueva, fecha_solicitud, estado, motivo_rechazo, cedula_asociado, cedula_empleado) FROM stdin;
\.


--
-- TOC entry 4995 (class 0 OID 16452)
-- Dependencies: 221
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (id_usuario, nombre_usuario, contrasena, fecha_creacion, estado, rol, cedula_asociado, cedula_empleado) FROM stdin;
1	admin	admin123	2024-01-01	Activo	Administrador	\N	11111111
2	cajero1	cajero123	2024-01-01	Activo	Asesor/Cajero	\N	55555555
3	asociado1	asociado123	2024-01-01	Activo	Asociado	10000005	\N
\.


--
-- TOC entry 5010 (class 0 OID 0)
-- Dependencies: 222
-- Name: bitacora_id_bitacora_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bitacora_id_bitacora_seq', 1, false);


--
-- TOC entry 5011 (class 0 OID 0)
-- Dependencies: 220
-- Name: usuario_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_id_usuario_seq', 3, true);


--
-- TOC entry 4799 (class 2606 OID 16400)
-- Name: agencia agencia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agencia
    ADD CONSTRAINT agencia_pkey PRIMARY KEY (codigo_agencia);


--
-- TOC entry 4805 (class 2606 OID 16429)
-- Name: asociado asociado_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asociado
    ADD CONSTRAINT asociado_correo_key UNIQUE (correo);


--
-- TOC entry 4807 (class 2606 OID 16427)
-- Name: asociado asociado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asociado
    ADD CONSTRAINT asociado_pkey PRIMARY KEY (cedula);


--
-- TOC entry 4811 (class 2606 OID 16445)
-- Name: beneficiario beneficiario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.beneficiario
    ADD CONSTRAINT beneficiario_pkey PRIMARY KEY (documento_beneficiario);


--
-- TOC entry 4817 (class 2606 OID 16478)
-- Name: bitacora bitacora_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitacora
    ADD CONSTRAINT bitacora_pkey PRIMARY KEY (id_bitacora);


--
-- TOC entry 4823 (class 2606 OID 16529)
-- Name: credito credito_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credito
    ADD CONSTRAINT credito_pkey PRIMARY KEY (numero_radicado);


--
-- TOC entry 4819 (class 2606 OID 16489)
-- Name: cuenta_ahorro cuenta_ahorro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_ahorro
    ADD CONSTRAINT cuenta_ahorro_pkey PRIMARY KEY (numero_cuenta);


--
-- TOC entry 4801 (class 2606 OID 16409)
-- Name: empleado empleado_correo_corporativo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_correo_corporativo_key UNIQUE (correo_corporativo);


--
-- TOC entry 4803 (class 2606 OID 16407)
-- Name: empleado empleado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_pkey PRIMARY KEY (cedula);


--
-- TOC entry 4809 (class 2606 OID 16434)
-- Name: fundador fundador_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fundador
    ADD CONSTRAINT fundador_pkey PRIMARY KEY (cedula);


--
-- TOC entry 4821 (class 2606 OID 16505)
-- Name: movimiento movimiento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimiento
    ADD CONSTRAINT movimiento_pkey PRIMARY KEY (numero_transaccion);


--
-- TOC entry 4825 (class 2606 OID 16551)
-- Name: cuota pk_cuota; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuota
    ADD CONSTRAINT pk_cuota PRIMARY KEY (numero_radicado, numero_cuota);


--
-- TOC entry 4827 (class 2606 OID 16564)
-- Name: solicitud_actualizacion solicitud_actualizacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitud_actualizacion
    ADD CONSTRAINT solicitud_actualizacion_pkey PRIMARY KEY (id_solicitud);


--
-- TOC entry 4813 (class 2606 OID 16461)
-- Name: usuario usuario_nombre_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_nombre_usuario_key UNIQUE (nombre_usuario);


--
-- TOC entry 4815 (class 2606 OID 16459)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 4831 (class 2606 OID 16446)
-- Name: beneficiario fk_beneficiario_asociado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.beneficiario
    ADD CONSTRAINT fk_beneficiario_asociado FOREIGN KEY (cedula_asociado) REFERENCES public.asociado(cedula);


--
-- TOC entry 4834 (class 2606 OID 16479)
-- Name: bitacora fk_bitacora_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitacora
    ADD CONSTRAINT fk_bitacora_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 4840 (class 2606 OID 16540)
-- Name: credito fk_credito_agencia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credito
    ADD CONSTRAINT fk_credito_agencia FOREIGN KEY (codigo_agencia) REFERENCES public.agencia(codigo_agencia);


--
-- TOC entry 4841 (class 2606 OID 16530)
-- Name: credito fk_credito_asociado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credito
    ADD CONSTRAINT fk_credito_asociado FOREIGN KEY (cedula_asociado) REFERENCES public.asociado(cedula);


--
-- TOC entry 4842 (class 2606 OID 16535)
-- Name: credito fk_credito_codeudor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credito
    ADD CONSTRAINT fk_credito_codeudor FOREIGN KEY (cedula_codeudor) REFERENCES public.asociado(cedula);


--
-- TOC entry 4835 (class 2606 OID 16495)
-- Name: cuenta_ahorro fk_cuenta_agencia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_ahorro
    ADD CONSTRAINT fk_cuenta_agencia FOREIGN KEY (codigo_agencia) REFERENCES public.agencia(codigo_agencia);


--
-- TOC entry 4836 (class 2606 OID 16490)
-- Name: cuenta_ahorro fk_cuenta_asociado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_ahorro
    ADD CONSTRAINT fk_cuenta_asociado FOREIGN KEY (cedula_asociado) REFERENCES public.asociado(cedula);


--
-- TOC entry 4843 (class 2606 OID 16552)
-- Name: cuota fk_cuota_credito; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuota
    ADD CONSTRAINT fk_cuota_credito FOREIGN KEY (numero_radicado) REFERENCES public.credito(numero_radicado);


--
-- TOC entry 4828 (class 2606 OID 16410)
-- Name: empleado fk_empleado_agencia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT fk_empleado_agencia FOREIGN KEY (codigo_agencia) REFERENCES public.agencia(codigo_agencia);


--
-- TOC entry 4829 (class 2606 OID 16415)
-- Name: empleado fk_empleado_supervisor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT fk_empleado_supervisor FOREIGN KEY (cedula_supervisor) REFERENCES public.empleado(cedula);


--
-- TOC entry 4830 (class 2606 OID 16435)
-- Name: fundador fk_fundador_asociado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fundador
    ADD CONSTRAINT fk_fundador_asociado FOREIGN KEY (cedula) REFERENCES public.asociado(cedula);


--
-- TOC entry 4837 (class 2606 OID 16506)
-- Name: movimiento fk_movimiento_cuenta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimiento
    ADD CONSTRAINT fk_movimiento_cuenta FOREIGN KEY (numero_cuenta) REFERENCES public.cuenta_ahorro(numero_cuenta);


--
-- TOC entry 4838 (class 2606 OID 16516)
-- Name: movimiento fk_movimiento_destino; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimiento
    ADD CONSTRAINT fk_movimiento_destino FOREIGN KEY (cuenta_destino) REFERENCES public.cuenta_ahorro(numero_cuenta);


--
-- TOC entry 4839 (class 2606 OID 16511)
-- Name: movimiento fk_movimiento_origen; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimiento
    ADD CONSTRAINT fk_movimiento_origen FOREIGN KEY (cuenta_origen) REFERENCES public.cuenta_ahorro(numero_cuenta);


--
-- TOC entry 4844 (class 2606 OID 16565)
-- Name: solicitud_actualizacion fk_solicitud_asociado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitud_actualizacion
    ADD CONSTRAINT fk_solicitud_asociado FOREIGN KEY (cedula_asociado) REFERENCES public.asociado(cedula);


--
-- TOC entry 4845 (class 2606 OID 16570)
-- Name: solicitud_actualizacion fk_solicitud_empleado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitud_actualizacion
    ADD CONSTRAINT fk_solicitud_empleado FOREIGN KEY (cedula_empleado) REFERENCES public.empleado(cedula);


--
-- TOC entry 4832 (class 2606 OID 16462)
-- Name: usuario fk_usuario_asociado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_usuario_asociado FOREIGN KEY (cedula_asociado) REFERENCES public.asociado(cedula);


--
-- TOC entry 4833 (class 2606 OID 16467)
-- Name: usuario fk_usuario_empleado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_usuario_empleado FOREIGN KEY (cedula_empleado) REFERENCES public.empleado(cedula);


-- Completed on 2026-06-08 22:50:49

--
-- PostgreSQL database dump complete
--

\unrestrict vgSraNK642ZFITjLPixYqXPpDrmafx36cZXnnhFuqTEuOeTFJQoE43TwotnJlas

