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
  FOREIGN KEY (fk_comic_id) REFERENCES comic(comic_id)
  ON DELETE CASCADE
);
