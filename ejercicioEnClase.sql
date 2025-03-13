/*Lenguaje de Definición de Datos DDL */
/*1. Crear BD create Crear estructuras BD Tablas vistas procedimientos almacenados indices */
/* Crear BD create database (Nombre de base de datos) */
create database ViajesUrosario;

create database tienda;

/*Crear tablas create table (NombreTabla)*/

/*Nosotros hacemos el de camionera y la profe, el otro*/

/** Hay que habilitar para usar la base de datos entonces. use (NombreBD)
**/

use tienda;

create table cliente(
IdCliente int auto_increment primary key,
DocumentoCliente int not null,
NombreCliente varchar(50) Not null,
EmailCliente varchar(50) Not null,
TelefonoCliente varchar(50) Not null,
DirecciónCliente text,
FechaRegistro timestamp default current_timestamp
);

create table Pedido(
IdPedido int auto_increment primary key,
IdClienteFK int Not null,
IdProductoFK int not null,
FechaPedido date Not null,
TotalPedido decimal(10,2) Not null,
Estado enum("Pendiente","Enviado","Entregado","Cancelado") default "Pendiente",
FechaRegistro timestamp default current_timestamp
);

create table Producto(
IdProducto int auto_increment primary key,
CodigoProducto varchar(50) not null,
NombreProducto varchar(50) not null,
PrecioProducto decimal(10,2) not null,
Stock int default 0,
FechaRegistro timestamp default current_timestamp
);

/*Consultar la estructura de las tablas, describe (NombreTabla)*/
describe Producto;

/*Modificar estructuras alter table */
/* agregar una columna un campo alter table, (NombreTabla) add Column (NombreDelCampo) (Restricciones) */

alter table Producto add column descripcionProducto varchar (50) not null;

/*modificar tipo de dato, alter table () */

alter table Producto modify column PrecioProducto decimal(12,2);

/*Renombrar una tabla, */

alter table Producto rename to Product;

/*Eliminar Tablas, */

drop table pedido;

/*Si lo eliminas, SE ELIMINA TODO EN LA TABLA */

/* Eliminar BD Drop database (NombreBD) */

drop database ViajesUrosario;

/*Eliminar todos los registros de una tabla,  */

truncate table Pedido;

/*Relaciones*/

/*Crear una relación */

alter table Pedido add constraint  FKClientePedido;
foreign key (IdClienteFK) references Cliente (IdCliente);