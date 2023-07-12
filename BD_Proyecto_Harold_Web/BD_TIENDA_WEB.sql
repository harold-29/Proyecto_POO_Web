
CREATE DATABASE BD_TIENDA_WEB_HAROLD
GO

USE BD_TIENDA_WEB_HAROLD
GO

--CREACIÓN DE TABLAS

CREATE TABLE CLIENTES(
	COD_CLIENTE int IDENTITY(1,1), -- PK
	ID_CLIENTE varchar(15) NOT NULL UNIQUE, 
	NOMBRE varchar(50) NOT NULL,
	APELLIDO1 varchar(50) NOT NULL,
	APELLIDO2 varchar(50) NOT NULL,
	E_MAIL varchar(50) UNIQUE,
	TELEFONO varchar(50),
	PROVINCIA varchar(50) NOT NULL,
	CANTON varchar(50) NOT NULL,
	DIRECCION varchar(200) NOT NULL,
	FECHA_NACIMIENTO date NOT NULL,
	ESTADO bit DEFAULT 1
);

CREATE TABLE CATEGORIAS(
	ID_CATEGORIA int IDENTITY (1,1),-- PK
	NOMBRE_CATEGORIA varchar(80) NOT NULL,
	DESCRIPCION_CATEGORIA varchar(300),
);

CREATE TABLE PRODUCTOS(
	ID_PRODUCTO int IDENTITY(1,1),-- PK
	NOMBRE_PRODUCTO varchar(80) NOT NULL,
	CATEGORIA_PRODUCTO int NOT NULL,
	COSTO_PRODUCTO decimal (10,2) NOT NULL DEFAULT 0,
	FABRICANTE varchar(80),
	CANTIDAD_STOCK int NOT NULL DEFAULT 0,
	DESCRIPCION varchar(300) NOT NULL

);

CREATE TABLE IMG_PRODUCTOS(
	ID_IMG int IDENTITY(1,1), --PK
	ID_PRODUCTO int NOT NULL,
	RUTA_IMG varchar(500) NOT NULL
);

--DROP TABLE IMG_PRODUCTOS;

CREATE TABLE PEDIDOS(
	ID_PEDIDO int IDENTITY(1,1),-- PK
	COD_CLIENTE int NOT NULL, --FK
	DESCUENTO_PEDIDO decimal(3,1) DEFAULT 0,
	COSTO_TOTAL decimal(10,2) NOT NULL DEFAULT 0,
	FECHA_PEDIDO date NOT NULL DEFAULT GETDATE(),
	ESTADO_PEDIDO bit NOT NULL DEFAULT 1,
	DIRECCION_ENVIO varchar(200) NOT NULL
);

CREATE TABLE DETALLE_PEDIDO(
	ID_DETALLE_PEDIDO int IDENTITY(1,1), -- PK
	ID_PEDIDO int NOT NULL,-- FK
	ID_PRODUCTO int NOT NULL,-- FK
);

CREATE TABLE COMENTARIOS(
	ID_COMENTARIO int IDENTITY(1,1), --PK
	ID_CLIENTE int,--FK
	ID_PRODUCTO int,--FK
	TEXTO_COMENTARIO varchar(300),
	VALORACION int DEFAULT 0
);

--ALTERACIÓN DE LAS TABLAS

ALTER TABLE CLIENTES
ADD CONSTRAINT PK_COD_CLIENTE PRIMARY KEY(COD_CLIENTE),
	CONSTRAINT CK_E_MAIL CHECK (E_MAIL LIKE '%@%'),
	CONSTRAINT CK_PROVINCIA CHECK (PROVINCIA IN('Alajuela','Heredia','Guanacaste','San José','Puntarenas','Limón','Cartago')),
	CONSTRAINT CK_EDAD CHECK (DATEDIFF(year, '1999-06-29', GETDATE()) >=18);

ALTER TABLE CATEGORIAS
ADD CONSTRAINT PK_ID_CATEGORIA PRIMARY KEY (ID_CATEGORIA),
	CONSTRAINT CK_CATEGORIA CHECK (NOMBRE_CATEGORIA IN ('Electrónica', 'Accesorios','Hogar'));

ALTER TABLE PRODUCTOS
ADD CONSTRAINT PK_ID_PRODUCTO PRIMARY KEY(ID_PRODUCTO),
	CONSTRAINT FK_ID_CATEGORIA FOREIGN KEY (CATEGORIA_PRODUCTO) REFERENCES CATEGORIAS(ID_CATEGORIA) 		
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION;

