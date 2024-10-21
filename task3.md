# Задание 1

# Задание 2. Испорт/экспорт

Раньше справочники создавались через sql команды.

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

Теперь они импортируются из csv

Файлы для импорта: [for_import](for_import)

Команда для импорта:

```bash
psql -h localhost -p 5432 -d deposit -U postgres
```

```psql
\copy currencies (name, in_rub) FROM 'currencies.csv' DELIMITER ',' CSV HEADER;
\copy departments (name) FROM 'departments.csv' DELIMITER ',' CSV HEADER;
\copy positions (name) FROM 'positions.csv' DELIMITER ',' CSV HEADER;
\copy deposits (name, duration, rate, currency_id) FROM 'deposits.csv' DELIMITER ',' CSV HEADER;
```

Экспорт в svg справочников

```
\copy (SELECT * FROM currencies) TO 'currencies.csv' DELIMITER ',' CSV HEADER;
\copy (SELECT * FROM departments) TO 'departments.csv' DELIMITER ',' CSV HEADER;
\copy (SELECT * FROM positions) TO 'positions.csv' DELIMITER ',' CSV HEADER;
\copy (SELECT * FROM deposits) TO 'deposits.csv' DELIMITER ',' CSV HEADER;
```

# Задание 3

# Задание 4