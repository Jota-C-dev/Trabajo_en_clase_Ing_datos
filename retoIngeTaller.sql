-- crear y usar esquema
CREATE SCHEMA reto;
USE reto;

-- tablas
create table cargo(
idcargo varchar(45) primary key,
nombreCargo varchar(45) not null,
rangoCargo varchar(45) not null,
DescripcionCargo varchar(45) not null
);

CREATE TABLE departamentos (
    idDepartamento INT AUTO_INCREMENT PRIMARY KEY,  
    nombreDepartamento VARCHAR(100) NOT NULL  
);

CREATE TABLE empleados (
    idEmpleado INT AUTO_INCREMENT PRIMARY KEY,  
    nombreEmpleado VARCHAR(100) NOT NULL,  
    edadEmpleado INT NOT NULL,  
    salarioEmpleado DECIMAL(10, 2) NOT NULL,  
    fechaContratacion DATE NOT NULL,  
    idDepartamento INT,  
    idcargoFK varchar(45) not null,
    FOREIGN KEY (idDepartamento) REFERENCES departamentos(idDepartamento),
    foreign key (idcargoFK) references cargo(idcargo)
);

-- datos

INSERT INTO departamentos (nombreDepartamento) VALUES
('Ventas'),
('IT'),
('Marketing'),
('Recursos Humanos'),
('Finanzas');

INSERT INTO empleados (nombreEmpleado, edadEmpleado, salarioEmpleado, fechaContratacion, idDepartamento, idcargoFK) VALUES
('Ana Pérez', 28, 4500.00, '2021-05-15', 1,'b'),  
('Carlos López', 35, 3500.00, '2020-07-10', 2 ,'c'),
('Maria García', 32, 6000.00, '2022-02-20', 3,'c'),
('Luis Rodríguez', 41, 4200.00, '2023-03-30', 1,'d'), 
('Elena Fernández', 38, 8000.00, '2021-09-05', 4,'a');

insert into cargo (idcargo, nombreCargo, rangoCargo, DescripcionCargo) values
('a','gerente','1','puesto gerencial donde el empleado tiene poca experiencia'),
('b','desarrollador frontend','2','desarrollador frontend con experiencia media'),
('c','desarrollador backend','3','desarrollador frontend con mucha experiencia'),
('d','data engenieer','2','ingeniero de datos con experiencia media'),
('e','secretario','2','secretario con experiencia media');

-- punto uno
SELECT nombreEmpleado, edadEmpleado, salarioEmpleado 
FROM empleados;


-- punto dos
SELECT nombreEmpleado, salarioEmpleado 
FROM empleados 
WHERE salarioEmpleado > 4000;


-- punto tres
SELECT e.nombreEmpleado, e.salarioEmpleado 
FROM empleados e
JOIN departamentos d ON e.idDepartamento = d.idDepartamento
WHERE d.nombreDepartamento = 'Ventas';

-- punto tres

-- punto cuatro
SELECT nombreEmpleado, edadEmpleado 
FROM empleados 
WHERE edadEmpleado BETWEEN 30 AND 40;

-- punto cinco 
SELECT nombreEmpleado, fechaContratacion 
FROM empleados 
WHERE fechaContratacion > '2020-01-01';

-- punto seis
SELECT d.nombreDepartamento AS departamento, COUNT(e.idEmpleado) AS cantidadEmpleados
FROM empleados e
JOIN departamentos d ON e.idDepartamento = d.idDepartamento
GROUP BY d.nombreDepartamento;

-- punto seis


-- punto siete
SELECT AVG(salarioEmpleado) AS salarioPromedio 
FROM empleados;

-- punto ocho
SELECT nombreEmpleado 
FROM empleados 
WHERE nombreEmpleado LIKE 'A%' OR nombreEmpleado LIKE 'C%';

-- punto nueve
SELECT nombreEmpleado 
FROM empleados 
WHERE nombreEmpleado LIKE 'A%' OR nombreEmpleado LIKE 'C%';

-- punto diez
SELECT nombreEmpleado, salarioEmpleado 
FROM empleados 
ORDER BY salarioEmpleado DESC 
LIMIT 1;

-- punto diez
SELECT nombreEmpleado, salarioEmpleado FROM empleados WHERE salarioEmpleado=(SELECT max(salarioEmpleado) from empleados);

/*consulta con rango "between"*/
SELECT * FROM empleados WHERE salarioEmpleado BETWEEN 8000 AND 10000;

/*consultar dentro de una lista de valores in */
select * from empleados where (idDepartamento in (1,2));


/*///////////////////////////////////////////////////*/
select salarioEmpleado from empleados order by salarioEmpleado desc;

select nombreEmpleado from empleados where idDepartamento is null;
/*select * from departamentos where;*/

select *,(2025-fechaContratacion) as 'tiempo contratado' from empleados;
select nombreEmpleado, fechaContratacion, timestampdiff(year, fechaContratacion, curdate()) as 'años trabajados' from empleados;

SELECT nombreEmpleado, salarioEmpleado FROM empleados ORDER BY salarioEmpleado DESC LIMIT 3;

select count(*) from empleados where salarioEmpleado > (select avg(salarioEmpleado) from empleados);

select nombreDepartamento,(select count(*) empleados where idDepartamento = idDepartamento) 
as 'cantidad gente' from departamentos order by (select count(*) empleados where idDepartamento = idDepartamento) desc;


select nombreEmpleado, salarioEmpleado, timestamp(year, fechaContratacion, curdate()) as 'años trabajando' from empleados
where (timestamp(year, fechaContratacion, curdate()))>=(select (max(timestamp(year,fechaContratacion,curdate()))) as 'mayor años')
and salarioEmpleado>=(select max(salarioEmpleado) from empleados) order by salario desc limit 5; 



/*having*/

select idDepartamento, count(*) as 'total Empleados' from empleados group by idDepartamento having count(*)>=0;

/*modificacion*/
-- sintaxis: update nombretabla set campo='lo que se reemplaza' where campo condicion

update empleados set salarioEmpleado='10000' where idEmpleado='1';

/*mostrar todos los empleados y sus departamentos*/
select nombreEmpleado, nombreDepartamento from empleados
inner join empleados
on empleados.idDepartamento=departamento.idDepartamento;

-- consultar tosdos los cargos que tengan un rango especifico
select nombreCargo from cargo where rangoCargo between 1 and 5;

-- mostrar en pantalla los empleados que tengan un cargo asignado
select  nombreEmpleado, nombreCargo from empleados inner join cargo on empleados.idcargoFK=cargo.idcargo;

-- mostrar todos los empleados con mas de 3 años en la empresa, que departamento pertenecen, que cargo tienen y cuanto ganan 
select nombreEmpleado, fechaContratacion, nombreCargo, rangoCargo, nombreDepartamento, salarioEmpleado from empleados
inner join cargo on empleados.idcargoFK=cargo.idcargo inner join departamentos on empleados.idDepartamento=departamentos.idDepartamento
where timestamp(year, fechaContratacion, curdate()) > 3;

-- mostrar toda la informacion de un empleado, nombre, fecha de contratacion, departamento donde está, cargo actual y rango actual
select nombreEmpleado, fechaContratacion, nombreCargo, rangoCargo, nombreDepartamento from empleados
inner join cargo on empleados.idcargoFK=cargo.idcargo inner join departamentos on empleados.idDepartamento=departamentos.idDepartamento;

-- mostrar todos los empleados sin rango asignado
select  nombreEmpleado, nombreCargo from empleados inner join cargo on empleados.idcargoFK=!cargo.idcargo;

describe empleados;