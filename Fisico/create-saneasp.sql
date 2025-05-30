create database SANEASP
use SANEASP

create table Usuarios(
	id_usuario int not null identity (1,1) primary key,
	nome varchar(50) not null,
	telefone varchar(14),
	email varchar(40) not null unique,
	senha varchar(100) not null,
	cpf char(11) unique,
	cep char(8),
	cidade varchar(30),
	bairro varchar(30),
	rua varchar(30),
	numero varchar(10),
	complemento varchar(30)
)

create table Administradores(
	id_admin int not null identity (1,1) primary key,
	id_usuario int not null,
	nivel int not null
	Constraint fk_usuario_admin foreign key (id_usuario) references Usuarios(id_usuario)
)

create table Tabela_logs(
	id_log int not null identity(1,1) primary key,
	operacao varchar(10) not null,
	conteudo_reclamacao varchar(500) not null,
	conteudo_versao varchar(10),
	data_criacao datetime not null default GETDATE(),
	id_usuario int not null
	Constraint fk_usuario_log foreign key (id_usuario) references Usuarios(id_usuario) 
)

create table Doencas(
	id_doenca int not null identity(1,1) primary key,
	nome_doenca varchar(50) not null,
	descricao_doenca varchar(500) not null,
	transmissao varchar(255) not null,
	tratamento varchar(255) not null,
	data_publicacao_doenca datetime not null default GETDATE(),
	id_admin int not null
	Constraint fk_admin_doenca foreign key (id_admin) references Administradores(id_admin)
) 

create table Sintomas(
	id_sintoma int not null identity(1,1) primary key,
	nome varchar(50) not null
)

create table Sintomas_doenca(
	id_sintoma_doenca int not null identity(1,1) primary key,
	id_doenca int not null,
	id_sintoma int not null,
	Constraint fk_doenca foreign key (id_doenca) references Doencas(id_doenca),
	Constraint fk_sintoma foreign key (id_sintoma) references Sintomas(id_sintoma)
)

create table Reclamacoes (
	id_reclamacao int not null identity(1,1) primary key,
	titulo varchar(50) not null,
	descricao varchar(500) not null,
	cep char(8),
	cidade varchar(30),
	bairro varchar(30),
	rua varchar(30),
	numero varchar(30),
	complemento varchar(30),
	status_reclamacao varchar(20) not null,
	data_criacao datetime default GETDATE() not null,
	pontuacao decimal(5,2) not null,
	id_usuario int not null,
	Constraint fk_usuario_reclamacao foreign key (id_usuario) references Usuarios(id_usuario)
)

create table Comentarios(
	id_comentario int not null identity(1,1) primary key,
	descricao varchar(500) not null,
	data_criacao datetime default GETDATE() not null,
	id_admin int,
	id_usuario int,
	id_reclamacao int not null,
	Constraint fk_comentario_administrador foreign key (id_admin) references Administradores(id_admin),
	Constraint fk_comentario_usuario foreign key (id_usuario) references Usuarios(id_usuario),
	Constraint fk_comentario_reclamacao foreign key (id_reclamacao) references Reclamacoes(id_reclamacao)
)

create table Imagens_reclamacao(
	id_imagem_reclamacao int not null identity(1,1) primary key,
	nome_imagem varchar(100) not null,
	id_reclamacao int not null
	Constraint fk_imagem_reclamacao foreign key (id_reclamacao) references Reclamacoes(id_reclamacao)
)

create table Tags(
	id_tag int not null identity(1,1) primary key,
	nome varchar(50) not null
)

create table Tags_reclamacao(
	id_tag_reclamacao int not null identity(1,1) primary key,
	id_tag int not null,
	id_reclamacao int not null
	Constraint fk_tags_reclamacao_tag foreign key (id_tag) references Tags(id_tag),
	Constraint fk_tags_reclamacao_reclamacao foreign key (id_reclamacao) references Reclamacoes(id_reclamacao)
)

create table Noticias (
	id_noticia int not null identity(1,1) primary key,
	titulo varchar(50) not null,
	descricao varchar(500) not null,
	data_criacao datetime not null default GETDATE(),
	id_admin int not null
	Constraint fk_noticia_administrador foreign key (id_admin) references Administradores(id_admin)
)

create table Tags_noticia(
	id_tag_noticia int not null identity(1,1) primary key,
	id_tag int not null,
	id_noticia int not null
	Constraint fk_tags_noticia_tag foreign key (id_tag) references Tags(id_tag),
	Constraint fk_tags_noticia_noticia foreign key (id_noticia) references Noticias(id_noticia)
)

