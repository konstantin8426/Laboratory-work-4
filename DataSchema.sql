/* Створення таблиці користувачів */
CREATE TABLE "user" (
    id SERIAL PRIMARY KEY,
    preferences TEXT NOT NULL,
    settings TEXT NOT NULL
);

/* Створення таблиці уподобань */
CREATE TABLE dietary_preference (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    recommended_dish_id INT NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (recommended_dish_id) REFERENCES recommended_dish (id),
    FOREIGN KEY (user_id) REFERENCES "user" (id)
);

/* Створення таблиці рекомендованих страв */
CREATE TABLE recommended_dish (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    calories INT CHECK (calories >= 0),
    allergy_filter_id INT,
    user_id INT NOT NULL,
    FOREIGN KEY (allergy_filter_id) REFERENCES allergy_filter (id),
    FOREIGN KEY (user_id) REFERENCES "user" (id)
);

/* Створення таблиці фільтрів алергенів */
CREATE TABLE allergy_filter (
    id SERIAL PRIMARY KEY,
    excluded_ingredients TEXT
);

/* Створення таблиці нагадувань */
CREATE TABLE reminder (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    message TEXT NOT NULL CHECK
    (message ~ '^[A-Z].*'), -- Повідомлення має починатися з великої літери
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES "user" (id)
);

/* Створення таблиці шаблонів привітань */
CREATE TABLE greetin_template (
    id SERIAL PRIMARY KEY,
    content TEXT NOT NULL CHECK (content ~ '.*[!.?]$'),
    -- Контент має закінчуватися на крапку, знак питання або оклик
    reminder_id INT NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (reminder_id) REFERENCES reminder (id),
    FOREIGN KEY (user_id) REFERENCES "user" (id)
);
