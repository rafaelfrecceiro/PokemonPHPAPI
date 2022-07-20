-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pokemongame
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pokemongame
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pokemongame` DEFAULT CHARACTER SET utf8 ;
USE `pokemongame` ;

-- -----------------------------------------------------
-- Table `pokemongame`.`pokemon_db`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemongame`.`pokemon_db` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NULL,
  `sprite_front` VARCHAR(500) NULL,
  `sprite_back` VARCHAR(500) NULL,
  `sprite_animated` VARCHAR(500) NULL,
  `base_attack` INT NULL,
  `base_defense` INT NULL,
  `base_speed` INT NULL,
  `base_hp` INT NULL,
  `base_level` INT NULL,
  `catch_level` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemongame`.`trainer_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemongame`.`trainer_roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemongame`.`trainer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemongame`.`trainer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NULL,
  `vip` TINYINT NULL,
  `coins` INT NULL,
  `money` INT NULL,
  `username` VARCHAR(45) NULL,
  `email` VARCHAR(200) NULL,
  `password` VARCHAR(45) NULL,
  `trainer_roles_id` INT NOT NULL,
  PRIMARY KEY (`id`, `trainer_roles_id`),
  INDEX `fk_trainer_trainer_roles1_idx` (`trainer_roles_id` ASC),
  CONSTRAINT `fk_trainer_trainer_roles1`
    FOREIGN KEY (`trainer_roles_id`)
    REFERENCES `pokemongame`.`trainer_roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemongame`.`pokemon_bag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemongame`.`pokemon_bag` (
  `hash_id` INT NOT NULL,
  `pokemon_id` INT NOT NULL,
  `trainer_id` INT NOT NULL,
  `level` INT NULL,
  `exp` INT NULL,
  `attack` INT NULL,
  `defense` INT NULL,
  `speed` INT NULL,
  `hp` INT NULL,
  PRIMARY KEY (`hash_id`, `pokemon_id`, `trainer_id`),
  INDEX `fk_pokemon_trainer1_idx` (`trainer_id` ASC),
  CONSTRAINT `fk_pokemon_pokemon_db`
    FOREIGN KEY (`pokemon_id`)
    REFERENCES `pokemongame`.`pokemon_db` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pokemon_trainer1`
    FOREIGN KEY (`trainer_id`)
    REFERENCES `pokemongame`.`trainer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemongame`.`item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemongame`.`item` (
  `id` INT NOT NULL,
  `name` VARCHAR(150) NULL,
  `sprite` VARCHAR(500) NULL,
  `description` VARCHAR(250) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemongame`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemongame`.`inventory` (
  `id` INT NOT NULL,
  `trainer_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  `quantity` INT NULL,
  PRIMARY KEY (`id`, `trainer_id`, `item_id`),
  INDEX `fk_inventory_trainer1_idx` (`trainer_id` ASC),
  INDEX `fk_inventory_item1_idx` (`item_id` ASC),
  CONSTRAINT `fk_inventory_trainer1`
    FOREIGN KEY (`trainer_id`)
    REFERENCES `pokemongame`.`trainer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventory_item1`
    FOREIGN KEY (`item_id`)
    REFERENCES `pokemongame`.`item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemongame`.`regions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemongame`.`regions` (
  `id` INT NOT NULL,
  `name` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemongame`.`pokemon_region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemongame`.`pokemon_region` (
  `pokemon_db_id` INT NOT NULL,
  `regions_id` INT NOT NULL,
  PRIMARY KEY (`pokemon_db_id`, `regions_id`),
  INDEX `fk_pokemon_region_regions1_idx` (`regions_id` ASC),
  CONSTRAINT `fk_pokemon_region_pokemon_db1`
    FOREIGN KEY (`pokemon_db_id`)
    REFERENCES `pokemongame`.`pokemon_db` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pokemon_region_regions1`
    FOREIGN KEY (`regions_id`)
    REFERENCES `pokemongame`.`regions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemongame`.`npcs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemongame`.`npcs` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `sprite` VARCHAR(500) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemongame`.`stores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemongame`.`stores` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `npcs_id` INT NOT NULL,
  PRIMARY KEY (`id`, `npcs_id`),
  INDEX `fk_stores_npcs1_idx` (`npcs_id` ASC),
  CONSTRAINT `fk_stores_npcs1`
    FOREIGN KEY (`npcs_id`)
    REFERENCES `pokemongame`.`npcs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemongame`.`store_region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemongame`.`store_region` (
  `regions_id` INT NOT NULL,
  `stores_id` INT NOT NULL,
  PRIMARY KEY (`regions_id`, `stores_id`),
  INDEX `fk_store_region_stores1_idx` (`stores_id` ASC),
  CONSTRAINT `fk_store_region_regions1`
    FOREIGN KEY (`regions_id`)
    REFERENCES `pokemongame`.`regions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_store_region_stores1`
    FOREIGN KEY (`stores_id`)
    REFERENCES `pokemongame`.`stores` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemongame`.`store_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemongame`.`store_items` (
  `stores_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  `price` INT NULL,
  PRIMARY KEY (`stores_id`, `item_id`),
  INDEX `fk_store_items_item1_idx` (`item_id` ASC),
  CONSTRAINT `fk_store_items_stores1`
    FOREIGN KEY (`stores_id`)
    REFERENCES `pokemongame`.`stores` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_store_items_item1`
    FOREIGN KEY (`item_id`)
    REFERENCES `pokemongame`.`item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemongame`.`missions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemongame`.`missions` (
  `id` INT NOT NULL,
  `name` VARCHAR(500) NULL,
  `level` INT NULL,
  `exp` INT NULL,
  `description` VARCHAR(500) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemongame`.`mission_rewards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemongame`.`mission_rewards` (
  `missions_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  `quantity` INT NULL,
  PRIMARY KEY (`missions_id`, `item_id`),
  INDEX `fk_mission_rewards_item1_idx` (`item_id` ASC),
  CONSTRAINT `fk_mission_rewards_missions1`
    FOREIGN KEY (`missions_id`)
    REFERENCES `pokemongame`.`missions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mission_rewards_item1`
    FOREIGN KEY (`item_id`)
    REFERENCES `pokemongame`.`item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemongame`.`region_missions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemongame`.`region_missions` (
  `regions_id` INT NOT NULL,
  `missions_id` INT NOT NULL,
  PRIMARY KEY (`regions_id`, `missions_id`),
  INDEX `fk_region_missions_missions1_idx` (`missions_id` ASC),
  CONSTRAINT `fk_region_missions_regions1`
    FOREIGN KEY (`regions_id`)
    REFERENCES `pokemongame`.`regions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_region_missions_missions1`
    FOREIGN KEY (`missions_id`)
    REFERENCES `pokemongame`.`missions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemongame`.`mission_rewards_pokemon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemongame`.`mission_rewards_pokemon` (
  `missions_id` INT NOT NULL,
  `pokemon_db_id` INT NOT NULL,
  PRIMARY KEY (`missions_id`, `pokemon_db_id`),
  INDEX `fk_mission_rewards_pokemon_pokemon_db1_idx` (`pokemon_db_id` ASC),
  CONSTRAINT `fk_mission_rewards_pokemon_missions1`
    FOREIGN KEY (`missions_id`)
    REFERENCES `pokemongame`.`missions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mission_rewards_pokemon_pokemon_db1`
    FOREIGN KEY (`pokemon_db_id`)
    REFERENCES `pokemongame`.`pokemon_db` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemongame`.`achievements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemongame`.`achievements` (
  `id` INT NOT NULL,
  `name` VARCHAR(150) NULL,
  `sprite` VARCHAR(500) NULL,
  `description` VARCHAR(500) NULL,
  `money` INT NULL,
  `coins` INT NULL,
  `exp` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemongame`.`trainer_achievements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemongame`.`trainer_achievements` (
  `trainer_id` INT NOT NULL,
  `achievements_id` INT NOT NULL,
  `date` DATETIME NULL,
  PRIMARY KEY (`trainer_id`, `achievements_id`),
  INDEX `fk_trainer_achievements_achievements1_idx` (`achievements_id` ASC),
  CONSTRAINT `fk_trainer_achievements_trainer1`
    FOREIGN KEY (`trainer_id`)
    REFERENCES `pokemongame`.`trainer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trainer_achievements_achievements1`
    FOREIGN KEY (`achievements_id`)
    REFERENCES `pokemongame`.`achievements` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemongame`.`trainer_missions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemongame`.`trainer_missions` (
  `trainer_id` INT NOT NULL,
  `missions_id` INT NOT NULL,
  `date` DATETIME NULL,
  PRIMARY KEY (`trainer_id`, `missions_id`),
  INDEX `fk_trainer_missions_missions1_idx` (`missions_id` ASC),
  CONSTRAINT `fk_trainer_missions_trainer1`
    FOREIGN KEY (`trainer_id`)
    REFERENCES `pokemongame`.`trainer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trainer_missions_missions1`
    FOREIGN KEY (`missions_id`)
    REFERENCES `pokemongame`.`missions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemongame`.`pokemon_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemongame`.`pokemon_types` (
  `id` INT NOT NULL,
  `name` VARCHAR(50) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemongame`.`pokemon_types_owned`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemongame`.`pokemon_types_owned` (
  `pokemon_db_id` INT NOT NULL,
  `pokemon_types_id` INT NOT NULL,
  PRIMARY KEY (`pokemon_db_id`, `pokemon_types_id`),
  INDEX `fk_pokemon_types_owned_pokemon_types1_idx` (`pokemon_types_id` ASC),
  CONSTRAINT `fk_pokemon_types_owned_pokemon_db1`
    FOREIGN KEY (`pokemon_db_id`)
    REFERENCES `pokemongame`.`pokemon_db` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pokemon_types_owned_pokemon_types1`
    FOREIGN KEY (`pokemon_types_id`)
    REFERENCES `pokemongame`.`pokemon_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemongame`.`pokemon_moves_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemongame`.`pokemon_moves_types` (
  `id` INT NOT NULL,
  `name` VARCHAR(50) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemongame`.`pokemon_moves`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemongame`.`pokemon_moves` (
  `id` INT NOT NULL,
  `name` VARCHAR(150) NULL,
  `description` VARCHAR(150) NULL,
  `bonus_attack` INT NULL,
  `bonus_defense` INT NULL,
  `bonus_speed` INT NULL,
  `bonus_hp` INT NULL,
  `pokemon_moves_types_id` INT NOT NULL,
  PRIMARY KEY (`id`, `pokemon_moves_types_id`),
  INDEX `fk_pokemon_moves_pokemon_moves_types1_idx` (`pokemon_moves_types_id` ASC),
  CONSTRAINT `fk_pokemon_moves_pokemon_moves_types1`
    FOREIGN KEY (`pokemon_moves_types_id`)
    REFERENCES `pokemongame`.`pokemon_moves_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pokemongame`.`pokemon_moves_owned`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pokemongame`.`pokemon_moves_owned` (
  `pokemon_db_id` INT NOT NULL,
  `pokemon_moves_id` INT NOT NULL,
  PRIMARY KEY (`pokemon_db_id`, `pokemon_moves_id`),
  INDEX `fk_pokemon_moves_owned_pokemon_moves1_idx` (`pokemon_moves_id` ASC),
  CONSTRAINT `fk_pokemon_moves_owned_pokemon_db1`
    FOREIGN KEY (`pokemon_db_id`)
    REFERENCES `pokemongame`.`pokemon_db` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pokemon_moves_owned_pokemon_moves1`
    FOREIGN KEY (`pokemon_moves_id`)
    REFERENCES `pokemongame`.`pokemon_moves` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