insert into Usuarios(nome, telefone, cep, cidade, bairro, complemento, rua, numero, email, senha, cpf)
values
('Davy Oliveira', '12345678910123', '18075718', 'Sorocaba','Wanel', 'Fundos', 'Alonco Muchon', '122', 'davy@gmail.com', '12345', '12345678910'),
('Adryann Theylor', '1098765432101', '57181807', 'Votorantim','Vossoroca', 'bloco A', 'Natal', '122', 'etec@etec.com', 'senhaconfiavel', '12310456789'),
('Matheus Gueff', '1076543210198', '51818077', 'Sorocaba','Jd Brasil�ndia', '', 'Alonco Muchon', '928', 'matheus@etec.com', 'senhanaoconfiavel', '10451236789'),
('Jones Terceiro Semestre', '1087654321019', '58180177', 'Itu','Bairro tal', 'Bloco B', 'Paes de Linhares', '18', 'jones@fatec.com', 'senha', '15123604789'),
('Jonin Alberto', '18910122345673', '18180775', 'Votorantim','Clarice', '', 'Alonco Muchon', '111', 'jonin@etec.com', '12345*', '45123610789'),
('Lav�nia', '11111111111111', '11111111', 'Sorocaba','Mineir�o', '', 'Ermolau del Cistia', '192', 'lav@etec.com', '**12345*', '42361510789'),
('Comum', '11111222211111', '22111111', 'Sorocaba','Mineir�o', '', 'Ermolau del Cistia', '11', 'etequi@etec.com', '2345*', '15231046789')

-- Administrador
INSERT INTO Administradores (id_usuario, nivel)
VALUES 
(1, 3),
(2, 2),
(3, 2),
(4, 1),
(5, 1)

-- Log
INSERT INTO Tabela_logs (operacao, data_criacao, conteudo_reclamacao, conteudo_versao, id_usuario)
VALUES 
('INSER��O', '2022-02-10 00:00:00.000', 'Achei um problema no meu encanamento, tem algumbixo la dentrueui', 'cria��o', 1),
('EDI��O', '2022-28-10 00:00:00.000', 'Achei um problema no meu encanamento, tem algumbixo la dentrueui', 'antigo', 1),
('EDI��O', '2024-28-10 00:00:00.000', 'Achei um problema no meu encanamento, tem algum bixo la dentro (apenas corrigindo)', 'novo', 1),
('INSER��O', '2023-01-01 00:00:00.000', 'Estou com certo problema', 'cria��o', 6),
('EDI��O', '2022-05-03 00:00:00.000', 'Estou com certo problema', 'antigo', 6),
('EDI��O', '2022-05-03 00:00:00.000', 'Esqueci de mencionar o problema, � que minha �gua ta muito quente nesse calor, preciso de gelo urgentemente', 'novo', 6);


-- Doen�a
INSERT INTO Doencas (nome_doenca, descricao_doenca, transmissao, tratamento, id_admin, data_publicacao_doenca)
VALUES 
('Esquistossomose', 'Doen�a esquisita','Contamina��o', 'M�dico', 1, '2022-05-01 00:00:00.000'),
('Dengue', 'Picada','Doen�a da �gua', 'Beber �gua', 2, '2020-05-03 00:00:00.000'),
('C�lera','Nome parece c�lica', 'Infecc��o', 'Descansar', 2, '2018-12-11 00:00:00.000'),
('Ascaridiase','Doen�a ascaridiase', 'Infecc��o', 'Melhorar', 3, '2022-13-10 00:00:00.000'),
('Leptospirose','Doen�a do rato', 'Infecc��o', 'Tentar melhorar', 2, '2024-05-08 00:00:00.000')

-- Sintomas
INSERT INTO Sintomas (nome)
VALUES 
('Febre'),
('Tosse'),
('Dor de cabe�a'),
('Nausea'),
('Diarreia')

-- Sintomas_doenca
INSERT INTO Sintomas_doenca (id_doenca, id_sintoma)
VALUES 
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(4, 5),
(3, 4),
(2, 2)

-- Reclamacoes
INSERT INTO Reclamacoes (id_usuario, titulo, descricao, cep, cidade, bairro, rua, numero, complemento, status_reclamacao, pontuacao, data_criacao)
VALUES 
(6, 'Minha rua ta ruim', 'Muitos buracos na rua', '18075718', 'Sorocaba', 'Jardim Flores','Seu Campo','123', null, 'visualizada', 5,'2020-12-12 00:00:00.000'),
(6, 'Vi que tem um problema aqui perto', 'Tem um problema acontecendo aqui no meu bairro', '10757188', 'Sorocaba', 'Jardim Seco','Meu Campo','231', null, 'enviado', 4,'2022-10-05 00:00:00.000'),
(6, 'Minha encana��o EXPLODIU', 'Literalmente explodiu', '18071857', 'Votorantim', 'Jardim Europa','Brasilandia',null, null, 'enviado', 9, '2022-08-12 00:00:00.000'),
(6, 'Vi uma contamina��o na �gua aqui perto', 'Contaminar�o minha �gua', '10757818', 'Votorantim', 'Jardim Jardim','Seu Seu','1', 'Fundos', 'enviado', 1, '2023-31-01 00:00:00.000'),
(7, 'DEU UM PROBLEM�O', 'Nem eu sei oq �, s� sei que � um grande problema, um PROBLEM�O', '80715718', 'Votorantim', 'Seu Flores','Seu Jardim',null, null,'resolvida', 10, '2023-01-01 00:00:00.000')

