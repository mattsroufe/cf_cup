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


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: tablefunc; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;


--
-- Name: EXTENSION tablefunc; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL
);


--
-- Name: courses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.courses (
    name character varying,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: holes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.holes (
    par integer,
    stroke integer,
    meters integer,
    number integer,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    course_id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: match_players; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.match_players (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    match_id uuid NOT NULL,
    player_id uuid NOT NULL,
    handicap numeric NOT NULL,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL
);


--
-- Name: match_teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.match_teams (
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    match_id uuid DEFAULT gen_random_uuid() NOT NULL,
    team_id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: matches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.matches (
    date date,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    course_id uuid DEFAULT gen_random_uuid() NOT NULL
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
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL,
    best_moment text,
    nick_name character varying,
    home_club character varying,
    trophies character varying,
    id uuid DEFAULT gen_random_uuid() NOT NULL
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
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL,
    putt_count integer,
    lost_ball_count integer,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    match_id uuid DEFAULT gen_random_uuid() NOT NULL,
    hole_id uuid DEFAULT gen_random_uuid() NOT NULL,
    player_id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: team_players; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.team_players (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    team_id uuid NOT NULL,
    player_id uuid NOT NULL,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL
);


--
-- Name: scorecards; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.scorecards AS
 WITH q0 AS (
         SELECT holes.number,
            holes.par,
            holes.stroke,
            scores.total_count AS gross_score,
            match_players.handicap,
            ceil((GREATEST((match_players.handicap - (holes.stroke)::numeric), (0)::numeric) / (18)::numeric)) AS strokes_given,
            scores.hole_id,
            scores.match_id,
            scores.player_id,
            team_players.team_id
           FROM (((public.scores
             JOIN public.holes ON ((scores.hole_id = holes.id)))
             JOIN public.match_players USING (player_id))
             JOIN public.team_players USING (player_id))
        ), q1 AS (
         SELECT q0.match_id,
            q0.number,
            q0.gross_score,
            q0.player_id,
            q0.hole_id,
            q0.par,
            q0.stroke,
            q0.strokes_given,
            ((q0.par)::numeric + q0.strokes_given) AS adjusted_par,
            q0.team_id
           FROM q0
        ), q2 AS (
         SELECT q1.team_id,
            q1.number,
            q1.par,
            q1.stroke,
            q1.strokes_given,
            q1.gross_score,
            q1.adjusted_par,
            q1.match_id,
            q1.hole_id,
            q1.player_id,
                CASE
                    WHEN ((q1.gross_score)::numeric = (q1.adjusted_par + (1)::numeric)) THEN 1
                    WHEN ((q1.gross_score)::numeric = q1.adjusted_par) THEN 2
                    WHEN ((q1.gross_score)::numeric = (q1.adjusted_par - (1)::numeric)) THEN 3
                    WHEN ((q1.gross_score)::numeric = (q1.adjusted_par - (2)::numeric)) THEN 4
                    WHEN ((q1.gross_score)::numeric = (q1.adjusted_par - (3)::numeric)) THEN 5
                    ELSE 0
                END AS points
           FROM q1
        ), q3 AS (
         SELECT q2.team_id,
            q2.number,
            q2.par,
            q2.stroke,
            q2.strokes_given,
            q2.gross_score,
            q2.adjusted_par,
            q2.match_id,
            q2.hole_id,
            q2.player_id,
            q2.points,
            max(q2.points) OVER (PARTITION BY q2.hole_id, q2.team_id ORDER BY q2.points DESC) AS team_points
           FROM q2
        )
 SELECT min((q3.match_id)::text) AS match_id,
    min((q3.hole_id)::text) AS hole_id,
    min((q3.team_id)::text) AS team_id,
    min(q3.gross_score) AS gross_score,
    min(q3.points) AS points,
    min(q3.team_points) AS team_points,
    min(q3.par) AS par,
    min(q3.stroke) AS stroke,
    q3.player_id,
    q3.number,
    sum(q3.gross_score) AS total_score,
    sum(q3.points) AS total_points,
    sum(q3.team_points) AS total_team_points
   FROM q3
  GROUP BY ROLLUP(q3.player_id, q3.number)
  ORDER BY q3.player_id, q3.number;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teams (
    name character varying,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
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
-- Name: match_players match_players_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.match_players
    ADD CONSTRAINT match_players_pkey PRIMARY KEY (id);


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
-- Name: team_players team_players_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.team_players
    ADD CONSTRAINT team_players_pkey PRIMARY KEY (id);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: index_match_players_on_match_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_match_players_on_match_id ON public.match_players USING btree (match_id);


--
-- Name: index_match_players_on_match_id_and_player_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_match_players_on_match_id_and_player_id ON public.match_players USING btree (match_id, player_id);


--
-- Name: index_match_players_on_player_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_match_players_on_player_id ON public.match_players USING btree (player_id);


--
-- Name: index_team_players_on_player_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_team_players_on_player_id ON public.team_players USING btree (player_id);


--
-- Name: index_team_players_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_team_players_on_team_id ON public.team_players USING btree (team_id);


--
-- Name: index_team_players_on_team_id_and_player_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_team_players_on_team_id_and_player_id ON public.team_players USING btree (team_id, player_id);


--
-- Name: scores fk_rails_3c6cd6d6f8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scores
    ADD CONSTRAINT fk_rails_3c6cd6d6f8 FOREIGN KEY (match_id) REFERENCES public.matches(id);


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
('20220508184027'),
('20220511080405'),
('20220616180842'),
('20220616192358'),
('20220616232225'),
('20220617215915'),
('20220618224334'),
('20220618225920');