ALTER TABLE IMG_PRODUCTOS
ADD CONSTRAINT PK_ID_IMG PRIMARY KEY(ID_IMG),
	CONSTRAINT FK_ID_PRODUCTO_IMG FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTOS(ID_PRODUCTO)
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION;

ALTER TABLE PEDIDOS
ADD CONSTRAINT PK_ID_PEDIDO PRIMARY KEY (ID_PEDIDO),
	CONSTRAINT FK_COD_CLIENTE FOREIGN KEY (COD_CLIENTE) REFERENCES CLIENTES(COD_CLIENTE)	
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION;

ALTER TABLE DETALLE_PEDIDO
ADD CONSTRAINT PK_ID_DETALLE_PEDIDO PRIMARY KEY (ID_DETALLE_PEDIDO),
	CONSTRAINT FK_ID_PEDIDO FOREIGN KEY (ID_PEDIDO) REFERENCES PEDIDOS(ID_PEDIDO)	
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION,
	CONSTRAINT FK_ID_PRODUCTO FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTOS(ID_PRODUCTO)
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION;;
	
ALTER TABLE COMENTARIOS
ADD CONSTRAINT PK_ID_COMENTARIO PRIMARY KEY (ID_COMENTARIO),
	CONSTRAINT CK_VALORACION CHECK (VALORACION IN (0,1,2,3,4,5)),
	CONSTRAINT FK_ID_CLIENTE FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTES(COD_CLIENTE)
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION,
	CONSTRAINT FK_ID_PRODUCTO_COMENTARIO FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTOS(ID_PRODUCTO)
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION;



--INSERCIÓN DE DATOS

INSERT INTO CLIENTES (ID_CLIENTE,NOMBRE,APELLIDO1,APELLIDO2,TELEFONO,E_MAIL,PROVINCIA,CANTON,DIRECCION,FECHA_NACIMIENTO) VALUES
('2000001','Andrés','Corrales','Pérez','88888881','2000001@outlook.com','Alajuela','Palmares','200 mts Norte del Banco Popular','1995-03-21'),
('2000002','Carlos','Marín','Herrera','88888882','2000002@outlook.com','Alajuela','San Ramón','Costado Oste del cementerio ','1986-05-24'),
('2000003','María','Vargas','Vargas','88888883','2000003@outlook.com','San José','San José','Barrio Escalante avenida 15','2001-01-30'),
('2000004','Cristian','Jiménez','Vargas','88888884','2000004@outlook.com','Puntarenas','Golfito','En la Guaria','1993-08-14'),
('2000005','Sofía','Alvarez','Muñoz','88888885','2000005@outlook.com','Cartago','Cartago','San Rafael Calle seis Avenida 1','1988-06-10');

INSERT INTO CATEGORIAS (NOMBRE_CATEGORIA,DESCRIPCION_CATEGORIA) VALUES
('Electrónica','Productos varios de tecnología como celulares, computadoras, electrodomésticos'),
('Accesorios','Productos varios como collares, aretes, colonias'),
('Hogar','Productos varios para el hogar como muebles, fundas, cortinas');

INSERT INTO PRODUCTOS(NOMBRE_PRODUCTO,CATEGORIA_PRODUCTO,CANTIDAD_STOCK,FABRICANTE,COSTO_PRODUCTO,DESCRIPCION) VALUES
('Motherboard b450 DS3h',1,5,'Gigabyte',40000,'Producto en buen estado, con daños leves en la caja'),
('Mouse G305 ',1,10,'Logitech',20000,'Producto en buen estado, con daños leves en la caja'),
('Headset HS80 ',1,7,'Corsair',45000,'Producto en buen estado, con daños leves en la caja'),
('Cable USB C ',1,10,'AON',1500,'Producto en buen estado'),
('Collar de Corazón',2,4,NULL,6000,'Material de Acero bañado en oro'),
('Cadena Guadalupe',2,3,NULL,5500,'Materia de Acero'),
('Pulsera con Cruz',2,1,NULL,8000,'Cadena con Perlas'),
('Cortinas blancas',3,3,NULL,15000,'Dimensión 120x250 color blanco traslucida'),
('Cama Individual',3,2,NULL,120000,'Hecha de Madera barnizada'),
('Tapete para baño',3,8,NULL,6000,'Color Azul'),
('Espejo mediano',3,4,NULL,10000,'Marco de Madera 50cm');

