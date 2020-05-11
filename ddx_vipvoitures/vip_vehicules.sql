USE `essentialmode`;

CREATE TABLE `vip_categories` (
	`name` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `vip_categories` (name, label) VALUES
	('vip','VIP')
;

CREATE TABLE carvip (
    name varchar(60) NOT NULL,
    model varchar(60) NOT NULL,
    price int(11) NOT NULL,
    category varchar(60) DEFAULT NULL,
    PRIMARY KEY (model)
);

INSERT INTO carvip (name, model, price, category) VALUES
    ('Dinghy 4Seat', 'dinghy', 25000, 'vip'),
    ('Dinghy 2Seat', 'dinghy2', 20000, 'vip'),
    ('Dinghy Yacht', 'dinghy4', 25000, 'vip'),
    ('Jetmax', 'jetmax', 30000, 'vip'),
    ('Marquis', 'marquis', 45000, 'vip'),
    ('Seashark', 'seashark', 10000, 'vip'),
    ('Seashark Yacht', 'seashark3', 10000, 'vip'),
    ('Speeder', 'speeder', 40000, 'vip'),
    ('Squalo', 'squalo', 32000, 'vip'),
    ('Suntrap', 'suntrap', 34000, 'vip'),
    ('Toro', 'toro', 38000, 'vip'),
    ('Toro Yacht', 'toro2', 38000, 'vip'),
    ('Tropic', 'tropic', 27000, 'vip'),
    ('Tropic Yacht', 'tropic2', 27000, 'vip')
;
