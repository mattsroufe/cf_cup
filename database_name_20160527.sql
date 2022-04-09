--
-- PostgreSQL database dump
--

-- Dumped from database version 12.8
-- Dumped by pg_dump version 14.0

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

--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: mattsroufe
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2022-04-03 05:05:57.920116	2022-04-03 05:05:57.920116
\.


--
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: mattsroufe
--

COPY public.courses (id, name, created_at, updated_at) FROM stdin;
1	Terrace Downs	2022-04-08 07:53:32.40234	2022-04-08 07:53:32.40234
2	Pegasus	2022-04-08 07:53:42.991878	2022-04-08 07:53:42.991878
3	Clearwater	2022-04-08 07:53:58.391358	2022-04-08 07:53:58.391358
\.


--
-- Data for Name: holes; Type: TABLE DATA; Schema: public; Owner: mattsroufe
--

COPY public.holes (id, course_id, par, stroke, meters, number, created_at, updated_at) FROM stdin;
1	1	5	15	\N	1	2022-04-08 10:41:16.019641	2022-04-08 10:41:16.019641
2	1	4	11	\N	2	2022-04-08 10:41:16.026207	2022-04-08 10:41:16.026207
3	1	4	13	\N	3	2022-04-08 10:41:16.028969	2022-04-08 10:41:16.028969
4	1	3	9	\N	4	2022-04-08 10:41:16.032	2022-04-08 10:41:16.032
5	1	4	5	\N	5	2022-04-08 10:41:16.035471	2022-04-08 10:41:16.035471
6	1	3	17	\N	6	2022-04-08 10:41:16.037675	2022-04-08 10:41:16.037675
7	1	5	7	\N	7	2022-04-08 10:41:16.039881	2022-04-08 10:41:16.039881
8	1	4	3	\N	8	2022-04-08 10:41:16.042118	2022-04-08 10:41:16.042118
9	1	4	1	\N	9	2022-04-08 10:41:16.044378	2022-04-08 10:41:16.044378
10	1	3	8	\N	10	2022-04-08 10:41:49.986545	2022-04-08 10:41:49.986545
11	1	4	2	\N	11	2022-04-08 10:41:49.990366	2022-04-08 10:41:49.990366
12	1	5	10	\N	12	2022-04-08 10:41:49.99343	2022-04-08 10:41:49.99343
13	1	4	6	\N	13	2022-04-08 10:41:49.996258	2022-04-08 10:41:49.996258
14	1	4	12	\N	14	2022-04-08 10:41:49.998995	2022-04-08 10:41:49.998995
15	1	4	14	\N	15	2022-04-08 10:41:50.002006	2022-04-08 10:41:50.002006
16	1	3	18	\N	16	2022-04-08 10:41:50.004895	2022-04-08 10:41:50.004895
17	1	4	4	\N	17	2022-04-08 10:41:50.007567	2022-04-08 10:41:50.007567
18	1	5	16	\N	18	2022-04-08 10:41:50.010232	2022-04-08 10:41:50.010232
\.


--
-- Data for Name: match_teams; Type: TABLE DATA; Schema: public; Owner: mattsroufe
--

COPY public.match_teams (id, match_id, team_id, created_at, updated_at) FROM stdin;
1	1	1	2022-04-03 07:36:29.151799	2022-04-03 07:36:29.151799
2	1	2	2022-04-03 07:42:24.682277	2022-04-03 07:42:24.682277
\.


--
-- Data for Name: matches; Type: TABLE DATA; Schema: public; Owner: mattsroufe
--

COPY public.matches (id, course_id, date, created_at, updated_at) FROM stdin;
1	1	2022-04-29	2022-04-03 07:28:04.063756	2022-04-08 08:00:30.670166
\.


--
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: mattsroufe
--

