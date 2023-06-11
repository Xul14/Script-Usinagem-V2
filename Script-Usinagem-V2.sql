show databases;

create database db_projeto_usinagem_v2;

use db_projeto_usinagem_v2;

show tables;

### ADMINISTRADOR
create table tbl_administrador (
		id int not null auto_increment primary key,
        nome varchar(100) not null,
        email varchar(255) not null,
        senha varchar(150) not null,
	
        unique index(id)
		);
        
### ALUNO
create table tbl_aluno (
		id int not null auto_increment primary key,
        nome varchar(100) not null,
        email_institucional varchar(255) not null,
        senha varchar(150) not null,
	
        unique index(id)
		);
   
### ANO
create table tbl_ano (
		id int not null auto_increment primary key,
        ano year not null,
       
        unique index(id)
		);

### CURSO
create table tbl_curso (
		id int not null auto_increment primary key,
        nome varchar(45) not null,
        descricao text,
        carga_horaria varchar(45),
       
        unique index(id)
		);

### PERIODO
create table tbl_periodo (
		id int not null auto_increment primary key,
        nome varchar(10) not null,
       
        unique index(id)
		);

### REGISTRO DE TEMPO
create table tbl_registro_tempo (
		id int not null auto_increment primary key,
        horario_inicio time not null,
        horario_termino time not null,
        desconto time not null,
        liquido time,
        data_registro date not null,
        
        unique index(id)
		);

### TIPO DE ATIVIDADE
create table tbl_tipo_atividade (
		id int not null auto_increment primary key,
        nome varchar(15) not null,
       
        unique index(id)
		);
        
### TEMPO PREVISTO
create table tbl_tempo_previsto (
		id int not null auto_increment primary key,
        tempo time not null,
       
        unique index(id)
		);
        
### CRITERIO
create table tbl_criterio (
		id int not null auto_increment primary key,
        descricao text not null,
       
        unique index(id)
		);
        
### DISCIPLINA 
create table tbl_disciplina (
		id int not null auto_increment primary key,
        nome varchar(45) not null,
        descricao varchar(300),
       
        unique index(id)
		);

### PROFESSOR
create table tbl_professor (
		id int not null auto_increment primary key,
        nome varchar(100) not null,
        email varchar(255) not null,
        senha varchar(150) not null,
        nif varchar(15) not null,
        id_administrador int not null,
       
        
        # FK ADMINISTRADOR
        constraint FK_Professor_Administrador
        foreign key (id_administrador)
        references tbl_administrador(id),
	
       
        unique index(id)
		);      
        
        
###  TURMA
create table tbl_turma (
		id int not null auto_increment primary key,
        nome varchar(15) not null,
        termo int not null,
        id_curso int not null,
        id_ano int not null,
        id_periodo int not null,
        
        # FK CURSO, ANO, PERIODO
        constraint FK_Turma_Curso
        foreign key (id_curso)
        references tbl_curso (id),
        
        constraint FK_Turma_Ano
        foreign key (id_ano)
        references tbl_ano (id),
        
        constraint FK_Turma_Periodo
        foreign key (id_periodo)
        references tbl_periodo (id),
       
        unique index(id)
		);

### VALOR DESEJADO
create table tbl_valor_desejado (
		id int not null auto_increment primary key,
        valor_desejado varchar(45) not null,
        id_criterio int not null,
       
        
        # FK CRITERIO
        constraint FK_Valor_Desejado_Criterio
        foreign key (id_criterio)
        references tbl_criterio(id),
	
       
        unique index(id)
		);  
        

### ATIVIDADE
create table tbl_atividade (
		id int not null auto_increment primary key,
        nome varchar(45) not null,
        numero int not null,
        id_tipo_atividade int not null,
        id_tempo_previsto int not null,
        
        # FK TIPO_ATIVIDADE, TEMPO_PREVISTO
        constraint FK_Atividade_Tipo_Atividade
        foreign key (id_tipo_atividade)
        references tbl_tipo_atividade (id),
        
        constraint FK_Atividade_Tempo_Previsto
        foreign key (id_tempo_previsto)
        references tbl_tempo_previsto (id),
       
        unique index(id)
		);


### MATRICULA
create table tbl_matricula (
		id int not null auto_increment primary key,
        numero varchar(45) not null,
        id_aluno int not null,
        id_turma int not null,
       
        # FK Aluno, Turma
        constraint FK_Matricula_Aluno
        foreign key (id_aluno)
        references tbl_aluno (id),
        
		constraint FK_Matricula_Turma
        foreign key (id_turma)
        references tbl_turma(id),
	
        unique index(id)
		);
     
