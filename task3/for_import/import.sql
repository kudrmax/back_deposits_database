COPY public.currencies (name, in_rub) FROM 'currencies.csv' DELIMITER ',' CSV HEADER;
COPY public.departments (name) FROM 'for_import/departments.csv' DELIMITER ',' CSV HEADER;
COPY public.positions (name) FROM 'for_import/positions.csv' DELIMITER ',' CSV HEADER;
COPY public.deposits (name, duration, rate, currency_id) FROM 'for_import/deposits.csv' DELIMITER ',' CSV HEADER;