COPY public.players (id, first_name, last_name, username, strengths, weaknesses, handicap_text, handicap, created_at, updated_at, team_id) FROM stdin;
6	Sam	Askew	asqboi69	\N	\N	\N	\N	2022-04-03 05:11:36.696247	2022-04-03 05:28:10.042171	\N
9	Ben	Oliver	ben	\N	\N	\N	\N	2022-04-03 05:12:45.767368	2022-04-03 05:29:14.577293	\N
10	Toby	Gillanders	tobz	\N	\N	\N	\N	2022-04-03 05:13:50.407553	2022-04-03 05:30:16.70323	\N
12	Michael	Coker	cokes	\N	\N	\N	\N	2022-04-03 05:15:07.121825	2022-04-03 05:32:59.553769	\N
8	Lee	Axten-Rice	lee	\N	\N	\N	\N	2022-04-03 05:11:58.66211	2022-04-03 05:36:58.975122	\N
7	Calvert	Scott	oldskin	\N	\N	\N	\N	2022-04-03 05:11:52.511034	2022-04-03 07:30:39.61594	1
5	Sam	Bourne	bournie	\N	\N	\N	\N	2022-04-03 05:11:30.120786	2022-04-03 07:41:46.514114	2
3	Hayden	Moore	moo	\N	\N	\N	\N	2022-04-03 05:11:11.169731	2022-04-03 07:41:51.969042	2
4	Jonny	Nippert	jfunk				\N	2022-04-03 05:11:20.146467	2022-04-05 04:07:25.965388	\N
2	Adam	Barrett	ayebee				\N	2022-04-03 05:11:01.202755	2022-04-05 04:11:04.52659	\N
11	Matthew	Coker	chubbs	STRENGTHS:\r\nC\r\nF cUp\r\nThis man is an absolute fan favorite, often refered to as the\r\nrockstar of the C F cup group. His strengths start straight\r\naway with his shaft handling skills, this leads into a lovely\r\ncontrolled low cut drive. Around the greens his hinge and\r\nhold touch is something to behold. Chubbs is certainly one\r\nto watch out for on this seasons tour\r\nWEAKNESSES:\r\nThe longer the irons get the more his game unravels, catch\r\nChubbs with the right Heckle from 170 or so out and he\r\nstarts wobbling in his boots. Chubbs likes to think of\r\nMATTHEW COKER himself as a bit of a trickster which dosnt always pay off.\r\nhis most famous "trickshot" was hitting a tee shot between\r\nNICKNAME: CHUBBS\r\nhis legs and sticking his opponents foot with the ball\r\nHOME CLUB: HASTINGS\r\nBEST C F MOMENT:\r\nCURRENT HANDICAP: 14.8\r\nVomiting in the lovely lush garden surrounding the tee\r\nTROPHIES: CURRENT HOLDER OF box on martinbourgh hole 9! an outstanding effort to\r\n"THE PIGS"\r\nkeep the spew down for so long			\N	2022-04-03 05:14:13.700681	2022-04-06 05:44:03.131108	\N
13	Matt	Sroufe 	money				\N	2022-04-05 06:03:38.983997	2022-04-07 06:11:03.455565	1
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: mattsroufe
--

COPY public.schema_migrations (version) FROM stdin;
20220403050456
20220403054418
20220403071640
20220403072410
20220403072920
20220405041405
20220408083340
20220408083737
\.


--
-- Data for Name: scores; Type: TABLE DATA; Schema: public; Owner: mattsroufe
--

