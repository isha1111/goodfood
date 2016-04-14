-- creating databse
CREATE Database goodfoofhunting;
-- connecting to databse
\c goodfoofhunting
-- creating table inside the database
CREATE TABLE dishes (
	id serial4 PRIMARY KEY,
	name VARCHAR(50),
	image_url VARCHAR(300)
);
ALTER TABLE dishes ADD dish_type_id INTEGER;
CREATE TABLE comments (
	id SERIAL4 PRIMARY KEY,
	body VARCHAR(800) NOT NULL,
	dish_id INTEGER
);

CREATE TABLE dish_types (
	id serial4 PRIMARY KEY,
	name VARCHAR(100) NOT NULL
);


INSERT INTO dishes (name, image_url) VALUES ('granola-with-fruit','http://www.mixmyown.com/images_upload/images/blog/granola-with-fruit.jpg');

INSERT INTO dish_types (name) VALUES ('snack');
INSERT INTO dish_types (name) VALUES ('dessert');
INSERT INTO dish_types (name) VALUES ('lunch');
