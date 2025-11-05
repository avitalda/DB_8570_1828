--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8
-- Dumped by pg_dump version 16.8

-- Started on 2025-11-04 16:07:40

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
-- TOC entry 215 (class 1259 OID 16586)
-- Name: city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city (
    city_id integer NOT NULL,
    city_name character varying(50) NOT NULL,
    region character varying(50)
);


ALTER TABLE public.city OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16601)
-- Name: family; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.family (
    family_id integer NOT NULL,
    family_name character varying(50) NOT NULL,
    number_of_people integer,
    city_id integer
);


ALTER TABLE public.family OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16611)
-- Name: foodbasket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.foodbasket (
    foodbasket_id integer NOT NULL,
    kind character varying(30),
    status character varying(20),
    basketweight numeric(6,2),
    family_id integer,
    volunteer_id integer
);


ALTER TABLE public.foodbasket OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16641)
-- Name: foodbasket_groceries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.foodbasket_groceries (
    foodbasket_id integer NOT NULL,
    groceries_id integer NOT NULL,
    quantity integer
);


ALTER TABLE public.foodbasket_groceries OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16631)
-- Name: groceries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groceries (
    groceries_id integer NOT NULL,
    groceries_name character varying(50) NOT NULL,
    unit_price numeric(8,2),
    supplier_id integer
);


ALTER TABLE public.groceries OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16626)
-- Name: supplier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.supplier (
    supplier_id integer NOT NULL,
    supplier_name character varying(50) NOT NULL,
    phone_number character varying(15)
);


ALTER TABLE public.supplier OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16591)
-- Name: volunteer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.volunteer (
    volunteer_id integer NOT NULL,
    volunteer_name character varying(50) NOT NULL,
    joiningdate date,
    city_id integer
);


ALTER TABLE public.volunteer OWNER TO postgres;

--
-- TOC entry 4922 (class 0 OID 16586)
-- Dependencies: 215
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.city (city_id, city_name, region) FROM stdin;
4	Rishon LeZion	Center
5	Petah Tikva	Center
6	Afula	North
7	Beer Sheva	South
8	Netanya	Center
9	Ashdod	South
10	Holon	Center
11	Nazareth	North
12	Eilat	South
13	Ramat Gan	Center
14	Dimona_1	Center
15	Petah Tikva_2	Center
16	Hadera_3	North
17	Beer Sheva_4	South
18	Tel Aviv_5	Center
19	Migdal HaEmek_6	South
20	Yokneam_7	South
21	Beit Shemesh_8	North
22	Gan Yavne_9	South
23	Migdal HaEmek_10	Center
24	Safed_11	North
25	Rishon Lezion_12	Center
26	Ofakim_13	Center
27	Eilat_14	South
28	Shoham_15	North
29	Hod Hasharon_16	North
30	Hadera_17	South
31	Ramat Hasharon_18	South
32	Hod Hasharon_19	North
33	Gan Yavne_20	South
34	Safed_21	Center
35	Lod_22	North
36	Kiryat Ata_23	North
37	Ramat Gan_24	Center
38	Beitar Illit_25	South
39	Hadera_26	Center
40	Gan Yavne_27	Center
41	Carmiel_28	South
42	Safed_29	North
43	Jerusalem_30	South
44	Rishon Lezion_31	South
45	Beitar Illit_32	Center
46	Arad_33	North
47	Safed_34	North
48	Tira_35	Center
49	Ramat Gan_36	Center
50	Hadera_37	North
51	Ra'anana_38	North
52	Kiryat Bialik_39	North
53	Beitar Illit_40	Center
54	Maale Adumim_41	North
55	Nahariya_42	North
56	Bnei Brak_43	Center
57	Kiryat Yam_44	North
58	Safed_45	North
59	Beit Shemesh_46	North
60	Migdal HaEmek_47	Center
61	Yokneam_48	Center
62	Dimona_49	South
63	Or Yehuda_50	South
64	Ramla_51	South
65	Nahariya_52	Center
66	Pardes Hanna_53	North
67	Tiberias_54	North
68	Beit Shemesh_55	Center
69	Lod_56	North
70	Sderot_57	Center
71	Herzliya_58	South
72	Kfar Tavor_59	North
73	Efrat_60	South
74	Jerusalem_61	South
75	Efrat_62	North
76	Sderot_63	Center
77	Dimona_64	Center
78	Beer Sheva_65	South
79	Zikhron Yaakov_66	South
80	Bnei Brak_67	North
81	Haifa_68	North
82	Kfar Saba_69	Center
83	Efrat_70	North
84	Kfar Tavor_71	Center
85	Petah Tikva_72	South
86	Kiryat Yam_73	Center
87	Tiberias_74	North
88	Yokneam_75	Center
89	Gan Yavne_76	North
90	Modiin_77	South
91	Eilat_78	South
92	Efrat_79	North
93	Sderot_80	North
94	Ramla_81	Center
95	Tira_82	Center
96	Ra'anana_83	Center
97	Tel Aviv_84	North
98	Ashdod_85	South
99	Bat Yam_86	Center
100	Shoham_87	North
101	Hod Hasharon_88	Center
102	Sderot_89	South
103	Pardes Hanna_90	Center
104	Nahariya_91	North
105	Tira_92	Center
106	Shoham_93	South
107	Beit Shemesh_94	Center
108	Kiryat Arba_95	Center
109	Ramat Gan_96	North
110	Holon_97	North
111	Modiin_98	South
112	Jerusalem_99	South
113	Ramla_100	North
114	Jerusalem_101	North
115	Or Yehuda_102	South
116	Eilat_103	Center
117	Shoham_104	North
118	Yavne_105	North
119	Gan Yavne_106	North
120	Herzliya_107	Center
121	Netanya_108	South
122	Pardes Hanna_109	North
123	Beer Sheva_110	North
124	Tiberias_111	North
125	Kiryat Arba_112	South
126	Herzliya_113	Center
127	Kiryat Arba_114	South
128	Efrat_115	South
129	Arad_116	South
130	Kiryat Shmona_117	South
131	Beer Sheva_118	North
132	Sderot_119	Center
133	Or Yehuda_120	South
134	Pardes Hanna_121	South
135	Kiryat Arba_122	Center
136	Givatayim_123	Center
137	Kfar Tavor_124	North
138	Acre_125	North
139	Arad_126	North
140	Sderot_127	North
141	Kiryat Arba_128	South
142	Maale Adumim_129	South
143	Eilat_130	North
144	Kiryat Arba_131	Center
145	Tiberias_132	Center
146	Ofakim_133	South
147	Arad_134	North
148	Or Yehuda_135	Center
149	Nahariya_136	North
150	Shoham_137	Center
151	Bat Yam_138	Center
152	Ramat Gan_139	Center
153	Efrat_140	Center
154	Ramla_141	South
155	Givatayim_142	South
156	Hod Hasharon_143	South
157	Haifa_144	Center
158	Migdal HaEmek_145	North
159	Sderot_146	South
160	Ofakim_147	North
161	Tel Aviv_148	North
162	Yokneam_149	Center
163	Kiryat Yam_150	North
164	Ramat Hasharon_151	Center
165	Haifa_152	North
166	Hadera_153	Center
167	Arad_154	North
168	Shoham_155	North
169	Dimona_156	North
170	Netanya_157	Center
171	Kiryat Gat_158	Center
172	Yokneam_159	Center
173	Haifa_160	Center
174	Sderot_161	Center
175	Ra'anana_162	South
176	Beer Sheva_163	South
177	Petah Tikva_164	Center
178	Acre_165	North
179	Bnei Brak_166	Center
180	Ramat Hasharon_167	Center
181	Ra'anana_168	South
182	Kiryat Shmona_169	Center
183	Maale Adumim_170	North
184	Acre_171	South
185	Ofakim_172	North
186	Kfar Tavor_173	North
187	Ofakim_174	Center
188	Tira_175	Center
189	Gan Yavne_176	Center
190	Kiryat Gat_177	North
191	Kiryat Yam_178	South
192	Hod Hasharon_179	South
193	Ramat Hasharon_180	North
194	Bnei Brak_181	North
195	Tira_182	South
196	Ramat Gan_183	Center
197	Gan Yavne_184	Center
198	Ramat Hasharon_185	North
199	Haifa_186	Center
200	Nahariya_187	North
201	Rishon Lezion_188	North
202	Jerusalem_189	North
203	Tiberias_190	South
204	Bnei Brak_191	South
205	Safed_192	North
206	Pardes Hanna_193	North
207	Tira_194	Center
208	Yokneam_195	Center
209	Eilat_196	North
210	Ramat Hasharon_197	Center
211	Rishon Lezion_198	South
212	Kiryat Shmona_199	South
213	Petah Tikva_200	South
214	Eilat_201	Center
215	Tiberias_202	North
216	Rishon Lezion_203	South
217	Ramla_204	Center
218	Herzliya_205	Center
219	Beitar Illit_206	North
220	Ramat Gan_207	South
221	Carmiel_208	North
222	Gan Yavne_209	North
223	Pardes Hanna_210	Center
224	Sderot_211	North
225	Modiin_212	Center
226	Hadera_213	North
227	Kfar Tavor_214	North
228	Bnei Brak_215	South
229	Beit Shemesh_216	South
230	Kiryat Ata_217	North
231	Or Yehuda_218	South
232	Beit Shemesh_219	Center
233	Hadera_220	Center
234	Lod_221	South
235	Kfar Tavor_222	South
236	Ramat Gan_223	South
237	Ra'anana_224	North
238	Beit Shemesh_225	South
239	Eilat_226	Center
240	Arad_227	North
241	Tira_228	Center
242	Kiryat Gat_229	Center
243	Petah Tikva_230	Center
244	Safed_231	Center
245	Ramla_232	North
246	Ashdod_233	Center
247	Ofakim_234	South
248	Lod_235	North
249	Acre_236	Center
250	Kiryat Ata_237	South
251	Kfar Saba_238	Center
252	Tiberias_239	Center
253	Hadera_240	North
254	Kiryat Arba_241	Center
255	Kfar Saba_242	South
256	Hadera_243	Center
257	Gan Yavne_244	North
258	Nahariya_245	Center
259	Bat Yam_246	South
260	Kiryat Ata_247	South
261	Givatayim_248	South
262	Safed_249	South
263	Kiryat Bialik_250	North
264	Kiryat Shmona_251	Center
265	Safed_252	South
266	Haifa_253	North
267	Ra'anana_254	South
268	Beit Shemesh_255	North
269	Acre_256	North
270	Arad_257	Center
271	Hadera_258	Center
272	Ramat Hasharon_259	Center
273	Efrat_260	North
274	Yavne_261	North
275	Dimona_262	South
276	Zikhron Yaakov_263	North
277	Pardes Hanna_264	South
278	Kiryat Bialik_265	North
279	Bat Yam_266	South
280	Beit Shemesh_267	Center
281	Eilat_268	North
282	Yavne_269	North
283	Pardes Hanna_270	South
284	Lod_271	Center
285	Kiryat Bialik_272	North
286	Acre_273	Center
287	Ashdod_274	Center
288	Yokneam_275	South
289	Shoham_276	North
290	Kfar Saba_277	North
291	Kiryat Ata_278	South
292	Efrat_279	Center
293	Nahariya_280	South
294	Arad_281	North
295	Safed_282	North
296	Nahariya_283	Center
297	Herzliya_284	South
298	Kiryat Arba_285	North
299	Ramat Hasharon_286	Center
300	Jerusalem_287	Center
301	Kfar Saba_288	Center
302	Maale Adumim_289	Center
303	Kiryat Yam_290	North
304	Efrat_291	North
305	Jerusalem_292	North
306	Ofakim_293	South
307	Ra'anana_294	North
308	Kfar Saba_295	South
309	Hod Hasharon_296	Center
310	Ra'anana_297	South
311	Kiryat Bialik_298	South
312	Beit Shemesh_299	Center
313	Zikhron Yaakov_300	Center
314	Gan Yavne_301	North
315	Givatayim_302	South
316	Tel Aviv_303	North
317	Yokneam_304	Center
318	Or Yehuda_305	North
319	Ramat Hasharon_306	Center
320	Kiryat Ata_307	North
321	Holon_308	South
322	Netanya_309	North
323	Safed_310	South
324	Kiryat Ata_311	Center
325	Migdal HaEmek_312	South
326	Maale Adumim_313	North
327	Hadera_314	North
328	Kiryat Gat_315	South
329	Kiryat Bialik_316	Center
330	Rishon Lezion_317	North
331	Eilat_318	South
332	Ramla_319	South
333	Kiryat Arba_320	Center
334	Modiin_321	Center
335	Ofakim_322	North
336	Kfar Saba_323	South
337	Jerusalem_324	North
338	Efrat_325	North
339	Petah Tikva_326	Center
340	Bnei Brak_327	North
341	Haifa_328	South
342	Carmiel_329	Center
343	Givatayim_330	South
344	Carmiel_331	North
345	Herzliya_332	South
346	Tira_333	North
347	Bat Yam_334	South
348	Bat Yam_335	South
349	Ramat Hasharon_336	Center
350	Shoham_337	Center
351	Ramat Hasharon_338	South
352	Kfar Tavor_339	South
353	Givatayim_340	Center
354	Givatayim_341	North
355	Jerusalem_342	Center
356	Dimona_343	North
357	Ofakim_344	Center
358	Givatayim_345	North
359	Kiryat Ata_346	North
360	Beit Shemesh_347	Center
361	Tiberias_348	North
362	Givatayim_349	Center
363	Beitar Illit_350	Center
364	Beit Shemesh_351	Center
365	Gan Yavne_352	Center
366	Hod Hasharon_353	South
367	Ramat Gan_354	Center
368	Tiberias_355	North
369	Kiryat Ata_356	North
370	Beit Shemesh_357	South
371	Bnei Brak_358	Center
372	Tiberias_359	North
373	Ramla_360	Center
374	Ra'anana_361	North
375	Yavne_362	North
376	Sderot_363	South
377	Lod_364	Center
378	Pardes Hanna_365	South
379	Ramat Gan_366	Center
380	Ofakim_367	North
381	Yokneam_368	North
382	Hod Hasharon_369	North
383	Gan Yavne_370	North
384	Holon_371	North
385	Maale Adumim_372	North
386	Rishon Lezion_373	North
387	Efrat_374	South
388	Tel Aviv_375	Center
389	Ofakim_376	South
390	Kiryat Bialik_377	South
391	Dimona_378	North
392	Kfar Tavor_379	North
393	Hadera_380	North
394	Givatayim_381	Center
395	Yavne_382	North
396	Ramla_383	South
397	Carmiel_384	North
398	Sderot_385	Center
399	Or Yehuda_386	North
400	Ashdod_387	Center
1	Kfar Saba_388	Center
2	Kfar Tavor_389	South
3	Bnei Brak_390	South
\.


