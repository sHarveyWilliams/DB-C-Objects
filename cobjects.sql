CREATE TABLE "observatory" (
  "id" SERIAL CONSTRAINT "pk_observatory" PRIMARY KEY,
  "o_name" TEXT NOT NULL
);

CREATE TABLE "instrument" (
  "id" SERIAL CONSTRAINT "pk_instrument" PRIMARY KEY,
  "name" TEXT NOT NULL,
  "description" TEXT NOT NULL,
  "observatory" INTEGER NOT NULL
);

CREATE INDEX "idx_instrument__observatory" ON "instrument" ("observatory");

ALTER TABLE "instrument" ADD CONSTRAINT "fk_instrument__observatory" FOREIGN KEY ("observatory") REFERENCES "observatory" ("id");

CREATE TABLE "object" (
  "id" SERIAL CONSTRAINT "pk_object" PRIMARY KEY,
  "observatory" INTEGER NOT NULL
);

CREATE INDEX "idx_object__observatory" ON "object" ("observatory");

ALTER TABLE "object" ADD CONSTRAINT "fk_object__observatory" FOREIGN KEY ("observatory") REFERENCES "observatory" ("id");

CREATE TABLE "information" (
  "id" SERIAL CONSTRAINT "pk_information" PRIMARY KEY,
  "object" INTEGER NOT NULL
);

CREATE INDEX "idx_information__object" ON "information" ("object");

ALTER TABLE "information" ADD CONSTRAINT "fk_information__object" FOREIGN KEY ("object") REFERENCES "object" ("id");

CREATE TABLE "astrometry" (
  "id" SERIAL CONSTRAINT "pk_astrometry" PRIMARY KEY,
  "parallax" DOUBLE PRECISION,
  "distance" TEXT NOT NULL ,
  "proper_motion" DOUBLE PRECISION,
  "information" INTEGER NOT NULL
);

CREATE INDEX "idx_astrometry__information" ON "astrometry" ("information");

ALTER TABLE "astrometry" ADD CONSTRAINT "fk_astrometry__information" FOREIGN KEY ("information") REFERENCES "information" ("id");

CREATE TABLE "characteristics" (
  "id" SERIAL CONSTRAINT "pk_characteristics" PRIMARY KEY,
  "spectral_type" TEXT NOT NULL,
  "variable_type" TEXT NOT NULL,
  "information" INTEGER NOT NULL
);

CREATE INDEX "idx_characteristics__information" ON "characteristics" ("information");

ALTER TABLE "characteristics" ADD CONSTRAINT "fk_characteristics__information" FOREIGN KEY ("information") REFERENCES "information" ("id");

CREATE TABLE "observation_data" (
  "id" SERIAL CONSTRAINT "pk_observation_data" PRIMARY KEY,
  "constellation" TEXT NOT NULL,
  "right_ascension" TEXT NOT NULL,
  "declination" TEXT NOT NULL,
  "apparent_magnitude" DOUBLE PRECISION,
  "information" INTEGER NOT NULL
);

CREATE INDEX "idx_observation_data__information" ON "observation_data" ("information");

ALTER TABLE "observation_data" ADD CONSTRAINT "fk_observation_data__information" FOREIGN KEY ("information") REFERENCES "information" ("id");

CREATE TABLE "physical_prop" (
  "id" SERIAL CONSTRAINT "pk_physical_prop" PRIMARY KEY,
  "mass" TEXT NOT NULL,
  "radius" DOUBLE PRECISION,
  "luminosity" TEXT NOT NULL,
  "temperature" DOUBLE PRECISION,
  "rotation" DOUBLE PRECISION,
  "information" INTEGER NOT NULL
);

CREATE INDEX "idx_physical_prop__information" ON "physical_prop" ("information");

ALTER TABLE "physical_prop" ADD CONSTRAINT "fk_physical_prop__information" FOREIGN KEY ("information") REFERENCES "information" ("id");

CREATE TABLE "star_name" (
  "id" SERIAL CONSTRAINT "pk_star_name" PRIMARY KEY,
  "name" TEXT NOT NULL,
  "object" INTEGER NOT NULL,
  "other_names" TEXT NOT NULL
);