INSERT INTO IMG_PRODUCTOS(ID_PRODUCTO,RUTA_IMG) VALUES 
(1,'https://static.gigabyte.com/StaticFile/Image/Global/fac1d2c440025e69e2731780e6feb98b/Product/21100/png/1000'),
(1,'https://static.gigabyte.com/StaticFile/Image/Global/3e985aab94dfec4be1a8ea011cce546e/Product/19863/png/1000'),
(1,'https://static.gigabyte.com/StaticFile/Image/Global/3391db6385f270b3bb58bf4cf586fb87/Product/19783/png/1000'),
(1,'https://static.gigabyte.com/StaticFile/Image/Global/584f0dc16ea959ec60f48b8b62389af0/Product/19781/png/1000'),

(2,'https://microless.com/cdn/products/62dd5fa746565cc0b6c70055d5e8a383-hi.jpg'),
(2,'https://teknopolis.vteximg.com.br/arquivos/ids/180503-1000-1000/1.jpg?v=636785338143100000'),
(2,'https://m.media-amazon.com/images/I/51DYDLykzoL._AC_SX679_.jpg'),
(2,'https://d3fa68hw0m2vcc.cloudfront.net/13c/237853896.jpeg'),

(3,'https://d3fa68hw0m2vcc.cloudfront.net/ad4/254698387.jpeg'),
(3,'https://m.media-amazon.com/images/I/51DzH31ApRL.jpg'),
(3,'https://img.terabyteshop.com.br/produto/g/headset-gamer-corsair-hs80-premium-rgb-surround-wireless-dolby-atmos-drivers-50mm-preto-ca-9011235-na_143198.jpg'),
(3,'https://th.bing.com/th/id/OIP.wtRlh7ZosI4TNRVbgOBo7QHaHa?pid=ImgDet&rs=1'),

(4,'https://www.staples-3p.com/s7/is/image/Staples/m003600849_sc7?$splssku$'),
(4,'https://www.unipro.my/image/unipro/image/data/Category/Unipro-cables-USB-C.jpg'),
(4,'https://cdn.kemik.gt/2022/10/AO-CB-5002-AON-1200x1200-1-768x768.jpg'),
(4,'https://cdn.kemik.gt/2022/10/AO-CB-5013-AON-1200X1200-1-768x768.jpg'),

(5,'https://www.lepetitcollar.es/wp-content/uploads/2020/01/Primer-pla_opt-1.jpg'),
(5,'https://http2.mlstatic.com/relicario-collar-mujer-en-forma-de-corazon-con-bano-en-oro-D_NQ_NP_745957-MCO26636357592_012018-F.jpg'),
(5,'https://joyeria-deyali.com/wp-content/uploads/2020/07/love2.png'),
(5,'https://cdn.shopify.com/s/files/1/0168/5658/0150/products/image_7fe1ed34-b847-4d57-a474-526db2c40fdc_1200x1200.jpg?v=1573049698'),

(6,'https://mlstaticquic-a.akamaihd.net/dije-virgen-de-guadalupe-plata-leve-cadena-de-acero-quirurg-D_NQ_NP_670353-MLU40485586180_012020-F.jpg'),
(6,'https://mlstaticquic-a.akamaihd.net/dije-virgen-de-guadalupe-plata-leve-cadena-de-acero-quirurg-D_NQ_NP_703438-MLU40485572884_012020-F.jpg'),
(6,'https://mlstaticquic-a.akamaihd.net/dije-virgen-de-guadalupe-plata-leve-cadena-acero-quirurgico-D_NQ_NP_842053-MLU40485630122_012020-F.jpg'),
(6,'https://img.clasf.mx/2019/01/02/Medalla-Virgen-De-Guadalupe-De-Acero-Inoxidable-Con-Cadena-20190102102753.3229900015.jpg'),

(7,'https://2.bp.blogspot.com/-JwgiAj-OOB0/UJCJSvDpnUI/AAAAAAAABLg/bS4xOu2tZrQ/s640/perlas+con+cruz.jpg'),
(7,'https://i.pinimg.com/originals/75/de/ce/75dece060bda594908c0e1d9f470e4fb.jpg'),
(7,'https://www.detallesymas.es/8118-thickbox_default/pulsera-perlas-cruz.jpg'),
(7,'https://i.pinimg.com/474x/a7/23/79/a72379d51e97ff5a21bda7df106b60d3.jpg'),

