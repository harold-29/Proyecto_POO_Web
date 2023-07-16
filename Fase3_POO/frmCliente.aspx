<%@ Page Title="" Language="C#" MasterPageFile="~/Plantilla.Master" AutoEventWireup="true" CodeBehind="frmCliente.aspx.cs" Inherits="Fase3_POO.frmCliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <form runat="server">
        <asp:ScriptManager runat="server" ID="ScriptManager" />

        <div class="container-xxl contenedor mb-5 my-5 row row-cols-1">
            <aside class="bd-sidebar col">
                <h3>Cuenta</h3>

                <div class="row-cols-1">

                    <div class="col my-5">
                        <a href="frmCliente.aspx" class="btn btn-warning">Información de cuenta</a>
                    </div>

                    <div class="col my-5">
                        <a href="frmCarrito.aspx" class="btn btn-warning">Carrito</a>
                    </div>

                    <div class="col my-5">
                        <a href="frmPedidos.aspx" class="btn btn-warning">Historial de Pedidos</a>
                    </div>

                    <div class="col my-5">
                        <asp:Button ID="btnLogout" runat="server" Text="Cerrar Sesión" OnClick="btnLogout_Click" class="btn btn-warning" />
                    </div>
                </div>
            </aside>
            <div class="container bd-main col">
                <h2 class="h2">Información de cuenta</h2>

                <div class="row row-cols-1 mt-5 row-cols-md-3">

                    <div class="col mt-2">
                        <p>Nombre</p>
                        <asp:TextBox ID="txtNombre" runat="server" MaxLength="50" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage='El campo "Nombre" es requerido' ControlToValidate="txtNombre" Text="*" ValidationGroup="Registro"></asp:RequiredFieldValidator>

                    </div>

                    <div class="col mt-2">

                        <p>Primer Apellido</p>
                        <asp:TextBox ID="txtApellido1" runat="server" MaxLength="50" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage='El campo "Primer Apellido" es requerido' ControlToValidate="txtApellido1" Text="*" ValidationGroup="Registro"></asp:RequiredFieldValidator>

                    </div>

                    <div class="col mt-2">
                        <p>Segundo Apellido</p>
                        <asp:TextBox ID="txtApellido2" runat="server" MaxLength="50" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage='El campo "Segundo Apellido" es requerido' ControlToValidate="txtApellido2" Text="*" ValidationGroup="Registro"></asp:RequiredFieldValidator>

                    </div>

                    <div class="col mt-2">
                        <p>Identificación</p>
                        <asp:TextBox ID="txtID" runat="server" ReadOnly="True" MaxLength="15" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage='El campo "Identificación" es requerido' ControlToValidate="txtID" Text="*" ValidationGroup="Registro"></asp:RequiredFieldValidator>

                    </div>

                    <div class="col mt-2">
                        <p>Correo Electrónico</p>
                        <asp:TextBox ID="txtEmail" runat="server" MaxLength="50" CssClass="form-control" TextMode="Email"></asp:TextBox>
                    </div>


                    <div class="col mt-2">
                        <p>Teléfono</p>
                        <asp:TextBox ID="txtTelefono" runat="server" MaxLength="50" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col mt-2">
                        <p>Provincia</p>
                        <asp:DropDownList ID="ddlProvincia" runat="server" class="form-control"></asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage='El campo "Provincia" es requerido' ControlToValidate="ddlProvincia" Text="*" ValidationGroup="Registro"></asp:RequiredFieldValidator>

                    </div>
                    <div class="col mt-2">
                        <p>Cantón</p>
                        <asp:TextBox ID="txtCanton" runat="server" MaxLength="50" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage='El campo "Cantón" es requerido' ControlToValidate="txtCanton" Text="*" ValidationGroup="Registro"></asp:RequiredFieldValidator>

                    </div>

                    <div class="col mt-2">
                        <p>Fecha de nacimiento</p>
                        <asp:TextBox ID="txtFechaNacimiento" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage='El campo "Fecha de Nacimiento" es requerido' ControlToValidate="txtFechaNacimiento" Text="*" ValidationGroup="Registro"></asp:RequiredFieldValidator>
                    </div>

                </div>
                <div class="row row-cols-1 my-2">
                    <div class="col">
                        <p>Dirección</p>
                        <textarea id="txtDireccion" cols="20" runat="server" class="form-control" maxlength="200"></textarea>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage='El campo "Dirección" es requerido' ControlToValidate="txtDireccion" Text="*" ValidationGroup="Registro"></asp:RequiredFieldValidator>

                    </div>

                    <div class="col my-5 ">
                        <asp:Button ID="btnActualizar" runat="server" Text="Actualizar Información" class="btn btn-warning" OnClick="btnActualizar_Click" />
                    </div>
                </div>
                <div class="col my-5 ">
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="Registro" />
                </div>
            </div>
        </div>
    </form>

</asp:Content>