--
-- TOC entry 4924 (class 0 OID 16601)
-- Dependencies: 217
-- Data for Name: family; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.family (family_id, family_name, number_of_people, city_id) FROM stdin;
4	BenPorat	5	6
5	BenDavid	4	5
6	Moreno	3	10
7	Malka	6	1
8	Hadad	6	6
9	Turgeman	6	5
10	BenPorat	7	1
11	Alon	5	3
12	Baruch	8	10
13	Shalom	4	1
14	Buzaglo	7	8
15	Levi	3	10
16	Sharabi	2	1
17	Efrati	4	7
18	Moyal	2	4
19	Shalom	8	7
20	Amsalem	5	5
21	Ohayon	2	9
22	Amsalem	4	10
23	Moreno	6	8
24	Tzadok	6	2
25	Halperin	8	3
26	Sharabi	6	7
27	Nahum	7	7
28	Shalev	2	10
29	Amsalem	6	7
30	Malka	5	7
31	Levi	2	10
32	Turgeman	4	3
33	Salem	3	6
34	Moreno	2	4
35	Efrati	7	9
36	Hazan	6	10
37	Avraham	3	2
38	Mizrahi	8	7
39	Eliyahu	5	3
40	Rosen	3	9
41	Gabay	4	3
42	Biton	3	3
43	Avraham	7	1
44	Toledano	8	9
45	Luzon	8	1
46	Luzon	6	6
47	Mizrahi	2	5
48	Avraham	8	7
49	Buzaglo	8	8
50	Chico	4	3
51	BenShimon	6	2
52	Baruch	8	5
53	BenHarush	5	8
54	Biton	7	7
55	Shalom	7	1
56	BenPorat	5	5
57	Halperin	5	4
58	Ohayon	6	8
59	Shalom	4	4
60	Biton	2	8
61	Nahum	3	3
62	Rosen	7	1
63	Mizrahi	8	1
64	Hadad	8	1
65	Mizrahi	7	9
66	Efrati	6	8
67	Cohen	4	10
68	BenYair	2	7
69	BenYair	4	3
70	Shalom	2	7
71	Baruch	7	10
72	Biton	5	1
73	Levi	6	8
74	Abutbul	7	2
75	Alon	6	2
76	Amsalem	6	4
77	Buzaglo	6	9
78	Buzaglo	6	9
79	Cohen	7	3
80	BenPorat	6	5
81	Abutbul	4	9
82	Moyal	2	5
83	Rosen	7	8
84	Avital	5	3
85	Malka	3	3
86	Alon	4	4
87	Hazan	5	8
88	Amsalem	2	1
89	Turgeman	3	8
90	Cohen	2	2
91	Chico	8	9
92	Sharabi	5	6
93	Salem	7	2
94	BenPorat	8	9
95	Vaknin	3	10
96	Katz	5	1
97	Rosen	8	4
98	Alon	3	9
99	Azulay	7	4
100	Buzaglo	6	6
101	Peretz	5	9
102	Chico	8	5
103	Amar	6	9
104	BenHarush	8	8
105	Daniel	2	4
106	Toledano	5	4
107	Levi	3	3
108	Abutbul	7	3
109	Golan	6	1
110	Shalev	8	3
111	Mizrahi	6	4
112	Avraham	3	4
113	Halperin	2	7
114	Turgeman	8	4
115	Mizrahi	8	10
116	Tzadok	7	3
117	Azulay	4	2
118	Malka	4	9
119	Baruch	4	8
120	BenAri	3	9
121	Gabay	3	6
122	Eliyahu	6	8
123	Biton	4	1
124	BenPorat	8	6
125	Efrati	4	7
126	BenPorat	6	4
127	Rosen	4	3
128	BenDavid	7	7
129	Malka	5	5
130	Dahan	8	6
131	Salem	7	2
132	Peretz	3	1
133	Tzadok	4	5
134	Peretz	5	2
135	Levi	2	3
136	BenHarush	6	2
137	Daniel	4	7
138	Nahum	3	6
139	Chico	5	6
140	Golan	4	3
141	BenShimon	8	1
142	Peretz	2	9
143	Nahum	7	2
144	Baruch	3	1
145	Toledano	2	7
146	Yosef	8	6
147	Amar	3	4
148	BenPorat	8	1
149	Shalev	6	8
150	Chico	3	1
151	BenYair	2	9
152	Chico	7	6
153	Houri	6	7
154	Biton	2	8
155	Toledano	4	3
156	Amsalem	3	10
157	Katz	5	4
158	Sharabi	7	9
159	Avraham	8	9
160	BenYair	4	9
161	Shalom	2	8
162	Moreno	8	5
163	Eliyahu	8	7
164	Malka	6	1
165	Houri	2	4
166	Levi	6	1
167	Peretz	6	9
168	Abutbul	5	5
169	Hadad	3	9
170	Dahan	2	10
171	Rosen	2	3
172	Melamed	7	5
173	Melamed	7	2
174	BenDavid	7	3
175	Ohayon	5	2
176	Efrati	8	10
177	Cohen	4	7
178	Cohen	8	10
179	Hazan	7	8
180	BenHarush	3	7
181	Katz	7	10
182	Vaknin	8	8
183	Peretz	7	4
184	Gabay	2	1
185	Azulay	7	5
186	Katz	8	5
187	Halperin	5	3
188	Houri	5	10
189	Mizrahi	8	3
190	Melamed	6	6
191	Buzaglo	3	5
192	Salem	7	5
193	Mizrahi	6	5
194	Hadad	5	7
195	Baruch	5	9
196	Yosef	8	4
197	Golan	8	3
198	Houri	5	8
199	Katz	5	3
200	Toledano	5	3
201	Amsalem	5	10
202	Moreno	3	1
203	Melamed	4	10
204	Amar	8	9
205	Rosen	8	8
206	Levi	4	2
207	Buzaglo	4	4
208	Baruch	7	5
209	BenAri	8	7
210	Salem	8	5
211	Hazan	8	7
212	Turgeman	4	7
213	Shalev	8	5
214	Buzaglo	6	5
215	Shalev	4	7
216	Avraham	3	8
217	Nahum	4	5
218	Buzaglo	3	4
219	Golan	8	3
220	BenPorat	4	7
221	BenAri	7	10
222	Dahan	2	8
223	Luzon	4	8
224	Golan	6	9
225	Luzon	6	2
226	Rosen	5	4
227	Alon	5	2
228	Cohen	2	9
229	Moreno	3	5
230	Gabay	8	2
231	Vaknin	8	1
232	Amar	3	1
233	Yosef	6	5
234	Biton	7	5
235	Salem	3	10
236	BenShimon	2	4
237	Halperin	3	3
238	Dahan	5	10
239	Malka	4	3
240	Malka	4	10
241	Amsalem	2	9
242	Hadad	5	1
243	Moreno	7	6
244	Ohayon	6	8
245	Luzon	8	1
246	Tzadok	2	9
247	Hazan	6	9
248	Nahum	7	1
249	Dahan	2	8
250	Baruch	6	9
251	BenShimon	6	5
252	Yosef	8	7
253	Yosef	2	3
254	Moyal	7	2
255	Golan	7	8
256	Daniel	7	4
257	Azulay	5	2
258	Rosen	2	2
259	Hazan	3	6
260	Sharabi	4	4
261	Katz	8	1
262	Buzaglo	4	9
263	BenHarush	8	7
264	Abutbul	7	7
265	Sharabi	7	1
266	Mor	6	8
267	Toledano	4	8
268	Salem	7	1
269	Shalom	3	1
270	Shalev	6	6
271	BenYair	8	5
272	Katz	2	6
273	Chico	3	6
274	BenDavid	7	3
275	Tzadok	5	9
276	Levi	3	8
277	BenAri	4	2
278	Nahum	8	1
279	Shalom	7	4
280	Alon	5	2
281	Shalom	3	4
282	Daniel	6	1
283	Katz	6	6
284	Moreno	6	7
285	Salem	3	7
286	Hadad	4	8
287	Halperin	2	6
288	Golan	3	9
289	BenPorat	8	5
290	Efrati	6	5
291	Cohen	2	1
292	Abutbul	5	4
293	Avital	7	7
294	Malka	2	10
295	BenYair	3	5
296	Avraham	8	8
297	Amsalem	2	10
298	Cohen	4	1
299	Amar	8	5
300	Yosef	7	10
301	Rosen	2	7
302	Avraham	6	1
303	Rosen	8	3
304	BenPorat	4	7
305	Yosef	8	5
306	Golan	3	10
307	Golan	6	7
308	Moyal	5	6
309	Baruch	8	4
310	Dahan	8	5
311	Ohayon	4	6
312	Halperin	6	7
313	Alon	7	2
314	BenShimon	3	8
315	Amar	3	1
316	BenPorat	5	4
317	Melamed	8	7
318	Moreno	7	7
319	Amar	7	9
320	Cohen	2	6
321	Avraham	8	1
322	BenShimon	7	2
323	Chico	8	8
324	Shalom	6	8
325	Halperin	3	3
326	BenAri	7	5
327	Gabay	3	10
328	Luzon	5	1
329	Tzadok	7	5
330	Hadad	7	2
331	Amar	6	9
332	Baruch	3	5
333	Chico	6	2
334	Shalev	3	2
335	Baruch	8	5
336	Mor	3	4
337	Amar	2	6
338	Amsalem	7	9
339	Vaknin	2	3
340	Houri	5	10
341	Efrati	8	1
342	Levi	4	9
343	BenYair	6	7
344	Shalom	6	10
345	Azulay	3	3
346	Avraham	5	2
347	Buzaglo	4	2
348	Shalom	7	3
349	Mizrahi	5	5
350	Chico	6	3
351	Shalev	4	6
352	Nahum	4	9
353	Vaknin	7	5
354	Salem	7	10
355	Dahan	6	3
356	Chico	5	3
357	Baruch	8	1
358	BenShimon	8	1
359	Alon	7	1
360	Amsalem	5	3
361	Avital	6	8
362	Melamed	6	4
363	Vaknin	8	6
364	Shalev	4	3
365	Dahan	3	2
366	Golan	8	7
367	Toledano	8	10
368	Hazan	7	3
369	Luzon	4	7
370	Eliyahu	7	5
371	Halperin	2	8
372	Mizrahi	6	8
373	Gabay	5	5
374	Avital	3	1
375	BenAri	4	5
376	Mor	4	6
377	Halperin	3	4
378	Shalom	8	9
379	Daniel	6	4
380	Eliyahu	5	6
381	Shalom	3	8
382	Avital	6	1
383	Halperin	3	8
384	Shalev	4	4
385	Moyal	6	5
386	Biton	6	6
387	Avital	6	3
388	Hadad	6	4
389	Abutbul	5	6
390	Shalom	2	3
391	Avraham	2	3
392	Tzadok	8	6
393	Moyal	4	6
394	Golan	6	5
395	Mor	6	5
396	Levi	2	8
397	Golan	2	4
398	Turgeman	6	9
399	Malka	3	6
400	BenHarush	2	2
1	Cohen	5	10
2	Melamed	5	5
3	Eliyahu	4	9
\.