(8,'https://www.vipcortinas.com/wp-content/uploads/2020/12/Cortinas-blancas-modernas.jpg'),
(8,'https://cortinamet.com/wp-content/uploads/2020/05/cortinas-blancas-1024x1024.jpg'),
(8,'https://th.bing.com/th/id/R.c458bbd2f59743971ee8b1b7e842ab8f?rik=lCn%2bU3dY%2fc0rLQ&riu=http%3a%2f%2fwww.cortina.com.ar%2fwp-content%2fuploads%2fCortinas-Blancas-en-Todo-Cortinas-04.jpg&ehk=hC7V96iXax3T3oqmpGorZ60AIySoC9rc%2byy7CrQzyJw%3d&risl=&pid=ImgRaw&r=0'),
(8,'https://www.vipcortinas.com/wp-content/uploads/2020/12/Cortinas-blancas-para-dormitorio-2.jpg'),

(9,'https://images-na.ssl-images-amazon.com/images/I/71Fuk6wjIcL._AC_SX679_.jpg'),
(9,'https://th.bing.com/th/id/OIP.K3QDYVyfIn9Bge_PedhcYAHaFm?pid=ImgDet&rs=1'),
(9,'https://th.bing.com/th/id/OIP.sRpfgPstjzeyZQl_P0mPbgHaFm?pid=ImgDet&rs=1'),
(9,'https://th.bing.com/th/id/OIP.YOmrGvHu7jiYWxWssZPR-AHaFk?pid=ImgDet&rs=1'),

(10,'https://res.cloudinary.com/walmart-labs/image/upload/w_960,dpr_auto,f_auto,q_auto:best/mg/gm/3pp/asr/92258cc3-cd9d-4192-888e-2ab6847f429a.9bd1fddeb8c7aa4aa2f30b4fd3b09c3c.jpeg?odnHeight=2000&odnWidth=2000&odnBg=ffffff'),
(10,'https://shopsmart.com.mx/307-thickbox_default/tapete-para-bano-pie-cama-antiderrante-azul.jpg'),
(10,'https://colchero.com.mx/wp-content/uploads/2019/11/AZUL_CIELO-min.png'),
(10,'https://hec.upmedia.mx/uploads/products/DaEIShEKWuVLu0fqEkLVumLb2IY4mnCEBynutrEs.png'),

(11,'https://www.ferrisariato.com/wp-content/uploads/2020/07/40355015_01-1-1024x1024.jpg'),
(11,'https://www.ferrisariato.com/wp-content/uploads/2020/07/40355015_02-1-768x768.jpg'),
(11,'https://th.bing.com/th/id/R.eef84076da469826906bfc2a7622f7e5?rik=q33yRWAJJRrqOA&riu=http%3a%2f%2fd2r9epyceweg5n.cloudfront.net%2fstores%2f854%2f520%2fproducts%2f41581-1ee64109181534622216365800516725-640-0.jpg&ehk=ZOWkfB8b8zW9oacHUzC2Nqa1dDHGKcMO3dyNiXwVznQ%3d&risl=&pid=ImgRaw&r=0'),
(11,'https://elbodegon26.com/wp-content/uploads/2020/04/Espejo-Gold-Petra-1-1.jpg');


INSERT INTO COMENTARIOS (ID_CLIENTE,ID_PRODUCTO,TEXTO_COMENTARIO,VALORACION) VALUES
(3,6,'Excelente',5),
(3,1,'Muy bien',4),
(2,1,'Bien',3),
(1,6,'Muy bien',4),
(4,11,'Bien',3),
(2,11,'Excelente',5);

INSERT INTO PEDIDOS (COD_CLIENTE,COSTO_TOTAL,ESTADO_PEDIDO,DIRECCION_ENVIO) VALUES
(1,0,1,'A'),
(2,0,1,'A'),
(3,0,1,'A'),
(4,0,1,'A');


INSERT INTO DETALLE_PEDIDO (ID_PEDIDO,ID_PRODUCTO) VALUES
(1,1),
(1,2),
(2,2),
(2,4),
(3,10),
(4,8);


/*
SELECT * FROM CLIENTES
SELECT * FROM CATEGORIAS
SELECT * FROM PRODUCTOS
SELECT * FROM COMENTARIOS
SELECT * FROM PEDIDOS
SELECT * FROM DETALLE_PEDIDO
SELECT * FROM IMG_PRODUCTOS
*/