### ATIVIDADE - VALOR DESEJADO
create table tbl_atividade_valor_desejado(
		id int not null auto_increment primary key,
        id_atividade int not null,
        id_valor_desejado int not null,
       
        # FK Atividade, Valor desejado
        constraint FK_Atividade_Valor_Desejado_Atividade
        foreign key (id_atividade)
        references tbl_atividade(id),
        
		constraint FK_Atividade_Valor_Desejado_Valor_Desejado
        foreign key (id_valor_desejado)
        references tbl_valor_desejado(id),
	
        unique index(id)
		);

### MATRICULA- ATIVIDADE - REGISTRO DE TEMPO
create table tbl_matricula_atividade_registro_tempo(
		id int not null auto_increment primary key,
        id_matricula int not null,
        id_atividade int not null,
        id_registro_tempo int not null,
       
        # FK Matricula, Atividade, Registro de tempo 
        constraint FK_Matricula_Atividade_Registro_Tempo_Matricula
        foreign key (id_matricula)
        references tbl_matricula(id),
        
		constraint FK_Matricula_Atividade_Registro_Tempo_Atividade
        foreign key (id_atividade)
        references tbl_atividade(id),
        
		constraint FK_Matricula_Atividade_Registro_Tempo_Registro_Tempo
        foreign key (id_registro_tempo)
        references tbl_registro_tempo(id),
        
	        unique index(id)
		);
        
### AVALIAÇÃO
create table tbl_avaliacao (
		id int not null auto_increment primary key,
        avaliacao_aluno bit,
        obtido varchar(45),
        avaliacao_professor bit,
        id_professor int not null,
        id_atividade_valor_desejado int not null, 
        id_matricula int not null, 
       
        # FK PROFESSOR VALOR DESEJADO, MATRICULA

        constraint FK_Avaliacao_Professor
        foreign key (id_professor)
        references tbl_professor (id),
        
        constraint FK_Avaliacao_Atividade_Valor_Desejado
        foreign key (id_atividade_valor_desejado)
        references tbl_atividade_valor_desejado (id),
	
	    constraint FK_Avaliacao_Matricula
        foreign key (id_matricula)
        references tbl_matricula (id),
    
        unique index(id)
		);
        
### TURMA - DISCIPLINA - PROFESSOR 
create table tbl_turma_disciplina_professor (
		id int not null auto_increment primary key,
        id_disciplina int not null,
        id_turma int not null,
        id_professor int not null,
       
        # FK TURMA, DISCIPLINA, PROFESSOR

        constraint FK_Turma_Disciplina_Professor_Disciplina
        foreign key (id_disciplina)
        references tbl_disciplina (id),
        
        constraint FK_Turma_Disciplina_Professor_Turma
        foreign key (id_turma)
        references tbl_turma (id),
        
        constraint FK_Turma_Disciplina_Professor_Professor
        foreign key (id_professor)
        references tbl_professor (id),

        unique index(id)
		);
 
 ### TURMA - DISCIPLINA - PROFESSOR - ATIVIDADE
create table tbl_turma_disciplina_professor_atividade (
		id int not null auto_increment primary key,
        id_turma_disciplina_professor int not null,
        id_atividade int not null,
       
        # FK TURMA - DISCIPLINA - PROFESSOR, ATIVIDADE

        constraint FK_Turma_Disciplina_Professor
        foreign key (id_turma_disciplina_professor)
        references tbl_turma_disciplina_professor (id),
        
        constraint FK_Turma_Disciplina_Professor_Turma_Atividade_Atividade
        foreign key (id_atividade)
        references tbl_atividade (id),

        unique index(id)
		);

############# VIEWS #############
##View Atividade
create view vwAtividade as
	select tbl_atividade.id, tbl_atividade.nome as nome_atividade, tbl_atividade.numero as numero_atividade,
		   tbl_tipo_atividade.nome as tipo_atividade,
		   time_format(tbl_tempo_previsto.tempo , '%H:%i') as tempo_previsto
    from tbl_atividade
         inner join tbl_tipo_atividade
             on tbl_atividade.id_tipo_atividade = tbl_tipo_atividade.id
         inner join tbl_tempo_previsto
             on tbl_atividade.id_tempo_previsto = tbl_tempo_previsto.id;

