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

ALTER TABLE "types" ADD CONSTRAINT "fk_types__object" FOREIGN KEY ("object") REFERENCES "object" ("id")

INSERT INTO observatory VALUES
    (1, 'Национальная обсерватория Китт-Пик'),
    (2, 'Космическая обсерватория НАСА');

INSERT INTO instrument VALUES
    (0, 'KPNO 2.1 m Telescope', 'Телескоп', 1),
    (2, 'RCT Consortium Telescope', 'Робот-телескоп', 1),
    (3, 'Spacewatch', '0,9-м телескоп', 1),
    (4, 'SOLIS', 'мониторинг переменности солнечного излучения', 1),
    (5, 'McMath', '1.6-м f/54 солнечный телескоп', 1),
    (6, 'Кэплер', 'Телескоп)', 2)
;

INSERT INTO object VALUES
    (1, 1),
    (2, 2),
    (3, 2),
    (4, 2);

INSERT INTO information VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4);

INSERT INTO astrometry VALUES
    (1, '0', '1.26', '0', 2),
    (2, '50.09', '65', '62', 3),
    (3, '0', '1.496E8', '0', 4);

INSERT INTO characteristics VALUES
    (1, 'Желтый карлик', 'Медленно меняющиеся неправильные переменные поздних спектральных классов К, М, углеродные звезды и звезды S типа, как правило, гиганты. К этому типу отнесены медленные красные неправильные переменные и в тех случаях, когда их спектральные классы и светимости ещё неизвестны.', 2),
    (2, 'Красный карлик', 'Медленно меняющиеся неправильные переменные поздних спектральных классов К, М, углеродные звезды и звезды S типа, как правило, гиганты. К этому типу отнесены медленные красные неправильные переменные и в тех случаях, когда их спектральные классы и светимости ещё неизвестны.', 3),
    (3, 'Желтый карлик', 'Неправильные переменные сверхгиганты поздних спектральных классов с амплитудой изменения яркости', 4);

INSERT INTO observation_data VALUES
    (1,'Лебедь', '19 ч 48 м 27.622 с', 'none', 'none', 2),
    (2,'Телец', '04 ч 35 м 55.2 с', '+16° 30′ 33″', '13.50', 3),
    (3,'none', '19 ч 4 мин 30 с', '+63,87°', '-26.74', 4);

INSERT INTO physical_prop VALUES
    (1, '2.7E10', '162.05', 'none', '270', '30', 1),
    (2, '1.889E30', '765300', 'none', '900', '0', 2),
    (3, '3.381E30', '30750000', '600E26', '3875', '30', 1),
    (4, '2.7E10', '695000', '3.828E26', '270', '0', 1)
    ;


INSERT INTO star_name VALUES
    (1, 'Апофис', 1, '2004 MN4'),
    (2, 'Кеплер 11б', 2, 'none'),
    (3, 'Альдебаран', 3, 'α Tauri, Parilicium, Cor Tauri, Paliliya, 87 Tauri, Gl 171.1A/B, GJ 9159 A/B, HR 1457, BD +16°629 A/B'),
    (4, 'Солнце', 4, '2004 MN4')
    ;

INSERT INTO types VALUES
    (1, 1, 'Астероиды'),
    (2, 2, 'Экзопланеты'),
    (3, 3, 'Звезды'),
    (4, 4, 'Звезды');




DELETE FROM instrument WHERE id = '0';

SELECT * FROM observation_data

