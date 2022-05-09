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
-- Name: scorecards; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.scorecards AS
 WITH scores_with_adjusted_par AS (
         SELECT scores.total_count,
            scores.created_at,
            scores.updated_at,
            scores.putt_count,
            scores.lost_ball_count,
            scores.id,
            scores.match_id,
            scores.hole_id,
            scores.player_id,
            holes.par,
            holes.stroke,
            holes.meters,
            holes.number,
            holes.created_at,
            holes.updated_at,
            holes.id,
            holes.course_id,
            players.first_name,
            players.last_name,
            players.username,
            players.strengths,
            players.weaknesses,
            players.handicap_text,
            players.handicap,
            players.created_at,
            players.updated_at,
            players.best_moment,
            players.nick_name,
            players.home_club,
            players.trophies,
            players.id,
            players.team_id,
                CASE
                    WHEN ((holes.stroke)::numeric <= players.handicap) THEN (holes.par + 1)
                    WHEN ((holes.stroke)::numeric <= (players.handicap - (18)::numeric)) THEN (holes.par + 2)
                    ELSE holes.par
                END AS adjusted_par
           FROM ((public.scores
             JOIN public.holes ON ((scores.hole_id = holes.id)))
             JOIN public.players ON ((scores.player_id = players.id)))
        )
 SELECT scores_with_adjusted_par.number,
    scores_with_adjusted_par.total_count,
    scores_with_adjusted_par.adjusted_par,
    scores_with_adjusted_par.match_id,
    scores_with_adjusted_par.hole_id,
    scores_with_adjusted_par.player_id,
        CASE
            WHEN (scores_with_adjusted_par.total_count = (scores_with_adjusted_par.adjusted_par + 1)) THEN 1
            WHEN (scores_with_adjusted_par.total_count = scores_with_adjusted_par.adjusted_par) THEN 2
            WHEN (scores_with_adjusted_par.total_count = (scores_with_adjusted_par.adjusted_par - 1)) THEN 3
            WHEN (scores_with_adjusted_par.total_count = (scores_with_adjusted_par.adjusted_par - 2)) THEN 4
            WHEN (scores_with_adjusted_par.total_count = (scores_with_adjusted_par.adjusted_par - 3)) THEN 5
            ELSE 0
        END AS points
   FROM scores_with_adjusted_par scores_with_adjusted_par(total_count, created_at, updated_at, putt_count, lost_ball_count, id, match_id, hole_id, player_id, par, stroke, meters, number, created_at_1, updated_at_1, id_1, course_id, first_name, last_name, username, strengths, weaknesses, handicap_text, handicap, created_at_2, updated_at_2, best_moment, nick_name, home_club, trophies, id_2, team_id, adjusted_par);


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
-- Name: holes fk_rails_6d0dd30f7d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.holes
    ADD CONSTRAINT fk_rails_6d0dd30f7d FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- Name: match_teams fk_rails_82ba98b0ef; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.match_teams
    ADD CONSTRAINT fk_rails_82ba98b0ef FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: match_teams fk_rails_8742c22c55; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.match_teams
    ADD CONSTRAINT fk_rails_8742c22c55 FOREIGN KEY (match_id) REFERENCES public.matches(id);


--
-- Name: players fk_rails_8880a915a5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT fk_rails_8880a915a5 FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: matches fk_rails_e250e03790; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT fk_rails_e250e03790 FOREIGN KEY (course_id) REFERENCES public.courses(id);


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
('20220424193150'),
('20220427075713'),
('20220508053131'),
('20220508184027');


