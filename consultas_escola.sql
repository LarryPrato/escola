/*=====================================
Parte 2.
=======================================
a- Produza um relatório que contenha os dados dos alunos matriculados em todos os 
cursos oferecidos pela escola.*/
SELECT curso.nome AS curso, matricula.cpf_aluno, aluno.nome AS nome_aluno
FROM matricula
INNER JOIN aluno
	ON matricula.cpf_aluno = aluno.cpf
INNER JOIN curso
	ON matricula.codigo_curso = curso.codigo
ORDER BY curso, cpf_aluno;

/* \\\OUTPUT DO PSQL (LIMIT 10 )///
 curso  |  cpf_aluno  |                  nome_aluno
--------+-------------+----------------------------------------------
 Alemão | 22558877441 | Josilda Nair Lyphornson
 Alemão | 34123567630 | Dionísio Cirilo Weiss Lole
 Alemão | 43926298300 | Victor de Medeiros d"Ávila Ecifoson
 Alemão | 55775324274 | Alexandre Humberto Pinhão de Cerqueira Usago
 Alemão | 62923232666 | Ivanete Mirela Tsuyupeka
 Alemão | 66497186863 | Helena Gois Creti
 Alemão | 69242576334 | Roberval da Cunha de Tavares
 Alemão | 70789700852 | Paula Eztrern
 Alemão | 71491051654 | Joelma de Brandão
 Alemão | 71841727055 | Edson Coso
(10 rows)
==============================================*/

/* b- Produza um relatório com os dados de todos os cursos, com suas respectivas 
disciplinas, oferecidos pela escola.*/
SELECT compoe.codigo_curso, curso.nome AS curso,  disciplina.nome AS disciplina, disciplina.qtde_creditos
FROM compoe
INNER JOIN curso
	ON compoe.codigo_curso = curso.codigo
INNER JOIN disciplina
	ON compoe.codigo_disc = disciplina.codigo 
ORDER BY curso, disciplina;

/* \\\OUTPUT DO PSQL (LIMIT 10)///
 codigo_curso |         curso         |      disciplina      | qtde_creditos
--------------+-----------------------+----------------------+---------------
 11           | Alemão                | Alemão Avançado      |             4
 11           | Alemão                | Alemão Básico        |             2
 11           | Alemão                | Alemão Intermediário |             3
 3            | Ciência da Computação | Banco de Dados       |             6
 3            | Ciência da Computação | Cálculo 1            |             2
 3            | Ciência da Computação | Data Science e IA    |             5
 3            | Ciência da Computação | Probabilidade        |             4
 3            | Ciência da Computação | Python               |             3
 4            | Engenharia Elétrica   | Cálculo 1            |             2
 4            | Engenharia Elétrica   | Circuitos Elétricos  |             3
(10 rows)
==============================================*/

/* c- Produza um relatório que contenha o nome dos alunos e as disciplinas em que estão 
matriculados.*/
SELECT cursa.cpf_aluno AS cpf, aluno.nome AS nome_aluno, disciplina.nome AS disciplina
FROM cursa
INNER JOIN aluno
	on cursa.cpf_aluno = aluno.cpf
INNER JOIN disciplina
	ON cursa.codigo_disc = disciplina.codigo
ORDER BY cpf;

/* \\\OUTPUT DO PSQL (LIMIT 10)///
     cpf     |             nome_aluno              |       disciplina
-------------+-------------------------------------+-------------------------
 01437901196 | Poliana Yasmin Naves Lielua         | Inglês Básico
 01712609174 | Elano Akizoho de Souza Terceiro     | Concepções de Linguagem
 01861002026 | Danielle Kiean Durirna              | Cálculo 1
 02928272625 | Manoel Charles de Trindade Penedo   | Cálculo 1
 05020555555 | Bianca Maria dos Santos             | Espanhol Avançado
 05020555555 | Bianca Maria dos Santos             | Inglês Básico
 06169933554 | Valéria Natália de Soares do Paraná | Concepções de Linguagem
 10130986185 | Alfredo Anderson de Barros          | Inglês Intermediário
 10299761377 | Roberto de Nogueira                 | Inglês Intermediário
 10468536559 | Abigail Dlantroz                    | Cálculo 1
(10 rows)
==============================================*/

/* d- Produza um relatório com os dados dos professores e as disciplinas que ministram.*/
SELECT professor.matricula AS matricula_prof, professor.nome AS nome_prof, professor.telefone, professor.codigo_dpto AS departamento, disciplina.nome AS disciplina
FROM professor
INNER JOIN disciplina
	ON professor.matricula = disciplina.matricula_prof
ORDER BY professor.nome;