--
-- TOC entry 4925 (class 0 OID 16611)
-- Dependencies: 218
-- Data for Name: foodbasket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.foodbasket (foodbasket_id, kind, status, basketweight, family_id, volunteer_id) FROM stdin;
4	family	ready	18.79	269	273
5	emergency	ready	16.42	22	378
6	basic	delivered	17.70	201	36
7	family	delivered	32.29	249	386
8	family	ready	27.91	373	118
9	basic	pending	22.46	234	393
10	emergency	delivered	25.26	74	129
11	family	pending	17.31	178	372
12	basic	ready	24.55	297	27
13	basic	ready	39.87	180	324
14	emergency	delivered	27.50	208	364
15	family	delivered	31.92	152	365
16	emergency	ready	21.56	62	12
17	family	delivered	33.68	41	303
18	basic	delivered	23.91	308	275
19	emergency	delivered	32.77	235	41
20	emergency	delivered	10.99	14	119
21	holiday	ready	23.07	209	335
22	emergency	pending	21.63	70	29
23	basic	ready	38.60	186	196
24	emergency	pending	15.36	101	271
25	emergency	ready	15.74	129	124
26	emergency	pending	36.86	186	55
27	basic	pending	24.98	296	52
28	emergency	ready	36.21	53	84
29	basic	delivered	27.55	288	346
30	emergency	ready	13.47	273	400
31	basic	pending	33.85	237	19
32	emergency	delivered	19.30	233	189
33	emergency	delivered	16.26	81	293
34	basic	ready	36.16	353	255
35	basic	delivered	30.71	353	326
36	family	delivered	35.93	296	196
37	basic	pending	20.80	330	109
38	basic	delivered	38.08	395	335
39	family	ready	16.11	90	13
40	emergency	pending	19.54	252	235
41	basic	pending	25.89	370	250
42	holiday	pending	23.88	170	114
43	basic	delivered	12.92	262	105
44	family	pending	35.64	22	63
45	emergency	pending	11.29	103	264
46	basic	ready	26.80	344	196
47	emergency	delivered	32.47	274	356
48	basic	ready	30.33	2	363
49	family	delivered	31.80	311	210
50	basic	ready	23.82	353	268
51	family	ready	21.24	57	221
52	family	ready	13.36	145	238
53	basic	ready	13.19	78	40
54	family	pending	33.15	225	394
55	family	delivered	16.66	161	285
56	emergency	ready	18.35	47	295
57	holiday	ready	24.64	17	327
58	basic	delivered	33.07	63	164
59	holiday	delivered	28.31	8	244
60	family	delivered	37.81	188	387
61	basic	ready	27.44	299	392
62	holiday	ready	13.19	222	369
63	holiday	pending	19.53	176	10
64	family	ready	21.33	372	91
65	basic	delivered	32.06	219	146
66	emergency	delivered	16.53	125	13
67	emergency	delivered	24.82	266	70
68	holiday	delivered	30.55	172	108
69	basic	ready	17.14	176	347
70	holiday	pending	30.84	271	108
71	holiday	delivered	30.16	279	208
72	basic	delivered	13.01	164	248
73	emergency	delivered	26.64	286	13
74	holiday	ready	16.13	299	257
75	holiday	delivered	12.67	296	10
76	family	delivered	30.09	105	75
77	basic	pending	11.88	227	395
78	family	delivered	12.49	205	94
79	holiday	pending	12.76	216	68
80	family	ready	20.52	109	66
81	family	delivered	33.07	33	72
82	holiday	delivered	23.70	203	36
83	basic	pending	21.44	173	264
84	family	delivered	36.00	76	378
85	holiday	pending	24.60	100	233
86	basic	delivered	21.92	252	219
87	emergency	delivered	21.18	212	281
88	family	delivered	28.31	298	355
89	basic	delivered	31.91	299	212
90	family	delivered	26.74	214	289
91	family	ready	29.20	184	11
92	family	pending	33.02	75	133
93	holiday	delivered	13.63	223	35
94	family	delivered	23.97	112	143
95	family	delivered	10.31	7	204
96	emergency	delivered	15.75	68	285
97	emergency	ready	31.18	273	173
98	basic	ready	20.47	153	254
99	holiday	delivered	32.59	31	34
100	family	ready	38.41	353	90
101	family	delivered	21.86	22	357
102	emergency	ready	34.31	206	336
103	family	delivered	27.76	278	394
104	holiday	ready	23.44	38	396
105	emergency	pending	30.51	352	71
106	family	pending	24.59	315	259
107	emergency	ready	13.45	21	227
108	family	ready	37.74	339	383
109	emergency	ready	20.76	311	293
110	family	delivered	16.32	355	40
111	basic	pending	15.55	400	247
112	basic	pending	20.16	312	245
113	emergency	delivered	22.15	394	150
114	family	delivered	19.36	96	73
115	family	delivered	30.06	98	65
116	emergency	pending	11.98	117	145
117	family	ready	37.54	113	67
118	basic	delivered	15.20	260	118
119	basic	ready	26.26	7	226
120	family	delivered	35.89	372	229
121	emergency	pending	11.67	113	278
122	emergency	delivered	29.87	17	386
123	holiday	delivered	18.70	286	147
124	holiday	pending	31.80	98	265
125	emergency	delivered	39.76	303	123
126	holiday	pending	30.05	141	132
127	basic	ready	10.70	183	345
128	basic	pending	28.44	397	396
129	holiday	delivered	38.32	237	55
130	basic	pending	25.59	87	392
131	emergency	pending	13.49	363	253
132	basic	pending	26.96	284	359
133	family	ready	32.95	277	135
134	holiday	delivered	35.96	270	386
135	emergency	pending	16.23	338	283
136	basic	ready	33.13	348	97
137	basic	pending	22.13	397	256
138	holiday	pending	28.82	4	57
139	basic	pending	18.44	391	318
140	basic	ready	11.02	23	247
141	emergency	pending	38.02	241	374
142	holiday	pending	10.32	15	278
143	emergency	delivered	23.88	179	23
144	holiday	ready	22.00	331	305
145	emergency	ready	17.78	293	228
146	emergency	ready	36.14	354	351
147	family	pending	37.50	284	269
148	emergency	delivered	32.02	105	83
149	emergency	delivered	33.25	276	2
150	family	delivered	14.40	95	341
151	emergency	delivered	34.78	366	172
152	emergency	delivered	32.62	77	373
153	basic	ready	27.83	101	237
154	emergency	delivered	34.76	159	364
155	emergency	delivered	32.41	302	340
156	family	ready	12.65	290	279
157	basic	pending	18.25	6	299
158	family	delivered	27.69	197	392
159	family	delivered	11.00	175	82
160	emergency	pending	39.15	374	79
161	emergency	delivered	13.12	120	96
162	emergency	pending	34.54	257	169
163	family	delivered	39.24	100	133
164	holiday	ready	33.83	114	310
165	holiday	ready	32.69	18	19
166	family	pending	38.10	352	396
167	family	pending	24.00	150	340
168	basic	pending	22.82	99	143
169	family	ready	19.60	230	15
170	family	delivered	39.54	28	277
171	holiday	ready	25.42	381	22
172	basic	ready	33.40	289	292
173	emergency	pending	25.51	271	231
174	holiday	ready	39.38	377	114
175	basic	pending	14.53	3	267
176	family	delivered	12.34	321	337
177	emergency	pending	32.80	108	147
178	basic	ready	16.09	202	94
179	family	ready	32.30	51	335
180	family	ready	16.14	177	233
181	basic	delivered	13.77	242	77
182	basic	pending	39.07	158	379
183	holiday	pending	33.65	319	32
184	basic	pending	35.65	286	94
185	family	delivered	21.87	49	293
186	holiday	ready	37.64	372	55
187	basic	pending	30.50	157	153
188	family	delivered	28.94	263	10
189	family	ready	26.91	369	322
190	holiday	delivered	12.38	113	96
191	holiday	delivered	23.69	159	189
192	basic	ready	17.12	388	89
193	basic	delivered	35.28	385	194
194	emergency	ready	29.57	24	313
195	emergency	ready	22.02	6	303
196	basic	delivered	23.29	334	331
197	family	pending	37.08	287	237
198	family	delivered	24.75	235	214
199	emergency	ready	13.07	137	390
200	basic	pending	25.57	387	154
201	holiday	ready	25.23	34	291
202	basic	ready	28.93	150	210
203	family	ready	11.16	139	200
204	family	delivered	18.46	15	392
205	basic	delivered	15.24	182	169
206	holiday	ready	16.79	290	212
207	family	delivered	25.95	336	253
208	family	pending	23.17	224	128
209	holiday	pending	35.85	327	336
210	holiday	ready	39.45	338	390
211	emergency	pending	10.96	164	327
212	emergency	delivered	17.39	302	158
213	holiday	ready	15.14	121	27
214	emergency	pending	29.23	73	25
215	holiday	pending	24.24	7	80
216	emergency	delivered	13.74	117	98
217	holiday	delivered	28.13	9	3
218	emergency	ready	35.82	112	227
219	basic	delivered	38.10	217	357
220	emergency	delivered	15.37	241	230
221	emergency	pending	35.13	77	272
222	holiday	delivered	32.80	393	224
223	emergency	ready	21.79	17	100
224	holiday	delivered	29.41	375	286
225	emergency	ready	30.45	121	297
226	basic	pending	12.89	314	133
227	family	ready	13.67	326	179
228	family	pending	29.25	371	10
229	holiday	ready	19.45	53	13
230	emergency	delivered	30.98	144	248
231	family	pending	30.38	309	336
232	holiday	delivered	34.48	388	239
233	holiday	delivered	15.96	399	119
234	emergency	delivered	26.59	305	173
235	family	pending	31.67	377	79
236	family	delivered	34.12	264	240
237	holiday	ready	26.71	109	159
238	emergency	ready	19.03	342	131
239	emergency	ready	13.07	379	399
240	basic	ready	13.16	286	177
241	holiday	pending	19.93	32	139
242	family	delivered	33.46	53	215
243	basic	pending	35.63	26	231
244	family	ready	33.43	200	40
245	family	ready	38.05	11	284
246	emergency	pending	31.43	88	140
247	emergency	pending	20.24	353	47
248	emergency	delivered	12.35	144	277
249	basic	pending	20.67	83	364
250	emergency	ready	10.62	396	320
251	family	pending	12.62	95	57
252	family	pending	19.12	183	268
253	holiday	ready	31.15	267	172
254	emergency	ready	25.79	343	382
255	basic	pending	35.81	108	390
256	family	delivered	36.76	62	306
257	family	ready	23.69	178	380
258	basic	delivered	21.26	217	395
259	basic	delivered	17.69	272	317
260	holiday	pending	36.51	258	306
261	emergency	delivered	37.97	82	336
262	emergency	delivered	16.97	245	381
263	basic	pending	31.87	29	47
264	emergency	pending	10.27	215	127
265	basic	ready	26.10	377	246
266	emergency	pending	21.29	297	380
267	family	pending	30.71	246	48
268	family	pending	26.26	315	238
269	emergency	ready	10.68	386	361
270	holiday	pending	12.74	106	218
271	holiday	pending	32.57	332	250
272	holiday	ready	18.04	93	156
273	emergency	pending	21.71	110	348
274	emergency	ready	28.54	173	99
275	emergency	ready	24.02	87	33
276	family	ready	25.17	357	65
277	holiday	delivered	13.82	117	13
278	family	pending	24.79	203	341
279	family	delivered	23.75	228	389
280	family	pending	23.35	298	79
281	holiday	pending	15.94	271	24
282	basic	ready	36.34	196	205
283	family	ready	11.58	47	25
284	basic	delivered	15.72	293	99
285	family	pending	26.48	205	75
286	basic	pending	35.64	277	340
287	family	delivered	24.42	125	218
288	holiday	delivered	23.96	190	389
289	basic	ready	33.91	144	93
290	emergency	pending	35.14	231	45
291	holiday	delivered	35.28	57	323
292	holiday	delivered	38.17	37	344
293	family	pending	34.04	1	244
294	basic	pending	20.44	138	328
295	basic	delivered	13.24	157	45
296	family	pending	20.00	233	133
297	holiday	pending	23.10	81	383
298	emergency	delivered	23.83	292	393
299	family	ready	22.09	71	279
300	basic	ready	37.82	399	74
301	basic	ready	12.85	14	193
302	basic	pending	15.74	325	244
303	emergency	ready	39.06	293	139
304	basic	delivered	19.29	143	182
305	holiday	delivered	16.77	248	364
306	family	ready	22.39	63	53
307	family	delivered	11.57	133	275
308	basic	pending	27.13	247	76
309	emergency	delivered	29.96	306	112
310	basic	delivered	19.74	149	231
311	emergency	pending	31.40	104	353
312	basic	ready	31.48	322	337
313	basic	ready	37.65	383	342
314	emergency	ready	35.89	356	153
315	basic	ready	33.77	277	109
316	basic	ready	34.43	234	1
317	basic	pending	24.25	245	363
318	family	pending	11.77	138	21
319	holiday	pending	13.41	33	343
320	holiday	ready	16.54	232	392
321	holiday	delivered	10.99	306	55
322	holiday	pending	20.34	340	10
323	basic	ready	32.89	168	61
324	emergency	pending	31.08	363	38
325	holiday	delivered	36.45	95	373
326	holiday	pending	16.04	342	307
327	basic	delivered	23.07	7	274
328	family	delivered	24.58	34	305
329	family	pending	23.72	28	164
330	family	ready	14.19	127	134
331	basic	delivered	32.26	349	28
332	emergency	delivered	19.01	292	339
333	holiday	delivered	23.01	233	134
334	holiday	ready	38.40	64	379
335	family	delivered	30.65	280	293
336	family	ready	26.98	324	45
337	family	pending	32.01	57	306
338	family	delivered	19.91	155	42
339	basic	delivered	27.75	232	25
340	family	pending	10.20	399	246
341	emergency	pending	10.37	174	153
342	basic	pending	26.74	55	342
343	holiday	ready	38.84	102	271
344	basic	delivered	32.72	250	297
345	family	ready	17.65	324	188
346	family	ready	31.28	109	175
347	holiday	pending	34.67	370	289
348	basic	delivered	15.44	363	324
349	basic	ready	19.60	208	208
350	holiday	ready	21.79	80	280
351	family	delivered	15.80	2	169
352	emergency	pending	32.58	315	50
353	family	delivered	31.51	127	304
354	family	pending	16.02	91	65
355	family	pending	24.13	373	144
356	holiday	ready	15.34	237	357
357	family	pending	26.79	1	286
358	family	ready	38.44	219	338
359	basic	ready	36.60	135	121
360	holiday	ready	10.90	269	113
361	emergency	pending	10.64	310	365
362	emergency	ready	13.74	289	80
363	basic	delivered	38.98	15	131
364	holiday	delivered	18.30	223	285
365	holiday	ready	10.64	293	172
366	basic	ready	24.04	369	96
367	holiday	ready	17.09	52	238
368	holiday	pending	39.36	175	2
369	holiday	delivered	27.62	321	385
370	basic	delivered	27.43	226	5
371	basic	ready	39.14	251	81
372	family	delivered	29.36	86	271
373	basic	ready	33.70	282	261
374	emergency	ready	20.04	269	7
375	holiday	ready	31.40	350	215
376	emergency	ready	24.21	161	112
377	emergency	pending	10.30	297	75
378	holiday	pending	17.63	193	278
379	emergency	pending	12.51	181	312
380	holiday	pending	14.60	112	93
381	basic	pending	37.09	214	208
382	holiday	pending	34.29	182	154
383	emergency	delivered	18.27	395	215
384	basic	delivered	25.80	383	67
385	family	ready	23.46	168	341
386	holiday	pending	33.37	261	397
387	family	ready	35.46	135	293
388	basic	delivered	11.32	317	66
389	basic	pending	12.14	344	244
390	family	delivered	17.50	324	274
391	emergency	ready	14.98	108	111
392	holiday	delivered	15.80	18	363
393	holiday	ready	36.71	247	202
394	family	delivered	28.70	36	124
395	basic	pending	24.60	375	117
396	basic	ready	37.86	74	229
397	holiday	delivered	33.57	72	254
398	holiday	ready	20.50	334	20
399	holiday	delivered	25.80	381	373
400	family	ready	33.29	184	135
1	basic	pending	17.78	301	1
2	family	pending	36.21	124	306
3	holiday	delivered	30.96	29	127
\.


