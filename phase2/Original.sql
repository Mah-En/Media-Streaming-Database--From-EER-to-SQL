CREATE TABLE "follows" (
  "following_user_id" integer,
  "followed_user_id" integer,
  "created_at" timestamp
);

CREATE TABLE "users" (
  "id" integer PRIMARY KEY,
  "username" varchar,
  "role" varchar,
  "created_at" timestamp
);

CREATE TABLE "posts" (
  "id" integer PRIMARY KEY,
  "title" varchar,
  "body" text,
  "user_id" integer,
  "status" varchar,
  "created_at" timestamp
);

CREATE TABLE "User" (
  "UserID" INT PRIMARY KEY NOT NULL,
  "Username" VARCHAR(255) UNIQUE NOT NULL,
  "Password" VARCHAR(255) NOT NULL,
  "Email" VARCHAR(255) UNIQUE NOT NULL,
  "SubscriptionTier" VARCHAR(50) NOT NULL,
  "SubscriptionStartDate" DATE NOT NULL,
  "SubscriptionEndDate" DATE NOT NULL
);

CREATE TABLE "Payment" (
  "PaymentID" INT PRIMARY KEY NOT NULL,
  "UserID" INT NOT NULL,
  "AmountPaid" DECIMAL(10,2) NOT NULL,
  "SubscriptionID" INT NOT NULL
);

CREATE TABLE "Media" (
  "MediaID" INT PRIMARY KEY NOT NULL,
  "Title" VARCHAR(255) NOT NULL,
  "Type" VARCHAR(50) NOT NULL,
  "Genre" VARCHAR(100) NOT NULL,
  "ProductionYear" YEAR NOT NULL,
  "AverageRatingScore" FLOAT DEFAULT 0,
  "Director" VARCHAR(255) NOT NULL,
  "Actors" TEXT NOT NULL,
  "Producers" TEXT NOT NULL,
  "Comments" TEXT
);

CREATE TABLE "Company" (
  "CompanyID" INT PRIMARY KEY NOT NULL,
  "Name" VARCHAR(255) NOT NULL,
  "YearOfEstablishment" YEAR NOT NULL,
  "PhoneNumber" VARCHAR(20) NOT NULL,
  "Location" VARCHAR(255) NOT NULL,
  "Email" VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE "Comment" (
  "CommentID" INT PRIMARY KEY NOT NULL,
  "UserID" INT NOT NULL,
  "MediaID" INT NOT NULL,
  "Text" TEXT NOT NULL
);

CREATE TABLE "Episode" (
  "EpisodeID" INT PRIMARY KEY NOT NULL,
  "SeriesID" INT NOT NULL,
  "Title" VARCHAR(255) NOT NULL,
  "StorageID" INT NOT NULL
);

CREATE TABLE "Movie" (
  "MovieID" INT PRIMARY KEY NOT NULL,
  "StorageID" INT NOT NULL,
  "MediaID" INT NOT NULL,
  "Title" VARCHAR(255) NOT NULL
);

CREATE TABLE "Series" (
  "SeriesID" INT PRIMARY KEY NOT NULL,
  "MediaID" INT UNIQUE NOT NULL,
  "Title" VARCHAR(255) NOT NULL
);

CREATE TABLE "StorageLocation" (
  "StorageID" INT PRIMARY KEY NOT NULL,
  "Server" VARCHAR(255) NOT NULL,
  "Path" VARCHAR(500) NOT NULL
);

CREATE TABLE "Rating" (
  "RatingID" INT PRIMARY KEY NOT NULL,
  "UserID" INT NOT NULL,
  "MediaID" INT NOT NULL,
  "Score" INT NOT NULL
);

CREATE TABLE "WatchLater" (
  "ListID" INT PRIMARY KEY NOT NULL,
  "UserID" INT NOT NULL,
  "MediaID" INT NOT NULL
);

COMMENT ON COLUMN "posts"."body" IS 'Content of the post';

ALTER TABLE "posts" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "follows" ADD FOREIGN KEY ("following_user_id") REFERENCES "users" ("id");

ALTER TABLE "follows" ADD FOREIGN KEY ("followed_user_id") REFERENCES "users" ("id");

ALTER TABLE "Payment" ADD FOREIGN KEY ("UserID") REFERENCES "User" ("UserID");

ALTER TABLE "Comment" ADD FOREIGN KEY ("UserID") REFERENCES "User" ("UserID");

ALTER TABLE "Comment" ADD FOREIGN KEY ("MediaID") REFERENCES "Media" ("MediaID");

ALTER TABLE "Episode" ADD FOREIGN KEY ("SeriesID") REFERENCES "Series" ("SeriesID");

ALTER TABLE "Episode" ADD FOREIGN KEY ("StorageID") REFERENCES "StorageLocation" ("StorageID");

ALTER TABLE "Movie" ADD FOREIGN KEY ("StorageID") REFERENCES "StorageLocation" ("StorageID");

ALTER TABLE "Movie" ADD FOREIGN KEY ("MediaID") REFERENCES "Media" ("MediaID");

ALTER TABLE "Series" ADD FOREIGN KEY ("MediaID") REFERENCES "Media" ("MediaID");

ALTER TABLE "Rating" ADD FOREIGN KEY ("UserID") REFERENCES "User" ("UserID");

ALTER TABLE "Rating" ADD FOREIGN KEY ("MediaID") REFERENCES "Media" ("MediaID");

ALTER TABLE "WatchLater" ADD FOREIGN KEY ("UserID") REFERENCES "User" ("UserID");

ALTER TABLE "WatchLater" ADD FOREIGN KEY ("MediaID") REFERENCES "Media" ("MediaID");
