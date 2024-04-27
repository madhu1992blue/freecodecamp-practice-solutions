--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    user_id integer NOT NULL,
    num_guesses integer
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    name character varying(22)
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (1, 3, 9);
INSERT INTO public.games VALUES (2, 3, 14);
INSERT INTO public.games VALUES (3, 13, 538);
INSERT INTO public.games VALUES (4, 14, 593);
INSERT INTO public.games VALUES (5, 13, 293);
INSERT INTO public.games VALUES (6, 13, 588);
INSERT INTO public.games VALUES (7, 13, 792);
INSERT INTO public.games VALUES (8, 16, 671);
INSERT INTO public.games VALUES (9, 16, 452);
INSERT INTO public.games VALUES (10, 17, 365);
INSERT INTO public.games VALUES (11, 17, 549);
INSERT INTO public.games VALUES (12, 16, 509);
INSERT INTO public.games VALUES (13, 16, 614);
INSERT INTO public.games VALUES (14, 16, 551);
INSERT INTO public.games VALUES (15, 18, 89);
INSERT INTO public.games VALUES (16, 18, 10);
INSERT INTO public.games VALUES (17, 19, 833);
INSERT INTO public.games VALUES (18, 19, 636);
INSERT INTO public.games VALUES (19, 18, 537);
INSERT INTO public.games VALUES (20, 18, 899);
INSERT INTO public.games VALUES (21, 18, 967);
INSERT INTO public.games VALUES (22, 20, 997);
INSERT INTO public.games VALUES (23, 20, 378);
INSERT INTO public.games VALUES (24, 21, 881);
INSERT INTO public.games VALUES (25, 21, 728);
INSERT INTO public.games VALUES (26, 20, 624);
INSERT INTO public.games VALUES (27, 20, 461);
INSERT INTO public.games VALUES (28, 20, 197);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (1, 'Madhusudan');
INSERT INTO public.users VALUES (2, 'm');
INSERT INTO public.users VALUES (3, 'MN');
INSERT INTO public.users VALUES (4, 'user_1714197626204');
INSERT INTO public.users VALUES (5, 'user_1714197626203');
INSERT INTO public.users VALUES (6, '1');
INSERT INTO public.users VALUES (7, 'user_1714198407115');
INSERT INTO public.users VALUES (8, 'user_1714198407114');
INSERT INTO public.users VALUES (9, 'user_1714198484959');
INSERT INTO public.users VALUES (10, 'user_1714198484958');
INSERT INTO public.users VALUES (11, 'user_1714198689204');
INSERT INTO public.users VALUES (12, 'user_1714198689203');
INSERT INTO public.users VALUES (13, 'user_1714198928882');
INSERT INTO public.users VALUES (14, 'user_1714198928881');
INSERT INTO public.users VALUES (15, 'MMM');
INSERT INTO public.users VALUES (16, 'user_1714199018919');
INSERT INTO public.users VALUES (17, 'user_1714199018918');
INSERT INTO public.users VALUES (18, 'user_1714199044832');
INSERT INTO public.users VALUES (19, 'user_1714199044831');
INSERT INTO public.users VALUES (20, 'user_1714199064505');
INSERT INTO public.users VALUES (21, 'user_1714199064504');


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 28, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 21, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: games games_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