-- Coment�rios
INSERT INTO Comentarios (id_admin, id_usuario, id_reclamacao, descricao, data_criacao)
VALUES 
(2, 2, 5, 'Que problem�o � esse? Seja mais espec�fico', '2022-10-10 00:00:00.000'),
(null, 7, 5, 'Mano, um problem�o, tipo muito', '2022-11-10 00:00:00.000'),
(2, 2, 5, 'Ta mas... que problema?', '2022-12-10 00:00:00.000'),
(null, 7, 5, 'Um professor meu vai deixar de dar aula pra n�s no pr�ximo semestre','2022-13-10 00:00:00.000'),
(2, 2, 5, 'Poxa que triste sinto muito por voc�, mas tipo, aqui � s� sobre reclama��es de saneamento b�sico', '2022-14-10 00:00:00.000'),
(null, 7, 5, 'Ata, desculpar s� queria desabafar, obrigado pela sua ajuda!', '2022-20-10 00:00:00.000'),
(1, 1, 1, 'Sua rua ta ruim �? Sinto muito por voc�', '2024-15-11 00:00:00.000')

-- Imagens_reclamacao
INSERT INTO Imagens_reclamacao (nome_imagem, id_reclamacao)
VALUES 
('agua.jpg', 1),
('icone_problema.png', 2),
('explosao.jpg', 3),
('icone_contaminacao.png', 4),
('agua.jpg', 5),
('icone_problema_grande.jpg', 5)

-- Tags
INSERT INTO Tags (nome)
VALUES 
('Vazamento'),
('Esgoto'),
('�gua'),
('Sa�de'),
('Obras'),
('Atendimento')

-- Tags_reclamacao
INSERT INTO Tags_reclamacao (id_tag, id_reclamacao)
VALUES 
(1,5),
(2,5),
(3,5),
(6,5),
(4,2)

-- Noticia
INSERT INTO Noticias (titulo, descricao, id_admin, data_criacao)
VALUES 
('Corrigimos uma encana��o', 'Deu tudo certo pessoal fiquem tranquilos', 1,'2022-08-10 00:00:00.000'),
('Dia Mundial da �gua', 'Dia mundial da �gua estamos distribuindo �gua', 1,'2022-09-10 00:00:00.000'),
('Reclama��o esquisita aparece no nosso site', 'Pessoal�, � urgente que entendam que esse site � apenas para reclama��es sobre saneamento b�sico e n�o para desabafos', 3,'2022-12-12 00:00:00.000'),
('Bebam �gua', 'Lembre-se de beber �gua', 2,'2022-15-12 00:00:00.000'),
('Se beber dirija!', 'N�o se esque�am de se hidratar, mesmo no tr�nsito! S� cuidado pra n�o bater (e sem bebidas alcoolicas, � PRA BEBER �GUA)', 4,'2024-20-11 00:00:00.000')

-- Tag_noticia
INSERT INTO Tags_noticia (id_tag, id_noticia)
VALUES 
(5, 2),
(3, 1),
(4, 3),
(5, 4),
(5, 5)

-- Select para todas as tabelas
SELECT * FROM Usuarios;
SELECT * FROM Administradores;
SELECT * FROM Tabela_logs;
SELECT * FROM Doencas;
SELECT * FROM Sintomas;
SELECT * FROM Sintomas_doenca;
SELECT * FROM Reclamacoes;
SELECT * FROM Comentarios;
SELECT * FROM Imagens_reclamacao;
SELECT * FROM Tags;
SELECT * FROM Tags_reclamacao;
SELECT * FROM Noticias;
SELECT * FROM Tags_noticia;

-- Mostrando administradores ordenados por n�vel (De 3 a 1)
select * from Administradores order by nivel desc

-- Mostrando reclama��es que n�o foram resolvidas ainda
select * from Reclamacoes where status_reclamacao != 'resolvida'

-- Mostrando quantidade de usu�rios por bairro
select bairro, count(*) as 'Quantidade por bairro' from Usuarios group by bairro

-- Mostrando quais tags tem a reclama��o
select r.titulo, string_agg(t.nome, ', ') as 'Tags da reclama��o'
from Reclamacoes r
inner join Tags_reclamacao tg on tg.id_reclamacao = r.id_reclamacao
inner join Tags t on t.id_tag = tg.id_tag
group by r.titulo;

-- Mostrando quais tags tem a not�cia
select n.titulo, string_agg(t.nome, ', ') as 'Tags da Not�cia'
from Noticias n
inner join Tags_noticia tn on tn.id_noticia = n.id_noticia
inner join Tags t on t.id_tag = tn.id_tag
group by n.titulo;

-- Mostrando todas informa��es da doen�a com a tabela sintomas, separadas por v�rgula
select d.nome_doenca, string_agg(s.nome, ', ') as 'Sintomas da Doen�a'
from Doencas d
inner join Sintomas_doenca sd on d.id_doenca = sd.id_doenca
inner join Sintomas s on sd.id_sintoma = s.id_sintoma
group by d.nome_doenca

-- Mostrando as 3 reclama��es com maior pontua��o e que n�o tenham sido resolvidas
select top 3 * from Reclamacoes where status_reclamacao != 'resolvida' order by pontuacao desc;