CREATE INDEX "idx_star_name__object" ON "star_name" ("object");

ALTER TABLE "star_name" ADD CONSTRAINT "fk_star_name__object" FOREIGN KEY ("object") REFERENCES "object" ("id");

CREATE TABLE "types" (
  "id" SERIAL CONSTRAINT "pk_types" PRIMARY KEY,
  "object" INTEGER,
  "type_of_object" TEXT NOT NULL
);

CREATE INDEX "idx_types__object" ON "types" ("object");

ALTER TABLE "types" ADD CONSTRAINT "fk_types__object" FOREIGN KEY ("object") REFERENCES "object" ("id");

INSERT INTO observatory VALUES
    (1, 'Национальная обсерватория Китт-Пик'),
    (2, 'Космическая обсерватория НАСА'),
    (3, 'Бюраканская астрофизическая обсерватория'),
    (4, 'Обсерватория Гёте Линка'),
    (5, 'Венская обсерватория'),
    (6, 'Межамериканская обсерватория Серро-Тололо'),
    (7, 'Обсерватория Фабра'),
    (8, 'ТЕСИС'),
    (9, 'Республиканская обсерватория Йоханнесбурга'),
    (10, 'Кёнигсбергска обсерватория'),
    (11, 'Неизвестно'),
    (12, 'Гарвардская обсерватория'),
    (13, 'Обсерватория Дадли')
;

INSERT INTO instrument VALUES
    (0, 'KPNO 2.1 m Telescope', 'Телескоп', 1),
    (2, 'RCT Consortium Telescope', 'Робот-телескоп', 1),
    (3, 'Spacewatch', '0,9-м телескоп', 1),
    (4, 'SOLIS', 'мониторинг переменности солнечного излучения', 1),
    (5, 'McMath', '1.6-м f/54 солнечный телескоп', 1),
    (6, 'Кэплер', 'Телескоп)', 2),
    (7, 'Высокоточная астрономическая установка', 'Телескоп)', 3),
    (8, 'ЗТА-2.6', 'Телескоп)', 3),
    (9, 'телескоп имени Виктора Бланко ', 'Телескоп)', 3),
    (10, 'SOAR', 'Телескоп)', 3),
    (11, 'Экваториальный телескоп', 'Телескоп)', 10),
    (12, 'Гелиометр Фраунгофера', 'Телескоп)', 10),
    (13, 'Неизвестно', 'none', 11),
    (14, '15-дюймовый Великий рефрактор', 'Телескоп)', 12),
    (15, 'Frank L. Fullam', 'Радиотелескоп', 13)
;

INSERT INTO object VALUES
    (1, 1),
    (2, 2),
    (3, 2),
    (4, 2),
    (5, 6),
    (6, 2),
    (7, 2),
    (8, 10),
    (9, 11),
    (10, 11),
    (11, 11)
;

INSERT INTO information VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10),
    (11, 11)
;

INSERT INTO astrometry VALUES
    (1, '0', '1.26', '0', 2),
    (2, '50.09', '65', '62', 3),
    (3, '0', '1.496E8', '0', 4),
    (4, '7.56', '434', '-11.34', 6),
    (5, '31.12', '105', '-66', 7),
    (6, '379.21', '8.6', '0', 6),
    (7, '20.49', '159', '-85.92', 7),
    (8, '18.41', '177', '-112.15', 10),
    (9, '202.52', '16', '-817', 11)
;

INSERT INTO characteristics VALUES
    (1, 'Желтые карлики', 'Переменные звезды, изменения блеска которых лишены каких-либо признаков периодичности ', 2),
    (2, 'Красные карлики', 'Переменные звезды, изменения блеска которых лишены каких-либо признаков периодичности ', 3),
    (3, 'Желтые карлики', 'none', 4),
    (4, 'Объекты рассеянного диска', 'none', 5),
    (5, 'Желтые карлики', 'Цефеида', 6),
    (6, 'Белые субгиганты', 'none', 7),
    (7, 'Желтый карлики', 'none', 8),
    (8, 'Белые гиганты', 'none', 9),
    (9, 'Оранжевые гиганты', 'none', 10),
    (10, 'Красные карлики', 'none', 11)
;