--
-- TOC entry 4928 (class 0 OID 16641)
-- Dependencies: 221
-- Data for Name: foodbasket_groceries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.foodbasket_groceries (foodbasket_id, groceries_id, quantity) FROM stdin;
301	258	1
342	212	8
204	364	8
389	379	2
27	125	8
237	284	5
179	283	5
359	328	3
67	376	10
24	357	2
201	253	9
332	92	2
101	342	9
71	253	4
185	82	3
76	293	4
163	91	5
8	61	4
314	350	10
109	384	3
105	340	7
14	195	3
9	220	9
116	39	8
132	266	7
149	40	9
58	373	6
194	380	6
347	45	10
227	26	10
116	389	10
27	388	4
118	228	9
252	163	7
296	215	10
79	85	2
73	236	8
149	65	10
49	50	1
104	123	2
279	112	1
168	96	4
36	295	8
341	339	9
83	13	8
379	16	2
54	187	5
307	382	1
348	63	2
227	39	3
355	189	7
153	285	2
210	61	1
189	365	7
212	167	7
101	260	5
163	160	7
339	128	10
391	169	10
295	144	4
290	306	8
281	158	5
155	245	9
392	86	10
395	263	4
332	326	5
201	164	3
215	302	7
259	324	1
196	393	2
157	295	8
371	158	5
154	312	2
59	288	6
384	246	8
223	233	7
137	338	3
48	94	4
300	38	8
105	347	4
180	314	2
98	106	8
284	389	4
167	274	4
248	314	9
378	102	2
9	298	1
342	324	6
292	195	8
2	304	8
116	258	10
121	216	5
349	306	5
376	113	2
82	273	10
210	121	3
212	21	7
126	302	7
127	366	4
397	376	3
217	389	5
279	93	6
185	8	7
347	71	4
166	385	8
246	331	8
105	357	5
354	81	9
52	354	2
266	377	10
326	25	6
375	372	8
342	224	9
76	69	6
239	385	4
390	202	9
249	226	7
12	182	10
178	25	4
238	170	8
75	50	3
184	243	2
201	242	1
215	99	2
378	123	10
338	169	2
348	80	8
103	186	5
277	39	1
381	325	10
134	131	9
386	260	2
115	11	3
105	48	7
224	110	5
86	8	7
259	278	5
42	32	3
31	367	4
333	145	5
57	103	6
114	243	1
224	318	9
316	174	10
21	293	3
17	195	10
350	48	3
97	380	8
138	285	2
299	273	7
270	46	2
172	12	4
391	301	1
222	368	2
124	277	1
32	12	5
304	76	1
154	51	9
204	255	8
263	167	4
50	186	10
353	162	7
222	90	6
28	336	2
89	177	4
168	315	7
355	254	5
264	336	4
59	157	9
353	300	5
366	50	2
265	343	3
308	356	6
154	117	2
372	323	9
24	323	6
293	76	8
309	310	5
330	325	6
165	224	9
179	383	5
167	122	3
319	279	4
392	9	7
361	41	8
270	163	6
113	298	10
169	29	1
353	149	2
335	152	1
116	367	7
369	39	9
321	138	5
223	121	7
269	94	9
395	32	8
27	321	6
345	236	3
42	331	3
45	203	2
62	4	5
396	162	9
204	381	6
307	282	3
253	230	2
338	117	1
198	372	2
226	165	9
163	103	2
309	364	9
269	172	6
239	215	5
187	296	10
75	252	3
387	29	3
369	108	2
221	316	3
310	310	1
100	191	1
75	36	6
212	152	9
135	248	9
193	53	6
173	88	10
128	138	10
345	166	2
323	270	5
161	317	7
142	396	7
17	3	4
224	93	2
384	386	5
161	131	9
170	134	4
321	319	2
380	237	9
357	389	7
395	39	8
330	2	7
205	384	4
308	267	2
308	63	6
264	350	7
111	74	1
339	81	10
167	313	1
87	51	7
137	250	8
352	339	1
74	147	7
77	292	10
46	81	5
220	257	4
399	120	1
207	129	4
221	235	4
226	145	1
156	102	3
59	361	5
355	294	5
32	64	4
329	63	5
3	385	10
362	196	2
268	291	9
36	234	5
290	317	10
205	143	6
135	357	2
368	123	5
205	210	6
8	113	8
245	20	3
247	76	10
312	35	3
139	158	9
112	321	4
294	361	5
173	47	1
60	224	4
261	178	4
376	316	8
9	8	2
279	166	5
262	29	10
102	139	8
178	240	8
6	30	2
149	48	10
106	163	3
376	145	2
194	220	3
200	144	5
7	140	3
260	148	6
315	329	10
170	376	2
308	18	1
306	23	1
85	339	7
67	132	1
330	229	4
395	134	1
69	106	8
327	396	8
350	335	8
37	183	8
144	113	1
37	125	10
384	381	7
118	388	7
55	320	3
82	245	2
128	398	1
249	257	9
28	114	1
22	17	4
69	20	7
306	7	4
105	227	10
283	254	1
359	122	5
12	126	7
8	271	8
336	291	1
205	16	4
104	7	4
208	246	7
244	110	6
42	361	7
97	154	10
98	317	6
310	1	7
177	370	5
170	75	7
202	19	9
11	126	9
321	162	9
396	292	5
290	241	10
220	98	10
152	341	3
222	62	9
268	262	5
141	394	10
70	240	1
240	351	6
161	309	9
1	352	5
118	222	1
82	119	7
365	361	9
199	83	5
218	364	6
23	202	5
84	36	2
164	338	5
239	1	7
176	32	9
260	78	10
20	291	2
103	396	8
8	382	6
216	313	10
290	182	6
128	292	10
160	316	8
275	271	1
277	180	3
238	321	5
211	55	3
300	129	6
18	227	3
137	116	6
119	58	9
243	199	1
383	76	4
21	360	8
286	257	3
257	219	4
5	143	5
49	248	10
98	3	4
331	137	10
150	244	1
19	357	8
15	156	7
231	97	9
5	155	6
194	358	3
187	159	7
107	102	4
389	389	4
126	28	7
272	228	6
153	85	5
343	70	3
242	39	6
310	3	2
\.


