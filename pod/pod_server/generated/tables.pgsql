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

CREATE INDEX username_idx ON "users" USING btree ("username");


--
-- Class ProfileImages as table profile_images
--

CREATE TABLE "profile_images" (
  "id" serial,
  "userId" integer NOT NULL,
  "avatar" text,
  "avatarThumbnail" text,
  "cover" text
);

ALTER TABLE ONLY "profile_images"
  ADD CONSTRAINT profile_images_pkey PRIMARY KEY (id);

ALTER TABLE ONLY "profile_images"
  ADD CONSTRAINT profile_images_fk_0
    FOREIGN KEY("userId")
      REFERENCES users(id)
        ON DELETE CASCADE;