## View Matricula
create view vwMatricula as 
	select  tbl_matricula.id as id_matricula,
			tbl_matricula.numero as numero_matricula,
			tbl_aluno.nome as nome_aluno, 
			tbl_aluno.email_institucional as email,
			tbl_aluno.senha as senha,
			tbl_turma.nome as nome_turma, tbl_turma.termo,
			tbl_curso.nome as nome_curso, 
			tbl_ano.ano as ano,
			tbl_periodo.nome as periodo
	from tbl_matricula 
		inner join tbl_aluno 
			on tbl_matricula.id_aluno = tbl_aluno.id
		inner join tbl_turma
			on tbl_matricula.id_turma = tbl_turma.id
		inner join tbl_curso
			on tbl_turma.id_curso = tbl_curso.id
		inner join tbl_ano
			on tbl_turma.id_ano = tbl_ano.id
		inner join tbl_periodo
			on tbl_turma.id_periodo = tbl_periodo.id;

##View Turma
create view vwTurma as
	   select tbl_turma.id ,tbl_turma.nome, tbl_turma.termo, 
			  tbl_curso.nome as nome_curso,
              tbl_ano.ano as ano, 
              tbl_periodo.nome as periodo
	   from tbl_turma
			inner join tbl_curso
				on tbl_turma.id_curso = tbl_curso.id
			inner join tbl_ano
				on tbl_turma.id_ano = tbl_ano.id
			inner join tbl_periodo
				on tbl_turma.id_periodo = tbl_periodo.id;

##View Registro de Tempo
create view vwRegistroTempo as 
	   select tbl_registro_tempo.id,
                time_format(tbl_registro_tempo.horario_inicio,'%H:%i') as horario_inicio, 
                time_format(tbl_registro_tempo.horario_termino, '%H:%i') as horario_termino,
                time_format(tbl_registro_tempo.desconto, '%H:%i') as desconto,
                time_format(tbl_registro_tempo.liquido, '%H:%i') as liquido,
                date_format(tbl_registro_tempo.data_registro, '%d/%m/%Y') as data_registro
		from tbl_registro_tempo;

##View Valor Desejado
create view vwValorDesejado as 
	   select tbl_valor_desejado.id, tbl_valor_desejado.valor_desejado,
			  tbl_criterio.descricao as criterio
	   from tbl_valor_desejado
			inner join tbl_criterio
				on tbl_valor_desejado.id_criterio = tbl_criterio.id;

##View Atividade Valor-Desejado
create view vwAtividadeValorDesejado as
	   select tbl_atividade_valor_desejado.id,
			  tbl_atividade.nome as nome_atividade, tbl_atividade.numero as numero_atividade,
              tbl_tipo_atividade.nome as tipo_atividade,
              tbl_tempo_previsto.tempo as tempo_previsto,
              tbl_valor_desejado.valor_desejado,
			  tbl_criterio.descricao as criterio
	   from tbl_atividade_valor_desejado
			inner join tbl_atividade
				on tbl_atividade_valor_desejado.id_atividade = tbl_atividade.id
			inner join tbl_tipo_atividade
				on tbl_atividade.id_tipo_atividade = tbl_tipo_atividade.id
			inner join tbl_tempo_previsto
				on tbl_atividade.id_tempo_previsto = tbl_tempo_previsto.id
			inner join tbl_valor_desejado
				on tbl_atividade_valor_desejado.id_valor_desejado = tbl_valor_desejado.id
			inner join tbl_criterio
				on tbl_valor_desejado.id_criterio = tbl_criterio.id;

##View Turma Disciplina Professor
create view vwTurmaDisciplinaProfessor as
			select tbl_turma_disciplina_professor.id,
				   tbl_professor.nome as nome_professor, tbl_professor.nif as nif_professor,
				   tbl_administrador.nome as nome_adm,
				   tbl_disciplina.nome as nome_disciplina,
				   tbl_curso.nome as nome_curso,
				   tbl_turma.nome as nome_turma, tbl_turma.termo,
				   tbl_periodo.nome as periodo,
                   tbl_ano.ano as ano_turma
			  from tbl_turma_disciplina_professor
					inner join tbl_professor
						on tbl_professor.id = tbl_turma_disciplina_professor.id_professor
					inner join tbl_administrador
						on tbl_administrador.id = tbl_professor.id_administrador
					inner join tbl_turma
						on tbl_turma.id = tbl_turma_disciplina_professor.id_turma 
					inner join tbl_curso
						on tbl_curso.id = tbl_turma.id_curso
					inner join tbl_periodo
						on tbl_periodo.id = tbl_turma.id_periodo
					inner join tbl_ano 
						on tbl_ano.id = tbl_turma.id_ano
					inner join tbl_disciplina
						on tbl_disciplina.id = tbl_turma_disciplina_professor.id_disciplina;