--
-- TOC entry 4927 (class 0 OID 16631)
-- Dependencies: 220
-- Data for Name: groceries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groceries (groceries_id, groceries_name, unit_price, supplier_id) FROM stdin;
4	Beans 4	5.78	137
5	Beans 5	11.54	306
6	Mustard 6	13.85	288
7	Soup Mix 7	12.08	149
8	Sugar 8	11.33	97
9	Oil 9	20.11	257
10	Cereal 10	3.41	231
11	Canned Mushrooms 11	7.30	69
12	Mustard 12	12.54	396
13	Chocolate 13	19.16	232
14	Crackers 14	21.73	218
15	Coffee 15	24.92	35
16	Tea 16	13.33	295
17	Beans 17	20.70	373
18	Flour 18	13.18	345
19	Honey 19	13.81	13
20	Corn 20	14.67	216
21	Biscuits 21	15.82	114
22	Pasta 22	3.39	385
23	Lentils 23	15.65	56
24	Lentils 24	8.01	310
25	Olives 25	6.44	326
26	Canned Peas 26	23.09	40
27	Canned Tuna 27	4.04	322
28	Oil 28	24.18	158
29	Canned Mushrooms 29	19.93	67
30	Honey 30	13.50	304
31	Beans 31	3.43	14
32	Soup Mix 32	13.02	135
33	Pasta 33	5.63	146
34	Rice 34	4.88	213
35	Pickles 35	15.07	164
36	Corn 36	20.08	397
37	Rice 37	22.80	173
38	Crackers 38	6.72	346
39	Flour 39	16.21	239
40	Coffee 40	8.98	198
41	Pasta 41	12.01	300
42	Mustard 42	13.59	292
43	Canned Beans 43	3.14	72
44	Oil 44	13.56	395
45	Mustard 45	7.85	58
46	Milk Powder 46	11.44	287
47	Coffee 47	15.10	287
48	Coffee 48	18.93	210
49	Canned Mushrooms 49	3.26	295
50	Chocolate 50	7.99	77
51	Sugar 51	14.48	156
52	Tuna 52	11.22	7
53	Cereal 53	24.21	135
54	Canned Corn 54	3.35	167
55	Pasta 55	9.51	70
56	Tea 56	5.41	322
57	Chocolate 57	10.19	197
58	Beans 58	22.28	115
59	Olives 59	20.91	348
60	Canned Corn 60	8.50	198
61	Chips 61	18.01	42
62	Honey 62	7.05	102
63	Canned Mushrooms 63	24.50	32
64	Milk Powder 64	4.71	345
65	Milk Powder 65	15.88	32
66	Coffee 66	11.41	178
67	Pickles 67	3.78	185
68	Canned Beans 68	17.15	355
69	Rice 69	15.98	131
70	Coffee 70	11.82	304
71	Canned Mushrooms 71	5.41	314
72	Ketchup 72	24.67	233
73	Honey 73	15.44	97
74	Honey 74	3.41	93
75	Oil 75	21.14	180
76	Mayonnaise 76	14.74	120
77	Pickles 77	17.61	380
78	Flour 78	19.23	143
79	Flour 79	4.81	213
80	Canned Tuna 80	23.06	103
81	Beans 81	4.55	38
82	Soup Mix 82	13.05	391
83	Pasta 83	3.57	253
84	Olives 84	23.86	46
85	Mayonnaise 85	3.34	375
86	Sugar 86	24.98	301
87	Biscuits 87	18.47	292
88	Corn 88	9.61	296
89	Pickles 89	11.48	274
90	Sugar 90	17.00	267
91	Sugar 91	6.59	200
92	Canned Corn 92	5.57	23
93	Chips 93	4.89	80
94	Tea 94	10.86	71
95	Tea 95	21.95	148
96	Beans 96	18.89	329
97	Jam 97	5.93	75
98	Lentils 98	3.94	400
99	Pasta 99	12.17	205
100	Crackers 100	7.13	256
101	Soup Mix 101	3.53	207
102	Flour 102	16.68	80
103	Mustard 103	17.64	288
104	Canned Beans 104	13.54	126
105	Soup Mix 105	5.47	64
106	Soup Mix 106	5.63	49
107	Sugar 107	4.94	244
108	Rice 108	18.59	51
109	Canned Beans 109	8.63	400
110	Milk Powder 110	22.71	104
111	Cereal 111	10.47	293
112	Olives 112	3.85	269
113	Mayonnaise 113	9.91	19
114	Tuna 114	12.21	1
115	Canned Tuna 115	14.92	140
116	Cereal 116	8.20	74
117	Coffee 117	7.92	171
118	Peas 118	9.71	160
119	Coffee 119	19.61	69
120	Chocolate 120	8.19	258
121	Sugar 121	22.82	329
122	Tea 122	11.96	341
123	Soup Mix 123	8.48	392
124	Canned Tuna 124	6.39	143
125	Coffee 125	20.18	17
126	Jam 126	18.50	170
127	Cereal 127	13.00	273
128	Lentils 128	11.67	40
129	Tea 129	13.96	120
130	Jam 130	8.70	232
131	Soup Mix 131	15.06	224
132	Tuna 132	6.45	385
133	Rice 133	20.68	123
134	Soup Mix 134	13.78	205
135	Canned Beans 135	24.22	124
136	Salt 136	4.08	238
137	Corn 137	11.21	176
138	Corn 138	17.83	256
139	Pickles 139	9.18	177
140	Canned Corn 140	21.69	151
141	Chocolate 141	22.40	99
142	Salt 142	8.10	125
143	Corn 143	3.17	119
144	Olives 144	12.44	149
145	Peas 145	6.44	293
146	Crackers 146	17.63	252
147	Canned Corn 147	12.82	114
148	Tuna 148	20.06	50
149	Rice 149	12.00	206
150	Olives 150	12.38	147
151	Beans 151	22.35	371
152	Ketchup 152	7.43	317
153	Mayonnaise 153	13.48	286
154	Lentils 154	12.76	56
155	Chocolate 155	5.91	357
156	Canned Beans 156	12.88	135
157	Chocolate 157	8.37	355
158	Pickles 158	3.20	367
159	Canned Peas 159	15.51	310
160	Canned Beans 160	5.60	393
161	Soup Mix 161	8.51	170
162	Honey 162	10.74	302
163	Lentils 163	12.11	304
164	Flour 164	14.73	206
165	Coffee 165	11.20	229
166	Canned Tuna 166	20.81	135
167	Beans 167	24.19	286
168	Sugar 168	17.92	364
169	Pasta 169	12.28	139
170	Soup Mix 170	20.40	52
171	Tea 171	4.64	193
172	Mustard 172	23.95	1
173	Canned Tuna 173	5.03	30
174	Tomato Sauce 174	6.59	302
175	Jam 175	23.45	359
176	Crackers 176	18.13	94
177	Canned Mushrooms 177	11.07	33
178	Corn 178	11.73	7
179	Milk Powder 179	24.38	220
180	Coffee 180	16.09	177
181	Beans 181	16.86	140
182	Cereal 182	23.77	29
183	Pasta 183	15.87	373
184	Tuna 184	12.34	120
185	Lentils 185	5.93	145
186	Honey 186	5.73	68
187	Lentils 187	22.68	273
188	Flour 188	22.29	135
189	Lentils 189	3.18	111
190	Tomato Sauce 190	14.27	252
191	Tuna 191	4.36	382
192	Ketchup 192	8.14	158
193	Peas 193	24.39	137
194	Flour 194	22.59	144
195	Canned Beans 195	12.30	388
196	Rice 196	18.46	20
197	Jam 197	5.64	10
198	Soup Mix 198	24.28	273
199	Mustard 199	15.92	224
200	Biscuits 200	3.04	80
201	Tuna 201	13.75	69
202	Soup Mix 202	5.64	58
203	Tuna 203	6.29	222
204	Tuna 204	16.82	357
205	Tuna 205	5.84	250
206	Lentils 206	4.13	69
207	Milk Powder 207	7.91	363
208	Pickles 208	22.58	42
209	Milk Powder 209	14.14	332
210	Biscuits 210	6.34	12
211	Tea 211	4.96	149
212	Mayonnaise 212	14.51	363
213	Honey 213	24.71	138
214	Canned Mushrooms 214	6.14	168
215	Cereal 215	5.40	245
216	Flour 216	16.01	211
217	Beans 217	7.02	119
218	Canned Beans 218	21.77	329
219	Tea 219	14.48	117
220	Biscuits 220	10.73	232
221	Corn 221	11.83	12
222	Tomato Sauce 222	16.77	220
223	Corn 223	24.07	315
224	Soup Mix 224	23.86	292
225	Ketchup 225	11.92	374
226	Pickles 226	18.51	42
227	Tuna 227	8.30	197
228	Honey 228	15.76	22
229	Cereal 229	19.57	224
230	Coffee 230	16.36	279
231	Lentils 231	22.01	233
232	Ketchup 232	6.61	198
233	Pickles 233	14.16	8
234	Ketchup 234	21.76	361
235	Jam 235	5.94	373
236	Jam 236	8.57	397
237	Coffee 237	20.90	319
238	Biscuits 238	13.47	389
239	Rice 239	5.90	147
240	Tuna 240	21.87	19
241	Tuna 241	22.38	123
242	Lentils 242	22.56	27
243	Salt 243	7.15	86
244	Ketchup 244	14.95	173
245	Tuna 245	20.73	105
246	Salt 246	24.59	400
247	Pasta 247	10.75	396
248	Canned Mushrooms 248	9.19	280
249	Tuna 249	21.10	225
250	Lentils 250	15.14	309
251	Chips 251	24.58	304
252	Soup Mix 252	6.40	342
253	Chocolate 253	14.07	398
254	Flour 254	3.71	321
255	Rice 255	10.93	10
256	Biscuits 256	12.98	52
257	Peas 257	19.68	340
258	Rice 258	17.83	375
259	Canned Mushrooms 259	18.43	295
260	Beans 260	6.71	114
261	Cereal 261	12.72	54
262	Tuna 262	14.69	355
263	Ketchup 263	14.05	268
264	Canned Tuna 264	17.97	398
265	Cereal 265	12.66	325
266	Canned Tuna 266	4.80	4
267	Canned Beans 267	6.56	117
268	Coffee 268	11.07	34
269	Canned Corn 269	24.10	73
270	Corn 270	21.36	395
271	Biscuits 271	5.94	154
272	Crackers 272	10.06	392
273	Soup Mix 273	22.32	363
274	Olives 274	19.53	121
275	Pasta 275	9.08	221
276	Milk Powder 276	8.80	99
277	Coffee 277	17.59	23
278	Chocolate 278	23.93	270
279	Coffee 279	18.44	152
280	Mustard 280	8.68	255
281	Cereal 281	11.08	102
282	Mayonnaise 282	20.57	142
283	Mustard 283	4.84	354
284	Sugar 284	13.39	168
285	Jam 285	11.20	197
286	Canned Beans 286	3.89	397
287	Canned Beans 287	12.10	232
288	Tomato Sauce 288	11.20	27
289	Ketchup 289	18.10	176
290	Chocolate 290	9.73	164
291	Canned Beans 291	21.14	55
292	Peas 292	15.05	374
293	Tomato Sauce 293	24.75	1
294	Corn 294	20.61	382
295	Canned Mushrooms 295	10.90	320
296	Pickles 296	10.35	182
297	Rice 297	21.16	92
298	Biscuits 298	8.53	175
299	Mayonnaise 299	14.02	186
300	Flour 300	23.26	217
301	Rice 301	24.19	73
302	Peas 302	11.83	310
303	Cereal 303	7.50	266
304	Chocolate 304	18.41	341
305	Tuna 305	16.72	327
306	Milk Powder 306	20.91	331
307	Canned Tuna 307	20.56	33
308	Peas 308	6.17	64
309	Cereal 309	7.99	265
310	Oil 310	16.04	272
311	Beans 311	5.93	89
312	Rice 312	5.92	100
313	Rice 313	17.86	391
314	Corn 314	19.99	134
315	Tea 315	12.82	315
316	Canned Peas 316	4.79	204
317	Pasta 317	8.37	206
318	Soup Mix 318	3.02	252
319	Corn 319	18.55	355
320	Beans 320	5.39	17
321	Biscuits 321	4.38	268
322	Biscuits 322	3.95	256
323	Tuna 323	18.93	347
324	Biscuits 324	15.44	345
325	Canned Peas 325	3.02	367
326	Jam 326	4.04	262
327	Lentils 327	14.26	354
328	Tuna 328	7.22	18
329	Coffee 329	21.29	32
330	Canned Corn 330	12.17	174
331	Tea 331	18.18	89
332	Olives 332	16.44	58
333	Biscuits 333	10.02	46
334	Soup Mix 334	20.12	208
335	Corn 335	19.22	295
336	Biscuits 336	4.30	123
337	Canned Tuna 337	12.00	9
338	Canned Corn 338	20.39	184
339	Olives 339	19.60	257
340	Honey 340	16.81	31
341	Pasta 341	4.66	82
342	Jam 342	17.26	266
343	Beans 343	7.95	388
344	Rice 344	4.49	261
345	Corn 345	16.68	247
346	Milk Powder 346	8.33	293
347	Ketchup 347	22.22	400
348	Tea 348	6.89	320
349	Salt 349	13.29	76
350	Canned Peas 350	23.60	312
351	Pickles 351	12.51	28
352	Milk Powder 352	24.13	172
353	Beans 353	9.79	273
354	Rice 354	21.61	88
355	Canned Corn 355	11.51	109
356	Canned Mushrooms 356	11.75	311
357	Coffee 357	10.28	389
358	Beans 358	20.37	260
359	Biscuits 359	5.99	131
360	Jam 360	8.36	394
361	Tea 361	4.88	112
362	Mayonnaise 362	21.20	381
363	Canned Beans 363	22.43	72
364	Flour 364	4.78	375
365	Soup Mix 365	24.74	279
366	Tomato Sauce 366	22.68	176
367	Jam 367	21.29	323
368	Salt 368	15.34	325
369	Tea 369	12.30	399
370	Mustard 370	19.42	180
371	Chocolate 371	23.42	321
372	Pasta 372	12.42	380
373	Cereal 373	8.69	262
374	Sugar 374	16.86	195
375	Ketchup 375	15.29	262
376	Mayonnaise 376	19.19	85
377	Rice 377	5.04	261
378	Rice 378	5.81	29
379	Lentils 379	13.80	272
380	Chips 380	3.55	85
381	Mustard 381	8.35	194
382	Chocolate 382	4.74	7
383	Tuna 383	17.30	357
384	Coffee 384	3.61	206
385	Chocolate 385	8.00	213
386	Cereal 386	21.66	102
387	Tea 387	14.11	265
388	Peas 388	16.52	259
389	Coffee 389	10.68	290
390	Ketchup 390	13.27	254
391	Beans 391	15.77	116
392	Peas 392	11.48	88
393	Mustard 393	4.18	121
394	Oil 394	20.99	167
395	Rice 395	6.19	218
396	Cereal 396	13.36	70
397	Flour 397	4.49	223
398	Rice 398	15.56	87
399	Sugar 399	7.48	199
400	Salt 400	7.76	363
1	Peas 401	4.57	182
2	Canned Mushrooms 402	22.66	395
3	Crackers 403	18.60	154
\.


