CREATE TABLE `client_contracts` (
  `id` int(11) NOT NULL auto_increment,
  `contract_code` varchar(255) default NULL,
  `contract_date` datetime default NULL,
  `actual_contract` tinyint(1) default NULL,
  `client_id` int(11) default NULL,
  `status` varchar(255) default NULL,
  `remark` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE `client_order_fulfillments` (
  `id` int(11) NOT NULL auto_increment,
  `client_invoice_id` int(11) default NULL,
  `order_status_id` int(11) default NULL,
  `supplier_sku_id` int(11) default NULL,
  `total_drain_weight` float default NULL,
  `total_gross_weight` float default NULL,
  `total_net_weight` float default NULL,
  `quantity` float default NULL,
  `container_usage` float default NULL,
  `unit_id` int(11) default NULL,
  `client_order_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `client_order_groups` (
  `id` int(11) NOT NULL auto_increment,
  `client_order_fulfillment_id` int(11) default NULL,
  `client_container_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `client_orders` (
  `id` int(11) NOT NULL auto_increment,
  `total_quantity` float default NULL,
  `client_PO_id` int(11) default NULL,
  `trader_sku_id` int(11) default NULL,
  `request_etd` varchar(255) default NULL,
  `request_eta` varchar(255) default NULL,
  `unit_of_order` varchar(255) default NULL,
  `unit_price` float default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `client_pos` (
  `id` int(11) NOT NULL auto_increment,
  `po` varchar(255) default NULL,
  `po_date` datetime default NULL,
  `po_amount` float default NULL,
  `currency` varchar(255) default NULL,
  `client_contract_id` int(11) default NULL,
  `payment_term_id` int(11) default NULL,
  `payment_term_day` int(11) default NULL,
  `status` varchar(255) default NULL,
  `remark` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `client_psses` (
  `id` int(11) NOT NULL auto_increment,
  `date_sent` datetime default NULL,
  `date_receive` datetime default NULL,
  `pss_status_id` int(11) default NULL,
  `client_order_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `clients` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `address` text,
  `country_name` varchar(255) default NULL,
  `status` tinyint(1) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE `countries` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=240 DEFAULT CHARSET=utf8;

CREATE TABLE `order_statuses` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE `payment_terms` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE `product_mappings` (
  `id` int(11) NOT NULL auto_increment,
  `trader_sku_id` int(11) default NULL,
  `supplier_sku_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE `products` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `detail` text,
  `product_type` varchar(255) default NULL,
  `spec` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

CREATE TABLE `pss_statuses` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `supplier_contracts` (
  `id` int(11) NOT NULL auto_increment,
  `contract_code` varchar(255) default NULL,
  `contract_date` datetime default NULL,
  `actual_contract` tinyint(1) default NULL,
  `supplier_id` int(11) default NULL,
  `status` varchar(255) default NULL,
  `remark` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `supplier_order_fulfillments` (
  `id` int(11) NOT NULL auto_increment,
  `supplier_invoice_id` int(11) default NULL,
  `order_status_id` int(11) default NULL,
  `trader_sku_id` int(11) default NULL,
  `total_drain_weight` float default NULL,
  `total_gross_weight` float default NULL,
  `total_net_weight` float default NULL,
  `quantity` float default NULL,
  `container_usage` float default NULL,
  `unit_id` int(11) default NULL,
  `supplier_order_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE `supplier_order_groups` (
  `id` int(11) NOT NULL auto_increment,
  `supplier_order_fulfillment_id` int(11) default NULL,
  `supplier_container_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `supplier_orders` (
  `id` int(11) NOT NULL auto_increment,
  `total_quantity` float default NULL,
  `supplier_PO_id` int(11) default NULL,
  `supplier_sku_id` int(11) default NULL,
  `request_etd` varchar(255) default NULL,
  `request_eta` varchar(255) default NULL,
  `unit_of_order` varchar(255) default NULL,
  `unit_price` float default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE `supplier_pos` (
  `id` int(11) NOT NULL auto_increment,
  `po` varchar(255) default NULL,
  `po_date` datetime default NULL,
  `po_amount` float default NULL,
  `currency` varchar(255) default NULL,
  `supplier_contract_id` int(11) default NULL,
  `payment_term_id` int(11) default NULL,
  `payment_term_day` int(11) default NULL,
  `status` varchar(255) default NULL,
  `remark` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `supplier_psses` (
  `id` int(11) NOT NULL auto_increment,
  `date_sent` datetime default NULL,
  `date_receive` datetime default NULL,
  `pss_status_id` int(11) default NULL,
  `supplier_order_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `supplier_skus` (
  `id` int(11) NOT NULL auto_increment,
  `sku` varchar(255) default NULL,
  `supplier_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE `suppliers` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `address` text,
  `country_name` varchar(255) default NULL,
  `status` tinyint(1) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE `trader_skus` (
  `id` int(11) NOT NULL auto_increment,
  `sku` varchar(255) default NULL,
  `product_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

CREATE TABLE `units` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `unit_per_container` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `lastname` varchar(255) default NULL,
  `privacy` varchar(255) default NULL,
  `status` int(11) default NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `crypted_password` varchar(255) NOT NULL,
  `password_salt` varchar(255) NOT NULL,
  `persistence_token` varchar(255) NOT NULL,
  `single_access_token` varchar(255) NOT NULL,
  `perishable_token` varchar(255) NOT NULL,
  `login_count` int(11) NOT NULL default '0',
  `failed_login_count` int(11) NOT NULL default '0',
  `last_request_at` datetime default NULL,
  `current_login_at` datetime default NULL,
  `last_login_at` datetime default NULL,
  `current_login_ip` varchar(255) default NULL,
  `last_login_ip` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO schema_migrations (version) VALUES ('20100727075550');

INSERT INTO schema_migrations (version) VALUES ('20100728072056');

INSERT INTO schema_migrations (version) VALUES ('20100729093920');

INSERT INTO schema_migrations (version) VALUES ('20100802065146');

INSERT INTO schema_migrations (version) VALUES ('20100804030324');

INSERT INTO schema_migrations (version) VALUES ('20100804072357');

INSERT INTO schema_migrations (version) VALUES ('20100805034701');

INSERT INTO schema_migrations (version) VALUES ('20100805083307');

INSERT INTO schema_migrations (version) VALUES ('20100810082731');

INSERT INTO schema_migrations (version) VALUES ('20100810082848');

INSERT INTO schema_migrations (version) VALUES ('20100810085117');

INSERT INTO schema_migrations (version) VALUES ('20100810090949');

INSERT INTO schema_migrations (version) VALUES ('20100810091028');

INSERT INTO schema_migrations (version) VALUES ('20100810095702');

INSERT INTO schema_migrations (version) VALUES ('20100811072905');

INSERT INTO schema_migrations (version) VALUES ('20100818075030');

INSERT INTO schema_migrations (version) VALUES ('20100819070200');

INSERT INTO schema_migrations (version) VALUES ('20100819072132');

INSERT INTO schema_migrations (version) VALUES ('20100819074222');

INSERT INTO schema_migrations (version) VALUES ('20100819075101');

INSERT INTO schema_migrations (version) VALUES ('20100819080148');

INSERT INTO schema_migrations (version) VALUES ('20100819082254');

INSERT INTO schema_migrations (version) VALUES ('20100819084514');

INSERT INTO schema_migrations (version) VALUES ('20100820033658');