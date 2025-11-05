CREATE DATABASE instituto;

CREATE TABLE persona (
    DNI VARCHAR(9),
    Nom VARCHAR(30),
    Cognom1 VARCHAR(30),
    Cognom2 VARCHAR(30),
    Adreça VARCHAR(50),
    CONSTRAINT PK_DNI PRIMARY KEY (DNI)
);

CREATE TABLE alumne (
    DNI_Persona_Alumne VARCHAR(9),
    DNI_Persona_Delegat VARCHAR(9),
    Data_Naixement DATE,
    CONSTRAINT FK_DNI_PERSONA FOREIGN KEY (DNI_Persona_Alumne) REFERENCES persona (DNI),
    CONSTRAINT PK_DNI_PERSONA PRIMARY KEY (DNI_Persona_Alumne),
    CONSTRAINT FK_DNI_Persona_Delegat FOREIGN KEY (DNI_Persona_Delegat) REFERENCES alumne (DNI_Persona_Alumne)
);

CREATE TABLE professor (
    DNI_Persona_Professor VARCHAR(9),
    Especialitat VARCHAR(30),
    CONSTRAINT FK_DNI_PERSONA_PROFESSOR FOREIGN KEY (DNI_Persona_Professor) REFERENCES persona (DNI),
    CONSTRAINT PK_DNI_PERSONA_PROFESSOR PRIMARY KEY (DNI_Persona_Professor)
);

CREATE TABLE assignatura (
    Codi_Assignatura NUMERIC(9),
    Nom_Assignatura VARCHAR(30),
    CONSTRAINT PK_CODI_ASSIGNATURA PRIMARY KEY (Codi_Assignatura)
);

CREATE TABLE aula (
    Codi_Aula NUMERIC(9),
    Mida NUMERIC(6,2),
    CONSTRAINT PK_CODI_AULA PRIMARY KEY (Codi_Aula)
);

CREATE TABLE modul (
    Codi_Modul NUMERIC(9),
    Codi_Aula NUMERIC(9),
    Nom_Modul VARCHAR(30),
    CONSTRAINT PK_CODI_MODUL PRIMARY KEY (Codi_Modul),
    CONSTRAINT FK_CODI_AULA FOREIGN KEY (Codi_Aula) REFERENCES aula (Codi_Aula)
);


CREATE TABLE Matricula (
    DNI_Persona_Alumne VARCHAR(9),
    Codi_Assignatura NUMERIC(9),
    CONSTRAINT PK_Matricula PRIMARY KEY (DNI_Persona_Alumne, Codi_Assignatura),
    CONSTRAINT FK_DNI_Persona_Alumne_Matricula FOREIGN KEY (DNI_Persona_Alumne) REFERENCES alumne (DNI_Persona_Alumne),
    CONSTRAINT FK_Codi_Assignatura_Matricula FOREIGN KEY (Codi_Assignatura) REFERENCES assignatura (Codi_Assignatura)
);


CREATE TABLE Ensenya (
    DNI_Persona_Professor VARCHAR(9),
    Codi_Assignatura NUMERIC(9),
    CONSTRAINT PK_Ensenya PRIMARY KEY (DNI_Persona_Professor, Codi_Assignatura),
    CONSTRAINT FK_DNI_Persona_Professor_Matricula FOREIGN KEY (DNI_Persona_Professor) REFERENCES professor (DNI_Persona_Professor),
    CONSTRAINT FK_Codi_Assignatura_Matricula_Ensenya FOREIGN KEY (Codi_Assignatura) REFERENCES assignatura (Codi_Assignatura)
);


CREATE TABLE Pertany (
    Codi_Assignatura NUMERIC(9),
    Codi_Modul NUMERIC(9),
    CONSTRAINT PK_Pertany PRIMARY KEY (Codi_Assignatura, Codi_Modul),
    CONSTRAINT FK_Codi_Assignatura_Matricula_Pertany FOREIGN KEY (Codi_Assignatura) REFERENCES assignatura (Codi_Assignatura),
    CONSTRAINT FK_Codi_Modul_Matricula FOREIGN KEY (Codi_Modul) REFERENCES modul (Codi_Modul)
);