--
-- TOC entry 4926 (class 0 OID 16626)
-- Dependencies: 219
-- Data for Name: supplier; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.supplier (supplier_id, supplier_name, phone_number) FROM stdin;
4	FreshMarket Ltd	547777777
5	Tnuva	31234567
6	Supersal	503334444
7	Shufersal	36969696
8	Victory	39090909
9	Mehadrin	522222222
10	OsherAd	585555555
11	Am-Pm	35555555
12	SuperDosh	501111111
13	Yohananof	536666666
14	Supplier_1	535007468
15	Supplier_2	512864030
16	Supplier_3	550784496
17	Supplier_4	568324597
18	Supplier_5	597699811
19	Supplier_6	523917436
20	Supplier_7	525893437
21	Supplier_8	575998853
22	Supplier_9	569897655
23	Supplier_10	513269984
24	Supplier_11	542105098
25	Supplier_12	511091956
26	Supplier_13	537433570
27	Supplier_14	554335417
28	Supplier_15	520289784
29	Supplier_16	543601009
30	Supplier_17	583138853
31	Supplier_18	523875851
32	Supplier_19	563647614
33	Supplier_20	573652952
34	Supplier_21	573583233
35	Supplier_22	547662822
36	Supplier_23	588085013
37	Supplier_24	582807041
38	Supplier_25	573954976
39	Supplier_26	528772017
40	Supplier_27	525215683
41	Supplier_28	531974124
42	Supplier_29	563067439
43	Supplier_30	582379651
44	Supplier_31	549891216
45	Supplier_32	585909482
46	Supplier_33	511820489
47	Supplier_34	518598135
48	Supplier_35	579806130
49	Supplier_36	582200457
50	Supplier_37	597671091
51	Supplier_38	596264333
52	Supplier_39	599584556
53	Supplier_40	596927821
54	Supplier_41	520065221
55	Supplier_42	575526203
56	Supplier_43	593150703
57	Supplier_44	541410824
58	Supplier_45	596512304
59	Supplier_46	563850814
60	Supplier_47	581952114
61	Supplier_48	571837476
62	Supplier_49	510029020
63	Supplier_50	557687603
64	Supplier_51	530942134
65	Supplier_52	574601506
66	Supplier_53	541230526
67	Supplier_54	543156175
68	Supplier_55	570108626
69	Supplier_56	553471684
70	Supplier_57	560163105
71	Supplier_58	520369636
72	Supplier_59	555594909
73	Supplier_60	557647702
74	Supplier_61	543507129
75	Supplier_62	597462800
76	Supplier_63	535023304
77	Supplier_64	571727786
78	Supplier_65	595307576
79	Supplier_66	575386366
80	Supplier_67	578001477
81	Supplier_68	541750264
82	Supplier_69	572175925
83	Supplier_70	588645577
84	Supplier_71	546650297
85	Supplier_72	526677726
86	Supplier_73	536608469
87	Supplier_74	570951137
88	Supplier_75	529670915
89	Supplier_76	558976751
90	Supplier_77	523302205
91	Supplier_78	593300088
92	Supplier_79	517568200
93	Supplier_80	586532782
94	Supplier_81	590909360
95	Supplier_82	553391342
96	Supplier_83	542754161
97	Supplier_84	529772423
98	Supplier_85	559510680
99	Supplier_86	584454309
100	Supplier_87	562880738
101	Supplier_88	511951334
102	Supplier_89	543304348
103	Supplier_90	539217049
104	Supplier_91	594648952
105	Supplier_92	573212893
106	Supplier_93	522402719
107	Supplier_94	521546280
108	Supplier_95	557876300
109	Supplier_96	512676044
110	Supplier_97	582765998
111	Supplier_98	524963078
112	Supplier_99	591407880
113	Supplier_100	546294976
114	Supplier_101	527264782
115	Supplier_102	583388728
116	Supplier_103	557719895
117	Supplier_104	532599072
118	Supplier_105	525673583
119	Supplier_106	589014158
120	Supplier_107	528812000
121	Supplier_108	524583932
122	Supplier_109	590197637
123	Supplier_110	527964296
124	Supplier_111	533421587
125	Supplier_112	587874042
126	Supplier_113	515356404
127	Supplier_114	554249706
128	Supplier_115	515030348
129	Supplier_116	593922606
130	Supplier_117	562366925
131	Supplier_118	546679968
132	Supplier_119	526600127
133	Supplier_120	576787397
134	Supplier_121	583392690
135	Supplier_122	579302141
136	Supplier_123	557937167
137	Supplier_124	555512614
138	Supplier_125	597739476
139	Supplier_126	591915752
140	Supplier_127	585493361
141	Supplier_128	564662393
142	Supplier_129	575137293
143	Supplier_130	522110121
144	Supplier_131	526683737
145	Supplier_132	593384524
146	Supplier_133	525862942
147	Supplier_134	554439093
148	Supplier_135	581530804
149	Supplier_136	551558723
150	Supplier_137	570815489
151	Supplier_138	540321722
152	Supplier_139	524422744
153	Supplier_140	548907278
154	Supplier_141	551851535
155	Supplier_142	597739412
156	Supplier_143	519959682
157	Supplier_144	513518502
158	Supplier_145	558667651
159	Supplier_146	560547916
160	Supplier_147	552067368
161	Supplier_148	529609761
162	Supplier_149	539089641
163	Supplier_150	535998028
164	Supplier_151	551177911
165	Supplier_152	578648499
166	Supplier_153	563888345
167	Supplier_154	526316283
168	Supplier_155	561362061
169	Supplier_156	550709754
170	Supplier_157	596028690
171	Supplier_158	555759174
172	Supplier_159	574881055
173	Supplier_160	598893435
174	Supplier_161	551618472
175	Supplier_162	544320179
176	Supplier_163	522559685
177	Supplier_164	589291382
178	Supplier_165	512119024
179	Supplier_166	511372061
180	Supplier_167	589358213
181	Supplier_168	553811061
182	Supplier_169	519687111
183	Supplier_170	584448187
184	Supplier_171	582377333
185	Supplier_172	544395330
186	Supplier_173	552097688
187	Supplier_174	576902283
188	Supplier_175	534214919
189	Supplier_176	516831768
190	Supplier_177	597440249
191	Supplier_178	545694444
192	Supplier_179	530292823
193	Supplier_180	546890105
194	Supplier_181	578924004
195	Supplier_182	528005255
196	Supplier_183	550426141
197	Supplier_184	510077519
198	Supplier_185	583820349
199	Supplier_186	550356776
200	Supplier_187	598781737
201	Supplier_188	595905104
202	Supplier_189	595084284
203	Supplier_190	538795907
204	Supplier_191	541778707
205	Supplier_192	578242949
206	Supplier_193	557099965
207	Supplier_194	546283191
208	Supplier_195	552551255
209	Supplier_196	546347576
210	Supplier_197	542131584
211	Supplier_198	582923631
212	Supplier_199	555449081
213	Supplier_200	594936296
214	Supplier_201	554173000
215	Supplier_202	590340721
216	Supplier_203	531429677
217	Supplier_204	514654265
218	Supplier_205	598045946
219	Supplier_206	597678932
220	Supplier_207	593937599
221	Supplier_208	575754307
222	Supplier_209	575860703
223	Supplier_210	529212593
224	Supplier_211	553469377
225	Supplier_212	572449878
226	Supplier_213	522023791
227	Supplier_214	538985434
228	Supplier_215	570777140
229	Supplier_216	573370664
230	Supplier_217	548220043
231	Supplier_218	531461880
232	Supplier_219	558240529
233	Supplier_220	530656693
234	Supplier_221	536414567
235	Supplier_222	526674759
236	Supplier_223	572308481
237	Supplier_224	544500495
238	Supplier_225	511648660
239	Supplier_226	546025887
240	Supplier_227	577304361
241	Supplier_228	585897377
242	Supplier_229	553457740
243	Supplier_230	586106193
244	Supplier_231	581842230
245	Supplier_232	530991007
246	Supplier_233	574334864
247	Supplier_234	545682916
248	Supplier_235	539398724
249	Supplier_236	520402075
250	Supplier_237	592243881
251	Supplier_238	589502221
252	Supplier_239	573162813
253	Supplier_240	580449898
254	Supplier_241	553424348
255	Supplier_242	559247715
256	Supplier_243	515068659
257	Supplier_244	511300541
258	Supplier_245	534775603
259	Supplier_246	537528639
260	Supplier_247	549022279
261	Supplier_248	592069461
262	Supplier_249	572346094
263	Supplier_250	514270607
264	Supplier_251	514723167
265	Supplier_252	559143521
266	Supplier_253	549856230
267	Supplier_254	574806650
268	Supplier_255	547113533
269	Supplier_256	560842430
270	Supplier_257	587847205
271	Supplier_258	579514931
272	Supplier_259	547483958
273	Supplier_260	571854166
274	Supplier_261	536798113
275	Supplier_262	584432280
276	Supplier_263	531258215
277	Supplier_264	598803402
278	Supplier_265	532268939
279	Supplier_266	588588894
280	Supplier_267	595888690
281	Supplier_268	564673749
282	Supplier_269	553906674
283	Supplier_270	581707838
284	Supplier_271	574851605
285	Supplier_272	540293811
286	Supplier_273	519765269
287	Supplier_274	513509455
288	Supplier_275	525529527
289	Supplier_276	532665154
290	Supplier_277	525638370
291	Supplier_278	530972252
292	Supplier_279	544082603
293	Supplier_280	526600005
294	Supplier_281	538678593
295	Supplier_282	578184121
296	Supplier_283	550927741
297	Supplier_284	570855198
298	Supplier_285	535876960
299	Supplier_286	589136687
300	Supplier_287	585408917
301	Supplier_288	520424239
302	Supplier_289	575447325
303	Supplier_290	589370747
304	Supplier_291	511143481
305	Supplier_292	577635687
306	Supplier_293	525290117
307	Supplier_294	548694764
308	Supplier_295	590376359
309	Supplier_296	519100470
310	Supplier_297	566542644
311	Supplier_298	596344471
312	Supplier_299	559956661
313	Supplier_300	533211427
314	Supplier_301	545285017
315	Supplier_302	533878341
316	Supplier_303	525572410
317	Supplier_304	549555632
318	Supplier_305	517222628
319	Supplier_306	517874980
320	Supplier_307	547153221
321	Supplier_308	584927587
322	Supplier_309	515449694
323	Supplier_310	553230299
324	Supplier_311	513696194
325	Supplier_312	539335182
326	Supplier_313	573770672
327	Supplier_314	515621297
328	Supplier_315	557289002
329	Supplier_316	511952735
330	Supplier_317	533220298
331	Supplier_318	539565312
332	Supplier_319	567463733
333	Supplier_320	594686631
334	Supplier_321	573378864
335	Supplier_322	584708616
336	Supplier_323	572518284
337	Supplier_324	554874200
338	Supplier_325	582640791
339	Supplier_326	568630549
340	Supplier_327	559401182
341	Supplier_328	510997736
342	Supplier_329	555689151
343	Supplier_330	563854633
344	Supplier_331	584654877
345	Supplier_332	578524733
346	Supplier_333	528247329
347	Supplier_334	597440832
348	Supplier_335	530154618
349	Supplier_336	524357883
350	Supplier_337	558529207
351	Supplier_338	538244804
352	Supplier_339	587106865
353	Supplier_340	535131961
354	Supplier_341	548528046
355	Supplier_342	577208692
356	Supplier_343	570788289
357	Supplier_344	542625642
358	Supplier_345	596182718
359	Supplier_346	554894876
360	Supplier_347	563558365
361	Supplier_348	592304355
362	Supplier_349	547709458
363	Supplier_350	516732148
364	Supplier_351	585643951
365	Supplier_352	527866358
366	Supplier_353	536527148
367	Supplier_354	537068744
368	Supplier_355	590489515
369	Supplier_356	532557377
370	Supplier_357	585036029
371	Supplier_358	522051568
372	Supplier_359	516344766
373	Supplier_360	523155377
374	Supplier_361	518828785
375	Supplier_362	577422723
376	Supplier_363	583881386
377	Supplier_364	589246189
378	Supplier_365	526864041
379	Supplier_366	582207588
380	Supplier_367	572997450
381	Supplier_368	532776074
382	Supplier_369	550309734
383	Supplier_370	551218092
384	Supplier_371	561720995
385	Supplier_372	543741901
386	Supplier_373	535153792
387	Supplier_374	520450643
388	Supplier_375	597492306
389	Supplier_376	511225287
390	Supplier_377	583028256
391	Supplier_378	532431897
392	Supplier_379	592016909
393	Supplier_380	550511204
394	Supplier_381	578983009
395	Supplier_382	518339362
396	Supplier_383	580114024
397	Supplier_384	598682249
398	Supplier_385	566562866
399	Supplier_386	563959059
400	Supplier_387	550193531
1	Supplier_388	549713297
2	Supplier_389	560134542
3	Supplier_390	593407505
\.


