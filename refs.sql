-- Скрипт перенакатываемый, можно выделить всё и выполнить чтобы пересоздать все справочники
-- (если коненчо у вас на них ничего не ссылается)

-- Справочник "Единицы измерения"
drop table if exists product; -- Для быстрого перенаката всего скрипта
drop table if exists unit_measurement; -- Для быстрого перенаката всего скрипта
--
create table unit_measurement (
	id_unit_measurement int,              -- Id
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
--
--
drop table if exists employee;
drop table if exists role;
drop table if exists payment;
drop table if exists rate;
drop table if exists job;
-- Справочник "Роли" (в эл. системе)
create table role (
	id_role     int,              -- Id
	name        varchar not null, -- наименование
	description varchar,          -- описание
	constraint role_pk primary key (id_role)
);
-- DML role
insert into role (id_role, name, description)
values (1, 'Сотрудник', 'Видит и редактирует почти всё');
insert into role (id_role, name, description)
values (2, 'Директор', 'Видит и редактирует ВСЁ');

-- Справочник "Должности"
create table job (
	id_job      int,              -- Id
	name        varchar not null, -- наименование
	description varchar,          -- описание
	constraint job_pk primary key (id_job)
);
-- DML job
insert into job (id_job, name, description)
values (1, 'Кладовщик', 'Работа на складе');
insert into job (id_job, name, description)
values (2, 'Продавец', 'Кладовщик, но который бегает на кассу');
insert into job (id_job, name, description)
values (3, 'Товаровед', 'Всё сразу');
insert into job (id_job, name, description)
values (4, 'Директор', 'Самая важная работа');

-- справочник "Ставки"
create table rate (
	id_rate int,              -- Id
	name    varchar not null, -- наименование
	constraint rate_pk primary key (id_rate)
);
-- DML rate
insert into rate (id_rate, name)
values (1, '0.25');
insert into rate (id_rate, name)
values (2, '0.50');
insert into rate (id_rate, name)
values (3, '0.75');
insert into rate (id_rate, name)
values (4, '1.0');

-- Справочник "Отлата-часы"
create table payment (
	id_payment      int,          -- Id
	id_rate         int,          -- код ставки
	id_job          int,          -- код должности
	hours_per_month int not null, -- кол-во часов в месяц (1.0 ставки)
	min_salary      int not null, -- мин. зарплата (RUB)
	max_salary      int,          -- макс. зарплата (RUB)
	-- возможно для отслеживания стоит создать таблицу payment_history, но мб и держать это здесь
	/*start_date date,
	end_date date*/
	constraint payment_pk primary key (id_payment),
	constraint payment_fk1 foreign key (id_rate) references rate (id_rate),
	constraint payment_fk2 foreign key (id_job) references job (id_job)
);
create index payment_i1 on payment (id_rate);
create index payment_i2 on payment (id_job);
-- DML payment
-- кладовщик
insert into payment (id_payment, id_rate, id_job, hours_per_month, min_salary, max_salary)
values (1, 1, 1, 40, 7500, 15000);
insert into payment (id_payment, id_rate, id_job, hours_per_month, min_salary, max_salary)
values (2, 2, 1, 80, 15000, 30000);
insert into payment (id_payment, id_rate, id_job, hours_per_month, min_salary, max_salary)
values (3, 3, 1, 120, 22500, 45000);
insert into payment (id_payment, id_rate, id_job, hours_per_month, min_salary, max_salary)
values (4, 4, 1, 160, 30000, 60000);
-- продавец
insert into payment (id_payment, id_rate, id_job, hours_per_month, min_salary, max_salary)
values (5, 1, 2, 40, 8750, 17500);
insert into payment (id_payment, id_rate, id_job, hours_per_month, min_salary, max_salary)
values (6, 2, 2, 80, 17500, 35000);
insert into payment (id_payment, id_rate, id_job, hours_per_month, min_salary, max_salary)
values (7, 3, 2, 120, 26250, 52500);
insert into payment (id_payment, id_rate, id_job, hours_per_month, min_salary, max_salary)
values (8, 4, 2, 160, 35000, 70000);
-- товаровед
insert into payment (id_payment, id_rate, id_job, hours_per_month, min_salary, max_salary)
values (9, 1, 3, 40, 7500, 15000);
insert into payment (id_payment, id_rate, id_job, hours_per_month, min_salary, max_salary)
values (10, 2, 3, 80, 15000, 30000);
insert into payment (id_payment, id_rate, id_job, hours_per_month, min_salary, max_salary)
values (11, 3, 3, 120, 22500, 45000);
insert into payment (id_payment, id_rate, id_job, hours_per_month, min_salary, max_salary)
values (12, 4, 3, 160, 30000, 60000);
-- директор
insert into payment (id_payment, id_rate, id_job, hours_per_month, min_salary, max_salary)
values (13, 1, 4, 40, 12500, 25000);
insert into payment (id_payment, id_rate, id_job, hours_per_month, min_salary, max_salary)
values (14, 2, 4, 80, 25000, 50000);
insert into payment (id_payment, id_rate, id_job, hours_per_month, min_salary, max_salary)
values (15, 3, 4, 120, 37500, 75000);
insert into payment (id_payment, id_rate, id_job, hours_per_month, min_salary, max_salary)
values (16, 4, 4, 160, 50000, 100000);

-- Справочник "Сотрудники"
create table employee (
	id_employee    int, -- Id
	fio            varchar not null, -- фио
	pass_info      varchar not null, -- паспортные данные. Пока строка. Возможно будет fk id на таблицу паспортов (Команда HR решит)
	birthday       date,             -- дата рождения
	id_job         int,              -- код должности fk
	id_payment     int,              -- код "отплата-часы" fk
	salary         int     not null, -- зарплата (RUB)
	--id_department  int,              -- подразделение /* какое подразделение, если ИС для ОДНОГО магазина??? */
	login          varchar not null, -- логин
	pass           varchar not null, -- хэш пароля
	id_role        int     not null, -- роль в системе
	phone          varchar,          -- рабочий телефон
	personal_phone varchar,          -- личный телефон
	email          varchar,          -- эл. почта
	constraint employee_pk primary key (id_employee),
	constraint employee_fk1 foreign key (id_role) references role (id_role),
	constraint employee_fk2 foreign key (id_job) references job (id_job),
	constraint employee_fk3 foreign key (id_payment) references payment (id_payment)
);
create index employee_i1 on employee (id_role);
create index employee_i2 on employee (id_job);
create index employee_i3 on employee (id_payment);
-- DML employee
-- 3 кладовщика
insert into employee (id_employee, fio, pass_info, birthday, id_job, id_payment, salary, login, pass, id_role, phone, personal_phone, email)
values (1, 'Сабля Дмитрий Петрович', '3537 875362 г. Краснодар', '1979-02-12', 1, 4, 45000, 'DPSablya', md5('sablya123'), 1, '+72348764512', '+72348764512', 'sab@mail.ru');
insert into employee (id_employee, fio, pass_info, birthday, id_job, id_payment, salary, login, pass, id_role, phone, personal_phone, email)
values (2, 'Мишкина Александра Дмитриевна', '6472 764532 г. Краснодар', '1982-05-27', 1, 3, 42000, 'ADMishkina', md5('mishkina123'), 1, '+72346479663', '+72346479663', 'mish@yandex.ru');
insert into employee (id_employee, fio, pass_info, birthday, id_job, id_payment, salary, login, pass, id_role, phone, personal_phone, email)
values (3, 'Синица Василий Федорович', '5327 987445 г. Краснодар', '1974-03-13', 1, 4, 45000, 'VFSinitsa', md5('sinitsa123'), 1, '+78765532197', '+78765532197', 'sin337@kubsu.ru');
-- 4 продавца
insert into employee (id_employee, fio, pass_info, birthday, id_job, id_payment, salary, login, pass, id_role, phone, personal_phone, email)
values (4, 'Фомин Кирилл Игоревич', '0317 656600 г. Краснодар', '1983-09-07', 2, 8, 50000, 'KIFomin', md5('fomin123'), 1, '+76457789017', '+76457789017', 'fom@mail.ru');
insert into employee (id_employee, fio, pass_info, birthday, id_job, id_payment, salary, login, pass, id_role, phone, personal_phone, email)
values (5, 'Рогаткина Елена Сергеевна', '6534 875600 г. Краснодар', '1990-03-18', 2, 6, 30000, 'ESRogatkina', md5('rogatkina123'), 1, '+79187653402', '+79187653402', 'rogat@gmail.com');
insert into employee (id_employee, fio, pass_info, birthday, id_job, id_payment, salary, login, pass, id_role, phone, personal_phone, email)
values (6, 'Касаткина Мария Павловна', '5309 760076 г. Краснодар', '1982-02-25', 2, 8, 55000, 'MPKasatkina', md5('kasatkina123'), 1, '+73859768918', '+73859768918', 'kasat@mail.ru');
insert into employee (id_employee, fio, pass_info, birthday, id_job, id_payment, salary, login, pass, id_role, phone, personal_phone, email)
values (7, 'Громов Иван Денисович', '7653 009654 г. Краснодар', '1992-11-13', 2, 8, 50000, 'IDGromov', md5('gromov123'), 1, '+78552340899', '+78552340899', 'grom@ya.ru');
-- 2 товароведа
insert into employee (id_employee, fio, pass_info, birthday, id_job, id_payment, salary, login, pass, id_role, phone, personal_phone, email)
values (8, 'Афонин Михаил Ильич', '0512 764500 г. Краснодар', '2001-03-12', 3, 12, 40000, 'MIAfonin', md5('afonin123'), 1, '+78765670955', '+78765670955', 'afonin@yandex.ru');
insert into employee (id_employee, fio, pass_info, birthday, id_job, id_payment, salary, login, pass, id_role, phone, personal_phone, email)
values (9, 'Королева Инга Михайловна', '6354 760077 г. Краснодар', '2002-05-02', 3, 11, 35000, 'IMKoroleva', md5('koroleva123'), 1, '+79183458765', '+79183458765', 'koroleva@yandex.ru');
-- 1 директор
insert into employee (id_employee, fio, pass_info, birthday, id_job, id_payment, salary, login, pass, id_role, phone, personal_phone, email)
values (10, 'Заврежнов Стас Дмитриевич', '6521 987645 г. Флорида', '1975-12-11', 4, 16, 90000, 'SDZavrezhnov', md5('zavrezhnov123'), 1, '+79543450766', '+79543450766', 'zavrezhnov@gmail.com');
