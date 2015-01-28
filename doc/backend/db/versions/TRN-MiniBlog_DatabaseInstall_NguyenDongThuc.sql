CREATE DATABASE IF NOT EXISTS miniblog CHARACTER SET utf8 COLLATE utf8_general_ci; 
 
-- Use database 

USE miniblog; 

-- create user table

CREATE TABLE IF NOT EXISTS `miniblog`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `gender` TINYINT(1) NULL,
  `address` VARCHAR(150) NULL,
  `birthday` DATETIME NULL,
  `created_at` DATETIME NOT NULL,
  fulltext(`username`,`firstname`,`lastname`),
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- create post table

CREATE TABLE IF NOT EXISTS `miniblog`.`post` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `description` VARCHAR(250) NOT NULL,
  `content` VARCHAR(1200) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  `user_id` INT NOT NULL,
  fulltext(`description`),
  PRIMARY KEY (`id`, `user_id`),
  INDEX `fk_post_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_post_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `miniblog`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- create comment table

CREATE TABLE IF NOT EXISTS `miniblog`.`comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(250) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  `post_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`, `post_id`, `user_id`),
  INDEX `fk_comment_post1_idx` (`post_id` ASC),
  INDEX `fk_comment_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_comment_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `miniblog`.`post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `miniblog`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- create token table

CREATE TABLE IF NOT EXISTS `miniblog`.`token` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `token` VARCHAR(100) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `expire_at` DATETIME NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`, `user_id`),
  INDEX `fk_token_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_token_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `miniblog`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB