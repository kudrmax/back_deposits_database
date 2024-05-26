# Задание

# Отчет

### ER-диаграмма

ER-диаграмма создана через DataGrip.

![ER.png](docs/ER.png)

### Код для создание базы данных

База данных создавалась вручную через GUI интерфейс DataGrip. Код ниже сгенерирован автоматически.

Например поэтому тут можно увидеть такие строки, как

```postgresql
id integer primary key not null default nextval('accounts_account_number_seq'::regclass),
```

Изначально вместо этой строки тут было

```postgresql
id serial primary key 
```

Код для создание БД:

```postgresql
create table public.accounts
(
    id         integer primary key not null default nextval('accounts_account_number_seq'::regclass),
    client_id  integer             not null,
    deposit_id integer             not null,
    date_open  date                not null,
    date_close date,
    amount     numeric(15, 2)      not null,
    foreign key (client_id) references public.clients (id)
        match simple on update no action on delete no action,
    foreign key (deposit_id) references public.deposits (id)
        match simple on update no action on delete no action
);

create table public.clients
(
    id          integer primary key    not null default nextval('clients_client_id_seq'::regclass),
    full_name   character varying(100) not null,
    passport    character varying(20)  not null,
    adress      character varying(200),
    phone       character varying(20),
    employee_id integer                not null,
    foreign key (employee_id) references public.employees (id)
        match simple on update no action on delete no action
);

create table currencies
(
    id     serial primary key,
    name   varchar(50)      not null,
    in_rub double precision not null
);

create table public.departments
(
    id   integer primary key   not null default nextval('departments_id_seq'::regclass),
    name character varying(50) not null
);

create table public.deposits
(
    id          integer primary key   not null default nextval('deposits_code_seq'::regclass),
    name        character varying(50) not null,
    duration    integer               not null,
    rate        numeric(5, 2)         not null,
    currency_id integer               not null,
    foreign key (currency_id) references public.currencies (id)
        match simple on update no action on delete no action
);

create table public.employees
(
    id            integer primary key not null default nextval('employees_employee_id_seq'::regclass),
    position_id   integer             not null,
    department_id integer             not null,
    foreign key (department_id) references public.departments (id)
        match simple on update no action on delete no action,
    foreign key (position_id) references public.positions (id)
        match simple on update no action on delete no action
);

create table public.positions
(
    id   integer primary key   not null default nextval('positions_id_seq'::regclass),
    name character varying(50) not null
);

```

### Наполнение базы данных данными

Заполним справочники

```postgresql
INSERT INTO public.currencies (name, in_rub)
VALUES ('Рубли', 1.00),
       ('Доллары США', 89.35),
       ('Юани', 12.60);

INSERT INTO public.departments (name)
VALUES ('Отдел вкладов'),
       ('Отдел обслуживания клиентов'),
       ('Отдел маркетинга');

INSERT INTO public.positions (name)
VALUES ('Менеджер'),
       ('Младший консультант'),
       ('Старший консультант'),
       ('Директор');

INSERT INTO public.deposits (name, duration, rate, currency_id)
VALUES ('Накопительный', 13, 10.00, 1),
       ('Капитал', 18, 7.00, 2),
       ('Друзья', 13, 2.00, 3),
       ('Пенсионный', 12, 12.00, 1),
       ('Молодежный', 36, 18.00, 1);
```

Наполним остальные таблицы вымышленными данными. Данные сгенерированны через ChatGPT:

```postgresql
INSERT INTO public.employees (position_id, department_id)
VALUES (1, 1),
       (2, 1),
       (3, 1),
       (4, 1),
       (1, 2),
       (2, 2),
       (3, 2),
       (4, 2),
       (1, 3),
       (2, 3),
       (3, 3),
       (4, 3),
       (1, 1),
       (2, 2),
       (3, 3),
       (4, 1),
       (1, 2),
       (2, 3),
       (3, 1),
       (4, 2);

INSERT INTO public.clients (full_name, passport, adress, phone, employee_id)
VALUES ('Иванов Иван Иванович', '1234 567890', 'ул. Пушкина, д.1', '89001234567', 1),
       ('Петров Петр Петрович', '2345 678901', 'ул. Лермонтова, д.2', '89007654321', 2),
       ('Сидоров Сидор Сидорович', '3456 789012', 'ул. Толстого, д.3', '89001237890', 3),
       ('Смирнова Анна Ивановна', '4567 890123', 'ул. Чехова, д.4', '89009876543', 4),
       ('Васильева Ольга Петровна', '5678 901234', 'ул. Гоголя, д.5', '89008765432', 5),
       ('Кузнецов Николай Сергеевич', '6789 012345', 'ул. Ленина, д.6', '89007654321', 6),
       ('Попов Алексей Дмитриевич', '7890 123456', 'ул. Маяковского, д.7', '89006543210', 7),
       ('Соколов Дмитрий Александрович', '8901 234567', 'ул. Достоевского, д.8', '89005432109', 8),
       ('Морозова Екатерина Андреевна', '9012 345678', 'ул. Некрасова, д.9', '89004321098', 1),
       ('Новиков Михаил Юрьевич', '0123 456789', 'ул. Белинского, д.10', '89003210987', 2),
       ('Фёдорова Наталья Владимировна', '1234 567891', 'ул. Островского, д.11', '89002109876', 3),
       ('Михайлова Алина Игоревна', '2345 678902', 'ул. Салтыкова, д.12', '89001098765', 4),
       ('Орлова Юлия Романовна', '3456 789013', 'ул. Тургенева, д.13', '89009876544', 5),
       ('Андреев Павел Олегович', '4567 890124', 'ул. Жуковского, д.14', '89008765433', 6),
       ('Волков Алексей Михайлович', '5678 901235', 'ул. Гончарова, д.15', '89007654322', 7),
       ('Зайцева Марина Викторовна', '6789 012346', 'ул. Есенина, д.16', '89006543211', 8);

INSERT INTO public.accounts (client_id, deposit_id, date_open, date_close, amount)
VALUES (1, 1, '2023-01-01', '2024-02-01', 100000.00),
       (2, 2, '2023-02-01', '2024-08-01', 2000.00),
       (3, 3, '2023-03-01', '2024-04-01', 15000.00),
       (4, 4, '2023-04-01', '2024-04-01', 50000.00),
       (5, 5, '2023-05-01', NULL, 30000.00),
       (6, 1, '2023-06-01', '2024-07-01', 120000.00),
       (7, 2, '2023-07-01', NULL, 2500.00),
       (8, 3, '2023-08-01', '2024-09-01', 17000.00),
       (9, 4, '2023-09-01', '2024-09-01', 55000.00),
       (10, 5, '2023-10-01', NULL, 32000.00),
       (11, 1, '2023-11-01', '2024-12-01', 130000.00),
       (12, 2, '2023-12-01', NULL, 3000.00),
       (13, 3, '2024-01-01', '2025-02-01', 20000.00),
       (14, 4, '2024-02-01', '2025-02-01', 60000.00),
       (15, 5, '2024-03-01', NULL, 35000.00),
       (16, 1, '2024-04-01', NULL, 140000.00),
       (17, 2, '2024-05-01', NULL, 3500.00),
       (18, 3, '2024-06-01', NULL, 22000.00),
       (19, 4, '2024-07-01', NULL, 65000.00),
       (20, 5, '2024-08-01', NULL, 37000.00),
       (1, 1, '2024-01-01', '2025-02-01', 110000.00),
       (2, 2, '2024-02-01', '2025-08-01', 4000.00),
       (3, 3, '2024-03-01', '2025-04-01', 18000.00),
       (4, 4, '2024-04-01', '2025-04-01', 70000.00),
       (5, 5, '2024-05-01', NULL, 40000.00),
       (6, 1, '2024-06-01', NULL, 150000.00);
```

Проверка того, что все сработало и данные появились в БД:

```postgresql
select *
from public.accounts
         left join public.clients clients on accounts.client_id = clients.id
         left join public.deposits deposits on accounts.deposit_id = deposits.id
         left join public.employees employees on employees.id = clients.employee_id;
```

Резальтат запросов выше (экспортирован в формате markdown через DataGrip):

| id | client\_id | deposit\_id | date\_open | date\_close | amount    | id | full\_name                    | passport    | adress                | phone       | employee\_id | id | name          | duration | rate  | currency\_id | id | position\_id | department\_id |
|:---|:-----------|:------------|:-----------|:------------|:----------|:---|:------------------------------|:------------|:----------------------|:------------|:-------------|:---|:--------------|:---------|:------|:-------------|:---|:-------------|:---------------|
| 61 | 9          | 4           | 2023-09-01 | 2024-09-01  | 55000.00  | 9  | Морозова Екатерина Андреевна  | 9012 345678 | ул. Некрасова, д.9    | 89004321098 | 1            | 4  | Пенсионный    | 12       | 12.00 | 1            | 1  | 1            | 1              |
| 69 | 1          | 2           | 2024-05-01 | null        | 3500.00   | 1  | Иванов Иван Иванович          | 1234 567890 | ул. Пушкина, д.1      | 89001234567 | 1            | 2  | Капитал       | 18       | 7.00  | 2            | 1  | 1            | 1              |
| 53 | 1          | 1           | 2023-01-01 | 2024-02-01  | 100000.00 | 1  | Иванов Иван Иванович          | 1234 567890 | ул. Пушкина, д.1      | 89001234567 | 1            | 1  | Накопительный | 13       | 10.00 | 1            | 1  | 1            | 1              |
| 73 | 1          | 1           | 2024-01-01 | 2025-02-01  | 110000.00 | 1  | Иванов Иван Иванович          | 1234 567890 | ул. Пушкина, д.1      | 89001234567 | 1            | 1  | Накопительный | 13       | 10.00 | 1            | 1  | 1            | 1              |
| 62 | 10         | 5           | 2023-10-01 | null        | 32000.00  | 10 | Новиков Михаил Юрьевич        | 0123 456789 | ул. Белинского, д.10  | 89003210987 | 2            | 5  | Молодежный    | 36       | 18.00 | 1            | 2  | 2            | 1              |
| 70 | 2          | 3           | 2024-06-01 | null        | 22000.00  | 2  | Петров Петр Петрович          | 2345 678901 | ул. Лермонтова, д.2   | 89007654321 | 2            | 3  | Друзья        | 13       | 2.00  | 3            | 2  | 2            | 1              |
| 54 | 2          | 2           | 2023-02-01 | 2024-08-01  | 2000.00   | 2  | Петров Петр Петрович          | 2345 678901 | ул. Лермонтова, д.2   | 89007654321 | 2            | 2  | Капитал       | 18       | 7.00  | 2            | 2  | 2            | 1              |
| 74 | 2          | 2           | 2024-02-01 | 2025-08-01  | 4000.00   | 2  | Петров Петр Петрович          | 2345 678901 | ул. Лермонтова, д.2   | 89007654321 | 2            | 2  | Капитал       | 18       | 7.00  | 2            | 2  | 2            | 1              |
| 71 | 3          | 4           | 2024-07-01 | null        | 65000.00  | 3  | Сидоров Сидор Сидорович       | 3456 789012 | ул. Толстого, д.3     | 89001237890 | 3            | 4  | Пенсионный    | 12       | 12.00 | 1            | 3  | 3            | 1              |
| 55 | 3          | 3           | 2023-03-01 | 2024-04-01  | 15000.00  | 3  | Сидоров Сидор Сидорович       | 3456 789012 | ул. Толстого, д.3     | 89001237890 | 3            | 3  | Друзья        | 13       | 2.00  | 3            | 3  | 3            | 1              |
| 75 | 3          | 3           | 2024-03-01 | 2025-04-01  | 18000.00  | 3  | Сидоров Сидор Сидорович       | 3456 789012 | ул. Толстого, д.3     | 89001237890 | 3            | 3  | Друзья        | 13       | 2.00  | 3            | 3  | 3            | 1              |
| 63 | 11         | 1           | 2023-11-01 | 2024-12-01  | 130000.00 | 11 | Фёдорова Наталья Владимировна | 1234 567891 | ул. Островского, д.11 | 89002109876 | 3            | 1  | Накопительный | 13       | 10.00 | 1            | 3  | 3            | 1              |
| 72 | 4          | 5           | 2024-08-01 | null        | 37000.00  | 4  | Смирнова Анна Ивановна        | 4567 890123 | ул. Чехова, д.4       | 89009876543 | 4            | 5  | Молодежный    | 36       | 18.00 | 1            | 4  | 4            | 1              |
| 56 | 4          | 4           | 2023-04-01 | 2024-04-01  | 50000.00  | 4  | Смирнова Анна Ивановна        | 4567 890123 | ул. Чехова, д.4       | 89009876543 | 4            | 4  | Пенсионный    | 12       | 12.00 | 1            | 4  | 4            | 1              |
| 76 | 4          | 4           | 2024-04-01 | 2025-04-01  | 70000.00  | 4  | Смирнова Анна Ивановна        | 4567 890123 | ул. Чехова, д.4       | 89009876543 | 4            | 4  | Пенсионный    | 12       | 12.00 | 1            | 4  | 4            | 1              |
| 64 | 12         | 2           | 2023-12-01 | null        | 3000.00   | 12 | Михайлова Алина Игоревна      | 2345 678902 | ул. Салтыкова, д.12   | 89001098765 | 4            | 2  | Капитал       | 18       | 7.00  | 2            | 4  | 4            | 1              |
| 57 | 5          | 5           | 2023-05-01 | null        | 30000.00  | 5  | Васильева Ольга Петровна      | 5678 901234 | ул. Гоголя, д.5       | 89008765432 | 5            | 5  | Молодежный    | 36       | 18.00 | 1            | 5  | 1            | 2              |
| 77 | 5          | 5           | 2024-05-01 | null        | 40000.00  | 5  | Васильева Ольга Петровна      | 5678 901234 | ул. Гоголя, д.5       | 89008765432 | 5            | 5  | Молодежный    | 36       | 18.00 | 1            | 5  | 1            | 2              |
| 65 | 13         | 3           | 2024-01-01 | 2025-02-01  | 20000.00  | 13 | Орлова Юлия Романовна         | 3456 789013 | ул. Тургенева, д.13   | 89009876544 | 5            | 3  | Друзья        | 13       | 2.00  | 3            | 5  | 1            | 2              |
| 66 | 14         | 4           | 2024-02-01 | 2025-02-01  | 60000.00  | 14 | Андреев Павел Олегович        | 4567 890124 | ул. Жуковского, д.14  | 89008765433 | 6            | 4  | Пенсионный    | 12       | 12.00 | 1            | 6  | 2            | 2              |
| 58 | 6          | 1           | 2023-06-01 | 2024-07-01  | 120000.00 | 6  | Кузнецов Николай Сергеевич    | 6789 012345 | ул. Ленина, д.6       | 89007654321 | 6            | 1  | Накопительный | 13       | 10.00 | 1            | 6  | 2            | 2              |
| 78 | 6          | 1           | 2024-06-01 | null        | 150000.00 | 6  | Кузнецов Николай Сергеевич    | 6789 012345 | ул. Ленина, д.6       | 89007654321 | 6            | 1  | Накопительный | 13       | 10.00 | 1            | 6  | 2            | 2              |
| 67 | 15         | 5           | 2024-03-01 | null        | 35000.00  | 15 | Волков Алексей Михайлович     | 5678 901235 | ул. Гончарова, д.15   | 89007654322 | 7            | 5  | Молодежный    | 36       | 18.00 | 1            | 7  | 3            | 2              |
| 59 | 7          | 2           | 2023-07-01 | null        | 2500.00   | 7  | Попов Алексей Дмитриевич      | 7890 123456 | ул. Маяковского, д.7  | 89006543210 | 7            | 2  | Капитал       | 18       | 7.00  | 2            | 7  | 3            | 2              |
| 60 | 8          | 3           | 2023-08-01 | 2024-09-01  | 17000.00  | 8  | Соколов Дмитрий Александрович | 8901 234567 | ул. Достоевского, д.8 | 89005432109 | 8            | 3  | Друзья        | 13       | 2.00  | 3            | 8  | 4            | 2              |
| 68 | 16         | 1           | 2024-04-01 | null        | 140000.00 | 16 | Зайцева Марина Викторовна     | 6789 012346 | ул. Есенина, д.16     | 89006543211 | 8            | 1  | Накопительный | 13       | 10.00 | 1            | 8  | 4            | 2              |

