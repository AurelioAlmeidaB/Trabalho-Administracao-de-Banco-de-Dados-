-- ============================================================
-- Trabalho - Administração de Banco de Dados (1º Bimestre)
-- Banco de dados: dvdrental (PostgreSQL Sample Database)
-- ============================================================



-- ============================================================
-- ATIVIDADE 1 — Visão sobre uma única tabela
-- Tabela escolhida: film
-- Descrição: traz filmes com classificação 'PG-13' e duração
--            acima de 100 minutos
-- ============================================================

CREATE OR REPLACE VIEW vw_filmes_pg13_longos AS
SELECT
    film_id,
    title          AS titulo,
    release_year   AS ano_lancamento,
    length         AS duracao_min,
    rating         AS classificacao,
    rental_rate    AS valor_locacao
FROM film
WHERE rating = 'PG-13'
  AND length > 100;

-- Teste
SELECT * FROM vw_filmes_pg13_longos LIMIT 10;


-- ============================================================
-- ATIVIDADE 2 — Visão com junção entre duas tabelas (1:N)
-- Tabelas: city (1) → address (N)
-- Descrição: endereços completos com o nome da cidade
-- ============================================================

CREATE OR REPLACE VIEW vw_enderecos_com_cidade AS
SELECT
    a.address_id,
    a.address,
    a.district,
    a.postal_code,
    c.city        AS cidade
FROM address a
JOIN city c ON a.city_id = c.city_id;

-- Teste
SELECT * FROM vw_enderecos_com_cidade LIMIT 10;


-- ============================================================
-- ATIVIDADE 3 — Sequências e inserts
-- Sequência 1: para a tabela category
-- Sequência 2: para a tabela city
-- ============================================================

-- Sequência 1 — nova categoria
CREATE SEQUENCE IF NOT EXISTS seq_category_id
    START WITH 20
    INCREMENT BY 1
    NO MAXVALUE
    NO CYCLE;

INSERT INTO category (category_id, name, last_update)
VALUES (nextval('seq_category_id'), 'Documentário Nacional', NOW());

INSERT INTO category (category_id, name, last_update)
VALUES (nextval('seq_category_id'), 'Minissérie',            NOW());

-- Teste
SELECT * FROM category ORDER BY category_id DESC LIMIT 5;


-- Sequência 2 — nova cidade
CREATE SEQUENCE IF NOT EXISTS seq_city_id
    START WITH 610
    INCREMENT BY 1
    NO MAXVALUE
    NO CYCLE;

INSERT INTO city (city_id, city, country_id, last_update)
VALUES (nextval('seq_city_id'), 'São Paulo',     31, NOW());  -- country_id 31 = Brazil

INSERT INTO city (city_id, city, country_id, last_update)
VALUES (nextval('seq_city_id'), 'Rio de Janeiro', 31, NOW());

-- Teste
SELECT * FROM city ORDER BY city_id DESC LIMIT 5;


-- ============================================================
-- ATIVIDADE 4 — Visão com UNION entre customer e staff
-- Descrição: nomes de clientes e funcionários em uma única lista
-- ============================================================

CREATE OR REPLACE VIEW vw_nomes_clientes_e_funcionarios AS
SELECT
    first_name,
    last_name,
    'Cliente'     AS tipo
FROM customer

UNION

SELECT
    first_name,
    last_name,
    'Funcionário' AS tipo
FROM staff;

-- Teste
 SELECT * FROM vw_nomes_clientes_e_funcionarios ORDER BY last_name;


-- ============================================================
-- ATIVIDADE 5 — Clientes e quantidade de filmes alugados
-- Regra: se o cliente não alugou nada → quantidade = 0
-- ============================================================

CREATE OR REPLACE VIEW vw_clientes_qtd_alugueis AS
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS nome_cliente,
    COUNT(r.rental_id)                 AS qtd_alugueis
FROM customer c
LEFT JOIN rental r ON r.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY qtd_alugueis DESC;

-- Teste
SELECT * FROM vw_clientes_qtd_alugueis LIMIT 30;
-- Clientes sem aluguel (deve mostrar 0):
 SELECT * FROM vw_clientes_qtd_alugueis WHERE qtd_alugueis = 0;


-- ============================================================
-- ATIVIDADE 6 — Clientes e títulos dos filmes alugados
-- Regra: se o cliente não alugou nada → título = NULL
-- ============================================================

CREATE OR REPLACE VIEW vw_clientes_titulos_alugados AS
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS nome_cliente,
    f.title                             AS titulo_filme
FROM customer c
LEFT JOIN rental    r  ON r.customer_id  = c.customer_id
LEFT JOIN inventory i  ON i.inventory_id = r.inventory_id
LEFT JOIN film      f  ON f.film_id      = i.film_id
ORDER BY c.last_name, c.first_name, f.title;

-- Teste
 SELECT * FROM vw_clientes_titulos_alugados LIMIT 30;
-- Clientes sem aluguel (título deve ser NULL):
 SELECT * FROM vw_clientes_titulos_alugados WHERE titulo_filme IS NULL;
