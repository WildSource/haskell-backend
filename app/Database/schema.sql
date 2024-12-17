DROP DATABASE IF EXISTS test;
CREATE DATABASE test;

USE test;

DROP TABLE IF EXISTS comic;
CREATE TABLE comic (
  comic_id INT AUTO_INCREMENT PRIMARY KEY,
  comic_title TINYTEXT,
  comic_cover TEXT,
  comic_desc TEXT, 
  comic_create_dt DATE DEFAULT CURRENT_DATE(),
  comic_update_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS page;
CREATE TABLE page (
  page_id INT AUTO_INCREMENT PRIMARY KEY,
  page_index INT,
  page_path TEXT,
  fk_comic_id INT,
  FOREIGN KEY (fk_comic_id) REFERENCES comic (comic_id)
  ON DELETE CASCADE
);

DROP TABLE IF EXISTS tag;
CREATE TABLE tag (
  tag_id INT AUTO_INCREMENT PRIMARY KEY,
  tag_name VARCHAR(15),
  fk_comic_id INT,
  FOREIGN KEY (fk_comic_id) REFERENCES comic (comic_id)
);

-- This table is a junction table for Many-To-Many relationship between comic and tag
DROP TABLE IF EXISTS comic_tag;
CREATE TABLE comic_tag (
  fk_comic_id INT,
  fk_tag_id INT,
  PRIMARY KEY (fk_comic_id, fk_tag_id),
  FOREIGN KEY (fk_comic_id) REFERENCES comic (comic_id),
  FOREIGN KEY (fk_tag_id) REFERENCES tag (tag_id)
);

DROP TABLE IF EXISTS commentary;
CREATE TABLE commentary (
  commentary_id INT AUTO_INCREMENT PRIMARY KEY,
  commentary_email VARCHAR(30) NOT NULL, 
  commentary_content TEXT,
  commentary_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  fk_comic_id INT,
  FOREIGN KEY (fk_comic_id) REFERENCES comic (comic_id)
);

DROP TABLE IF EXISTS session_id;
CREATE TABLE session_id (
  session_id BINARY(16) PRIMARY KEY
);