Отлично, все данные загрузились (остальные данные я проверил вручную отдельно).

### Реализация задания

1. Получить список сотрудников, курирующих вкладчиков вклада
   «Накопительный»

![1.png](queries/1.png)

2. Получить список вкладчиков, закрывших свои вклады, в заданный период
   времени

![2.png](queries/2.png)

3. Определить ТОП 3 наиболее популярных вкладов банка (критерий –
   количество вкладчиков)

![3.png](queries/3.png)

4. Определить вклад, который «принес» меньше всего денежных средств
   банку (сумма вложенных средств по вкладу) в течение заданного периода.

![4.png](queries/4.png)

5. Получить ТОП 3 вкладчиков, имеющих вклады в иностранной валюте.
   Суммарный объем вкладов определяется в рублях.

![5.png](queries/5.png)

6. Сформировать ведомость получения доходов клиентами банка
   по закрытым счетам за заданный период в табличной форме

| Наименование вклада | Срок хранения, месяцев | Ставка, % годовых | Сумма вложенная, руб. | Сумма накопления, руб. |
|---------------------|------------------------|-------------------|-----------------------|------------------------|

где "Сумма накопления, руб." = " Сумма вложенная, руб." * ("Срок хранения, месяцев" * "Ставка, % годовых" : 12) : 100

![6.png](queries/6.png)