-- MySQL Script generated by MySQL Workbench
-- Fri Apr 22 08:35:52 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema sidedish
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `category` (
                                          `id` BIGINT NOT NULL AUTO_INCREMENT,
                                          `name` VARCHAR(45) NOT NULL,
    `description` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `subcategory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `subcategory` (
                                             `id` BIGINT NOT NULL AUTO_INCREMENT,
                                             `name` VARCHAR(45) NOT NULL,
    `description` VARCHAR(100) NOT NULL,
    `category_id` BIGINT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_subcategory_category1_idx` (`category_id` ASC) VISIBLE,
    CONSTRAINT `fk_subcategory_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `delivery_policy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `delivery_policy` (
                                                 `id` BIGINT NOT NULL AUTO_INCREMENT,
                                                 `description` VARCHAR(100) NOT NULL,
    `early_morning_delivery` TINYINT(1) NOT NULL,
    `nationwide_delivery` TINYINT(1) NOT NULL,
    `delivery_rate` INT NOT NULL,
    `free_delivery_threshold` INT NOT NULL,
    PRIMARY KEY (`id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `product` (
                                         `id` BIGINT NOT NULL AUTO_INCREMENT,
                                         `name` VARCHAR(45) NOT NULL,
    `description` VARCHAR(100) NOT NULL,
    `price` INT NOT NULL,
    `mileage_rate` DECIMAL NOT NULL,
    `stock` INT NOT NULL,
    `primary_image` VARCHAR(255) NOT NULL,
    `category_id` BIGINT NOT NULL,
    `subcategory_id` BIGINT NOT NULL,
    `delivery_policy_id` BIGINT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_product_category1_idx` (`category_id` ASC) VISIBLE,
    INDEX `fk_product_subcategory1_idx` (`subcategory_id` ASC) VISIBLE,
    INDEX `fk_product_delivery_policy1_idx` (`delivery_policy_id` ASC) VISIBLE,
    CONSTRAINT `fk_product_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_product_subcategory1`
    FOREIGN KEY (`subcategory_id`)
    REFERENCES `subcategory` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_product_delivery_policy1`
    FOREIGN KEY (`delivery_policy_id`)
    REFERENCES `delivery_policy` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `variant_image`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `variant_image` (
                                               `product_id` BIGINT NOT NULL,
                                               `url` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`product_id`, `url`),
    CONSTRAINT `fk_image_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `discount`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `discount` (
                                          `id` BIGINT NOT NULL AUTO_INCREMENT,
                                          `name` VARCHAR(45) NOT NULL,
    `discount_rate` DECIMAL NOT NULL,
    PRIMARY KEY (`id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `product_discount`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `product_discount` (
                                                  `product_id` BIGINT NOT NULL,
                                                  `discount_id` BIGINT NOT NULL,
                                                  PRIMARY KEY (`product_id`, `discount_id`),
    INDEX `fk_product_discount_discount1_idx` (`discount_id` ASC) VISIBLE,
    CONSTRAINT `fk_product_discount_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_product_discount_discount1`
    FOREIGN KEY (`discount_id`)
    REFERENCES `discount` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `theme`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `theme` (
                                       `id` BIGINT NOT NULL AUTO_INCREMENT,
                                       `name` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `product_theme`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `product_theme` (
                                               `product_id` BIGINT NOT NULL,
                                               `theme_id` BIGINT NOT NULL,
                                               PRIMARY KEY (`product_id`, `theme_id`),
    INDEX `fk_product_theme_theme1_idx` (`theme_id` ASC) VISIBLE,
    CONSTRAINT `fk_product_theme_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_product_theme_theme1`
    FOREIGN KEY (`theme_id`)
    REFERENCES `theme` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;