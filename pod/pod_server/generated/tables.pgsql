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


