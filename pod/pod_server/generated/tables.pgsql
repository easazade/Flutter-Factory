--
-- Class Secret as table secrets
--

CREATE TABLE "secrets" (
  "id" serial,
  "phrase" text NOT NULL,
  "publicKey" text NOT NULL,
  "privateKey" text
);

ALTER TABLE ONLY "secrets"
  ADD CONSTRAINT secrets_pkey PRIMARY KEY (id);


--
-- Class Todo as table todos
--

CREATE TABLE "todos" (
  "id" serial,
  "name" text NOT NULL,
  "isDone" boolean NOT NULL
);

ALTER TABLE ONLY "todos"
  ADD CONSTRAINT todos_pkey PRIMARY KEY (id);


--
-- Class User as table users
--

CREATE TABLE "users" (
  "id" serial,
  "username" text NOT NULL,
  "password" text
);

ALTER TABLE ONLY "users"
  ADD CONSTRAINT users_pkey PRIMARY KEY (id);


