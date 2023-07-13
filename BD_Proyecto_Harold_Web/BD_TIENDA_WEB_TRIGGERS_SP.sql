USE BD_TIENDA_WEB_HAROLD
GO




--TRIGGERS

--GO
--CREATE OR ALTER TRIGGER TR_RESTAR_PRODUCTO ON DETALLE_PEDIDO AFTER INSERT AS
	
--	DECLARE @stock int;
			
		
--BEGIN

--	SET @stock = (SELECT CANTIDAD_STOCK
--					FROM PRODUCTOS p inner join inserted i
--					on p.ID_PRODUCTO = i.ID_PEDIDO
--					WHERE p.ID_PRODUCTO = i.ID_PRODUCTO)

--	BEGIN TRY
--		IF (@stock) > 0
--			BEGIN
--				UPDATE PRODUCTOS 
--				SET CANTIDAD_STOCK = CANTIDAD_STOCK - 1
--				FROM inserted
--				WHERE PRODUCTOS.ID_PRODUCTO = inserted.ID_PRODUCTO
--			END
--		ELSE
--			BEGIN
--				RAISERROR('Ya no quedan más productos',16,1);
--			END
--	END TRY

--	BEGIN CATCH
--		PRINT ERROR_MESSAGE()
--	END CATCH

--END
--GO

GO
CREATE OR ALTER TRIGGER TR_RESTAR_PRODUCTO ON DETALLE_PEDIDO AFTER INSERT AS
BEGIN
	DECLARE @stock int;

	BEGIN TRY

		SET @stock = (SELECT CANTIDAD_STOCK
				  FROM PRODUCTOS p inner join inserted i on p.ID_PRODUCTO = i.ID_PRODUCTO
				  WHERE p.ID_PRODUCTO = i.ID_PRODUCTO );

		IF (@stock > 0)
			BEGIN
				UPDATE PRODUCTOS
				SET CANTIDAD_STOCK = CANTIDAD_STOCK - 1
				FROM inserted
				WHERE PRODUCTOS.ID_PRODUCTO = inserted.ID_PRODUCTO;
			END
		ELSE
			BEGIN
				RAISERROR('Ya no quedan más productos', 16, 1);
			END
	END TRY

	BEGIN CATCH
		PRINT ERROR_MESSAGE();
	END CATCH;
END
GO


--DROP TRIGGER TR_RESTAR_PRODUCTO

--GO
--CREATE OR ALTER TRIGGER TR_SUMAR_COSTO ON DETALLE_PEDIDO AFTER INSERT AS
	
--	DECLARE @costo decimal(10,2), @idPedido int;
				
--BEGIN
--	IF @@ROWCOUNT = 1 
--		BEGIN
--			SELECT @costo = (SELECT COSTO_TOTAL
--						FROM inserted i inner join PEDIDOS p
--						on p.ID_PEDIDO = i.ID_PEDIDO
--						WHERE p.ID_PEDIDO = i.ID_PEDIDO)

--			UPDATE PEDIDOS 
--			SET COSTO_TOTAL = COSTO_TOTAL + COSTO_PRODUCTO
--			FROM inserted i inner join PRODUCTOS p
--				on i.ID_PRODUCTO = p.ID_PRODUCTO
--			WHERE PEDIDOS.ID_PEDIDO = i.ID_PEDIDO

--		END
--	ELSE
--	BEGIN
--		DECLARE CU_SUMAR_COSTO_PEDIDO CURSOR FOR

--			SELECT PE.ID_PEDIDO, PE.COSTO_TOTAL
--			FROM DETALLE_PEDIDO DP INNER JOIN PEDIDOS PE
--				ON DP.ID_PEDIDO = PE.ID_PEDIDO
--				INNER JOIN PRODUCTOS PR
--				ON DP.ID_PRODUCTO = PR.ID_PRODUCTO

--			OPEN CU_SUMAR_COSTO_PEDIDO

--			FETCH CU_SUMAR_COSTO_PEDIDO INTO @idPedido, @costo

--			WHILE(@@FETCH_STATUS=0)
--				BEGIN

--				SELECT @costo = p.COSTO_TOTAL
--				FROM inserted i inner join PEDIDOS p
--						on p.ID_PEDIDO = i.ID_PEDIDO
--						WHERE p.ID_PEDIDO = i.ID_PEDIDO

--						UPDATE PEDIDOS
--						SET COSTO_TOTAL = COSTO_TOTAL + COSTO_PRODUCTO
--						FROM PEDIDOS pe inner join PRODUCTOS pr
--						on pe.ID_PEDIDO = pr.ID_PRODUCTO inner join inserted i
--						on pe.ID_PEDIDO = i.ID_PEDIDO
--						WHERE pe.ID_PEDIDO = @idPedido

--						FETCH CU_SUMAR_COSTO_PEDIDO INTO @idPedido, @costo

--				END--WHILE

--		CLOSE CU_SUMAR_COSTO_PEDIDO
--		DEALLOCATE CU_SUMAR_COSTO_PEDIDO;		
--	END
--END
--GO

