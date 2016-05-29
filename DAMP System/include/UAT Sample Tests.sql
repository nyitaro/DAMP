SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `DAMP` ;
CREATE SCHEMA IF NOT EXISTS `DAMP` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `DAMP` ;

-- -----------------------------------------------------
-- Table `DAMP`.`venue`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DAMP`.`venue` ;

CREATE TABLE IF NOT EXISTS `DAMP`.`venue` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `stadium` VARCHAR(45) NULL,
  `town` VARCHAR(45) NULL,
  `referred_as` VARCHAR(40) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DAMP`.`title`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DAMP`.`title` ;

CREATE TABLE IF NOT EXISTS `DAMP`.`title` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(10) NULL,
  `referred_as` VARCHAR(40) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DAMP`.`supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DAMP`.`supplier` ;

CREATE TABLE IF NOT EXISTS `DAMP`.`supplier` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `goodsAndServices` VARCHAR(45) NULL,
  `based` VARCHAR(45) NULL,
  `referred_as` VARCHAR(40) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DAMP`.`driver`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DAMP`.`driver` ;

CREATE TABLE IF NOT EXISTS `DAMP`.`driver` (
  `id` INT NULL AUTO_INCREMENT,
  `title_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `supplier_id` INT NOT NULL,
  `referred_as` VARCHAR(40) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_driver_title_idx` (`title_id` ASC),
  INDEX `fk_driver_supplier1_idx` (`supplier_id` ASC),
  CONSTRAINT `fk_driver_title`
    FOREIGN KEY (`title_id`)
    REFERENCES `DAMP`.`title` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_driver_supplier1`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `DAMP`.`supplier` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DAMP`.`vehicle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DAMP`.`vehicle` ;

CREATE TABLE IF NOT EXISTS `DAMP`.`vehicle` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `make` VARCHAR(45) NULL,
  `model` VARCHAR(45) NULL,
  `registration` VARCHAR(45) NULL,
  `supplier_id` INT NOT NULL,
  `referred_as` VARCHAR(40) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_vehicle_supplier1_idx` (`supplier_id` ASC),
  CONSTRAINT `fk_vehicle_supplier1`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `DAMP`.`supplier` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DAMP`.`delivery`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DAMP`.`delivery` ;

CREATE TABLE IF NOT EXISTS `DAMP`.`delivery` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `venue_id` INT NOT NULL,
  `driver_id` INT NOT NULL,
  `vehicle_id` INT NOT NULL,
  `referred_as` VARCHAR(40) NULL,
  `date` DATETIME NULL,
  INDEX `fk_delivery_driver1_idx` (`driver_id` ASC),
  INDEX `fk_delivery_venue1_idx` (`venue_id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_delivery_vehicle1_idx` (`vehicle_id` ASC),
  CONSTRAINT `fk_delivery_driver1`
    FOREIGN KEY (`driver_id`)
    REFERENCES `DAMP`.`driver` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_delivery_venue1`
    FOREIGN KEY (`venue_id`)
    REFERENCES `DAMP`.`venue` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_delivery_vehicle1`
    FOREIGN KEY (`vehicle_id`)
    REFERENCES `DAMP`.`vehicle` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DAMP`.`state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DAMP`.`state` ;

CREATE TABLE IF NOT EXISTS `DAMP`.`state` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `state` VARCHAR(45) NULL,
  `referred_as` VARCHAR(40) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DAMP`.`card`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DAMP`.`card` ;

CREATE TABLE IF NOT EXISTS `DAMP`.`card` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `driver_id` INT NOT NULL,
  `startDate` DATETIME NULL,
  `endDate` DATETIME NULL,
  `state_id` INT NOT NULL,
  `referred_as` VARCHAR(40) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_card_driver1_idx` (`driver_id` ASC),
  INDEX `fk_card_state1_idx` (`state_id` ASC),
  CONSTRAINT `fk_card_driver1`
    FOREIGN KEY (`driver_id`)
    REFERENCES `DAMP`.`driver` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_card_state1`
    FOREIGN KEY (`state_id`)
    REFERENCES `DAMP`.`state` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DAMP`.`entry_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DAMP`.`entry_log` ;

CREATE TABLE IF NOT EXISTS `DAMP`.`entry_log` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `driver_id` INT NOT NULL,
  `vehicle_id` INT NOT NULL,
  `venue_id` INT NOT NULL,
  `allowed` TINYINT(1) NULL,
  `date` DATETIME NULL,
  `referred_as` VARCHAR(40) NULL,
  INDEX `fk_entry_log_driver1_idx` (`driver_id` ASC),
  INDEX `fk_entry_log_vehicle1_idx` (`vehicle_id` ASC),
  INDEX `fk_entry_log_venue1_idx` (`venue_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_entry_log_driver1`
    FOREIGN KEY (`driver_id`)
    REFERENCES `DAMP`.`driver` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_entry_log_vehicle1`
    FOREIGN KEY (`vehicle_id`)
    REFERENCES `DAMP`.`vehicle` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_entry_log_venue1`
    FOREIGN KEY (`venue_id`)
    REFERENCES `DAMP`.`venue` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DAMP`.`accounts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DAMP`.`accounts` ;

CREATE TABLE IF NOT EXISTS `DAMP`.`accounts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(8) NULL,
  `password` VARCHAR(64) NULL,
  `access_level` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `DAMP`.`venue`
-- -----------------------------------------------------
START TRANSACTION;
USE `DAMP`;
INSERT INTO `DAMP`.`venue` (`id`, `stadium`, `town`, `referred_as`) VALUES (1, 'Arena da Sao Paulo', 'São Paulo', 'Arena da Sao Paulo');
INSERT INTO `DAMP`.`venue` (`id`, `stadium`, `town`, `referred_as`) VALUES (2, 'Estádio do Maracanã', 'Rio de Janeiro', 'Estádio do Maracanã');
INSERT INTO `DAMP`.`venue` (`id`, `stadium`, `town`, `referred_as`) VALUES (3, 'Arena da Baixada', 'Curituba', 'Arena da Baixada');
INSERT INTO `DAMP`.`venue` (`id`, `stadium`, `town`, `referred_as`) VALUES (4, 'Estádio Beira-Rio', 'Porto Alegre', 'Estádio Beira-Rio');

COMMIT;


-- -----------------------------------------------------
-- Data for table `DAMP`.`title`
-- -----------------------------------------------------
START TRANSACTION;
USE `DAMP`;
INSERT INTO `DAMP`.`title` (`id`, `title`, `referred_as`) VALUES (1, 'Ms', 'Ms');
INSERT INTO `DAMP`.`title` (`id`, `title`, `referred_as`) VALUES (2, 'Mrs', 'Mrs');
INSERT INTO `DAMP`.`title` (`id`, `title`, `referred_as`) VALUES (3, 'Mr', 'Mr');
INSERT INTO `DAMP`.`title` (`id`, `title`, `referred_as`) VALUES (4, 'Dr', 'Dr');

COMMIT;


-- -----------------------------------------------------
-- Data for table `DAMP`.`supplier`
-- -----------------------------------------------------
START TRANSACTION;
USE `DAMP`;
INSERT INTO `DAMP`.`supplier` (`id`, `name`, `goodsAndServices`, `based`, `referred_as`) VALUES (1, 'Brenny Cola', 'Drinks', 'Rio de Janeiro', 'Brenny Cola');
INSERT INTO `DAMP`.`supplier` (`id`, `name`, `goodsAndServices`, `based`, `referred_as`) VALUES (2, 'Micro Zoft', 'IT Services', 'Rio de Janeiro', 'Micro Zoft');
INSERT INTO `DAMP`.`supplier` (`id`, `name`, `goodsAndServices`, `based`, `referred_as`) VALUES (3, 'Food Stuff', 'Catering', 'Santa Cruz', 'Food Stuff');
INSERT INTO `DAMP`.`supplier` (`id`, `name`, `goodsAndServices`, `based`, `referred_as`) VALUES (5, 'Uframed', 'CCTV', 'Curitiba', 'Uframed');
INSERT INTO `DAMP`.`supplier` (`id`, `name`, `goodsAndServices`, `based`, `referred_as`) VALUES (4, 'Muscletone', 'Gym equipment', 'Santos', 'Muscletone');

COMMIT;


-- -----------------------------------------------------
-- Data for table `DAMP`.`driver`
-- -----------------------------------------------------
START TRANSACTION;
USE `DAMP`;
INSERT INTO `DAMP`.`driver` (`id`, `title_id`, `name`, `supplier_id`, `referred_as`) VALUES (1, 1, 'Carmen Miranda', 1, 'Carmen Miranda');
INSERT INTO `DAMP`.`driver` (`id`, `title_id`, `name`, `supplier_id`, `referred_as`) VALUES (2, 3, 'Dani Marinio', 1, 'Dani Marinio');
INSERT INTO `DAMP`.`driver` (`id`, `title_id`, `name`, `supplier_id`, `referred_as`) VALUES (3, 3, 'Jose Alves', 2, 'Jose Alves');
INSERT INTO `DAMP`.`driver` (`id`, `title_id`, `name`, `supplier_id`, `referred_as`) VALUES (4, 1, 'Maria Silva', 2, 'Maria Silva');
INSERT INTO `DAMP`.`driver` (`id`, `title_id`, `name`, `supplier_id`, `referred_as`) VALUES (5, 4, 'Inez Thiago', 2, 'Inez Thiago');
INSERT INTO `DAMP`.`driver` (`id`, `title_id`, `name`, `supplier_id`, `referred_as`) VALUES (6, 4, 'Vito Gelato', 3, 'Vito Gelato');
INSERT INTO `DAMP`.`driver` (`id`, `title_id`, `name`, `supplier_id`, `referred_as`) VALUES (7, 3, 'David César', 3, 'David César');
INSERT INTO `DAMP`.`driver` (`id`, `title_id`, `name`, `supplier_id`, `referred_as`) VALUES (8, 3, 'Júlio Luiz', 3, 'Júlio Luiz');
INSERT INTO `DAMP`.`driver` (`id`, `title_id`, `name`, `supplier_id`, `referred_as`) VALUES (9, 3, 'Diego Rocha', 4, 'Diego Rocha');
INSERT INTO `DAMP`.`driver` (`id`, `title_id`, `name`, `supplier_id`, `referred_as`) VALUES (10, 3, 'Marcos Alves', 5, 'Marcos Alves');
INSERT INTO `DAMP`.`driver` (`id`, `title_id`, `name`, `supplier_id`, `referred_as`) VALUES (11, 3, 'Robinho', 5, 'Robinho');

COMMIT;


-- -----------------------------------------------------
-- Data for table `DAMP`.`vehicle`
-- -----------------------------------------------------
START TRANSACTION;
USE `DAMP`;
INSERT INTO `DAMP`.`vehicle` (`id`, `make`, `model`, `registration`, `supplier_id`, `referred_as`) VALUES (1, 'Renault', 'Master', 'A02 TLC', 1, 'A02 TLC');
INSERT INTO `DAMP`.`vehicle` (`id`, `make`, `model`, `registration`, `supplier_id`, `referred_as`) VALUES (2, 'Renault', 'Kangoo', 'B03 PPD', 1, 'B03 PPD');
INSERT INTO `DAMP`.`vehicle` (`id`, `make`, `model`, `registration`, `supplier_id`, `referred_as`) VALUES (3, 'Vauxhall', 'Vivaro', 'C04 DFD', 2, 'C04 DFD');
INSERT INTO `DAMP`.`vehicle` (`id`, `make`, `model`, `registration`, `supplier_id`, `referred_as`) VALUES (4, 'Ford', 'Transit', 'D05 RAM', 3, 'D05 RAM');
INSERT INTO `DAMP`.`vehicle` (`id`, `make`, `model`, `registration`, `supplier_id`, `referred_as`) VALUES (5, 'Ford', 'Transit', 'E06 ROM', 3, 'E06 ROM');
INSERT INTO `DAMP`.`vehicle` (`id`, `make`, `model`, `registration`, `supplier_id`, `referred_as`) VALUES (6 , 'Ford', 'Transit', 'F07 CPU', 3, 'F07 CPU');
INSERT INTO `DAMP`.`vehicle` (`id`, `make`, `model`, `registration`, `supplier_id`, `referred_as`) VALUES (7, 'Vauxhall', 'Vivaro', 'G08 PHP', 4, 'G08 PHP');
INSERT INTO `DAMP`.`vehicle` (`id`, `make`, `model`, `registration`, `supplier_id`, `referred_as`) VALUES (8, 'Vauxhall', 'Vivaro', 'H09 UML', 5, 'H09 UML');

COMMIT;


-- -----------------------------------------------------
-- Data for table `DAMP`.`delivery`
-- -----------------------------------------------------
START TRANSACTION;
USE `DAMP`;
INSERT INTO `DAMP`.`delivery` (`id`, `venue_id`, `driver_id`, `vehicle_id`, `referred_as`, `date`) VALUES (1, 1, 6, 4, '1', '12/06/2014');
INSERT INTO `DAMP`.`delivery` (`id`, `venue_id`, `driver_id`, `vehicle_id`, `referred_as`, `date`) VALUES (2, 3, 8, 5, '2', '12/06/2014');
INSERT INTO `DAMP`.`delivery` (`id`, `venue_id`, `driver_id`, `vehicle_id`, `referred_as`, `date`) VALUES (3, 3, 2, 2, '3', '12/06/2014');
INSERT INTO `DAMP`.`delivery` (`id`, `venue_id`, `driver_id`, `vehicle_id`, `referred_as`, `date`) VALUES (4, 2, 10, 8, '4', '15/06/2014');
INSERT INTO `DAMP`.`delivery` (`id`, `venue_id`, `driver_id`, `vehicle_id`, `referred_as`, `date`) VALUES (5, 1, 7, 5, '5', '15/06/2014');
INSERT INTO `DAMP`.`delivery` (`id`, `venue_id`, `driver_id`, `vehicle_id`, `referred_as`, `date`) VALUES (6, 3, 8, 6, '6', '18/06/2014');
INSERT INTO `DAMP`.`delivery` (`id`, `venue_id`, `driver_id`, `vehicle_id`, `referred_as`, `date`) VALUES (7, 4, 2, 1, '7', '20/06/2014');
INSERT INTO `DAMP`.`delivery` (`id`, `venue_id`, `driver_id`, `vehicle_id`, `referred_as`, `date`) VALUES (8, 1, 6, 4, '8', '29/06/2014');

COMMIT;


-- -----------------------------------------------------
-- Data for table `DAMP`.`state`
-- -----------------------------------------------------
START TRANSACTION;
USE `DAMP`;
INSERT INTO `DAMP`.`state` (`id`, `state`, `referred_as`) VALUES (1, 'valid', 'valid');
INSERT INTO `DAMP`.`state` (`id`, `state`, `referred_as`) VALUES (2, 'expired', 'expired');
INSERT INTO `DAMP`.`state` (`id`, `state`, `referred_as`) VALUES (3, 'cancelled', 'cancelled');

COMMIT;


-- -----------------------------------------------------
-- Data for table `DAMP`.`entry_log`
-- -----------------------------------------------------
START TRANSACTION;
USE `DAMP`;
INSERT INTO `DAMP`.`entry_log` (`id`, `driver_id`, `vehicle_id`, `venue_id`, `allowed`, `date`, `referred_as`) VALUES (1, 6, 4, 1, true, '12/06/2014', '1');
INSERT INTO `DAMP`.`entry_log` (`id`, `driver_id`, `vehicle_id`, `venue_id`, `allowed`, `date`, `referred_as`) VALUES (2, 7, 5, 1, true, '15/06/2014', '2');
INSERT INTO `DAMP`.`entry_log` (`id`, `driver_id`, `vehicle_id`, `venue_id`, `allowed`, `date`, `referred_as`) VALUES (3, 8, 6, 3, true, '18/06/2014', '3');
INSERT INTO `DAMP`.`entry_log` (`id`, `driver_id`, `vehicle_id`, `venue_id`, `allowed`, `date`, `referred_as`) VALUES (4, 8, 4, 1, false, '12/06/2014', '4');
INSERT INTO `DAMP`.`entry_log` (`id`, `driver_id`, `vehicle_id`, `venue_id`, `allowed`, `date`, `referred_as`) VALUES (5, 6, 6, 1, false, '12/06/2014', '5');
INSERT INTO `DAMP`.`entry_log` (`id`, `driver_id`, `vehicle_id`, `venue_id`, `allowed`, `date`, `referred_as`) VALUES (6, 6, 4, 1, false, '13/06/2014', '6');
INSERT INTO `DAMP`.`entry_log` (`id`, `driver_id`, `vehicle_id`, `venue_id`, `allowed`, `date`, `referred_as`) VALUES (7, 6, 4, 3, false, '12/06/2014', '7');
INSERT INTO `DAMP`.`entry_log` (`id`, `driver_id`, `vehicle_id`, `venue_id`, `allowed`, `date`, `referred_as`) VALUES (8, 6, 4, 1, false, '29/06/2014', '8');

COMMIT;


-- -----------------------------------------------------
-- Data for table `DAMP`.`accounts`
-- -----------------------------------------------------
START TRANSACTION;
USE `DAMP`;
INSERT INTO `DAMP`.`accounts` (`id`, `username`, `password`, `access_level`) VALUES (1, 'admin', 'admin', 1);

COMMIT;

