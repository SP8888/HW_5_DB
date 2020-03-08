-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
-- Заполните их текущими датой и временем.

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';


INSERT users VALUES (NULL, 'Alex', '1990-10-02', NULL, NULL);
INSERT users VALUES (NULL, 'Anton', '1989-10-02', NULL, NULL);
INSERT users VALUES (NULL, 'Boris', '1987-10-02', NULL, NULL);
INSERT users VALUES (NULL, 'Olga', '1995-10-02', NULL, NULL);
INSERT users VALUES (NULL, 'Violeta', '1993-10-02', NULL, NULL);

SELECT * FROM users;

UPDATE
  users SET
  	created_at = NOW(),
 	updated_at = NOW();
 
 
-- Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы 
-- типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". 
-- Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = 'Покупатели';
 
DROP TABLE IF EXISTS users_new;
CREATE TABLE users_new (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

desc users;
desc users_new;


INSERT users VALUES (NULL, 'Alex', '1990-10-02', "20.10.2017 8:10", "20.10.2017 8:10");
INSERT users VALUES (NULL, 'Anton', '1989-10-02', "20.10.2017 8:10", "20.10.2017 8:10");
INSERT users VALUES (NULL, 'Boris', '1987-10-02', "20.10.2017 8:10", "20.10.2017 8:10");
INSERT users VALUES (NULL, 'Olga', '1995-10-02', "20.10.2017 8:10", "20.10.2017 8:10");
INSERT users VALUES (NULL, 'Violeta', '1993-10-02', "20.10.2017 8:10", "20.10.2017 8:10");
 
SELECT * FROM users;


INSERT INTO users_new (name, birthday_at, created_at, updated_at) 
		SELECT name,
		birthday_at,
		STR_TO_DATE(created_at,'%e.%c.%Y %h:%i'),
		STR_TO_DATE(updated_at,'%e.%c.%Y %h:%i')
		FROM users;

SELECT * FROM users_new;

DROP TABLE IF EXISTS users;

ALTER TABLE users_new RENAME users;

DESC users;

-- или второй вариант

SELECT * FROM users;

UPDATE
  users
SET
  created_at = STR_TO_DATE(created_at, '%e.%c.%Y %h:%i'),
  updated_at = STR_TO_DATE(updated_at, '%e.%c.%Y %h:%i');

ALTER TABLE
  users
CHANGE
  created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE
  users
CHANGE
  updated_at updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

DESC users;

 
-- В таблице складских запасов storehouses_products в поле value могут встречаться 
-- самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы.
-- Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения 
-- значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.

DROP TABLE IF EXISTS storehouses_products;

CREATE TABLE `storehouses_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `value` int(10) unsigned DEFAULT NULL COMMENT 'Запас товарной позиции на складе',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Запасы на складе';

INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('1', 26, '1988-07-23 10:28:15', '2019-01-12 11:12:51');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('2', 55, '2017-07-07 18:34:02', '2012-08-11 18:54:07');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('3', 0, '1996-01-08 10:06:11', '2005-02-04 00:47:20');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('4', 73, '1978-01-28 03:28:30', '1991-05-23 21:55:23');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('5', 47, '1986-06-10 15:41:12', '1985-01-05 12:03:43');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('6', 45, '2017-04-10 15:56:01', '1985-08-18 00:57:22');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('7', 53, '1977-09-03 11:38:28', '2012-10-26 17:01:42');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('8', 62, '2019-04-04 03:04:00', '1989-10-27 10:17:13');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('9', 2, '1992-06-04 10:36:13', '1978-10-31 10:46:38');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('10', 0, '2011-09-10 11:33:14', '2003-11-29 06:23:16');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('11', 72, '1989-09-24 20:53:05', '2014-12-05 11:52:39');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('12', 55, '1996-10-19 19:45:26', '2001-08-07 06:14:53');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('13', 22, '1998-07-08 07:14:08', '1987-12-30 19:33:03');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('14', 31, '1982-01-08 16:17:27', '2004-07-02 08:35:37');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('15', 0, '2007-08-25 20:22:15', '1986-03-10 11:29:19');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('16', 13, '1990-04-27 11:24:01', '2010-03-25 02:57:35');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('17', 75, '1982-01-10 18:18:12', '2007-08-09 16:37:58');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('18', 0, '1988-01-05 08:02:34', '2006-12-09 06:09:10');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('19', 59, '2010-01-16 09:06:24', '2000-07-05 19:09:44');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('20', 64, '1986-11-03 17:43:27', '1972-02-26 00:50:41');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('21', 48, '1992-11-01 14:45:38', '1972-05-19 10:57:43');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('22', 35, '2014-11-30 15:00:34', '1999-06-02 20:36:36');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('23', 0, '1974-08-15 14:30:53', '1995-07-07 02:45:18');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('24', 30, '1998-02-18 08:51:49', '2000-07-11 09:09:29');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('25', 32, '2002-04-21 05:42:49', '1971-04-16 04:53:23');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('26', 75, '2011-10-25 18:50:37', '1990-11-06 04:15:24');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('27', 0, '2002-06-24 01:59:33', '1979-01-26 15:19:12');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('28', 40, '2006-01-07 15:34:47', '1989-06-10 00:02:04');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('29', 86, '1999-08-28 18:35:21', '1983-09-14 10:28:53');
INSERT INTO `storehouses_products` (`id`, `value`, `created_at`, `updated_at`) VALUES ('30', 48, '2012-03-03 01:28:04', '1970-08-30 13:22:48');

SELECT * FROM storehouses_products;



SELECT * FROM storehouses_products  ORDER BY value = 0, value DESC;

-- (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
-- Месяцы заданы в виде списка английских названий ('may', 'august')

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Имя покупателя',
  `birthday_at` date DEFAULT NULL COMMENT 'Дата рождения',
  `created_at` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `updated_at` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Покупатели';

INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('1', 'Dustin Abernathy', '1976-05-25', '1999-02-18', '1955-09-19 20:30:28');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('2', 'Harrison Zulauf Jr.', '2011-06-28', '1980-05-03', '2006-01-18 22:33:24');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('3', 'Dave Bergstrom', '1997-04-30', '2017-08-10', '2012-07-23 06:50:19');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('4', 'Dr. Americo Huels', '1978-04-23', '1992-04-06', '1993-06-06 14:40:07');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('5', 'Mabelle Windler IV', '2005-02-11', '1995-03-09', '1924-03-27 02:16:03');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('6', 'Mercedes Bayer', '1992-10-20', '1976-07-14', '1974-09-18 22:24:18');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('7', 'Colt Bode', '2006-05-29', '2000-06-11', '1949-06-01 04:15:33');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('8', 'Issac Yost', '2015-10-08', '2012-05-01', '1986-04-28 00:02:34');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('9', 'Mrs. Elouise Hudson MD', '2008-03-29', '2018-11-14', '1930-07-12 01:43:08');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('10', 'Helga Waelchi', '1986-06-12', '1976-06-27', '1943-12-04 01:01:40');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('11', 'Gene Reynolds IV', '2009-06-07', '1991-07-19', '1921-03-06 02:09:32');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('12', 'Janie Davis', '1986-08-15', '1994-12-18', '1924-09-13 21:18:30');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('13', 'Clifford Bartoletti PhD', '1996-03-04', '1976-11-28', '1933-05-01 02:58:27');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('14', 'Callie White', '2008-04-11', '2001-06-22', '1970-02-28 06:02:36');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('15', 'Candido Hamill', '1982-04-08', '1992-07-14', '1934-09-26 02:59:11');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('16', 'Mrs. Dasia Armstrong', '1989-03-02', '2018-08-08', '1982-10-07 23:49:55');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('17', 'Lukas Hauck', '2003-03-29', '1976-02-23', '1946-12-23 01:07:50');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('18', 'Daphnee Lesch', '1982-06-26', '1979-05-23', '2010-07-02 06:17:15');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('19', 'Daren Yost', '1977-07-21', '2007-05-03', '1979-08-05 12:27:36');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('20', 'Flossie Jaskolski', '2017-01-20', '2010-01-09', '1929-07-27 10:34:30');

SELECT * FROM users;

UPDATE
  users
SET
  created_at = DATE_FORMAT(birthday_at, '%e-%b-%Y');
 
 SELECT * FROM users WHERE DATE_FORMAT(birthday_at, '%c ') = 5 
						or DATE_FORMAT(birthday_at, '%c ') = 8;
					
					
-- (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. 
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.
 
use shop;

INSERT INTO catalogs VALUES (4, 'Ножки от стула');
INSERT INTO catalogs VALUES (5, 'Матрешки');

SELECT * FROM catalogs WHERE id IN (5, 1, 2);

SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY
  FIELD(id, 5, 1, 2);
 
 -- Подсчитайте средний возраст пользователей в таблице users
 
 
DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Имя покупателя',
  `birthday_at` date DEFAULT NULL COMMENT 'Дата рождения',
  `created_at` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `updated_at` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Покупатели';

INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('1', 'Dustin Abernathy', '1976-05-25', '1999-02-18', '1955-09-19 20:30:28');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('2', 'Harrison Zulauf Jr.', '2011-06-28', '1980-05-03', '2006-01-18 22:33:24');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('3', 'Dave Bergstrom', '1997-04-30', '2017-08-10', '2012-07-23 06:50:19');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('4', 'Dr. Americo Huels', '1978-04-23', '1992-04-06', '1993-06-06 14:40:07');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('5', 'Mabelle Windler IV', '2005-02-11', '1995-03-09', '1924-03-27 02:16:03');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('6', 'Mercedes Bayer', '1992-10-20', '1976-07-14', '1974-09-18 22:24:18');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('7', 'Colt Bode', '2006-05-29', '2000-06-11', '1949-06-01 04:15:33');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('8', 'Issac Yost', '2015-10-08', '2012-05-01', '1986-04-28 00:02:34');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('9', 'Mrs. Elouise Hudson MD', '2008-03-29', '2018-11-14', '1930-07-12 01:43:08');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('10', 'Helga Waelchi', '1986-06-12', '1976-06-27', '1943-12-04 01:01:40');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('11', 'Gene Reynolds IV', '2009-06-07', '1991-07-19', '1921-03-06 02:09:32');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('12', 'Janie Davis', '1986-08-15', '1994-12-18', '1924-09-13 21:18:30');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('13', 'Clifford Bartoletti PhD', '1996-03-04', '1976-11-28', '1933-05-01 02:58:27');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('14', 'Callie White', '2008-04-11', '2001-06-22', '1970-02-28 06:02:36');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('15', 'Candido Hamill', '1982-04-08', '1992-07-14', '1934-09-26 02:59:11');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('16', 'Mrs. Dasia Armstrong', '1989-03-02', '2018-08-08', '1982-10-07 23:49:55');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('17', 'Lukas Hauck', '2003-03-29', '1976-02-23', '1946-12-23 01:07:50');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('18', 'Daphnee Lesch', '1982-06-26', '1979-05-23', '2010-07-02 06:17:15');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('19', 'Daren Yost', '1977-07-21', '2007-05-03', '1979-08-05 12:27:36');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('20', 'Flossie Jaskolski', '2017-01-20', '2010-01-09', '1929-07-27 10:34:30');

SELECT * FROM users;

SELECT AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) FROM users;

-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.

SELECT
  DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day,
  COUNT(*) AS total
FROM
  users
GROUP BY
  day
ORDER BY
  total DESC;

-- (по желанию) Подсчитайте произведение чисел в столбце таблицы
-- (это я не сам)

 CREATE TABLE value (
		id SERIAL PRIMARY KEY,
		val INT 
 );

INSERT value (val) VALUES (5);

SELECT * FROM value;

SELECT ROUND(EXP(SUM(LN(id)))) FROM value;