GO
CREATE OR ALTER TRIGGER TR_SUMAR_COSTO ON DETALLE_PEDIDO AFTER INSERT AS
	BEGIN
		UPDATE PEDIDOS
		SET COSTO_TOTAL = COSTO_TOTAL + p.COSTO_PRODUCTO
		FROM PEDIDOS pe
		INNER JOIN inserted i ON pe.ID_PEDIDO = i.ID_PEDIDO
		INNER JOIN PRODUCTOS p ON i.ID_PRODUCTO = p.ID_PRODUCTO;
	END
GO

-- PROCEDIMIENTOS ALMACENADOS

--SP_PEDIDOS
CREATE OR ALTER PROCEDURE SP_AGREGAR_ACTUALIZAR_PEDIDO
										(
										@codCliente int OUT,
										@idPedido int OUT,
										@costo decimal(10,2),
										@descuento decimal(3,1),
										@direccion varchar(200),
										@msj varchar(200) OUT
										)

AS
	BEGIN

	BEGIN TRANSACTION
		BEGIN TRY

			IF (NOT EXISTS (SELECT 1 FROM PEDIDOS WHERE ID_PEDIDO = @idPedido))
				BEGIN
					INSERT INTO PEDIDOS(COD_CLIENTE,DESCUENTO_PEDIDO,COSTO_TOTAL,DIRECCION_ENVIO)
					VALUES (@codCliente,@descuento,@costo,@direccion);

					SET @idPedido = SCOPE_IDENTITY();

					SET @msj = 'Pedido Realizado con éxito';

				END
			ELSE
				BEGIN
					UPDATE PEDIDOS
						SET COD_CLIENTE = @codCliente,
							DESCUENTO_PEDIDO = @descuento,
							COSTO_TOTAL = @costo,
							FECHA_PEDIDO = GETDATE(),
							DIRECCION_ENVIO = @direccion
						WHERE ID_PEDIDO = @idPedido

					SET @msj = 'Pedido actualizado con éxito'
				END
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
			SET @msj = ERROR_MESSAGE()
		END CATCH
END
GO




CREATE OR ALTER PROCEDURE SP_ELIMINAR_PEDIDO
										(
										@idPedido int,
										@msj varchar(200) OUT
										)
AS
	BEGIN

	BEGIN TRANSACTION
		BEGIN TRY
			IF(EXISTS (SELECT 1 FROM DETALLE_PEDIDO WHERE ID_PEDIDO = @idPedido))
				BEGIN
					DELETE
					FROM DETALLE_PEDIDO 
					WHERE ID_PEDIDO = @idPedido
				END

			DELETE
			FROM PEDIDOS 
			WHERE ID_PEDIDO = @idPedido 
			
			SET @msj = 'Pedido eliminado exitosamente';

			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
			SET @msj = ERROR_MESSAGE()
		END CATCH
END
GO


--SP_DETALLE_PEDIDO

CREATE OR ALTER PROCEDURE SP_AGREGAR_DETALLE_PEDIDO
										(
										@idPedido int,
										@idProducto int,
										@msj varchar(200) OUT
										)

AS
	BEGIN

	BEGIN TRANSACTION
		BEGIN TRY

			INSERT INTO DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO)
								VALUES(@idPedido,@idProducto);			

			COMMIT TRANSACTION
		END TRY

		BEGIN CATCH
			ROLLBACK TRANSACTION
			SET @msj = ERROR_MESSAGE()
		END CATCH
END
GO

--DECLARE @IDP int,
--		@IDPRO int,
--		@msj varchar(200)

--SET @IDP = 1
--SET @IDPRO = 1
--SET @msj = ''


--EXECUTE SP_AGREGAR_DETALLE_PEDIDO @IDP,@IDPRO,@msj;

--print @msj;

--select * from PEDIDOS
--SELECT * FROM DETALLE_PEDIDO

--select * from PRODUCTOS 

GO
CREATE OR ALTER PROCEDURE SP_ELIMINAR_DETALLE_PEDIDO
										(
										@idPedido int,
										@idProducto int,
										@msj varchar(200) OUT
										)
AS
	BEGIN

	BEGIN TRANSACTION
		BEGIN TRY
			DELETE
			FROM DETALLE_PEDIDO 
			WHERE ID_PEDIDO = @idPedido AND ID_PRODUCTO = @idProducto
			
			SET @msj = 'Producto eliminado del carro';

			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
			SET @msj = ERROR_MESSAGE()
		END CATCH
END
GO

--SP_CLIENTES

CREATE OR ALTER PROCEDURE SP_AGREGAR_ACTUALIZAR_CLIENTE
										(
										@codCliente int OUT,
										@idCliente varchar(15),
										@nombre varchar(50),
										@apellido1 varchar(50),
										@apellido2 varchar(50),
										@email varchar(50),
										@telefono varchar(50),
										@provincia varchar(50),
										@canton varchar(50),
										@direccion varchar(200),
										@fecha date,
										@msj varchar(200) OUT
										)

AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY

			IF (NOT EXISTS (SELECT 1 FROM CLIENTES WHERE ID_CLIENTE = @idCliente))
				BEGIN
					INSERT INTO CLIENTES(ID_CLIENTE,NOMBRE,APELLIDO1,APELLIDO2,E_MAIL,TELEFONO,PROVINCIA,CANTON,DIRECCION,FECHA_NACIMIENTO)
					VALUES (@idCliente,@nombre,@apellido1,@apellido2,@email,@telefono,@provincia,@canton,@direccion,@fecha);

					SET @msj = 'Cliente ingresado con éxito';

				END
			ELSE
				BEGIN
					UPDATE CLIENTES
						SET NOMBRE = @nombre,
							APELLIDO1 = @apellido1,
							APELLIDO2 = @apellido2,
							E_MAIL = @email,
							TELEFONO = @telefono,
							PROVINCIA = @provincia,
							CANTON = @canton,
							DIRECCION = @direccion,
							FECHA_NACIMIENTO = @fecha
						WHERE COD_CLIENTE = @codCliente

					SET @msj = 'Cliente actualizado con éxito'
				END
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
			SET @msj = ERROR_MESSAGE()
		END CATCH
END
GO


CREATE OR ALTER PROCEDURE SP_ELIMINAR_CLIENTE
										(
										@codCliente int,
										@msj varchar(200) OUT
										)
AS
	BEGIN

	BEGIN TRANSACTION
		BEGIN TRY
			UPDATE CLIENTES
			SET ESTADO = 0
			WHERE COD_CLIENTE = @codCliente
			
			SET @msj = 'Cuenta eliminada';

			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
			SET @msj = ERROR_MESSAGE()
		END CATCH
END
GO

--SP_COMENTARIOS
CREATE OR ALTER PROCEDURE SP_AGREGAR_MODIFICAR_COMENTARIO
										(
										@idComentario int,
										@idCliente int,
										@idProducto int,
										@texto varchar(300),
										@valoracion int,
										@msj varchar(200) OUT
										)
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY

			IF (NOT EXISTS (SELECT 1 FROM COMENTARIOS WHERE ID_CLIENTE = @idCliente AND ID_PRODUCTO = @idProducto)) -- Un Comentario por Producto de cada Cliente
				BEGIN
					INSERT INTO COMENTARIOS(ID_CLIENTE,ID_PRODUCTO,TEXTO_COMENTARIO,VALORACION)
					VALUES (@idCliente,@idProducto,@texto,@valoracion);

					SET @msj = 'Comentario ingresado con éxito';

				END
			ELSE
				BEGIN
					UPDATE COMENTARIOS
						SET TEXTO_COMENTARIO = @texto,
							VALORACION = @valoracion
						WHERE ID_COMENTARIO = @idComentario

					SET @msj = 'Comentario actualizado con éxito'
				END
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
			SET @msj = ERROR_MESSAGE()
		END CATCH
END
GO


CREATE OR ALTER PROCEDURE SP_ELIMINAR_COMENTARIO
										(
										@idComentario int,
										@msj varchar(200) OUT
										)
AS
	BEGIN

	BEGIN TRANSACTION
		BEGIN TRY
			DELETE FROM COMENTARIOS WHERE ID_COMENTARIO = @idComentario
			
			SET @msj = 'Comentario eliminada';

			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
			SET @msj = ERROR_MESSAGE()
		END CATCH
END
GO


--sp_app_escritorio

--SP_PRODUCTOS

CREATE OR ALTER PROCEDURE SP_AGREGAR_MODIFICAR_PRODUCTO
										(
										@idProducto int,
										@nombre varchar(80),
										@categoria int,
										@costo decimal(10,2),
										@fabricante varchar(80),
										@cantidad int,
										@descripcion varchar(300),
										@msj varchar(200) OUT
										)
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY

			IF (NOT EXISTS (SELECT 1 FROM PRODUCTOS WHERE ID_PRODUCTO = @idProducto))
				BEGIN
					INSERT INTO PRODUCTOS(NOMBRE_PRODUCTO,CATEGORIA_PRODUCTO,COSTO_PRODUCTO,FABRICANTE,CANTIDAD_STOCK,DESCRIPCION)
					VALUES (@nombre,@categoria,@costo,@fabricante,@cantidad,@descripcion);

					SET @msj = 'Producto ingresado con éxito';

				END
			ELSE
				BEGIN
					UPDATE PRODUCTOS
						SET NOMBRE_PRODUCTO = @nombre,
							CATEGORIA_PRODUCTO = @categoria,
							COSTO_PRODUCTO = @costo,
							FABRICANTE = @fabricante,
							CANTIDAD_STOCK = @cantidad,
							DESCRIPCION = @descripcion
						WHERE ID_PRODUCTO = @idProducto

					SET @msj = 'Producto actualizado con éxito'
				END
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
			SET @msj = ERROR_MESSAGE()
		END CATCH
END
GO
