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