--
-- TOC entry 4923 (class 0 OID 16591)
-- Dependencies: 216
-- Data for Name: volunteer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.volunteer (volunteer_id, volunteer_name, joiningdate, city_id) FROM stdin;
4	Avi Cohen	2023-01-10	1
5	Dana Levi	2022-05-14	2
6	Noam Ben Ami	2024-02-20	3
7	Rachel Mor	2023-06-07	1
8	Yossi Azulay	2023-07-25	4
9	Liran Shalev	2023-03-30	2
10	Tal Avital	2023-08-12	5
11	Maya Golan	2023-11-01	3
12	Amir Elbaz	2024-01-18	6
13	Inbar Sharabi	2024-03-02	7
14	Rachel Cohen	2024-12-30	1
15	Amir Rosen	2024-04-11	4
16	Gal Levi	2021-09-17	5
17	Eli Azulay	2023-03-13	7
18	Tamar Cohen	2024-04-29	6
19	Noam Mizrahi	2021-04-25	6
20	Amir Mor	2022-12-16	7
21	Tamar Peretz	2022-02-05	2
22	Gal BenDavid	2020-11-28	6
23	Inbar Sharabi	2024-06-27	5
24	Tamar Peretz	2023-03-11	3
25	Eli Shalev	2023-12-28	3
26	Eli Shalev	2023-12-21	5
27	Nadav Shalev	2024-05-21	7
28	Tamar Sharabi	2020-06-18	4
29	Noam Shalev	2023-01-10	7
30	Amir Mizrahi	2021-05-21	1
31	Yossi Cohen	2021-07-15	2
32	Gal Cohen	2021-09-16	4
33	Noam Mor	2024-09-08	4
34	Inbar BenDavid	2024-10-17	5
35	Lior Biton	2023-12-01	6
36	Nadav BenDavid	2021-04-18	4
37	Inbar Cohen	2020-09-08	6
38	Inbar Shalev	2020-10-13	2
39	Maya Sharabi	2021-05-31	5
40	Lior Biton	2023-06-26	2
41	Noam Avraham	2024-06-26	2
42	Avi Peretz	2024-12-08	2
43	Nadav Mor	2022-11-25	5
44	Nadav BenDavid	2021-10-04	3
45	Nadav Levi	2024-01-20	4
46	Tamar Biton	2022-10-15	1
47	Nadav Mor	2024-04-10	5
48	Noam Azulay	2024-12-14	7
49	Inbar Avraham	2020-10-26	6
50	Noam Mizrahi	2021-07-14	5
51	Noam Mor	2024-11-20	2
52	Amir Shalev	2024-01-13	3
53	Amir Mizrahi	2021-05-14	3
54	Amir Shalev	2023-03-08	1
55	Gal Biton	2023-12-31	3
56	Ronen Peretz	2020-12-14	2
57	Yossi Avraham	2021-02-20	4
58	Rachel Shalev	2023-01-15	6
59	Lior Mor	2022-11-29	3
60	Maya Levi	2023-03-19	2
61	Yossi Azulay	2023-06-20	7
62	Yael Levi	2024-03-13	2
63	Dana Levi	2021-01-19	6
64	Yossi Mor	2021-08-13	5
65	Noam Mor	2020-03-26	3
66	Avi Mizrahi	2024-01-10	1
67	Rachel Levi	2022-11-08	4
68	Yossi Rosen	2023-11-23	3
69	Eli Mizrahi	2021-07-20	4
70	Gal Mor	2023-04-06	6
71	Amir Mor	2021-01-03	4
72	Maya Sharabi	2022-12-27	7
73	Ronen Mor	2021-02-19	7
74	Tamar Peretz	2020-08-08	1
75	Lior Mor	2024-09-30	4
76	Lior Cohen	2020-06-22	4
77	Lior Levi	2023-06-12	5
78	Inbar Cohen	2023-09-14	6
79	Tamar Azulay	2021-06-29	5
80	Inbar Mor	2023-01-22	5
81	Rachel Rosen	2021-07-18	5
82	Amir Azulay	2023-06-01	1
83	Maya Shalev	2021-07-13	2
84	Amir Rosen	2022-02-22	2
85	Gal Cohen	2024-02-04	1
86	Lior Mizrahi	2021-12-15	6
87	Ronen Biton	2024-01-21	6
88	Yossi Biton	2023-11-02	5
89	Rachel Sharabi	2021-06-28	1
90	Maya Biton	2023-08-02	4
91	Avi Peretz	2021-12-15	3
92	Amir BenDavid	2022-12-15	5
93	Maya Avraham	2021-08-28	1
94	Ronen Sharabi	2023-05-01	2
95	Yael Mor	2020-10-06	3
96	Tamar Cohen	2020-05-06	6
97	Avi Mizrahi	2024-04-08	7
98	Tamar Avraham	2021-04-06	6
99	Ronen Azulay	2022-01-15	7
100	Dana Shalev	2020-08-04	5
101	Yossi Mor	2023-06-04	4
102	Nadav Shalev	2023-03-26	3
103	Inbar Azulay	2021-10-20	6
104	Yossi Levi	2020-08-23	2
105	Dana Levi	2021-08-31	6
106	Dana Peretz	2020-08-15	3
107	Dana Peretz	2024-02-09	4
108	Gal Azulay	2020-01-15	5
109	Noam Biton	2024-12-02	4
110	Lior Peretz	2024-05-04	4
111	Avi Shalev	2023-05-28	5
112	Nadav Biton	2023-09-01	2
113	Ronen Biton	2023-06-21	5
114	Nadav Azulay	2021-03-20	4
115	Ronen Azulay	2024-05-25	1
116	Dana Sharabi	2021-08-03	3
117	Ronen Rosen	2023-10-08	6
118	Maya Cohen	2022-05-09	6
119	Inbar Rosen	2024-06-18	6
120	Ronen Rosen	2021-09-23	3
121	Yael Mizrahi	2022-12-26	5
122	Avi Biton	2023-05-29	3
123	Gal Mizrahi	2021-06-06	5
124	Dana Shalev	2023-10-23	7
125	Amir Mizrahi	2022-09-16	5
126	Yossi Mizrahi	2023-02-13	1
127	Amir Biton	2021-05-09	3
128	Yael Rosen	2020-04-14	4
129	Amir Sharabi	2021-03-14	6
130	Avi Rosen	2024-01-23	1
131	Maya Levi	2023-01-06	2
132	Maya Peretz	2023-05-05	3
133	Maya Rosen	2023-04-04	1
134	Dana Shalev	2021-12-16	6
135	Ronen BenDavid	2024-12-24	7
136	Dana Mizrahi	2024-04-01	5
137	Rachel Mor	2020-06-09	6
138	Ronen Avraham	2024-12-24	5
139	Dana Sharabi	2020-08-29	3
140	Lior Biton	2021-06-11	3
141	Yossi Azulay	2020-11-09	7
142	Tamar Levi	2022-03-24	4
143	Tamar Sharabi	2021-06-29	6
144	Dana Peretz	2020-09-15	3
145	Yossi BenDavid	2020-02-06	5
146	Amir Biton	2020-03-26	5
147	Yael Azulay	2020-05-17	7
148	Yossi BenDavid	2021-01-08	5
149	Noam Mor	2022-06-12	3
150	Inbar Cohen	2021-09-01	3
151	Gal Rosen	2023-10-28	6
152	Yossi BenDavid	2024-08-18	6
153	Yossi Shalev	2024-02-11	7
154	Avi Mizrahi	2023-12-19	7
155	Avi Rosen	2022-11-20	3
156	Yael BenDavid	2023-08-14	7
157	Inbar Mizrahi	2021-06-06	4
158	Gal Mizrahi	2021-07-01	4
159	Rachel Mor	2023-06-03	1
160	Nadav Azulay	2022-06-23	3
161	Avi Sharabi	2022-05-16	4
162	Maya Azulay	2021-11-30	6
163	Dana BenDavid	2022-12-06	7
164	Tamar Rosen	2022-12-17	6
165	Inbar Cohen	2022-10-29	1
166	Maya Rosen	2021-11-09	4
167	Rachel Rosen	2022-04-05	6
168	Lior Levi	2022-08-14	1
169	Rachel Shalev	2021-01-04	5
170	Dana Biton	2023-03-18	2
171	Avi Avraham	2022-06-23	1
172	Maya Peretz	2021-07-21	6
173	Gal Cohen	2023-05-01	2
174	Maya Cohen	2022-10-12	1
175	Gal Azulay	2020-07-09	3
176	Amir Biton	2020-01-25	4
177	Dana Peretz	2022-02-23	3
178	Yossi BenDavid	2024-03-15	3
179	Amir Rosen	2022-07-25	4
180	Inbar Levi	2021-10-18	5
181	Nadav Cohen	2020-02-06	2
182	Maya BenDavid	2022-01-23	1
183	Noam Avraham	2022-02-22	3
184	Maya Mizrahi	2021-07-28	6
185	Dana Azulay	2022-07-13	7
186	Amir Peretz	2023-05-11	5
187	Rachel Cohen	2023-12-30	1
188	Rachel Mor	2022-05-23	2
189	Ronen BenDavid	2023-11-15	6
190	Maya Azulay	2022-01-17	6
191	Rachel Cohen	2021-08-23	6
192	Noam Mizrahi	2024-10-23	3
193	Ronen Mor	2024-06-27	4
194	Rachel Azulay	2021-08-30	4
195	Ronen Azulay	2021-05-03	7
196	Eli Mor	2021-01-01	4
197	Gal Mor	2023-04-01	4
198	Inbar Peretz	2024-03-11	6
199	Yossi Sharabi	2023-11-24	3
200	Maya Mor	2020-09-18	6
201	Yael Rosen	2022-12-04	2
202	Lior Rosen	2020-12-22	2
203	Avi Mizrahi	2023-03-04	2
204	Yossi BenDavid	2024-05-06	5
205	Noam BenDavid	2021-03-06	4
206	Rachel Mor	2020-03-16	6
207	Inbar Shalev	2022-05-30	3
208	Yossi Biton	2020-10-10	4
209	Ronen Shalev	2022-01-29	1
210	Gal Biton	2021-10-13	4
211	Gal Avraham	2020-03-24	2
212	Ronen Avraham	2020-03-01	5
213	Eli Peretz	2024-07-14	3
214	Tamar Levi	2021-11-28	1
215	Yael Shalev	2021-09-07	7
216	Noam Sharabi	2021-12-28	1
217	Maya Mor	2021-05-28	1
218	Amir Mizrahi	2022-05-14	3
219	Maya BenDavid	2020-06-21	5
220	Yossi Sharabi	2022-04-13	3
221	Dana Peretz	2022-07-13	7
222	Amir Azulay	2021-08-12	1
223	Ronen Avraham	2020-01-30	2
224	Yael BenDavid	2024-12-24	3
225	Ronen Sharabi	2024-11-21	4
226	Rachel Levi	2023-09-18	7
227	Lior Levi	2020-03-16	7
228	Gal Azulay	2023-03-28	1
229	Tamar Biton	2024-04-15	7
230	Ronen Mizrahi	2022-09-17	1
231	Tamar Cohen	2020-12-24	5
232	Gal Azulay	2024-03-19	7
233	Yossi Levi	2024-02-29	4
234	Dana Biton	2022-06-08	6
235	Noam Shalev	2021-07-16	3
236	Dana Rosen	2024-02-24	4
237	Lior Cohen	2024-08-20	2
238	Yael Levi	2022-04-21	7
239	Lior Azulay	2021-10-06	7
240	Maya Avraham	2023-05-06	4
241	Amir Rosen	2021-07-17	5
242	Ronen Shalev	2020-12-26	3
243	Yael Shalev	2024-11-11	1
244	Lior Mizrahi	2021-05-29	5
245	Noam Cohen	2022-10-16	7
246	Lior Azulay	2024-04-18	4
247	Tamar Mizrahi	2020-01-29	2
248	Inbar Biton	2021-07-04	2
249	Avi Mizrahi	2022-01-01	6
250	Lior Levi	2022-11-26	7
251	Gal Levi	2020-10-27	7
252	Noam Mor	2024-06-25	5
253	Noam Rosen	2023-01-19	4
254	Noam Avraham	2020-02-16	5
255	Noam Azulay	2024-04-13	1
256	Gal Rosen	2023-02-05	6
257	Tamar Avraham	2024-05-10	3
258	Lior Cohen	2023-11-22	5
259	Yael Avraham	2021-09-15	2
260	Inbar Biton	2021-03-31	7
261	Lior Avraham	2021-01-22	7
262	Yossi BenDavid	2023-09-01	2
263	Ronen Sharabi	2022-03-01	5
264	Ronen Mor	2022-05-09	3
265	Nadav BenDavid	2020-03-01	5
266	Inbar Biton	2023-12-07	2
267	Gal Shalev	2021-11-25	6
268	Yael Levi	2020-02-10	5
269	Yossi Mizrahi	2024-06-08	2
270	Lior Biton	2022-03-23	2
271	Noam Biton	2020-10-04	7
272	Avi Mizrahi	2023-08-13	3
273	Noam Sharabi	2021-09-24	6
274	Gal Cohen	2021-10-16	4
275	Dana Sharabi	2022-09-25	4
276	Inbar Rosen	2020-07-13	2
277	Eli Levi	2024-05-06	7
278	Dana BenDavid	2021-03-22	6
279	Ronen BenDavid	2021-08-06	5
280	Yossi BenDavid	2022-01-12	3
281	Ronen Mizrahi	2021-02-07	7
282	Yael Biton	2023-06-24	7
283	Yossi BenDavid	2020-08-18	4
284	Maya Mor	2020-06-10	3
285	Ronen Peretz	2022-02-08	4
286	Noam Mor	2022-01-19	2
287	Inbar Levi	2021-08-03	6
288	Amir Rosen	2021-05-31	4
289	Rachel Cohen	2021-02-08	7
290	Eli Avraham	2021-02-07	1
291	Rachel Cohen	2023-08-14	4
292	Avi Mor	2024-09-24	2
293	Nadav Mizrahi	2021-04-01	2
294	Noam Peretz	2023-08-05	1
295	Yossi Levi	2022-01-25	1
296	Yossi Levi	2020-11-03	5
297	Nadav Biton	2022-11-14	6
298	Dana BenDavid	2020-08-10	4
299	Yossi BenDavid	2024-08-18	4
300	Yossi Azulay	2023-08-31	3
301	Eli Levi	2020-03-08	5
302	Dana Peretz	2020-12-01	1
303	Yossi Shalev	2021-01-01	4
304	Eli Rosen	2024-09-28	3
305	Tamar Azulay	2022-08-09	1
306	Eli Azulay	2023-07-17	7
307	Ronen Avraham	2024-06-05	1
308	Rachel Azulay	2022-11-13	7
309	Gal Mizrahi	2020-12-14	6
310	Ronen Cohen	2022-02-02	4
311	Gal Azulay	2022-04-11	4
312	Avi Levi	2020-07-24	3
313	Avi Peretz	2020-10-02	3
314	Rachel Cohen	2022-04-07	6
315	Inbar Avraham	2023-01-30	3
316	Dana BenDavid	2022-08-08	5
317	Eli Avraham	2023-04-14	2
318	Inbar Cohen	2021-01-28	4
319	Inbar Rosen	2023-01-10	1
320	Avi Avraham	2022-10-28	3
321	Yael Avraham	2023-01-18	6
322	Rachel Azulay	2022-07-16	6
323	Inbar Cohen	2023-02-21	2
324	Amir Peretz	2021-11-29	3
325	Maya Sharabi	2023-05-30	7
326	Eli Rosen	2020-07-25	6
327	Avi Azulay	2020-08-19	2
328	Tamar BenDavid	2020-05-27	1
329	Yossi Mizrahi	2020-12-04	7
330	Tamar Cohen	2020-04-12	6
331	Nadav Biton	2023-07-04	3
332	Avi Cohen	2022-10-28	2
333	Maya BenDavid	2020-12-18	4
334	Maya Azulay	2021-01-21	6
335	Dana Avraham	2021-12-19	4
336	Avi BenDavid	2023-02-10	3
337	Gal Shalev	2022-06-20	1
338	Gal Avraham	2023-01-29	2
339	Ronen Biton	2020-11-27	3
340	Gal Shalev	2020-01-22	1
341	Dana Azulay	2022-09-20	7
342	Avi Azulay	2024-02-22	7
343	Nadav Peretz	2024-10-25	7
344	Nadav Shalev	2023-02-18	2
345	Gal Peretz	2023-08-21	3
346	Eli Biton	2022-06-26	6
347	Noam Sharabi	2022-04-04	1
348	Noam Avraham	2022-01-27	3
349	Noam Rosen	2024-07-14	6
350	Lior Levi	2020-01-10	3
351	Maya Levi	2024-01-07	3
352	Eli Azulay	2024-12-08	5
353	Noam Mizrahi	2020-11-23	1
354	Noam Shalev	2020-07-18	7
355	Avi Shalev	2021-01-29	7
356	Tamar Rosen	2021-10-17	1
357	Yael Peretz	2022-02-02	3
358	Eli Avraham	2022-12-09	7
359	Amir Levi	2020-01-23	3
360	Yael Levi	2021-09-06	4
361	Yael Sharabi	2021-08-20	3
362	Rachel Avraham	2021-04-05	2
363	Maya Cohen	2020-01-14	4
364	Tamar Mor	2024-12-29	7
365	Noam Azulay	2022-06-11	7
366	Maya Peretz	2020-10-26	5
367	Ronen Rosen	2024-03-23	2
368	Eli Azulay	2024-09-18	3
369	Eli Avraham	2022-11-29	1
370	Yael Rosen	2021-02-23	5
371	Gal Avraham	2020-09-22	4
372	Lior Shalev	2022-12-07	6
373	Nadav Shalev	2022-12-14	6
374	Yossi Levi	2021-10-18	7
375	Gal Rosen	2023-08-10	6
376	Tamar Avraham	2022-09-03	4
377	Nadav Avraham	2020-10-02	3
378	Noam Sharabi	2020-03-12	6
379	Gal Shalev	2023-10-16	3
380	Rachel Mor	2020-05-21	5
381	Lior Azulay	2021-08-12	5
382	Maya Cohen	2020-10-30	2
383	Maya BenDavid	2021-03-16	2
384	Tamar Azulay	2023-02-02	4
385	Inbar Cohen	2022-11-11	5
386	Avi Levi	2024-08-18	2
387	Rachel Mor	2022-06-08	2
388	Rachel Rosen	2020-11-08	4
389	Eli BenDavid	2024-03-10	5
390	Inbar Mizrahi	2021-05-05	6
391	Gal Peretz	2021-11-04	5
392	Yossi Biton	2024-11-11	1
393	Inbar Peretz	2021-08-09	6
394	Tamar BenDavid	2020-09-25	4
395	Yossi Peretz	2022-10-03	4
396	Ronen Levi	2022-09-11	6
397	Lior Azulay	2020-10-21	5
398	Ronen Shalev	2024-02-18	3
399	Yossi Shalev	2021-08-02	2
400	Rachel Azulay	2024-10-27	4
1	Inbar Mor	2021-02-09	6
2	Yael Mor	2024-03-09	3
3	Lior Azulay	2020-05-20	2
\.