INSERT INTO observation_data VALUES
    (1,'Лебедь', '19 ч 48 м 27.622 с', 'none', '15.21', 2),
    (2,'Телец', '04 ч 35 м 55.2 с', '+16° 30′ 33″', '13.50', 3),
    (3,'Солнечная система', '19 ч 4 мин 30 с', '+63,87°', '-26.74', 4),
    (4,'Солнечная система', 'none', 'none', 5),
    (5,'Малая медведица', '02ч 31м 48,7с', '+83°', '1.97', 6),
    (6,'Близнецы', '06 ч 37 м 42.7 с', '+66', '1.93', 7),
    (7,'Большой пес', '06 ч 45 м 08.9173 с', ' 	−16° 42′ 58.017″', '-1.4', 7),
    (8,'Заяц', '05 ч 28 м 14.72 с', 'none', '2.84', 8),
    (9,'Андромеда', '01 ч 37 м 59.56 с', '+48° 37′ 41,6″', '3.57', 10),
    (10,'21 ч 33 м 33.9752 с', '-49° 00′ 32,422″', '8.67', 11)
;

INSERT INTO physical_prop VALUES
    (1, '2.7E10', '162.05', 'none', '270', '30', 1),
    (2, '1.889E30', '765300', 'none', '900', '0', 2),
    (3, '3.381E30', '30750000', '1.982E26', '3875', '30', 3),
    (4, '2.7E10', '695000', '3.828E26', '270', '0', 4),
    (5, '2.3E16', '14000', 'none', '2', '0', 5),
    (6, '8.95E30', '32002200', '841.4E26', '7000', '17', 6),
    (7, '5.589E30', '2296800', '61.32E26', '9750', '15', 7),
    (8, '3.97784E30', '1183200', '84E26', '9948', '0', 8),
    (9, '5.96676E30', '1136000', 'none', '5225', '11', 9),
    (10, '4.5724E30', '1493200', '84E26', '3500', '56', 10),
    (11, '0.894E30', '3346000', 'none', '3300', '0', 11)
;


INSERT INTO star_name VALUES
    (1, 'Апофис', 1, '2004 MN4'),
    (2, 'Кеплер 11б', 2, 'none'),
    (3, 'Альдебаран', 3, 'α Tauri, Parilicium, Cor Tauri, Paliliya, 87 Tauri, Gl 171.1A/B, GJ 9159 A/B, HR 1457, BD +16°629 A/B'),
    (4, 'Солнце', 4, '2004 MN4'),
    (5, 'Полярная звезда', 6, 'Polaris, Cynosura, Alruccabah, Phoenice, Lodestar, Pole Star, Tramontana, Angel Stern, Navigatoria, Star of Arcady, Yilduz, Mismar, Polyarnaya, 1 Ursae Minoris'),
    (6, 'Альхена', 7, 'HR 2421, BD +16°1223, HD 47105,GCTP1539.00, SAO 95912, FK5 251, HIP 31681'),
    (7, 'Сириус', 8, 'HD 48915, HIP 32349, HR 2491, BD −16°1591, CCDM J06451-1643 Сириус, α CMa, 9 CMa, альфа Большого Пса'),
    (8, 'Нихал', 9, 'β Зайца, Бета Зайца, 9 Зайца, Nihal, β Lep, Beta Leporis, Beta Lep, 9 Leporis, 9 Lep, BU 320A, ADS 4066 A'),
    (9, '51 Андромеды', 8, 'льфа Большого Пса'),
    (10, 'Глизе 832', 9, ' Leporis, 9 Lep, BU 320A, ADS 4066 A')

;

INSERT INTO types VALUES
    (1, 1, 'Астероиды'),
    (2, 2, 'Экзопланеты'),
    (3, 3, 'Звезды'),
    (4, 4, 'Звезды'),
    (5, 5, 'Астероиды'),
    (6, 6, 'Звезды'),
    (7, 7, 'Астероиды'),
    (8, 8, 'Звезды'),
    (9, 9, 'Звезды'),
    (10, 10, 'Звезды'),
    (11, 11, 'Звезды')
;



DELETE FROM instrument WHERE id = '0';

SELECT * FROM observation_data;

DELETE FROM observation_data WHERE id='3';

DROP TABLE observation_data;