COPY public.scores (id, match_id, hole_id, player_id, score, created_at, updated_at) FROM stdin;
1	1	1	13	4	2022-04-08 10:55:37.727587	2022-04-08 10:55:37.727587
3	1	1	5	4	2022-04-09 01:12:28.886156	2022-04-09 01:12:28.886156
4	1	1	3	5	2022-04-09 01:24:49.543606	2022-04-09 01:24:49.543606
6	1	2	3	4	2022-04-09 01:30:03.858991	2022-04-09 01:30:03.858991
7	1	2	3	4	2022-04-09 01:30:14.234675	2022-04-09 01:30:14.234675
9	1	2	13	6	2022-04-09 01:59:21.93166	2022-04-09 01:59:21.93166
15	1	12	3	8	2022-04-09 02:23:06.510101	2022-04-09 02:23:06.510101
16	1	5	7	5	2022-04-09 02:27:32.649002	2022-04-09 02:27:32.649002
8	1	2	5	5	2022-04-09 01:54:54.111561	2022-04-09 02:42:02.654117
2	1	1	7	5	2022-04-09 01:12:01.296987	2022-04-09 02:44:06.32945
12	1	3	5	4	2022-04-09 02:19:51.744374	2022-04-09 02:49:22.657643
13	1	3	3	8	2022-04-09 02:20:02.189385	2022-04-09 02:49:26.083434
20	1	5	13	4	2022-04-09 03:13:49.824459	2022-04-09 03:13:49.824459
21	1	5	5	5	2022-04-09 03:13:52.366266	2022-04-09 03:13:55.41261
22	1	5	3	3	2022-04-09 03:13:57.770757	2022-04-09 03:13:57.770757
24	1	6	7	4	2022-04-09 03:14:37.708459	2022-04-09 03:14:37.708459
26	1	6	5	5	2022-04-09 03:14:42.623455	2022-04-09 03:14:42.623455
27	1	6	3	4	2022-04-09 03:14:45.081086	2022-04-09 03:14:45.081086
28	1	7	7	4	2022-04-09 03:16:24.321195	2022-04-09 03:16:24.321195
23	1	7	13	5	2022-04-09 03:14:11.743844	2022-04-09 03:16:27.454887
29	1	7	5	8	2022-04-09 03:16:30.758803	2022-04-09 03:16:30.758803
30	1	7	3	4	2022-04-09 03:16:33.523442	2022-04-09 03:16:33.523442
31	1	9	7	2	2022-04-09 03:17:36.484806	2022-04-09 03:17:36.484806
32	1	9	13	5	2022-04-09 03:17:39.556636	2022-04-09 03:17:39.556636
33	1	9	5	3	2022-04-09 03:17:42.321261	2022-04-09 03:17:42.321261
34	1	9	3	7	2022-04-09 03:17:44.59128	2022-04-09 03:17:44.59128
38	1	8	3	5	2022-04-09 03:18:07.512031	2022-04-09 03:18:07.512031
36	1	8	13	3	2022-04-09 03:17:59.831232	2022-04-09 03:18:16.730381
37	1	8	5	3	2022-04-09 03:18:04.283018	2022-04-09 03:18:21.339538
35	1	8	7	5	2022-04-09 03:17:58.458	2022-04-09 03:18:58.733489
39	1	10	7	5	2022-04-09 03:19:04.650741	2022-04-09 03:19:04.650741
40	1	10	13	2	2022-04-09 03:19:07.117745	2022-04-09 03:19:07.117745
41	1	10	5	5	2022-04-09 03:19:09.566004	2022-04-09 03:19:09.566004
42	1	10	3	3	2022-04-09 03:19:11.612076	2022-04-09 03:19:11.612076
43	1	11	7	3	2022-04-09 03:19:21.239782	2022-04-09 03:19:21.239782
44	1	11	13	2	2022-04-09 03:19:24.311573	2022-04-09 03:19:24.311573
45	1	11	5	4	2022-04-09 03:19:27.076718	2022-04-09 03:19:27.076718
46	1	11	3	3	2022-04-09 03:19:30.769047	2022-04-09 03:19:30.769047
5	1	2	7	3	2022-04-09 01:28:33.540702	2022-04-09 03:20:03.327656
47	1	12	5	4	2022-04-09 03:20:36.196779	2022-04-09 03:20:36.196779
10	1	3	7	5	2022-04-09 01:59:31.586078	2022-04-09 03:20:43.26407
14	1	3	13	3	2022-04-09 02:20:14.169959	2022-04-09 03:20:51.250921
49	1	13	5	8	2022-04-09 03:28:46.897248	2022-04-09 03:28:46.897248
50	1	13	3	4	2022-04-09 03:28:49.434125	2022-04-09 03:28:49.434125
25	1	6	13	67	2022-04-09 03:14:40.165937	2022-04-09 03:32:39.043743
51	1	12	13	2	2022-04-09 03:35:13.8709	2022-04-09 03:35:13.8709
48	1	13	13	3	2022-04-09 03:28:43.418478	2022-04-09 03:37:03.084877
52	1	13	7	3	2022-04-09 03:37:06.155114	2022-04-09 03:37:06.155114
11	1	4	7	6	2022-04-09 02:14:10.246103	2022-04-09 03:54:32.218657
18	1	4	5	5	2022-04-09 03:13:39.358745	2022-04-09 03:54:40.709006
19	1	4	3	3	2022-04-09 03:13:41.598621	2022-04-09 03:54:44.702089
17	1	4	13	5	2022-04-09 03:13:07.275022	2022-04-09 03:55:01.597354
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: mattsroufe
--

COPY public.teams (id, name, created_at, updated_at) FROM stdin;
1	Caddyshack	2022-04-03 07:07:13.311781	2022-04-03 07:07:13.311781
2	\N	2022-04-03 07:41:24.889453	2022-04-03 07:41:24.889453
\.


--
-- Name: courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mattsroufe
--

SELECT pg_catalog.setval('public.courses_id_seq', 3, true);


--
-- Name: holes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mattsroufe
--

SELECT pg_catalog.setval('public.holes_id_seq', 18, true);


--
-- Name: match_teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mattsroufe
--

SELECT pg_catalog.setval('public.match_teams_id_seq', 2, true);


--
-- Name: matches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mattsroufe
--

SELECT pg_catalog.setval('public.matches_id_seq', 1, true);


--
-- Name: players_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mattsroufe
--

SELECT pg_catalog.setval('public.players_id_seq', 13, true);


--
-- Name: scores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mattsroufe
--

SELECT pg_catalog.setval('public.scores_id_seq', 52, true);


--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mattsroufe
--

SELECT pg_catalog.setval('public.teams_id_seq', 2, true);


--
-- PostgreSQL database dump complete
--

