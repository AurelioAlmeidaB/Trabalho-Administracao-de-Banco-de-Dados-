Trabalho de Administração de Banco de Dados (1º Bimestre)
Este repositório contém a entrega da disciplina Administração de Banco de Dados, utilizando o banco de exemplo dvdrental (PostgreSQL Sample Database).

Integrantes
Aurélio Almeida Barbosa
Pedro Henrique do Santo
Objetivo do trabalho
Após importar corretamente o banco dvdrental, foram desenvolvidas as atividades solicitadas em aula:

Criação de visão com uma tabela.
Criação de visão com junção entre tabelas 1:N.
Criação de sequências e inserções.
Criação de visão com UNION entre customer e staff.
Criação de visão com clientes e quantidade de alugueis (incluindo clientes sem aluguel com valor 0).
Criação de visão com clientes e títulos alugados (incluindo clientes sem aluguel com valor NULL).
Estrutura lógica das atividades implementadas
1) Visão sobre uma única tabela
View: vw_filmes_pg13_longos
Tabela base: film
Regra: filmes PG-13 com duração maior que 100 minutos.
2) Visão com relacionamento 1:N
View: vw_enderecos_com_cidade
Tabelas: city (1) → address (N)
Regra: retornar endereço com nome da cidade.
3) Sequências e inserts
Sequência 1: seq_category_id (tabela category)
Sequência 2: seq_city_id (tabela city)
Regra: pelo menos dois inserts em cada tabela usando nextval(...).
4) Visão com UNION
View: vw_nomes_clientes_e_funcionarios
Tabelas: customer e staff
Regra: unificar nomes com identificação do tipo (Cliente/Funcionário).
5) Clientes e quantidade de filmes alugados
View: vw_clientes_qtd_alugueis
Regra: mostrar nome completo e total de alugueis por cliente.
Importante: cliente sem aluguel aparece com 0.
6) Clientes e títulos alugados
View: vw_clientes_titulos_alugados
Regra: mostrar nome completo e título de cada filme alugado.
Importante: cliente sem aluguel aparece com título NULL.
Como executar no PostgreSQL
Crie/importe o banco de exemplo dvdrental.

Abra o psql conectado ao banco:

\c dvdrental
Execute o script SQL do trabalho (com os CREATE VIEW, CREATE SEQUENCE e INSERT).

Rode os SELECT de teste para validar os resultados das views.

Resultado esperado
Com a execução do script, o banco ficará com:

As views solicitadas no enunciado;
As duas sequências criadas;
Inserções de exemplo nas tabelas escolhidas;
Consultas cobrindo também os casos de clientes sem aluguel.
