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
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: courses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.courses (
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    id uuid DEFAULT public.gen_random_uuid() NOT NULL
);


--
-- Name: holes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.holes (
    par integer,
    stroke integer,
    meters integer,
    number integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    course_id uuid DEFAULT public.gen_random_uuid() NOT NULL
);


--
-- Name: match_teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.match_teams (
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    match_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    team_id uuid DEFAULT public.gen_random_uuid() NOT NULL
);


--
-- Name: matches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.matches (
    date date,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    course_id uuid DEFAULT public.gen_random_uuid() NOT NULL
);


--
-- Name: players; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.players (
    first_name character varying,
    last_name character varying,
    username character varying,
    strengths text,
    weaknesses text,
    handicap_text character varying,
    handicap numeric NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    best_moment text,
    nick_name character varying,
    home_club character varying,
    trophies character varying,
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    team_id uuid DEFAULT public.gen_random_uuid() NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: scores; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scores (
    total_count integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    putt_count integer,
    lost_ball_count integer,
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    match_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    hole_id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    player_id uuid DEFAULT public.gen_random_uuid() NOT NULL
);


--
-- Name: teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teams (
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    id uuid DEFAULT public.gen_random_uuid() NOT NULL
);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: holes holes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.holes
    ADD CONSTRAINT holes_pkey PRIMARY KEY (id);


--
-- Name: match_teams match_teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.match_teams
    ADD CONSTRAINT match_teams_pkey PRIMARY KEY (id);


--
-- Name: matches matches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_pkey PRIMARY KEY (id);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: scores scores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scores
    ADD CONSTRAINT scores_pkey PRIMARY KEY (id);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: scores; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.scores ENABLE ROW LEVEL SECURITY;

--
-- Name: scores update_match_score; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY update_match_score ON public.scores USING (('money'::name = CURRENT_USER));


--
-- Name: scores view_all_player_scores; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY view_all_player_scores ON public.scores FOR SELECT USING (true);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20220403050456'),
('20220403054418'),
('20220403071640'),
('20220403072410'),
('20220403072920'),
('20220405041405'),
('20220408083340'),
('20220408083737'),
('20220411173005'),
('20220411173158'),
('20220411173308'),
('20220411173635'),
('20220414180622'),
('20220416190052'),
('20220424085406'),
('20220424085825'),
('20220424093839'),
('20220424193150');


