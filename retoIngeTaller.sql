-- crear y usar esquema
CREATE SCHEMA reto;
USE reto;

-- tablas
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
    FOREIGN KEY (idDepartamento) REFERENCES departamentos(idDepartamento)  
);

-- datos

INSERT INTO departamentos (nombreDepartamento) VALUES
('Ventas'),
('IT'),
('Marketing'),
('Recursos Humanos'),
('Finanzas');

INSERT INTO empleados (nombreEmpleado, edadEmpleado, salarioEmpleado, fechaContratacion, idDepartamento) VALUES
('Ana Pérez', 28, 4500.00, '2021-05-15', 1),  
('Carlos López', 35, 3500.00, '2020-07-10', 2),
('Maria García', 32, 6000.00, '2022-02-20', 3),
('Luis Rodríguez', 41, 4200.00, '2023-03-30', 1), 
('Elena Fernández', 38, 8000.00, '2021-09-05', 4);


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