/* \\\OUTPUT DO PSQL (LIMIT 10)///
 matricula_prof |            nome_prof             |       telefone        | departamento |          disciplina
----------------+----------------------------------+-----------------------+--------------+------------------------
 11             | Áureo de Palhares Neiol          | +55-51-92929-5550     | 3            | Alemão Intermediário       
 11             | Áureo de Palhares Neiol          | +55-51-92929-5550     | 3            | Alemão Avançado
 11             | Áureo de Palhares Neiol          | +55-51-92929-5550     | 3            | Alemão Básico
 17             | Bella Biwo                       | +1-060-465-8808x51762 | 1            | Mercado de Capitais
 17             | Bella Biwo                       | +1-060-465-8808x51762 | 1            | Matemática Financeira
 4              | Cléber de Vasconcelos            | +55-11-4224-2626      | 9            | Python
 19             | Décio de Leão do Amaral Terceiro | +1-065-022-0820       | 3            | Inglês Básico
 19             | Décio de Leão do Amaral Terceiro | +1-065-022-0820       | 3            | Inglês Intermediário
 14             | Flaviana Supugeko de Arantes     | +55-21-90909-4444     | 2            | Gestão de Competências
 14             | Flaviana Supugeko de Arantes     | +55-21-90909-4444     | 2            | Identif. Realoc. de Tal
entos
(10 rows)
==============================================*/

/* e- Produza um relatório com os nomes das disciplinas e seus pré-requisitos.*/
SELECT pr.codigo_discp AS codigo_disc, disc.nome AS disciplina, 
	pr.codigo_discp_dependencia AS cod_pre_req, disc_pr.nome AS pre_requisito
FROM pre_req AS pr
JOIN disciplina AS disc
	ON pr.codigo_discp = disc.codigo
JOIN disciplina AS disc_pr
	ON pr.codigo_discp_dependencia = disc_pr.codigo
ORDER BY disciplina, pre_requisito;

/* \\\OUTPUT DO PSQL ///
 codigo_disc |           disciplina           | cod_pre_req |     pre_requisito
-------------+--------------------------------+-------------+------------------------
 35          | Alemão Avançado                | 34          | Alemão Intermediário
 34          | Alemão Intermediário           | 33          | Alemão Básico
 2           | Cálculo 2                      | 1           | Cálculo 1
 18          | Comércio exterior              | 13          | Elementos do Marketing
 15          | Criação e Melhorias            | 13          | Elementos do Marketing
 9           | Data Science e IA              | 8           | Python
 32          | Espanhol Avançado              | 31          | Espanhol Intermediário
 31          | Espanhol Intermediário         | 30          | Espanhol Básico
 38          | Francês Avançado               | 35          | Alemão Avançado
 38          | Francês Avançado               | 37          | Francês Intermediário
 37          | Francês Intermediário          | 36          | Francês Básico
 19          | Gestão de Projetos             | 6           | Admin. e Contabilidade
 22          | Identif. Realoc. de Talentos   | 20          | Introd. Psicologia
 29          | Inglês Avançado                | 28          | Inglês Intermediário
 28          | Inglês Intermediário           | 27          | Inglês Básico
 12          | Instalações Elétricas          | 11          | Circuitos Elétricos
 26          | Literaturas na Educação Básica | 24          | Gêneros Literários
 7           | Mercado de Capitais            | 5           | Matemática Financeira
(18 rows)

Obs. A linha:  38| Francês Avançado| 35| Alemão Avançado
Foi inserida para testar o INSERT na tabela pre_req.
==============================================*/

/* f- Produza um relatório com a média de idade dos alunos matriculados em cada curso.*/
SELECT curso.codigo AS codigo_curso, curso.nome curso, date_part('year', AVG((age(al.data_nasc)))) AS idade_media
FROM curso
JOIN matricula AS mat
	ON curso.codigo = mat.codigo_curso
JOIN aluno AS al
	ON al.cpf = mat.cpf_aluno
GROUP BY curso.codigo
ORDER BY idade_media;

/* \\\OUTPUT DO PSQL///
 codigo_curso |         curso         | idade_media
--------------+-----------------------+-------------
 11           | Alemão                |          40
 2            | Finanças              |          41
 3            | Ciência da Computação |          44
 1            | Estatística           |          45
 4            | Engenharia Elétrica   |          46
 10           | Espanhol              |          48
 6            | Gestão de RH          |          52
 8            | Letras                |          53
 9            | Inglês                |          54
 7            | Gestão Comercial      |          55
 12           | Francês               |          55
 5            | Marketing             |          61
(12 rows)
==============================================*/

/* g- Produza um relatório com os cursos oferecidos por cada departamento.*/
SELECT dep.codigo AS cod_dpto, dep.nome AS nome_dpto, curso.codigo AS cod_curso, curso.nome AS curso   
FROM departamento AS dep
JOIN curso
	ON dep.codigo = curso.codigo_dpto;

/* \\\OUTPUT DO PSQL///
 cod_dpto | nome_dpto | cod_curso |         curso
----------+-----------+-----------+-----------------------
 1        | Exatas    | 4         | Engenharia Elétrica
 1        | Exatas    | 2         | Finanças
 1        | Exatas    | 1         | Estatística
 2        | Humanas   | 8         | Letras
 2        | Humanas   | 7         | Gestão Comercial
 2        | Humanas   | 6         | Gestão de RH
 2        | Humanas   | 5         | Marketing
 3        | Idiomas   | 33        | Ciência de dados
 3        | Idiomas   | 12        | Francês
 3        | Idiomas   | 11        | Alemão
 3        | Idiomas   | 10        | Espanhol
 3        | Idiomas   | 9         | Inglês
 9        | TI        | 3         | Ciência da Computação
(13 rows)

Obs. A linha:  3| Idiomas| 33| Ciência de dados
Foi inserida para testar o INSERT na tabela curso.
==============================================*/