--
-- TOC entry 4759 (class 2606 OID 16590)
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (city_id);


--
-- TOC entry 4763 (class 2606 OID 16605)
-- Name: family family_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family
    ADD CONSTRAINT family_pkey PRIMARY KEY (family_id);


--
-- TOC entry 4771 (class 2606 OID 16645)
-- Name: foodbasket_groceries foodbasket_groceries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foodbasket_groceries
    ADD CONSTRAINT foodbasket_groceries_pkey PRIMARY KEY (foodbasket_id, groceries_id);


--
-- TOC entry 4765 (class 2606 OID 16615)
-- Name: foodbasket foodbasket_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foodbasket
    ADD CONSTRAINT foodbasket_pkey PRIMARY KEY (foodbasket_id);


--
-- TOC entry 4769 (class 2606 OID 16635)
-- Name: groceries groceries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groceries
    ADD CONSTRAINT groceries_pkey PRIMARY KEY (groceries_id);


--
-- TOC entry 4767 (class 2606 OID 16630)
-- Name: supplier supplier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_pkey PRIMARY KEY (supplier_id);


--
-- TOC entry 4761 (class 2606 OID 16595)
-- Name: volunteer volunteer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volunteer
    ADD CONSTRAINT volunteer_pkey PRIMARY KEY (volunteer_id);


--
-- TOC entry 4773 (class 2606 OID 16606)
-- Name: family family_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family
    ADD CONSTRAINT family_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.city(city_id);


--
-- TOC entry 4774 (class 2606 OID 16616)
-- Name: foodbasket foodbasket_family_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foodbasket
    ADD CONSTRAINT foodbasket_family_id_fkey FOREIGN KEY (family_id) REFERENCES public.family(family_id);


--
-- TOC entry 4777 (class 2606 OID 16646)
-- Name: foodbasket_groceries foodbasket_groceries_foodbasket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foodbasket_groceries
    ADD CONSTRAINT foodbasket_groceries_foodbasket_id_fkey FOREIGN KEY (foodbasket_id) REFERENCES public.foodbasket(foodbasket_id);


--
-- TOC entry 4778 (class 2606 OID 16651)
-- Name: foodbasket_groceries foodbasket_groceries_groceries_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foodbasket_groceries
    ADD CONSTRAINT foodbasket_groceries_groceries_id_fkey FOREIGN KEY (groceries_id) REFERENCES public.groceries(groceries_id);


--
-- TOC entry 4775 (class 2606 OID 16621)
-- Name: foodbasket foodbasket_volunteer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foodbasket
    ADD CONSTRAINT foodbasket_volunteer_id_fkey FOREIGN KEY (volunteer_id) REFERENCES public.volunteer(volunteer_id);


--
-- TOC entry 4776 (class 2606 OID 16636)
-- Name: groceries groceries_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groceries
    ADD CONSTRAINT groceries_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.supplier(supplier_id);


--
-- TOC entry 4772 (class 2606 OID 16596)
-- Name: volunteer volunteer_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volunteer
    ADD CONSTRAINT volunteer_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.city(city_id);


-- Completed on 2025-11-04 16:07:41

--
-- PostgreSQL database dump complete
--