##View Turma Disciplina Professor Atividade
create view vwTurmaDisciplinaProfessorAtividade as
	select tbl_turma_disciplina_professor_atividade.id,
    tbl_professor.nome as nome_professor, tbl_professor.nif as nif_professor,
    tbl_administrador.nome as nome_adm,
    tbl_disciplina.nome as nome_disciplina,
    tbl_curso.nome as nome_curso,
    tbl_turma.nome as nome_turma, tbl_turma.termo,
    tbl_periodo.nome as periodo,
    tbl_ano.ano as ano_turma,
    tbl_atividade.nome as nome_atividade, tbl_atividade.numero as numero_atividade,
    tbl_tipo_atividade.nome as tipo_atividade,
    time_format(tbl_tempo_previsto.tempo , '%H:%i') as tempo_previsto
    from tbl_turma_disciplina_professor_atividade
         inner join tbl_turma_disciplina_professor
                 on tbl_turma_disciplina_professor_atividade.id_turma_disciplina_professor = tbl_turma_disciplina_professor.id
         inner join tbl_atividade
                 on tbl_turma_disciplina_professor_atividade.id_atividade = tbl_atividade.id
         inner join tbl_professor
                 on tbl_professor.id = tbl_turma_disciplina_professor.id_professor
         inner join tbl_administrador
                 on tbl_administrador.id = tbl_professor.id_administrador
         inner join tbl_turma
                 on tbl_turma.id = tbl_turma_disciplina_professor.id_turma 
         inner join tbl_curso
                 on tbl_curso.id = tbl_turma.id_curso
         inner join tbl_periodo
                 on tbl_periodo.id = tbl_turma.id_periodo
         inner join tbl_ano 
                 on tbl_ano.id = tbl_turma.id_ano
         inner join tbl_disciplina
                 on tbl_disciplina.id = tbl_turma_disciplina_professor.id_disciplina
          inner join tbl_tipo_atividade
                 on tbl_atividade.id_tipo_atividade = tbl_tipo_atividade.id
         inner join tbl_tempo_previsto
                 on tbl_atividade.id_tempo_previsto = tbl_tempo_previsto.id;
                 
##View Matricula Atividade Registro de Tempo
create view vwMatriculaAtividadeRegistroTempo as 
	select tbl_matricula_atividade_registro_tempo.id,
    tbl_matricula.numero as numero_matricula,
    tbl_aluno.nome as nome_aluno, 
    tbl_aluno.email_institucional as email,
    tbl_aluno.senha as senha,
    tbl_turma.nome as nome_turma, tbl_turma.termo,
    tbl_curso.nome as nome_curso, 
    tbl_ano.ano as ano,
    tbl_periodo.nome as periodo,
    tbl_atividade.nome as nome_atividade, tbl_atividade.numero as numero_atividade,
    tbl_tipo_atividade.nome as tipo_atividade,
    time_format(tbl_tempo_previsto.tempo , '%H:%i') as tempo_previsto,
    time_format(tbl_registro_tempo.horario_inicio,'%H:%i') as horario_inicio, 
    time_format(tbl_registro_tempo.horario_termino, '%H:%i') as horario_termino,
    time_format(tbl_registro_tempo.desconto, '%H:%i') as desconto,
    time_format(tbl_registro_tempo.liquido, '%H:%i') as liquido,
    date_format(tbl_registro_tempo.data_registro, '%d/%m/%Y') as data_registro
         from tbl_matricula_atividade_registro_tempo
             inner join tbl_matricula
                     on tbl_matricula_atividade_registro_tempo.id_matricula = tbl_matricula.id
             inner join tbl_atividade
                     on tbl_matricula_atividade_registro_tempo.id_atividade = tbl_atividade.id
             inner join tbl_registro_tempo
                     on tbl_matricula_atividade_registro_tempo.id_registro_tempo = tbl_registro_tempo.id
             inner join tbl_aluno 
                     on tbl_matricula.id_aluno = tbl_aluno.id
             inner join tbl_turma
                     on tbl_matricula.id_turma = tbl_turma.id
             inner join tbl_curso
                     on tbl_turma.id_curso = tbl_curso.id
             inner join tbl_ano
                     on tbl_turma.id_ano = tbl_ano.id
             inner join tbl_periodo
                     on tbl_turma.id_periodo = tbl_periodo.id
             inner join tbl_tipo_atividade
                     on tbl_atividade.id_tipo_atividade = tbl_tipo_atividade.id
             inner join tbl_tempo_previsto
                     on tbl_atividade.id_tempo_previsto = tbl_tempo_previsto.id;

show tables;


