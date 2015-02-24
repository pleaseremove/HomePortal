
-- Dumping structure for table homeportal_v2.calendars
CREATE TABLE IF NOT EXISTS `calendars` (
  `calendar_id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL,
  `private` tinyint(1) NOT NULL DEFAULT '0',
  `family_id` int(11) NOT NULL,
  PRIMARY KEY (`calendar_id`),
  KEY `user_id` (`user_id`),
  KEY `public` (`private`),
  KEY `family_id` (`family_id`),
  KEY `title` (`title`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table homeportal_v2.calendars: 0 rows
/*!40000 ALTER TABLE `calendars` DISABLE KEYS */;
/*!40000 ALTER TABLE `calendars` ENABLE KEYS */;


-- Dumping structure for table homeportal_v2.calendar_events
CREATE TABLE IF NOT EXISTS `calendar_events` (
  `event_id` int(10) NOT NULL AUTO_INCREMENT,
  `family_id` int(10) NOT NULL DEFAULT '1',
  `private` int(10) NOT NULL DEFAULT '0',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `location` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `all_day` tinyint(1) NOT NULL DEFAULT '0',
  `important` tinyint(1) NOT NULL DEFAULT '0',
  `tentative` tinyint(1) NOT NULL DEFAULT '0',
  `repeat` tinyint(1) NOT NULL DEFAULT '0',
  `created_by` int(10) NOT NULL,
  `created_datetime` datetime NOT NULL,
  `sequence` int(10) NOT NULL DEFAULT '0',
  `updated_datetime` datetime DEFAULT NULL,
  `updated_by` int(10) DEFAULT NULL,
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
  FULLTEXT KEY `title_description` (`title`,`description`,`location`)
) ENGINE=MyISAM AUTO_INCREMENT=728 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping structure for table homeportal_v2.contacts_addresses
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
) ENGINE=MyISAM AUTO_INCREMENT=295 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping structure for table homeportal_v2.contacts_categories
CREATE TABLE IF NOT EXISTS `contacts_categories` (
  `category_id` int(8) NOT NULL AUTO_INCREMENT,
  `description` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `family_id` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping structure for table homeportal_v2.contacts_category_links
CREATE TABLE IF NOT EXISTS `contacts_category_links` (
  `contact_id` int(8) NOT NULL,
  `category_id` int(8) NOT NULL,
  PRIMARY KEY (`contact_id`,`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping structure for table homeportal_v2.contacts_children
CREATE TABLE IF NOT EXISTS `contacts_children` (
  `contacts_child_id` int(10) NOT NULL AUTO_INCREMENT,
  `parent_1_id` int(10) NOT NULL,
  `parent_2_id` int(10) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `birthday` date DEFAULT NULL,
  PRIMARY KEY (`contacts_child_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping structure for table homeportal_v2.contacts_data
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
) ENGINE=MyISAM AUTO_INCREMENT=881 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping structure for table homeportal_v2.contacts_data_types
CREATE TABLE IF NOT EXISTS `contacts_data_types` (
  `data_type_id` int(10) NOT NULL AUTO_INCREMENT,
  `data_type_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `data_type_view_string` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `family_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`data_type_id`),
  KEY `data_type_name` (`data_type_name`),
  KEY `family_id` (`family_id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table homeportal_v2.contacts_data_types: 16 rows
/*!40000 ALTER TABLE `contacts_data_types` DISABLE KEYS */;
INSERT INTO `contacts_data_types` (`data_type_id`, `data_type_name`, `data_type_view_string`, `family_id`) VALUES
	(1, 'Home Phone', '<a class="new_window" href="tel://<%data%>"><%data%></a>', 0),
	(2, 'Mobile Phone', '<a class="new_window" href="tel://<%data%>"><%data%></a>', 0),
	(3, 'Livejournal', '<a class="new_window" href="http://<%data%>.livejournal.com" title="Journal for <%data%>">LiveJournal: <%data%></a>', 0),
	(4, 'Facebook', '<a class="new_window" href="http://www.facebook.com/profile.php?id=<%data%>">Facebook Profile</a>', 0),
	(5, 'Work Phone', '<a class="new_window" href="tel://<%data%></a>', 0),
	(6, 'Fax Number', '<%data%>', 0),
	(7, 'Skype', '<a class="click-through" href="skype:<%data%>">Call: <%data%></a>', 0),
	(8, 'Website', '<a class="new_window" href="http://<%data%>"><%data%></a>', 0),
	(9, 'MSN', '<%data%>', 0),
	(10, 'Yahoo', '<%data%>', 0),
	(11, 'Twitter', '<a class="new_window" href="https://twitter.com/<%data%>">#<%data%></a>', 0),
	(12, 'LinkedIn', '<%data%>', 0),
	(13, 'Steam', '<%data%>', 0),
	(14, 'Youtube', '<%data%>', 0),
	(15, 'Flickr', '<%data%>', 0),
	(16, 'Google Plus', '<%data%>', 0);
/*!40000 ALTER TABLE `contacts_data_types` ENABLE KEYS */;


-- Dumping structure for table homeportal_v2.contacts_emails
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
) ENGINE=MyISAM AUTO_INCREMENT=419 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping structure for table homeportal_v2.contacts_main
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
) ENGINE=MyISAM AUTO_INCREMENT=126 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping structure for table homeportal_v2.contacts_relations
CREATE TABLE IF NOT EXISTS `contacts_relations` (
  `contact_id` int(10) NOT NULL,
  `relation_id` int(10) NOT NULL,
  PRIMARY KEY (`contact_id`,`relation_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping structure for table homeportal_v2.contacts_titles
CREATE TABLE IF NOT EXISTS `contacts_titles` (
  `title_id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`title_id`),
  KEY `title` (`title`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table homeportal_v2.contacts_titles: 11 rows
/*!40000 ALTER TABLE `contacts_titles` DISABLE KEYS */;
INSERT INTO `contacts_titles` (`title_id`, `title`) VALUES
	(1, 'Mr'),
	(2, 'Mrs'),
	(3, 'Miss'),
	(4, 'Master'),
	(5, 'Rev'),
	(6, 'Lord'),
	(7, 'Dr'),
	(8, 'Ms'),
	(9, 'Lady'),
	(10, 'Baron'),
	(11, 'Baroness');
/*!40000 ALTER TABLE `contacts_titles` ENABLE KEYS */;


-- Dumping structure for table homeportal_v2.families
CREATE TABLE IF NOT EXISTS `families` (
  `family_id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `subdomain` varchar(255) NOT NULL,
  PRIMARY KEY (`family_id`),
  UNIQUE KEY `subdomain` (`subdomain`),
  KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table homeportal_v2.families: 2 rows
/*!40000 ALTER TABLE `families` DISABLE KEYS */;
INSERT INTO `families` (`family_id`, `name`, `subdomain`) VALUES
	(1, 'Default', 'default');
/*!40000 ALTER TABLE `families` ENABLE KEYS */;


-- Dumping structure for table homeportal_v2.inventory_containers
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
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

-- Dumping structure for table homeportal_v2.inventory_items
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
) ENGINE=MyISAM AUTO_INCREMENT=166 DEFAULT CHARSET=latin1;

-- Dumping structure for table homeportal_v2.inventory_locations
CREATE TABLE IF NOT EXISTS `inventory_locations` (
  `location_id` int(10) NOT NULL AUTO_INCREMENT,
  `family_id` int(10) NOT NULL DEFAULT '1',
  `location_name` varchar(255) NOT NULL,
  `location_description` text,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`location_id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

-- Dumping structure for table homeportal_v2.library_films
CREATE TABLE IF NOT EXISTS `library_films` (
  `lib_film_id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`lib_film_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping structure for table homeportal_v2.library_genres
CREATE TABLE IF NOT EXISTS `library_genres` (
  `genre_id` int(10) NOT NULL AUTO_INCREMENT,
  `genre_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `genre_type` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`genre_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping structure for table homeportal_v2.library_genre_link
CREATE TABLE IF NOT EXISTS `library_genre_link` (
  `library_id` int(10) NOT NULL DEFAULT '0',
  `genre_id` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`library_id`,`genre_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping structure for table homeportal_v2.library_main
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

-- Dumping structure for table homeportal_v2.money_accounts
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
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping structure for table homeportal_v2.money_catagories
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
) ENGINE=MyISAM AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table homeportal_v2.money_catagories: 61 rows
/*!40000 ALTER TABLE `money_catagories` DISABLE KEYS */;
INSERT INTO `money_catagories` (`money_category_id`, `family_id`, `description`, `top_level`, `color`, `parent`, `dont_include_in_stats`, `target_amount`, `system`) VALUES
	(1, 1, 'Transfered out', 0, NULL, 6, 1, 0, 'trans_out'),
	(2, 1, 'Transfered in', 0, NULL, 6, 1, 0, 'trans_in'),
	(49, 1, 'Office Supplies', 0, NULL, 4, 0, 0, NULL);
/*!40000 ALTER TABLE `money_catagories` ENABLE KEYS */;


-- Dumping structure for table homeportal_v2.money_category_links
CREATE TABLE IF NOT EXISTS `money_category_links` (
  `transaction_id` int(8) NOT NULL,
  `category_id` int(8) NOT NULL,
  PRIMARY KEY (`transaction_id`,`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping structure for table homeportal_v2.money_items
CREATE TABLE IF NOT EXISTS `money_items` (
  `item_id` int(8) NOT NULL AUTO_INCREMENT,
  `family_id` int(8) NOT NULL DEFAULT '1',
  `account_id` int(8) NOT NULL,
  `trans_type` tinyint(1) NOT NULL DEFAULT '-1',
  `description` text COLLATE utf8_unicode_ci,
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
) ENGINE=MyISAM AUTO_INCREMENT=4311 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping structure for table homeportal_v2.money_regulars
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

-- Dumping structure for table homeportal_v2.money_targets
CREATE TABLE IF NOT EXISTS `money_targets` (
  `target_id` int(10) NOT NULL AUTO_INCREMENT,
  `category_id` int(10) NOT NULL,
  `month` smallint(6) NOT NULL,
  `date_ended` date DEFAULT NULL,
  `amount` float NOT NULL,
  PRIMARY KEY (`target_id`),
  KEY `category_id` (`category_id`),
  KEY `month` (`month`)
) ENGINE=MyISAM AUTO_INCREMENT=74 DEFAULT CHARSET=latin1;

-- Dumping structure for table homeportal_v2.money_transactions
CREATE TABLE IF NOT EXISTS `money_transactions` (
  `transaction_id` int(8) NOT NULL AUTO_INCREMENT,
  `item_id` int(8) NOT NULL,
  `category_id` int(8) NOT NULL DEFAULT '0',
  `amount` float NOT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `amount` (`amount`),
  KEY `category_id` (`category_id`),
  KEY `item_id` (`item_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5571 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping structure for table homeportal_v2.notes
CREATE TABLE IF NOT EXISTS `notes` (
  `note_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `note` text,
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
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- Dumping structure for table homeportal_v2.tasks
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
) ENGINE=MyISAM AUTO_INCREMENT=111 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping structure for table homeportal_v2.users
CREATE TABLE IF NOT EXISTS `users` (
  `users_id` int(10) NOT NULL AUTO_INCREMENT,
  `family_id` int(10) NOT NULL DEFAULT '0',
  `username` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pass_hash` char(40) COLLATE utf8_unicode_ci NOT NULL,
  `pass_salt` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `created_date` datetime NOT NULL,
  `last_logged_in` datetime DEFAULT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reminder_days` int(10) NOT NULL DEFAULT '10',
  `email_alerts` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`users_id`),
  KEY `family_id` (`family_id`),
  KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping structure for view homeportal_v2.v_inventory_containers
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_inventory_containers` (
	`container_id` INT(10) NOT NULL,
	`container_name` VARCHAR(255) NOT NULL COLLATE 'latin1_swedish_ci',
	`container_type` ENUM('card_box','plastic_box','open_space') NOT NULL COLLATE 'latin1_swedish_ci',
	`location_name` VARCHAR(255) NOT NULL COLLATE 'latin1_swedish_ci',
	`family_id` INT(10) NOT NULL,
	`deleted` TINYINT(1) NOT NULL,
	`item_count` BIGINT(21) NOT NULL
) ENGINE=MyISAM;


-- Dumping structure for view homeportal_v2.v_money_cats_overview
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_money_cats_overview` (
	`family_id` INT(8) NOT NULL,
	`money_category_id` INT(8) NOT NULL,
	`parent_desc` VARCHAR(100) NOT NULL COLLATE 'utf8_unicode_ci',
	`cat_desc` VARCHAR(100) NOT NULL COLLATE 'utf8_unicode_ci',
	`parent` INT(10) NULL,
	`trans_count_in` DECIMAL(23,0) NULL,
	`trans_count_out` DECIMAL(23,0) NULL,
	`total_in` DOUBLE(19,2) NULL,
	`total_out` DOUBLE(19,2) NULL,
	`average_in` DOUBLE(19,2) NULL,
	`average_out` DOUBLE(19,2) NULL,
	`deleted` INT(1) NOT NULL
) ENGINE=MyISAM;


-- Dumping structure for view homeportal_v2.v_money_transactions
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_money_transactions` (
	`account_name` VARCHAR(255) NOT NULL COLLATE 'utf8_unicode_ci',
	`item_id` INT(8) NOT NULL,
	`account_id` INT(8) NOT NULL,
	`account_verified` TINYINT(1) NOT NULL,
	`trans_type` TINYINT(1) NOT NULL,
	`date` DATE NOT NULL,
	`trans_count` BIGINT(21) NOT NULL,
	`amount` DOUBLE(19,2) NULL,
	`top_descriptions` TEXT NULL COLLATE 'utf8_unicode_ci',
	`cat_descriptions` TEXT NULL COLLATE 'utf8_unicode_ci',
	`cat_descriptions_without` TEXT NULL COLLATE 'utf8_unicode_ci',
	`family_id` INT(8) NOT NULL,
	`deleted` TINYINT(1) NOT NULL,
	`confirmed` TINYINT(1) NOT NULL
) ENGINE=MyISAM;


-- Dumping structure for view homeportal_v2.v_transfers
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `v_transfers` (
	`out_account` VARCHAR(255) NOT NULL COLLATE 'utf8_unicode_ci',
	`date` DATE NOT NULL,
	`amount` FLOAT NOT NULL,
	`in_account` VARCHAR(255) NULL COLLATE 'utf8_unicode_ci'
) ENGINE=MyISAM;


-- Dumping structure for view homeportal_v2.v_inventory_containers
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_inventory_containers`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_inventory_containers` AS select `ic`.`container_id` AS `container_id`,`ic`.`container_name` AS `container_name`,`ic`.`container_type` AS `container_type`,`il`.`location_name` AS `location_name`,`ic`.`family_id` AS `family_id`,`ic`.`deleted` AS `deleted`,count(`ii`.`invent_id`) AS `item_count` from ((`inventory_containers` `ic` join `inventory_locations` `il` on((`ic`.`location_id` = `il`.`location_id`))) left join `inventory_items` `ii` on((`ic`.`container_id` = `ii`.`container_id`))) group by `ic`.`container_id`;


-- Dumping structure for view homeportal_v2.v_money_cats_overview
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_money_cats_overview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_money_cats_overview` AS select `mc`.`family_id` AS `family_id`,`mc`.`money_category_id` AS `money_category_id`,`mc2`.`description` AS `parent_desc`,`mc`.`description` AS `cat_desc`,`mc`.`parent` AS `parent`,sum(if((`mi`.`trans_type` = 1),1,0)) AS `trans_count_in`,sum(if((`mi`.`trans_type` = -(1)),1,0)) AS `trans_count_out`,round(sum(if((`mi`.`trans_type` = 1),`mt`.`amount`,0)),2) AS `total_in`,round(sum(if((`mi`.`trans_type` = -(1)),`mt`.`amount`,0)),2) AS `total_out`,round(avg(if((`mi`.`trans_type` = 1),`mt`.`amount`,0)),2) AS `average_in`,round(avg(if((`mi`.`trans_type` = -(1)),`mt`.`amount`,0)),2) AS `average_out`,0 AS `deleted` from (((`money_catagories` `mc` join `money_catagories` `mc2` on((`mc`.`parent` = `mc2`.`money_category_id`))) left join `money_transactions` `mt` on((`mc`.`money_category_id` = `mt`.`category_id`))) left join `money_items` `mi` on((`mt`.`item_id` = `mi`.`item_id`))) group by `mc`.`money_category_id`;


-- Dumping structure for view homeportal_v2.v_money_transactions
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_money_transactions`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_money_transactions` AS select `ma`.`name` AS `account_name`,`mi`.`item_id` AS `item_id`,`mi`.`account_id` AS `account_id`,`ma`.`verified` AS `account_verified`,`mi`.`trans_type` AS `trans_type`,`mi`.`date` AS `date`,count(`mt`.`transaction_id`) AS `trans_count`,round(sum(`mt`.`amount`),2) AS `amount`,group_concat(`mc2`.`description` separator ', ') AS `top_descriptions`,group_concat(concat('<a href="money/categories/stats/',`mc`.`money_category_id`,'">',`mc`.`description`,'</a>') separator ', ') AS `cat_descriptions`,group_concat(`mc`.`description` separator ', ') AS `cat_descriptions_without`,`mi`.`family_id` AS `family_id`,`mi`.`deleted` AS `deleted`,`mi`.`confirmed` AS `confirmed` from ((((`money_transactions` `mt` join `money_items` `mi` on((`mi`.`item_id` = `mt`.`item_id`))) join `money_accounts` `ma` on((`ma`.`account_id` = `mi`.`account_id`))) join `money_catagories` `mc` on((`mt`.`category_id` = `mc`.`money_category_id`))) join `money_catagories` `mc2` on((`mc`.`parent` = `mc2`.`money_category_id`))) group by `mt`.`item_id`;


-- Dumping structure for view homeportal_v2.v_transfers
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_transfers`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_transfers` AS select `a`.`name` AS `out_account`,`i`.`date` AS `date`,`t`.`amount` AS `amount`,(select `ia`.`name` from (((`money_items` `ii` join `money_transactions` `it` on((`ii`.`item_id` = `it`.`item_id`))) join `money_catagories` `ic` on((`it`.`category_id` = `ic`.`money_category_id`))) join `money_accounts` `ia` on((`ii`.`account_id` = `ia`.`account_id`))) where ((`ic`.`system` = 'trans_in') and (`it`.`amount` = `t`.`amount`) and (`ii`.`date` = `i`.`date`)) limit 1) AS `in_account` from (((`money_items` `i` join `money_transactions` `t` on((`i`.`item_id` = `t`.`item_id`))) join `money_catagories` `c` on((`t`.`category_id` = `c`.`money_category_id`))) join `money_accounts` `a` on((`i`.`account_id` = `a`.`account_id`))) where (`c`.`system` = 'trans_out') order by `i`.`date` desc;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
