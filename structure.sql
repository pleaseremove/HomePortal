-- --------------------------------------------------------
-- Host:                         192.168.0.2
-- Server version:               5.1.49 - Source distribution
-- Server OS:                    unknown-linux-gnu
-- HeidiSQL version:             7.0.0.4053
-- Date/time:                    2013-04-12 00:48:15
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;

-- Dumping database structure for home_portal
CREATE DATABASE IF NOT EXISTS `home_portal` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `home_portal`;


-- Dumping structure for table home_portal.calendar_events
CREATE TABLE IF NOT EXISTS `calendar_events` (
  `event_id` int(10) NOT NULL AUTO_INCREMENT,
  `family_id` int(10) NOT NULL DEFAULT '1',
  `private` int(10) NOT NULL DEFAULT '0',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `all_day` tinyint(1) NOT NULL DEFAULT '0',
  `important` tinyint(1) NOT NULL DEFAULT '0',
  `repeat` tinyint(1) NOT NULL DEFAULT '0',
  `created_by` int(10) NOT NULL,
  `created_datetime` datetime NOT NULL,
  PRIMARY KEY (`event_id`),
  KEY `family_id` (`family_id`),
  KEY `private` (`private`),
  KEY `title` (`title`),
  KEY `start_date` (`start_date`),
  KEY `end_date` (`end_date`),
  KEY `start_time` (`start_time`),
  KEY `end_time` (`end_time`),
  KEY `all_day` (`all_day`),
  KEY `important` (`important`),
  KEY `repeat` (`repeat`),
  KEY `created_by` (`created_by`),
  KEY `created_datetime` (`created_datetime`),
  FULLTEXT KEY `title_description` (`title`,`description`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.contacts_addresses
CREATE TABLE IF NOT EXISTS `contacts_addresses` (
  `address_id` int(8) NOT NULL AUTO_INCREMENT,
  `contact_id` int(8) NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `main` tinyint(1) NOT NULL DEFAULT '0',
  `building` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `house` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `road` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `locality` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `town` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `county` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postcode` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`address_id`),
  KEY `contact_id` (`contact_id`),
  KEY `main` (`main`),
  FULLTEXT KEY `name_house_road_town_county_postcode_country` (`name`,`house`,`road`,`town`,`county`,`postcode`,`country`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.contacts_categories
CREATE TABLE IF NOT EXISTS `contacts_categories` (
  `category_id` int(8) NOT NULL AUTO_INCREMENT,
  `description` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `family_id` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.contacts_category_links
CREATE TABLE IF NOT EXISTS `contacts_category_links` (
  `contact_id` int(8) NOT NULL,
  `category_id` int(8) NOT NULL,
  PRIMARY KEY (`contact_id`,`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.contacts_children
CREATE TABLE IF NOT EXISTS `contacts_children` (
  `contacts_child_id` int(10) NOT NULL AUTO_INCREMENT,
  `parent_1_id` int(10) NOT NULL,
  `parent_2_id` int(10) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `birthday` date DEFAULT NULL,
  PRIMARY KEY (`contacts_child_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.contacts_data
CREATE TABLE IF NOT EXISTS `contacts_data` (
  `contact_data_id` int(10) NOT NULL AUTO_INCREMENT,
  `contact_id` int(10) NOT NULL,
  `contact_data_type` int(10) NOT NULL DEFAULT '0',
  `data` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `in_use` tinyint(1) NOT NULL DEFAULT '1',
  `default` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`contact_data_id`),
  KEY `contact_id` (`contact_id`),
  KEY `contact_data_type` (`contact_data_type`),
  KEY `in_use` (`in_use`),
  FULLTEXT KEY `data` (`data`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.contacts_data_types
CREATE TABLE IF NOT EXISTS `contacts_data_types` (
  `data_type_id` int(10) NOT NULL AUTO_INCREMENT,
  `data_type_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `data_type_view_string` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `family_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`data_type_id`),
  KEY `data_type_name` (`data_type_name`),
  KEY `family_id` (`family_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.contacts_emails
CREATE TABLE IF NOT EXISTS `contacts_emails` (
  `email_id` int(8) NOT NULL AUTO_INCREMENT,
  `contact_id` int(8) NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `in_use` tinyint(1) NOT NULL DEFAULT '0',
  `default` tinyint(4) NOT NULL,
  PRIMARY KEY (`email_id`),
  KEY `contact_id` (`contact_id`),
  KEY `in_use` (`in_use`),
  KEY `email` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.contacts_main
CREATE TABLE IF NOT EXISTS `contacts_main` (
  `contact_id` int(8) NOT NULL AUTO_INCREMENT,
  `family_id` int(8) NOT NULL DEFAULT '1',
  `private` int(8) NOT NULL DEFAULT '0',
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `other_names` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `aniversary` date DEFAULT NULL,
  `picture` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8_unicode_ci,
  `title_id` int(11) DEFAULT NULL,
  `gender` tinyint(1) DEFAULT NULL COMMENT 'Null:Unknown, 0: Female, 1: Male',
  `datetime_created` datetime DEFAULT NULL,
  `datetime_updated` datetime DEFAULT NULL,
  `datetime_deleted` datetime DEFAULT NULL,
  `created_by` int(8) NOT NULL DEFAULT '0',
  `updated_by` int(11) DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`contact_id`),
  KEY `family_id` (`family_id`),
  KEY `created_by` (`created_by`),
  KEY `private` (`private`),
  KEY `first_name` (`first_name`),
  KEY `other_names` (`other_names`),
  KEY `last_name` (`last_name`),
  KEY `birthday` (`birthday`),
  KEY `aniversary` (`aniversary`),
  KEY `deleted` (`deleted`),
  FULLTEXT KEY `first_name_other_names_last_name_notes` (`first_name`,`other_names`,`last_name`,`notes`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.contacts_relations
CREATE TABLE IF NOT EXISTS `contacts_relations` (
  `contact_id` int(10) NOT NULL,
  `relation_id` int(10) NOT NULL,
  PRIMARY KEY (`contact_id`,`relation_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.contacts_titles
CREATE TABLE IF NOT EXISTS `contacts_titles` (
  `title_id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`title_id`),
  KEY `title` (`title`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.families
CREATE TABLE IF NOT EXISTS `families` (
  `family_id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `subdomain` varchar(255) NOT NULL,
  PRIMARY KEY (`family_id`),
  UNIQUE KEY `subdomain` (`subdomain`),
  KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.inventory_containers
CREATE TABLE IF NOT EXISTS `inventory_containers` (
  `container_id` int(10) NOT NULL AUTO_INCREMENT,
  `family_id` int(10) NOT NULL DEFAULT '1',
  `location_id` int(10) NOT NULL DEFAULT '0',
  `container_name` varchar(255) NOT NULL,
  `container_type` enum('card_box','plastic_box','open_space') NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`container_id`),
  KEY `location_id` (`location_id`),
  KEY `container_type` (`container_type`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.inventory_items
CREATE TABLE IF NOT EXISTS `inventory_items` (
  `invent_id` int(10) NOT NULL AUTO_INCREMENT,
  `family_id` int(10) NOT NULL DEFAULT '1',
  `container_id` int(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `bought_for` double(6,2) DEFAULT NULL,
  `current_value` double(6,2) DEFAULT NULL,
  `quantity` int(10) NOT NULL DEFAULT '1',
  `datetime_added` datetime NOT NULL,
  `datetime_updated` datetime DEFAULT NULL,
  `user_added` int(10) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`invent_id`),
  KEY `container_id` (`container_id`),
  KEY `name` (`name`),
  KEY `bought_for` (`bought_for`),
  KEY `current_value` (`current_value`),
  KEY `datetime_added` (`datetime_added`),
  KEY `datetime_updated` (`datetime_updated`),
  KEY `user_added` (`user_added`),
  FULLTEXT KEY `name_description` (`name`,`description`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.inventory_locations
CREATE TABLE IF NOT EXISTS `inventory_locations` (
  `location_id` int(10) NOT NULL AUTO_INCREMENT,
  `family_id` int(10) NOT NULL DEFAULT '1',
  `location_name` varchar(255) NOT NULL,
  `location_description` text,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`location_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.library_films
CREATE TABLE IF NOT EXISTS `library_films` (
  `lib_film_id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`lib_film_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.library_genres
CREATE TABLE IF NOT EXISTS `library_genres` (
  `genre_id` int(10) NOT NULL AUTO_INCREMENT,
  `genre_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `genre_type` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`genre_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.library_genre_link
CREATE TABLE IF NOT EXISTS `library_genre_link` (
  `library_id` int(10) NOT NULL DEFAULT '0',
  `genre_id` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`library_id`,`genre_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.library_main
CREATE TABLE IF NOT EXISTS `library_main` (
  `library_id` int(10) NOT NULL AUTO_INCREMENT,
  `type` enum('film','cd','book') COLLATE utf8_unicode_ci NOT NULL,
  `type_id` int(10) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_added` int(11) NOT NULL,
  PRIMARY KEY (`library_id`),
  KEY `type_id` (`type_id`),
  KEY `date_added` (`date_added`),
  KEY `user_added` (`user_added`),
  KEY `type` (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.money_accounts
CREATE TABLE IF NOT EXISTS `money_accounts` (
  `account_id` int(8) NOT NULL AUTO_INCREMENT,
  `family_id` int(8) NOT NULL DEFAULT '0',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `colour` char(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `verified` tinyint(1) NOT NULL DEFAULT '0',
  `default` tinyint(1) NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `hide` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`account_id`),
  KEY `type` (`type`),
  KEY `default` (`default`),
  KEY `family_id` (`family_id`),
  KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.money_catagories
CREATE TABLE IF NOT EXISTS `money_catagories` (
  `money_category_id` int(8) NOT NULL AUTO_INCREMENT,
  `family_id` int(8) NOT NULL DEFAULT '0',
  `description` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `top_level` tinyint(1) NOT NULL DEFAULT '0',
  `color` char(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent` int(10) DEFAULT '0',
  `dont_include_in_stats` tinyint(1) NOT NULL DEFAULT '0',
  `target_amount` float NOT NULL DEFAULT '0',
  `system` enum('trans_in','trans_out') COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`money_category_id`),
  KEY `top_level` (`top_level`),
  KEY `parent` (`parent`),
  KEY `family_id` (`family_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.money_category_links
CREATE TABLE IF NOT EXISTS `money_category_links` (
  `transaction_id` int(8) NOT NULL,
  `category_id` int(8) NOT NULL,
  PRIMARY KEY (`transaction_id`,`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.money_items
CREATE TABLE IF NOT EXISTS `money_items` (
  `item_id` int(8) NOT NULL AUTO_INCREMENT,
  `family_id` int(8) NOT NULL DEFAULT '1',
  `account_id` int(8) NOT NULL,
  `trans_type` tinyint(1) NOT NULL DEFAULT '-1',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date` date NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `added_by` int(10) DEFAULT NULL,
  `added_datetime` datetime DEFAULT NULL,
  `confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `bank_date` date DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `account_id` (`account_id`),
  KEY `trans_type` (`trans_type`),
  KEY `date` (`date`),
  KEY `family_id` (`family_id`),
  FULLTEXT KEY `description` (`description`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.money_regulars
CREATE TABLE IF NOT EXISTS `money_regulars` (
  `regular_id` int(8) NOT NULL AUTO_INCREMENT,
  `family_id` int(8) NOT NULL DEFAULT '0',
  `account_id` int(8) NOT NULL,
  `trans_type` tinyint(1) NOT NULL,
  `amount` float NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `occurrence` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`regular_id`),
  KEY `account_id` (`account_id`),
  KEY `trans_type` (`trans_type`),
  KEY `amount` (`amount`),
  KEY `start_date` (`start_date`),
  KEY `end_date` (`end_date`),
  KEY `family_id` (`family_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.money_targets
CREATE TABLE IF NOT EXISTS `money_targets` (
  `target_id` int(10) NOT NULL AUTO_INCREMENT,
  `category_id` int(10) NOT NULL,
  `month` smallint(6) NOT NULL,
  `date_ended` date DEFAULT NULL,
  `amount` float NOT NULL,
  PRIMARY KEY (`target_id`),
  KEY `category_id` (`category_id`),
  KEY `month` (`month`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.money_transactions
CREATE TABLE IF NOT EXISTS `money_transactions` (
  `transaction_id` int(8) NOT NULL AUTO_INCREMENT,
  `item_id` int(8) NOT NULL,
  `category_id` int(8) NOT NULL DEFAULT '0',
  `amount` float NOT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `amount` (`amount`),
  KEY `category_id` (`category_id`),
  KEY `item_id` (`item_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.money_transactions_old
CREATE TABLE IF NOT EXISTS `money_transactions_old` (
  `item_id` int(8) NOT NULL AUTO_INCREMENT,
  `family_id` int(8) NOT NULL DEFAULT '1',
  `account_id` int(8) NOT NULL,
  `trans_type` tinyint(1) NOT NULL DEFAULT '-1',
  `amount` float NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date` date NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_id`),
  KEY `account_id` (`account_id`),
  KEY `trans_type` (`trans_type`),
  KEY `amount` (`amount`),
  KEY `date` (`date`),
  KEY `family_id` (`family_id`),
  FULLTEXT KEY `description` (`description`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.notes
CREATE TABLE IF NOT EXISTS `notes` (
  `note_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `note` mediumtext,
  `date_created` datetime NOT NULL,
  `user_created` int(11) NOT NULL,
  `date_updated` datetime DEFAULT NULL,
  `user_updated` int(11) DEFAULT NULL,
  `family_id` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `private` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`note_id`),
  KEY `deleted` (`deleted`),
  KEY `family_id` (`family_id`),
  KEY `private` (`private`),
  KEY `date_created` (`date_created`),
  KEY `user_created` (`user_created`),
  KEY `date_updated` (`date_updated`),
  KEY `user_updated` (`user_updated`),
  FULLTEXT KEY `name_note` (`name`,`note`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.sessions
CREATE TABLE IF NOT EXISTS `sessions` (
  `session_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `ip_address` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `user_agent` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`session_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.tasks
CREATE TABLE IF NOT EXISTS `tasks` (
  `task_id` int(10) NOT NULL AUTO_INCREMENT,
  `family_id` int(10) NOT NULL DEFAULT '1',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `date_created` datetime NOT NULL,
  `date_due` datetime DEFAULT NULL,
  `priority` tinyint(1) NOT NULL DEFAULT '3',
  `details` text COLLATE utf8_unicode_ci,
  `completed` tinyint(1) NOT NULL DEFAULT '0',
  `user_created` int(10) NOT NULL,
  `private` tinyint(1) NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`task_id`),
  KEY `family_id` (`family_id`),
  KEY `name` (`name`),
  KEY `date_created` (`date_created`),
  KEY `date_due` (`date_due`),
  KEY `priority` (`priority`),
  KEY `completed` (`completed`),
  KEY `user_created` (`user_created`),
  KEY `private` (`private`),
  KEY `deleted` (`deleted`),
  FULLTEXT KEY `name_details` (`name`,`details`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table home_portal.users
CREATE TABLE IF NOT EXISTS `users` (
  `users_id` int(10) NOT NULL AUTO_INCREMENT,
  `family_id` int(10) NOT NULL DEFAULT '0',
  `username` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pass_hash` char(40) COLLATE utf8_unicode_ci NOT NULL,
  `pass_salt` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `created_date` datetime NOT NULL,
  `last_logged_in` datetime DEFAULT NULL,
  `imap_server` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `imap_subscribed` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `smtp_server` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `imap_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `imap_pass` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `smtp_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `smtp_pass` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `theme` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'default',
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `access_rights` text COLLATE utf8_unicode_ci,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reminder_days` int(10) NOT NULL DEFAULT '10',
  `email_alerts` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`users_id`),
  KEY `family_id` (`family_id`),
  KEY `username` (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for view home_portal.v_inventory_containers
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_inventory_containers` (
	`container_id` INT(10) NOT NULL DEFAULT '0',
	`container_name` VARCHAR(255) NOT NULL COLLATE 'latin1_swedish_ci',
	`container_type` ENUM('card_box','plastic_box','open_space') NOT NULL COLLATE 'latin1_swedish_ci',
	`location_name` VARCHAR(255) NOT NULL COLLATE 'latin1_swedish_ci',
	`family_id` INT(10) NOT NULL DEFAULT '1',
	`deleted` TINYINT(1) NOT NULL DEFAULT '0',
	`item_count` BIGINT(21) NOT NULL DEFAULT '0'
) ENGINE=MyISAM;


-- Dumping structure for view home_portal.v_money_cats_overview
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_money_cats_overview` (
	`family_id` INT(8) NOT NULL DEFAULT '0',
	`money_category_id` INT(8) NOT NULL DEFAULT '0',
	`parent_desc` VARCHAR(100) NOT NULL COLLATE 'utf8_unicode_ci',
	`cat_desc` VARCHAR(100) NOT NULL COLLATE 'utf8_unicode_ci',
	`parent` INT(10) NULL DEFAULT '0',
	`trans_count_in` DECIMAL(23,0) NULL DEFAULT NULL,
	`trans_count_out` DECIMAL(23,0) NULL DEFAULT NULL,
	`total_in` DOUBLE(19,2) NULL DEFAULT NULL,
	`total_out` DOUBLE(19,2) NULL DEFAULT NULL,
	`average_in` DOUBLE(19,2) NULL DEFAULT NULL,
	`average_out` DOUBLE(19,2) NULL DEFAULT NULL,
	`deleted` INT(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM;


-- Dumping structure for view home_portal.v_money_transactions
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_money_transactions` (
	`account_name` VARCHAR(255) NOT NULL COLLATE 'utf8_unicode_ci',
	`item_id` INT(8) NOT NULL DEFAULT '0',
	`account_id` INT(8) NOT NULL,
	`account_verified` TINYINT(1) NOT NULL DEFAULT '0',
	`trans_type` TINYINT(1) NOT NULL DEFAULT '-1',
	`date` DATE NOT NULL,
	`trans_count` BIGINT(21) NOT NULL DEFAULT '0',
	`amount` DOUBLE(19,2) NULL DEFAULT NULL,
	`top_descriptions` VARCHAR(341) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`cat_descriptions` VARCHAR(341) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`family_id` INT(8) NOT NULL DEFAULT '1',
	`deleted` TINYINT(1) NOT NULL DEFAULT '0',
	`confirmed` TINYINT(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM;


-- Dumping structure for view home_portal.v_inventory_containers
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_inventory_containers`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_inventory_containers` AS select `ic`.`container_id` AS `container_id`,`ic`.`container_name` AS `container_name`,`ic`.`container_type` AS `container_type`,`il`.`location_name` AS `location_name`,`ic`.`family_id` AS `family_id`,`ic`.`deleted` AS `deleted`,count(`ii`.`invent_id`) AS `item_count` from ((`inventory_containers` `ic` join `inventory_locations` `il` on((`ic`.`location_id` = `il`.`location_id`))) left join `inventory_items` `ii` on((`ic`.`container_id` = `ii`.`container_id`))) group by `ic`.`container_id`;


-- Dumping structure for view home_portal.v_money_cats_overview
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_money_cats_overview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_money_cats_overview` AS select `mc`.`family_id` AS `family_id`,`mc`.`money_category_id` AS `money_category_id`,`mc2`.`description` AS `parent_desc`,`mc`.`description` AS `cat_desc`,`mc`.`parent` AS `parent`,sum(if((`mi`.`trans_type` = 1),1,0)) AS `trans_count_in`,sum(if((`mi`.`trans_type` = -(1)),1,0)) AS `trans_count_out`,round(sum(if((`mi`.`trans_type` = 1),`mt`.`amount`,0)),2) AS `total_in`,round(sum(if((`mi`.`trans_type` = -(1)),`mt`.`amount`,0)),2) AS `total_out`,round(avg(if((`mi`.`trans_type` = 1),`mt`.`amount`,0)),2) AS `average_in`,round(avg(if((`mi`.`trans_type` = -(1)),`mt`.`amount`,0)),2) AS `average_out`,0 AS `deleted` from (((`money_catagories` `mc` join `money_catagories` `mc2` on((`mc`.`parent` = `mc2`.`money_category_id`))) left join `money_transactions` `mt` on((`mc`.`money_category_id` = `mt`.`category_id`))) left join `money_items` `mi` on((`mt`.`item_id` = `mi`.`item_id`))) group by `mc`.`money_category_id`;


-- Dumping structure for view home_portal.v_money_transactions
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_money_transactions`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `v_money_transactions` AS select `ma`.`name` AS `account_name`,`mi`.`item_id` AS `item_id`,`mi`.`account_id` AS `account_id`,`ma`.`verified` AS `account_verified`,`mi`.`trans_type` AS `trans_type`,`mi`.`date` AS `date`,count(`mt`.`transaction_id`) AS `trans_count`,round(sum(`mt`.`amount`),2) AS `amount`,group_concat(`mc2`.`description` separator ', ') AS `top_descriptions`,group_concat(`mc`.`description` separator ', ') AS `cat_descriptions`,`mi`.`family_id` AS `family_id`,`mi`.`deleted` AS `deleted`,`mi`.`confirmed` AS `confirmed` from ((((`money_transactions` `mt` join `money_items` `mi` on((`mi`.`item_id` = `mt`.`item_id`))) join `money_accounts` `ma` on((`ma`.`account_id` = `mi`.`account_id`))) join `money_catagories` `mc` on((`mt`.`category_id` = `mc`.`money_category_id`))) join `money_catagories` `mc2` on((`mc`.`parent` = `mc2`.`money_category_id`))) group by `mt`.`item_id`;
/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
