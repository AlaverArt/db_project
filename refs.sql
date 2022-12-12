-- Справочник "Единицы измерения"
drop table if exists product; -- Для быстрого перенаката всего скрипта
drop table if exists unit_measurement; -- Для быстрого перенаката всего скрипта
--
create table unit_measurement (
	id_unit_measurement int, 		 	  -- Id
	name                varchar not null, -- Наименование единицы измерения
	constraint unit_measurement_pk primary key (id_unit_measurement)
);
-- DML unit_measurement
insert into unit_measurement (id_unit_measurement, name)
values (1, 'шт');
insert into unit_measurement (id_unit_measurement, name)
values (2, 'кг');

-- Справочник "Товары"
create table product (
	id_product       int,              -- Id
	name             varchar not null, -- наименование
	exp_date_in_days int     not null, -- технический срок годности
	id_unit_meas     int     not null, -- единица измерения
	id_vendor        int,              -- производитель / изготовитель
	name_vendor      varchar,          -- название компании производителя
	country_vendor   varchar,          -- страна производителя
	sizes            varchar,          -- 'height-width-length' (миллиметры)
	barcode          varchar not null, -- штрих-код
	constraint product_pk primary key (id_product),
	constraint product_fk1 foreign key (id_unit_meas) references unit_measurement (id_unit_measurement)
);
--
create index product_i1 on product (id_unit_meas);
-- DML product
insert into product (id_product, name, exp_date_in_days, id_unit_meas, id_vendor, name_vendor, country_vendor, sizes, barcode)
values (1, 'Красное бордо', 360, 1 /*шт*/, 1 /*Delikate*/, 'Delicate', 'Франция', '400-90-90', '3003890042345');
insert into product (id_product, name, exp_date_in_days, id_unit_meas, id_vendor, name_vendor, country_vendor, sizes, barcode)
values (2, 'Индийский чай', 300, 1 /*шт*/, 2 /*Тибет*/, 'Тибет', 'Китай', '50-40-150', '3003890022946');
insert into product (id_product, name, exp_date_in_days, id_unit_meas, id_vendor, name_vendor, country_vendor, sizes, barcode)
values (3, 'Анисовый сироп', 700, 1 /*шт*/, 3 /*Fruct*/, 'Fruct', 'Россия', '100-50-50', '3023490022975');
insert into product (id_product, name, exp_date_in_days, id_unit_meas, id_vendor, name_vendor, country_vendor, sizes, barcode)
values (4, 'Тибетское пиво', 200, 1 /*шт*/, 2 /*Тибет*/, 'Тибет', 'Китай', '100-60-60', '3003800822472');
insert into product (id_product, name, exp_date_in_days, id_unit_meas, id_vendor, name_vendor, country_vendor, sizes, barcode)
values (5, 'Соленые огурцы', 925, 1 /*шт*/, 3 /*Fruct*/, 'Fruct', 'Россия', '180-100-100', '3003800829874');
insert into product (id_product, name, exp_date_in_days, id_unit_meas, id_vendor, name_vendor, country_vendor, sizes, barcode)
values (6, 'Апельсиновый сок', 200, 1 /*шт*/, 3 /*Fruct*/, 'Fruct', 'Россия', '250-80-80', '3003800815275');
insert into product (id_product, name, exp_date_in_days, id_unit_meas, id_vendor, name_vendor, country_vendor, sizes, barcode)
values (7, 'Йогурт клюквенный', 30, 1 /*шт*/, 4 /*Danone*/, 'Danone', 'Россия', '50-60-80', '4206482930461');
insert into product (id_product, name, exp_date_in_days, id_unit_meas, id_vendor, name_vendor, country_vendor, sizes, barcode)
values (8, 'Чипсы Lays с крабом', 970, 1 /*шт*/, 5 /*Lays*/, 'Lays', 'Россия', '200-100-150', '4203800829743');
insert into product (id_product, name, exp_date_in_days, id_unit_meas, id_vendor, name_vendor, country_vendor, sizes, barcode)
values (9, 'Картофель', 60, 2 /*кг*/, 3 /*Fruct*/, 'Fruct', 'Россия', '800-800-800', '3003800829874');

/*select * from product;
select * from unit_measurement;
drop table product;*/