USE `essentialmode`;

CREATE TABLE `shopsvip` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`store` varchar(100) NOT NULL,
	`item` varchar(100) NOT NULL,
	`price` int(11) NOT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `shopsvip` (store, item, price) VALUES
	('TwentyFourSeven','water',500),
	('TwentyFourSeven','bread',500),
	('RobsLiquor','water',500),
	('RobsLiquor','bread',500),
	('LTDgasoline','water',500),
	('LTDgasoline','bread',500)
;