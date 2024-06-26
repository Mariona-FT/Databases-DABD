CREATE TABLE aprovat (
  code char(4),
  name varchar(50),
  city varchar(50),
  district varchar(50),
  grade decimal(3, 1) CHECK (grade >= 4 AND grade <= 10),
  pdate date,
  subject char(4),
  semester char(2)
);
CREATE TABLE ESTUDIANTS (
    code TEXT NOT NULL,
    name TEXT NOT NULL,
    city TEXT,
    district TEXT,
    PRIMARY KEY (code)
);
CREATE TABLE ASSIGNATURA (
    subject TEXT NOT NULL,
    semester TEXT NOT NULL,
    PRIMARY KEY (subject)
);
CREATE TABLE QUALIFICACIONS (
    code TEXT NOT NULL,
    subject TEXT NOT NULL,
    grade REAL NOT NULL,
    pdate DATE NOT NULL,
    PRIMARY KEY (code, subject),
    FOREIGN KEY (code) REFERENCES ESTUDIANTS(code) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (subject) REFERENCES ASSIGNATURA(subject) ON DELETE RESTRICT ON UPDATE CASCADE
);

INSERT INTO aprovat VALUES('C1813','Gabriel Pla Madrigal','Sant Pere de Ribes','Garraf',4.2999999999999998223,'2018-01-07','ARCO','Q4');
INSERT INTO aprovat VALUES('C4864','Alicia Losada Sánchez','Sant Pere de Ribes','Garraf',6.4000000000000003552,'2018-06-21','PRO1','Q2');
INSERT INTO aprovat VALUES('C4221','Esperanza Valentín','Cunit','Baix Penedès',8.3000000000000007105,'2016-11-01','INTE','Q5');
INSERT INTO aprovat VALUES('C4922','Gema Bustos Uriarte','Canyelles','Garraf',5.7000000000000001776,'2019-01-11','ESIN','Q3');
INSERT INTO aprovat VALUES('C9137','Cristina Berrocal Ferrández','Sant Sadurní','Alt Penedès',4.5,'2018-05-06','XACO','Q4');
INSERT INTO aprovat VALUES('C8106','Carla Real-Rivera','La Granada','Alt Penedès',9.3000000000000007105,'2019-02-25','PACO','Q5');
INSERT INTO aprovat VALUES('C3556','Guillermo Tomé Escudero','La Granada','Alt Penedès',9.3000000000000007105,'2017-09-30','ESC2','Q3');
INSERT INTO aprovat VALUES('C7096','Mario Alemán Tomé','Cunit','Baix Penedès',7.5999999999999996447,'2016-04-05','INDI','Q4');
INSERT INTO aprovat VALUES('C3066','Sergio del Zamorano','Sant Pere de Ribes','Garraf',8.9000000000000003552,'2018-11-05','ESTA','Q3');
INSERT INTO aprovat VALUES('C8990','Vicenta Teruel Mendoza','Els Monjos','Alt Penedès',9.5,'2016-07-09','INEP','Q3');
INSERT INTO aprovat VALUES('C3556','Guillermo Tomé Escudero','La Granada','Alt Penedès',6.2000000000000001776,'2019-05-18','FISI','Q1');
INSERT INTO aprovat VALUES('C3543','Alfonso del Ayala','Vilafranca','Alt Penedès',5.2999999999999998223,'2019-10-29','INTE','Q5');
INSERT INTO aprovat VALUES('C3904','Jose Miguel Mariano Mercader Arnaiz','Vilanova','Garraf',7.2999999999999998223,'2018-06-28','INTE','Q5');
INSERT INTO aprovat VALUES('C6627','Lorena Barba Casado','Vilafranca','Alt Penedès',8.3000000000000007105,'2016-09-18','PRO1','Q2');
INSERT INTO aprovat VALUES('C2147','Lucía Villa Coello','Cunit','Baix Penedès',4,'2016-10-01','FOPR','Q1');
INSERT INTO aprovat VALUES('C7997','Nicolás Viñas Armas','El Vendrell','Baix Penedès',6.7000000000000001776,'2017-08-03','FOPR','Q1');
INSERT INTO aprovat VALUES('C2256','Guillermo Sala Pizarro','Calafell','Baix Penedès',6.0999999999999996447,'2017-08-18','LOAL','Q2');
INSERT INTO aprovat VALUES('C3556','Guillermo Tomé Escudero','La Granada','Alt Penedès',4.9000000000000003552,'2017-04-24','SIOP','Q3');
INSERT INTO aprovat VALUES('C7017','Eugenia del Gil','Canyelles','Garraf',9,'2017-04-11','ESC1','Q2');
INSERT INTO aprovat VALUES('C2553','Nuria Costa Antón','Vilafranca','Alt Penedès',6.4000000000000003552,'2019-08-05','ADSO','Q5');
INSERT INTO aprovat VALUES('C9872','Soledad Gil Tello','Sitges','Garraf',7.7999999999999998223,'2019-06-18','INCO','Q1');
INSERT INTO aprovat VALUES('C5741','Begoña Suárez','Vilafranca','Alt Penedès',8.1999999999999992894,'2018-03-23','ESTA','Q3');
INSERT INTO aprovat VALUES('C0643','Martin Casanova-Palomares','Cunit','Baix Penedès',4.4000000000000003552,'2017-03-31','EMPR','Q4');
INSERT INTO aprovat VALUES('C2147','Lucía Villa Coello','Cunit','Baix Penedès',4.0999999999999996447,'2016-06-10','PTIN','Q6');
INSERT INTO aprovat VALUES('C3556','Guillermo Tomé Escudero','La Granada','Alt Penedès',6.0999999999999996447,'2019-04-05','PTIN','Q6');
INSERT INTO aprovat VALUES('C8918','Montserrat Galan Olmedo','Sitges','Garraf',6.7000000000000001776,'2019-11-17','ARCO','Q4');
INSERT INTO aprovat VALUES('C7096','Mario Alemán Tomé','Cunit','Baix Penedès',5.5999999999999996447,'2019-06-29','ESIN','Q3');
INSERT INTO aprovat VALUES('C3904','Jose Miguel Mariano Mercader Arnaiz','Vilanova','Garraf',8.8000000000000007105,'2019-03-28','MATD','Q2');
INSERT INTO aprovat VALUES('C9872','Soledad Gil Tello','Sitges','Garraf',7.5,'2016-04-01','ADSO','Q5');
INSERT INTO aprovat VALUES('C3543','Alfonso del Ayala','Vilafranca','Alt Penedès',6.0999999999999996447,'2017-05-08','FISI','Q1');
INSERT INTO aprovat VALUES('C4221','Esperanza Valentín','Cunit','Baix Penedès',8.9000000000000003552,'2019-01-10','SEAX','Q6');
INSERT INTO aprovat VALUES('C3904','Jose Miguel Mariano Mercader Arnaiz','Vilanova','Garraf',5.5,'2017-02-04','PACO','Q5');
INSERT INTO aprovat VALUES('C8990','Vicenta Teruel Mendoza','Els Monjos','Alt Penedès',8.5,'2019-07-07','ESIN','Q3');
INSERT INTO aprovat VALUES('C3543','Alfonso del Ayala','Vilafranca','Alt Penedès',6,'2018-10-30','INEP','Q3');
INSERT INTO aprovat VALUES('C8106','Carla Real-Rivera','La Granada','Alt Penedès',6.7000000000000001776,'2018-03-24','ARCO','Q4');
INSERT INTO aprovat VALUES('C4221','Esperanza Valentín','Cunit','Baix Penedès',5.2999999999999998223,'2020-02-28','FUIN','Q6');
INSERT INTO aprovat VALUES('C7997','Nicolás Viñas Armas','El Vendrell','Baix Penedès',7.7999999999999998223,'2018-07-29','SODX','Q5');
INSERT INTO aprovat VALUES('C8918','Montserrat Galan Olmedo','Sitges','Garraf',4.4000000000000003552,'2020-02-16','INEP','Q3');
INSERT INTO aprovat VALUES('C4221','Esperanza Valentín','Cunit','Baix Penedès',9.4000000000000003552,'2017-10-17','PROP','Q5');
INSERT INTO aprovat VALUES('C2147','Lucía Villa Coello','Cunit','Baix Penedès',7.2000000000000001776,'2016-09-04','EMPR','Q4');
INSERT INTO aprovat VALUES('C9872','Soledad Gil Tello','Sitges','Garraf',6.0999999999999996447,'2019-08-21','INTE','Q5');
INSERT INTO aprovat VALUES('C5867','Joan Cuenca Cánovas','Els Monjos','Alt Penedès',6.9000000000000003552,'2018-03-27','PROP','Q5');
INSERT INTO aprovat VALUES('C5069','Silvia Lourdes Llorens Rozas','Cubelles','Garraf',5.0999999999999996447,'2018-12-29','SODX','Q5');
INSERT INTO aprovat VALUES('C5069','Silvia Lourdes Llorens Rozas','Cubelles','Garraf',7.5999999999999996447,'2016-04-03','FISI','Q1');
INSERT INTO aprovat VALUES('C5867','Joan Cuenca Cánovas','Els Monjos','Alt Penedès',7.4000000000000003552,'2017-07-05','AMEP','Q4');
INSERT INTO aprovat VALUES('C2147','Lucía Villa Coello','Cunit','Baix Penedès',8,'2017-03-25','DABD','Q6');
INSERT INTO aprovat VALUES('C4221','Esperanza Valentín','Cunit','Baix Penedès',6.7999999999999998223,'2018-04-07','XAMU','Q6');
INSERT INTO aprovat VALUES('C7017','Eugenia del Gil','Canyelles','Garraf',7.7999999999999998223,'2016-04-19','SODX','Q5');
INSERT INTO aprovat VALUES('C2147','Lucía Villa Coello','Cunit','Baix Penedès',9,'2017-02-21','FUIN','Q6');
INSERT INTO aprovat VALUES('C0602','Elisa Mármol Sanjuan','Calafell','Baix Penedès',4.2999999999999998223,'2019-05-08','SODX','Q5');
INSERT INTO aprovat VALUES('C7997','Nicolás Viñas Armas','El Vendrell','Baix Penedès',7.0999999999999996447,'2016-07-23','EMPR','Q4');
INSERT INTO aprovat VALUES('C3066','Sergio del Zamorano','Sant Pere de Ribes','Garraf',6,'2016-06-13','DABD','Q6');
INSERT INTO aprovat VALUES('C5741','Begoña Suárez','Vilafranca','Alt Penedès',4.5,'2017-06-15','FUIN','Q6');
INSERT INTO aprovat VALUES('C8208','Carlos Barranco','Sitges','Garraf',7.5999999999999996447,'2019-06-30','PTIN','Q6');
INSERT INTO aprovat VALUES('C4864','Alicia Losada Sánchez','Sant Pere de Ribes','Garraf',6.4000000000000003552,'2018-01-11','EMPR','Q4');
INSERT INTO aprovat VALUES('C4922','Gema Bustos Uriarte','Canyelles','Garraf',4.9000000000000003552,'2019-11-08','PRO1','Q2');
INSERT INTO aprovat VALUES('C6894','Catalina Casas Jerez','Sant Pere de Ribes','Garraf',5.0999999999999996447,'2016-08-18','SEAX','Q6');
INSERT INTO aprovat VALUES('C5069','Silvia Lourdes Llorens Rozas','Cubelles','Garraf',7.2999999999999998223,'2020-02-20','PRO1','Q2');
INSERT INTO aprovat VALUES('C3904','Jose Miguel Mariano Mercader Arnaiz','Vilanova','Garraf',5.7000000000000001776,'2018-09-13','LOAL','Q2');
INSERT INTO aprovat VALUES('C7017','Eugenia del Gil','Canyelles','Garraf',6.2000000000000001776,'2018-10-04','SIOP','Q3');
INSERT INTO aprovat VALUES('C3556','Guillermo Tomé Escudero','La Granada','Alt Penedès',7.4000000000000003552,'2018-12-29','LOAL','Q2');
INSERT INTO aprovat VALUES('C3066','Sergio del Zamorano','Sant Pere de Ribes','Garraf',6.7999999999999998223,'2018-09-21','AMEP','Q4');
INSERT INTO aprovat VALUES('C9872','Soledad Gil Tello','Sitges','Garraf',7.5,'2019-10-12','MATD','Q2');
INSERT INTO aprovat VALUES('C3543','Alfonso del Ayala','Vilafranca','Alt Penedès',4,'2020-01-31','FOMA','Q1');
INSERT INTO aprovat VALUES('C0643','Martin Casanova-Palomares','Cunit','Baix Penedès',8.8000000000000007105,'2017-04-18','FOMA','Q1');
INSERT INTO aprovat VALUES('C3904','Jose Miguel Mariano Mercader Arnaiz','Vilanova','Garraf',9.8000000000000007105,'2019-02-19','ESIN','Q3');
INSERT INTO aprovat VALUES('C6894','Catalina Casas Jerez','Sant Pere de Ribes','Garraf',6.5999999999999996447,'2018-06-10','SODX','Q5');
INSERT INTO aprovat VALUES('C8990','Vicenta Teruel Mendoza','Els Monjos','Alt Penedès',8.4000000000000003552,'2016-03-19','INCO','Q1');
INSERT INTO aprovat VALUES('C8179','Belen Jover Puerta','Sitges','Garraf',5.2999999999999998223,'2019-06-24','XAMU','Q6');
INSERT INTO aprovat VALUES('C4221','Esperanza Valentín','Cunit','Baix Penedès',5.2999999999999998223,'2018-10-02','ESTA','Q3');
INSERT INTO aprovat VALUES('C2413','Juana del Álvaro','Cubelles','Garraf',9.0999999999999996447,'2019-06-03','ESTA','Q3');
INSERT INTO aprovat VALUES('C4864','Alicia Losada Sánchez','Sant Pere de Ribes','Garraf',4.4000000000000003552,'2018-04-09','ARCO','Q4');
INSERT INTO aprovat VALUES('C3904','Jose Miguel Mariano Mercader Arnaiz','Vilanova','Garraf',5.5,'2018-07-22','ESTA','Q3');
INSERT INTO aprovat VALUES('C8990','Vicenta Teruel Mendoza','Els Monjos','Alt Penedès',7.5,'2018-08-20','SODX','Q5');
INSERT INTO aprovat VALUES('C3543','Alfonso del Ayala','Vilafranca','Alt Penedès',7.0999999999999996447,'2019-08-12','FUIN','Q6');
INSERT INTO aprovat VALUES('C7997','Nicolás Viñas Armas','El Vendrell','Baix Penedès',4.7999999999999998223,'2019-09-14','SEAX','Q6');
INSERT INTO aprovat VALUES('C8179','Belen Jover Puerta','Sitges','Garraf',7.5999999999999996447,'2016-11-18','PACO','Q5');
INSERT INTO aprovat VALUES('C8918','Montserrat Galan Olmedo','Sitges','Garraf',6.9000000000000003552,'2017-05-19','ESIN','Q3');
INSERT INTO aprovat VALUES('C9872','Soledad Gil Tello','Sitges','Garraf',9.0999999999999996447,'2019-03-02','INDI','Q4');
INSERT INTO aprovat VALUES('C8918','Montserrat Galan Olmedo','Sitges','Garraf',8.9000000000000003552,'2016-10-24','FOPR','Q1');
INSERT INTO aprovat VALUES('C3904','Jose Miguel Mariano Mercader Arnaiz','Vilanova','Garraf',8.5999999999999996447,'2017-11-21','INEP','Q3');
INSERT INTO aprovat VALUES('C2413','Juana del Álvaro','Cubelles','Garraf',9.0999999999999996447,'2019-01-03','INTE','Q5');
INSERT INTO aprovat VALUES('C0643','Martin Casanova-Palomares','Cunit','Baix Penedès',6.2999999999999998223,'2020-01-15','PROP','Q5');
INSERT INTO aprovat VALUES('C2413','Juana del Álvaro','Cubelles','Garraf',4.5,'2019-03-23','FOPR','Q1');
INSERT INTO aprovat VALUES('C3543','Alfonso del Ayala','Vilafranca','Alt Penedès',7.2999999999999998223,'2019-09-15','ARCO','Q4');
INSERT INTO aprovat VALUES('C8106','Carla Real-Rivera','La Granada','Alt Penedès',4.5999999999999996447,'2018-08-16','PROP','Q5');
INSERT INTO aprovat VALUES('C5867','Joan Cuenca Cánovas','Els Monjos','Alt Penedès',10,'2019-09-12','MATD','Q2');
INSERT INTO aprovat VALUES('C2256','Guillermo Sala Pizarro','Calafell','Baix Penedès',9.5999999999999996447,'2019-09-17','FOMA','Q1');
INSERT INTO aprovat VALUES('C1813','Gabriel Pla Madrigal','Sant Pere de Ribes','Garraf',6,'2019-05-12','SIOP','Q3');
INSERT INTO aprovat VALUES('C0602','Elisa Mármol Sanjuan','Calafell','Baix Penedès',6.5999999999999996447,'2019-07-20','SIOP','Q3');
INSERT INTO aprovat VALUES('C2413','Juana del Álvaro','Cubelles','Garraf',4.4000000000000003552,'2016-08-17','AMEP','Q4');
INSERT INTO aprovat VALUES('C0643','Martin Casanova-Palomares','Cunit','Baix Penedès',9.8000000000000007105,'2016-10-06','SODX','Q5');
INSERT INTO aprovat VALUES('C2147','Lucía Villa Coello','Cunit','Baix Penedès',10,'2019-01-20','ADSO','Q5');
INSERT INTO aprovat VALUES('C5741','Begoña Suárez','Vilafranca','Alt Penedès',6,'2018-04-23','PTIN','Q6');
INSERT INTO aprovat VALUES('C0602','Elisa Mármol Sanjuan','Calafell','Baix Penedès',5.4000000000000003552,'2019-03-12','LOAL','Q2');
INSERT INTO aprovat VALUES('C9872','Soledad Gil Tello','Sitges','Garraf',6,'2016-10-09','LOAL','Q2');
INSERT INTO aprovat VALUES('C5741','Begoña Suárez','Vilafranca','Alt Penedès',5.4000000000000003552,'2016-06-20','EMPR','Q4');
INSERT INTO aprovat VALUES('C3556','Guillermo Tomé Escudero','La Granada','Alt Penedès',5.7999999999999998223,'2018-06-07','DABD','Q6');
INSERT INTO aprovat VALUES('C3543','Alfonso del Ayala','Vilafranca','Alt Penedès',4.7000000000000001776,'2017-07-19','ESC2','Q3');
INSERT INTO aprovat VALUES('C1813','Gabriel Pla Madrigal','Sant Pere de Ribes','Garraf',7,'2017-06-02','PRO1','Q2');
INSERT INTO aprovat VALUES('C8990','Vicenta Teruel Mendoza','Els Monjos','Alt Penedès',6.5999999999999996447,'2020-03-01','DABD','Q6');
INSERT INTO aprovat VALUES('C5867','Joan Cuenca Cánovas','Els Monjos','Alt Penedès',5.9000000000000003552,'2016-07-07','ESC1','Q2');
INSERT INTO aprovat VALUES('C4221','Esperanza Valentín','Cunit','Baix Penedès',4.0999999999999996447,'2017-05-04','XACO','Q4');
INSERT INTO aprovat VALUES('C4922','Gema Bustos Uriarte','Canyelles','Garraf',8.0999999999999996447,'2016-10-03','ARCO','Q4');
INSERT INTO aprovat VALUES('C3904','Jose Miguel Mariano Mercader Arnaiz','Vilanova','Garraf',6.5,'2019-08-02','FUIN','Q6');
INSERT INTO aprovat VALUES('C8179','Belen Jover Puerta','Sitges','Garraf',6.2999999999999998223,'2017-04-28','SODX','Q5');
INSERT INTO aprovat VALUES('C0643','Martin Casanova-Palomares','Cunit','Baix Penedès',7.5999999999999996447,'2019-08-04','DABD','Q6');
INSERT INTO aprovat VALUES('C2553','Nuria Costa Antón','Vilafranca','Alt Penedès',4.2999999999999998223,'2018-12-02','XACO','Q4');
INSERT INTO aprovat VALUES('C3543','Alfonso del Ayala','Vilafranca','Alt Penedès',5.5,'2016-06-17','ESC1','Q2');
INSERT INTO aprovat VALUES('C5069','Silvia Lourdes Llorens Rozas','Cubelles','Garraf',4.2999999999999998223,'2017-09-09','SEAX','Q6');
INSERT INTO aprovat VALUES('C0602','Elisa Mármol Sanjuan','Calafell','Baix Penedès',7.7000000000000001776,'2017-10-14','FISI','Q1');
INSERT INTO aprovat VALUES('C5867','Joan Cuenca Cánovas','Els Monjos','Alt Penedès',9.8000000000000007105,'2019-04-23','SODX','Q5');
INSERT INTO aprovat VALUES('C9872','Soledad Gil Tello','Sitges','Garraf',4.0999999999999996447,'2017-06-23','XACO','Q4');
INSERT INTO aprovat VALUES('C4922','Gema Bustos Uriarte','Canyelles','Garraf',4.0999999999999996447,'2016-08-29','ESTA','Q3');
INSERT INTO aprovat VALUES('C5741','Begoña Suárez','Vilafranca','Alt Penedès',5.9000000000000003552,'2019-01-06','LOAL','Q2');
INSERT INTO aprovat VALUES('C2147','Lucía Villa Coello','Cunit','Baix Penedès',5.5999999999999996447,'2019-01-13','PACO','Q5');
INSERT INTO aprovat VALUES('C3904','Jose Miguel Mariano Mercader Arnaiz','Vilanova','Garraf',7.2000000000000001776,'2019-07-19','FOPR','Q1');
INSERT INTO aprovat VALUES('C8918','Montserrat Galan Olmedo','Sitges','Garraf',8.5,'2017-07-04','FISI','Q1');
INSERT INTO aprovat VALUES('C0643','Martin Casanova-Palomares','Cunit','Baix Penedès',7.2999999999999998223,'2018-12-25','PRO1','Q2');
INSERT INTO aprovat VALUES('C2553','Nuria Costa Antón','Vilafranca','Alt Penedès',6.7999999999999998223,'2018-10-13','INTE','Q5');
INSERT INTO aprovat VALUES('C2553','Nuria Costa Antón','Vilafranca','Alt Penedès',6.2999999999999998223,'2019-02-16','ESC1','Q2');
INSERT INTO aprovat VALUES('C4221','Esperanza Valentín','Cunit','Baix Penedès',8.1999999999999992894,'2016-06-06','ARCO','Q4');
INSERT INTO aprovat VALUES('C8918','Montserrat Galan Olmedo','Sitges','Garraf',6.9000000000000003552,'2019-09-17','XACO','Q4');
INSERT INTO aprovat VALUES('C9137','Cristina Berrocal Ferrández','Sant Sadurní','Alt Penedès',6.7000000000000001776,'2017-12-19','INDI','Q4');
INSERT INTO aprovat VALUES('C2147','Lucía Villa Coello','Cunit','Baix Penedès',9.8000000000000007105,'2019-06-25','FOMA','Q1');
INSERT INTO aprovat VALUES('C5069','Silvia Lourdes Llorens Rozas','Cubelles','Garraf',8.0999999999999996447,'2019-08-01','FOMA','Q1');
INSERT INTO aprovat VALUES('C5741','Begoña Suárez','Vilafranca','Alt Penedès',5.9000000000000003552,'2017-12-06','XAMU','Q6');
INSERT INTO aprovat VALUES('C7997','Nicolás Viñas Armas','El Vendrell','Baix Penedès',9.8000000000000007105,'2020-02-18','XAMU','Q6');
INSERT INTO aprovat VALUES('C2553','Nuria Costa Antón','Vilafranca','Alt Penedès',7.9000000000000003552,'2018-02-23','INDI','Q4');
INSERT INTO aprovat VALUES('C4864','Alicia Losada Sánchez','Sant Pere de Ribes','Garraf',9.9000000000000003552,'2018-05-30','ESC2','Q3');
INSERT INTO aprovat VALUES('C9872','Soledad Gil Tello','Sitges','Garraf',9.1999999999999992894,'2019-03-11','ESC1','Q2');
INSERT INTO aprovat VALUES('C2413','Juana del Álvaro','Cubelles','Garraf',4.5,'2017-05-10','PROP','Q5');
INSERT INTO aprovat VALUES('C9137','Cristina Berrocal Ferrández','Sant Sadurní','Alt Penedès',8.1999999999999992894,'2017-12-03','MATD','Q2');
INSERT INTO aprovat VALUES('C3904','Jose Miguel Mariano Mercader Arnaiz','Vilanova','Garraf',9.5,'2018-11-24','PTIN','Q6');
INSERT INTO aprovat VALUES('C2147','Lucía Villa Coello','Cunit','Baix Penedès',8.8000000000000007105,'2020-01-08','AMEP','Q4');
INSERT INTO aprovat VALUES('C7997','Nicolás Viñas Armas','El Vendrell','Baix Penedès',8.9000000000000003552,'2017-05-17','XACO','Q4');
INSERT INTO aprovat VALUES('C3066','Sergio del Zamorano','Sant Pere de Ribes','Garraf',9.1999999999999992894,'2018-03-27','ARCO','Q4');
INSERT INTO aprovat VALUES('C1813','Gabriel Pla Madrigal','Sant Pere de Ribes','Garraf',4.2000000000000001776,'2019-03-01','SODX','Q5');
INSERT INTO aprovat VALUES('C5741','Begoña Suárez','Vilafranca','Alt Penedès',7.9000000000000003552,'2019-01-31','PRO1','Q2');
INSERT INTO aprovat VALUES('C5069','Silvia Lourdes Llorens Rozas','Cubelles','Garraf',5.4000000000000003552,'2018-12-02','INCO','Q1');
INSERT INTO aprovat VALUES('C3066','Sergio del Zamorano','Sant Pere de Ribes','Garraf',5,'2018-06-02','PRO1','Q2');
INSERT INTO aprovat VALUES('C1503','Pilar Bustamante Criado','Sitges','Garraf',8.5,'2019-04-20','INEP','Q3');
INSERT INTO aprovat VALUES('C6894','Catalina Casas Jerez','Sant Pere de Ribes','Garraf',6.0999999999999996447,'2017-05-21','ADSO','Q5');
INSERT INTO aprovat VALUES('C9872','Soledad Gil Tello','Sitges','Garraf',5,'2019-04-23','AMEP','Q4');
INSERT INTO aprovat VALUES('C7017','Eugenia del Gil','Canyelles','Garraf',4.9000000000000003552,'2016-03-20','DABD','Q6');
INSERT INTO aprovat VALUES('C8179','Belen Jover Puerta','Sitges','Garraf',9.3000000000000007105,'2016-08-06','PTIN','Q6');
INSERT INTO aprovat VALUES('C8179','Belen Jover Puerta','Sitges','Garraf',4.2999999999999998223,'2017-03-31','ADSO','Q5');
INSERT INTO aprovat VALUES('C8208','Carlos Barranco','Sitges','Garraf',7.7000000000000001776,'2017-10-06','ESTA','Q3');
INSERT INTO aprovat VALUES('C7997','Nicolás Viñas Armas','El Vendrell','Baix Penedès',9.5999999999999996447,'2019-03-11','PRO1','Q2');
INSERT INTO aprovat VALUES('C7096','Mario Alemán Tomé','Cunit','Baix Penedès',7,'2018-09-03','INTE','Q5');
INSERT INTO ESTUDIANTS VALUES('C1813','Gabriel Pla Madrigal','Sant Pere de Ribes','Garraf');
INSERT INTO ESTUDIANTS VALUES('C4864','Alicia Losada Sánchez','Sant Pere de Ribes','Garraf');
INSERT INTO ESTUDIANTS VALUES('C4221','Esperanza Valentín','Cunit','Baix Penedès');
INSERT INTO ESTUDIANTS VALUES('C4922','Gema Bustos Uriarte','Canyelles','Garraf');
INSERT INTO ESTUDIANTS VALUES('C9137','Cristina Berrocal Ferrández','Sant Sadurní','Alt Penedès');
INSERT INTO ESTUDIANTS VALUES('C8106','Carla Real-Rivera','La Granada','Alt Penedès');
INSERT INTO ESTUDIANTS VALUES('C3556','Guillermo Tomé Escudero','La Granada','Alt Penedès');
INSERT INTO ESTUDIANTS VALUES('C7096','Mario Alemán Tomé','Cunit','Baix Penedès');
INSERT INTO ESTUDIANTS VALUES('C3066','Sergio del Zamorano','Sant Pere de Ribes','Garraf');
INSERT INTO ESTUDIANTS VALUES('C8990','Vicenta Teruel Mendoza','Els Monjos','Alt Penedès');
INSERT INTO ESTUDIANTS VALUES('C3543','Alfonso del Ayala','Vilafranca','Alt Penedès');
INSERT INTO ESTUDIANTS VALUES('C3904','Jose Miguel Mariano Mercader Arnaiz','Vilanova','Garraf');
INSERT INTO ESTUDIANTS VALUES('C6627','Lorena Barba Casado','Vilafranca','Alt Penedès');
INSERT INTO ESTUDIANTS VALUES('C2147','Lucía Villa Coello','Cunit','Baix Penedès');
INSERT INTO ESTUDIANTS VALUES('C7997','Nicolás Viñas Armas','El Vendrell','Baix Penedès');
INSERT INTO ESTUDIANTS VALUES('C2256','Guillermo Sala Pizarro','Calafell','Baix Penedès');
INSERT INTO ESTUDIANTS VALUES('C7017','Eugenia del Gil','Canyelles','Garraf');
INSERT INTO ESTUDIANTS VALUES('C2553','Nuria Costa Antón','Vilafranca','Alt Penedès');
INSERT INTO ESTUDIANTS VALUES('C9872','Soledad Gil Tello','Sitges','Garraf');
INSERT INTO ESTUDIANTS VALUES('C5741','Begoña Suárez','Vilafranca','Alt Penedès');
INSERT INTO ESTUDIANTS VALUES('C0643','Martin Casanova-Palomares','Cunit','Baix Penedès');
INSERT INTO ESTUDIANTS VALUES('C8918','Montserrat Galan Olmedo','Sitges','Garraf');
INSERT INTO ESTUDIANTS VALUES('C5867','Joan Cuenca Cánovas','Els Monjos','Alt Penedès');
INSERT INTO ESTUDIANTS VALUES('C5069','Silvia Lourdes Llorens Rozas','Cubelles','Garraf');
INSERT INTO ESTUDIANTS VALUES('C0602','Elisa Mármol Sanjuan','Calafell','Baix Penedès');
INSERT INTO ESTUDIANTS VALUES('C8208','Carlos Barranco','Sitges','Garraf');
INSERT INTO ESTUDIANTS VALUES('C6894','Catalina Casas Jerez','Sant Pere de Ribes','Garraf');
INSERT INTO ESTUDIANTS VALUES('C8179','Belen Jover Puerta','Sitges','Garraf');
INSERT INTO ESTUDIANTS VALUES('C2413','Juana del Álvaro','Cubelles','Garraf');
INSERT INTO ESTUDIANTS VALUES('C1503','Pilar Bustamante Criado','Sitges','Garraf');
INSERT INTO ASSIGNATURA VALUES('ARCO','Q4');
INSERT INTO ASSIGNATURA VALUES('PRO1','Q2');
INSERT INTO ASSIGNATURA VALUES('INTE','Q5');
INSERT INTO ASSIGNATURA VALUES('ESIN','Q3');
INSERT INTO ASSIGNATURA VALUES('XACO','Q4');
INSERT INTO ASSIGNATURA VALUES('PACO','Q5');
INSERT INTO ASSIGNATURA VALUES('ESC2','Q3');
INSERT INTO ASSIGNATURA VALUES('INDI','Q4');
INSERT INTO ASSIGNATURA VALUES('ESTA','Q3');
INSERT INTO ASSIGNATURA VALUES('INEP','Q3');
INSERT INTO ASSIGNATURA VALUES('FISI','Q1');
INSERT INTO ASSIGNATURA VALUES('FOPR','Q1');
INSERT INTO ASSIGNATURA VALUES('LOAL','Q2');
INSERT INTO ASSIGNATURA VALUES('SIOP','Q3');
INSERT INTO ASSIGNATURA VALUES('ESC1','Q2');
INSERT INTO ASSIGNATURA VALUES('ADSO','Q5');
INSERT INTO ASSIGNATURA VALUES('INCO','Q1');
INSERT INTO ASSIGNATURA VALUES('EMPR','Q4');
INSERT INTO ASSIGNATURA VALUES('PTIN','Q6');
INSERT INTO ASSIGNATURA VALUES('MATD','Q2');
INSERT INTO ASSIGNATURA VALUES('SEAX','Q6');
INSERT INTO ASSIGNATURA VALUES('FUIN','Q6');
INSERT INTO ASSIGNATURA VALUES('SODX','Q5');
INSERT INTO ASSIGNATURA VALUES('PROP','Q5');
INSERT INTO ASSIGNATURA VALUES('AMEP','Q4');
INSERT INTO ASSIGNATURA VALUES('DABD','Q6');
INSERT INTO ASSIGNATURA VALUES('XAMU','Q6');
INSERT INTO ASSIGNATURA VALUES('FOMA','Q1');
INSERT INTO QUALIFICACIONS VALUES('C1813','ARCO',4.2999999999999998223,'2018-01-07');
INSERT INTO QUALIFICACIONS VALUES('C4864','PRO1',6.4000000000000003552,'2018-06-21');
INSERT INTO QUALIFICACIONS VALUES('C4221','INTE',8.3000000000000007105,'2016-11-01');
INSERT INTO QUALIFICACIONS VALUES('C4922','ESIN',5.7000000000000001776,'2019-01-11');
INSERT INTO QUALIFICACIONS VALUES('C9137','XACO',4.5,'2018-05-06');
INSERT INTO QUALIFICACIONS VALUES('C8106','PACO',9.3000000000000007105,'2019-02-25');
INSERT INTO QUALIFICACIONS VALUES('C3556','ESC2',9.3000000000000007105,'2017-09-30');
INSERT INTO QUALIFICACIONS VALUES('C7096','INDI',7.5999999999999996447,'2016-04-05');
INSERT INTO QUALIFICACIONS VALUES('C3066','ESTA',8.9000000000000003552,'2018-11-05');
INSERT INTO QUALIFICACIONS VALUES('C8990','INEP',9.5,'2016-07-09');
INSERT INTO QUALIFICACIONS VALUES('C3556','FISI',6.2000000000000001776,'2019-05-18');
INSERT INTO QUALIFICACIONS VALUES('C3543','INTE',5.2999999999999998223,'2019-10-29');
INSERT INTO QUALIFICACIONS VALUES('C3904','INTE',7.2999999999999998223,'2018-06-28');
INSERT INTO QUALIFICACIONS VALUES('C6627','PRO1',8.3000000000000007105,'2016-09-18');
INSERT INTO QUALIFICACIONS VALUES('C2147','FOPR',4.0,'2016-10-01');
INSERT INTO QUALIFICACIONS VALUES('C7997','FOPR',6.7000000000000001776,'2017-08-03');
INSERT INTO QUALIFICACIONS VALUES('C2256','LOAL',6.0999999999999996447,'2017-08-18');
INSERT INTO QUALIFICACIONS VALUES('C3556','SIOP',4.9000000000000003552,'2017-04-24');
INSERT INTO QUALIFICACIONS VALUES('C7017','ESC1',9.0,'2017-04-11');
INSERT INTO QUALIFICACIONS VALUES('C2553','ADSO',6.4000000000000003552,'2019-08-05');
INSERT INTO QUALIFICACIONS VALUES('C9872','INCO',7.7999999999999998223,'2019-06-18');
INSERT INTO QUALIFICACIONS VALUES('C5741','ESTA',8.1999999999999992894,'2018-03-23');
INSERT INTO QUALIFICACIONS VALUES('C0643','EMPR',4.4000000000000003552,'2017-03-31');
INSERT INTO QUALIFICACIONS VALUES('C2147','PTIN',4.0999999999999996447,'2016-06-10');
INSERT INTO QUALIFICACIONS VALUES('C3556','PTIN',6.0999999999999996447,'2019-04-05');
INSERT INTO QUALIFICACIONS VALUES('C8918','ARCO',6.7000000000000001776,'2019-11-17');
INSERT INTO QUALIFICACIONS VALUES('C7096','ESIN',5.5999999999999996447,'2019-06-29');
INSERT INTO QUALIFICACIONS VALUES('C3904','MATD',8.8000000000000007105,'2019-03-28');
INSERT INTO QUALIFICACIONS VALUES('C9872','ADSO',7.5,'2016-04-01');
INSERT INTO QUALIFICACIONS VALUES('C3543','FISI',6.0999999999999996447,'2017-05-08');
INSERT INTO QUALIFICACIONS VALUES('C4221','SEAX',8.9000000000000003552,'2019-01-10');
INSERT INTO QUALIFICACIONS VALUES('C3904','PACO',5.5,'2017-02-04');
INSERT INTO QUALIFICACIONS VALUES('C8990','ESIN',8.5,'2019-07-07');
INSERT INTO QUALIFICACIONS VALUES('C3543','INEP',6.0,'2018-10-30');
INSERT INTO QUALIFICACIONS VALUES('C8106','ARCO',6.7000000000000001776,'2018-03-24');
INSERT INTO QUALIFICACIONS VALUES('C4221','FUIN',5.2999999999999998223,'2020-02-28');
INSERT INTO QUALIFICACIONS VALUES('C7997','SODX',7.7999999999999998223,'2018-07-29');
INSERT INTO QUALIFICACIONS VALUES('C8918','INEP',4.4000000000000003552,'2020-02-16');
INSERT INTO QUALIFICACIONS VALUES('C4221','PROP',9.4000000000000003552,'2017-10-17');
INSERT INTO QUALIFICACIONS VALUES('C2147','EMPR',7.2000000000000001776,'2016-09-04');
INSERT INTO QUALIFICACIONS VALUES('C9872','INTE',6.0999999999999996447,'2019-08-21');
INSERT INTO QUALIFICACIONS VALUES('C5867','PROP',6.9000000000000003552,'2018-03-27');
INSERT INTO QUALIFICACIONS VALUES('C5069','SODX',5.0999999999999996447,'2018-12-29');
INSERT INTO QUALIFICACIONS VALUES('C5069','FISI',7.5999999999999996447,'2016-04-03');
INSERT INTO QUALIFICACIONS VALUES('C5867','AMEP',7.4000000000000003552,'2017-07-05');
INSERT INTO QUALIFICACIONS VALUES('C2147','DABD',8.0,'2017-03-25');
INSERT INTO QUALIFICACIONS VALUES('C4221','XAMU',6.7999999999999998223,'2018-04-07');
INSERT INTO QUALIFICACIONS VALUES('C7017','SODX',7.7999999999999998223,'2016-04-19');
INSERT INTO QUALIFICACIONS VALUES('C2147','FUIN',9.0,'2017-02-21');
INSERT INTO QUALIFICACIONS VALUES('C0602','SODX',4.2999999999999998223,'2019-05-08');
INSERT INTO QUALIFICACIONS VALUES('C7997','EMPR',7.0999999999999996447,'2016-07-23');
INSERT INTO QUALIFICACIONS VALUES('C3066','DABD',6.0,'2016-06-13');
INSERT INTO QUALIFICACIONS VALUES('C5741','FUIN',4.5,'2017-06-15');
INSERT INTO QUALIFICACIONS VALUES('C8208','PTIN',7.5999999999999996447,'2019-06-30');
INSERT INTO QUALIFICACIONS VALUES('C4864','EMPR',6.4000000000000003552,'2018-01-11');
INSERT INTO QUALIFICACIONS VALUES('C4922','PRO1',4.9000000000000003552,'2019-11-08');
INSERT INTO QUALIFICACIONS VALUES('C6894','SEAX',5.0999999999999996447,'2016-08-18');
INSERT INTO QUALIFICACIONS VALUES('C5069','PRO1',7.2999999999999998223,'2020-02-20');
INSERT INTO QUALIFICACIONS VALUES('C3904','LOAL',5.7000000000000001776,'2018-09-13');
INSERT INTO QUALIFICACIONS VALUES('C7017','SIOP',6.2000000000000001776,'2018-10-04');
INSERT INTO QUALIFICACIONS VALUES('C3556','LOAL',7.4000000000000003552,'2018-12-29');
INSERT INTO QUALIFICACIONS VALUES('C3066','AMEP',6.7999999999999998223,'2018-09-21');
INSERT INTO QUALIFICACIONS VALUES('C9872','MATD',7.5,'2019-10-12');
INSERT INTO QUALIFICACIONS VALUES('C3543','FOMA',4.0,'2020-01-31');
INSERT INTO QUALIFICACIONS VALUES('C0643','FOMA',8.8000000000000007105,'2017-04-18');
INSERT INTO QUALIFICACIONS VALUES('C3904','ESIN',9.8000000000000007105,'2019-02-19');
INSERT INTO QUALIFICACIONS VALUES('C6894','SODX',6.5999999999999996447,'2018-06-10');
INSERT INTO QUALIFICACIONS VALUES('C8990','INCO',8.4000000000000003552,'2016-03-19');
INSERT INTO QUALIFICACIONS VALUES('C8179','XAMU',5.2999999999999998223,'2019-06-24');
INSERT INTO QUALIFICACIONS VALUES('C4221','ESTA',5.2999999999999998223,'2018-10-02');
INSERT INTO QUALIFICACIONS VALUES('C2413','ESTA',9.0999999999999996447,'2019-06-03');
INSERT INTO QUALIFICACIONS VALUES('C4864','ARCO',4.4000000000000003552,'2018-04-09');
INSERT INTO QUALIFICACIONS VALUES('C3904','ESTA',5.5,'2018-07-22');
INSERT INTO QUALIFICACIONS VALUES('C8990','SODX',7.5,'2018-08-20');
INSERT INTO QUALIFICACIONS VALUES('C3543','FUIN',7.0999999999999996447,'2019-08-12');
INSERT INTO QUALIFICACIONS VALUES('C7997','SEAX',4.7999999999999998223,'2019-09-14');
INSERT INTO QUALIFICACIONS VALUES('C8179','PACO',7.5999999999999996447,'2016-11-18');
INSERT INTO QUALIFICACIONS VALUES('C8918','ESIN',6.9000000000000003552,'2017-05-19');
INSERT INTO QUALIFICACIONS VALUES('C9872','INDI',9.0999999999999996447,'2019-03-02');
INSERT INTO QUALIFICACIONS VALUES('C8918','FOPR',8.9000000000000003552,'2016-10-24');
INSERT INTO QUALIFICACIONS VALUES('C3904','INEP',8.5999999999999996447,'2017-11-21');
INSERT INTO QUALIFICACIONS VALUES('C2413','INTE',9.0999999999999996447,'2019-01-03');
INSERT INTO QUALIFICACIONS VALUES('C0643','PROP',6.2999999999999998223,'2020-01-15');
INSERT INTO QUALIFICACIONS VALUES('C2413','FOPR',4.5,'2019-03-23');
INSERT INTO QUALIFICACIONS VALUES('C3543','ARCO',7.2999999999999998223,'2019-09-15');
INSERT INTO QUALIFICACIONS VALUES('C8106','PROP',4.5999999999999996447,'2018-08-16');
INSERT INTO QUALIFICACIONS VALUES('C5867','MATD',10.0,'2019-09-12');
INSERT INTO QUALIFICACIONS VALUES('C2256','FOMA',9.5999999999999996447,'2019-09-17');
INSERT INTO QUALIFICACIONS VALUES('C1813','SIOP',6.0,'2019-05-12');
INSERT INTO QUALIFICACIONS VALUES('C0602','SIOP',6.5999999999999996447,'2019-07-20');
INSERT INTO QUALIFICACIONS VALUES('C2413','AMEP',4.4000000000000003552,'2016-08-17');
INSERT INTO QUALIFICACIONS VALUES('C0643','SODX',9.8000000000000007105,'2016-10-06');
INSERT INTO QUALIFICACIONS VALUES('C2147','ADSO',10.0,'2019-01-20');
INSERT INTO QUALIFICACIONS VALUES('C5741','PTIN',6.0,'2018-04-23');
INSERT INTO QUALIFICACIONS VALUES('C0602','LOAL',5.4000000000000003552,'2019-03-12');
INSERT INTO QUALIFICACIONS VALUES('C9872','LOAL',6.0,'2016-10-09');
INSERT INTO QUALIFICACIONS VALUES('C5741','EMPR',5.4000000000000003552,'2016-06-20');
INSERT INTO QUALIFICACIONS VALUES('C3556','DABD',5.7999999999999998223,'2018-06-07');
INSERT INTO QUALIFICACIONS VALUES('C3543','ESC2',4.7000000000000001776,'2017-07-19');
INSERT INTO QUALIFICACIONS VALUES('C1813','PRO1',7.0,'2017-06-02');
INSERT INTO QUALIFICACIONS VALUES('C8990','DABD',6.5999999999999996447,'2020-03-01');
INSERT INTO QUALIFICACIONS VALUES('C5867','ESC1',5.9000000000000003552,'2016-07-07');
INSERT INTO QUALIFICACIONS VALUES('C4221','XACO',4.0999999999999996447,'2017-05-04');
INSERT INTO QUALIFICACIONS VALUES('C4922','ARCO',8.0999999999999996447,'2016-10-03');
INSERT INTO QUALIFICACIONS VALUES('C3904','FUIN',6.5,'2019-08-02');
INSERT INTO QUALIFICACIONS VALUES('C8179','SODX',6.2999999999999998223,'2017-04-28');
INSERT INTO QUALIFICACIONS VALUES('C0643','DABD',7.5999999999999996447,'2019-08-04');
INSERT INTO QUALIFICACIONS VALUES('C2553','XACO',4.2999999999999998223,'2018-12-02');
INSERT INTO QUALIFICACIONS VALUES('C3543','ESC1',5.5,'2016-06-17');
INSERT INTO QUALIFICACIONS VALUES('C5069','SEAX',4.2999999999999998223,'2017-09-09');
INSERT INTO QUALIFICACIONS VALUES('C0602','FISI',7.7000000000000001776,'2017-10-14');
INSERT INTO QUALIFICACIONS VALUES('C5867','SODX',9.8000000000000007105,'2019-04-23');
INSERT INTO QUALIFICACIONS VALUES('C9872','XACO',4.0999999999999996447,'2017-06-23');
INSERT INTO QUALIFICACIONS VALUES('C4922','ESTA',4.0999999999999996447,'2016-08-29');
INSERT INTO QUALIFICACIONS VALUES('C5741','LOAL',5.9000000000000003552,'2019-01-06');
INSERT INTO QUALIFICACIONS VALUES('C2147','PACO',5.5999999999999996447,'2019-01-13');
INSERT INTO QUALIFICACIONS VALUES('C3904','FOPR',7.2000000000000001776,'2019-07-19');
INSERT INTO QUALIFICACIONS VALUES('C8918','FISI',8.5,'2017-07-04');
INSERT INTO QUALIFICACIONS VALUES('C0643','PRO1',7.2999999999999998223,'2018-12-25');
INSERT INTO QUALIFICACIONS VALUES('C2553','INTE',6.7999999999999998223,'2018-10-13');
INSERT INTO QUALIFICACIONS VALUES('C2553','ESC1',6.2999999999999998223,'2019-02-16');
INSERT INTO QUALIFICACIONS VALUES('C4221','ARCO',8.1999999999999992894,'2016-06-06');
INSERT INTO QUALIFICACIONS VALUES('C8918','XACO',6.9000000000000003552,'2019-09-17');
INSERT INTO QUALIFICACIONS VALUES('C9137','INDI',6.7000000000000001776,'2017-12-19');
INSERT INTO QUALIFICACIONS VALUES('C2147','FOMA',9.8000000000000007105,'2019-06-25');
INSERT INTO QUALIFICACIONS VALUES('C5069','FOMA',8.0999999999999996447,'2019-08-01');
INSERT INTO QUALIFICACIONS VALUES('C5741','XAMU',5.9000000000000003552,'2017-12-06');
INSERT INTO QUALIFICACIONS VALUES('C7997','XAMU',9.8000000000000007105,'2020-02-18');
INSERT INTO QUALIFICACIONS VALUES('C2553','INDI',7.9000000000000003552,'2018-02-23');
INSERT INTO QUALIFICACIONS VALUES('C4864','ESC2',9.9000000000000003552,'2018-05-30');
INSERT INTO QUALIFICACIONS VALUES('C9872','ESC1',9.1999999999999992894,'2019-03-11');
INSERT INTO QUALIFICACIONS VALUES('C2413','PROP',4.5,'2017-05-10');
INSERT INTO QUALIFICACIONS VALUES('C9137','MATD',8.1999999999999992894,'2017-12-03');
INSERT INTO QUALIFICACIONS VALUES('C3904','PTIN',9.5,'2018-11-24');
INSERT INTO QUALIFICACIONS VALUES('C2147','AMEP',8.8000000000000007105,'2020-01-08');
INSERT INTO QUALIFICACIONS VALUES('C7997','XACO',8.9000000000000003552,'2017-05-17');
INSERT INTO QUALIFICACIONS VALUES('C3066','ARCO',9.1999999999999992894,'2018-03-27');
INSERT INTO QUALIFICACIONS VALUES('C1813','SODX',4.2000000000000001776,'2019-03-01');
INSERT INTO QUALIFICACIONS VALUES('C5741','PRO1',7.9000000000000003552,'2019-01-31');
INSERT INTO QUALIFICACIONS VALUES('C5069','INCO',5.4000000000000003552,'2018-12-02');
INSERT INTO QUALIFICACIONS VALUES('C3066','PRO1',5.0,'2018-06-02');
INSERT INTO QUALIFICACIONS VALUES('C1503','INEP',8.5,'2019-04-20');
INSERT INTO QUALIFICACIONS VALUES('C6894','ADSO',6.0999999999999996447,'2017-05-21');
INSERT INTO QUALIFICACIONS VALUES('C9872','AMEP',5.0,'2019-04-23');
INSERT INTO QUALIFICACIONS VALUES('C7017','DABD',4.9000000000000003552,'2016-03-20');
INSERT INTO QUALIFICACIONS VALUES('C8179','PTIN',9.3000000000000007105,'2016-08-06');
INSERT INTO QUALIFICACIONS VALUES('C8179','ADSO',4.2999999999999998223,'2017-03-31');
INSERT INTO QUALIFICACIONS VALUES('C8208','ESTA',7.7000000000000001776,'2017-10-06');
INSERT INTO QUALIFICACIONS VALUES('C7997','PRO1',9.5999999999999996447,'2019-03-11');
INSERT INTO QUALIFICACIONS VALUES('C7096','INTE',7.0,'2018-09-03');


