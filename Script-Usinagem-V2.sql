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


show tables;
 

 

