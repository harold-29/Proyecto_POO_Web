<%@ Page Title="" Language="C#" MasterPageFile="~/Plantilla.Master" AutoEventWireup="true" CodeBehind="frmRegistro.aspx.cs" Inherits="Fase3_POO.frmRegistro" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <div class="container bd-main col">
        <h2 class="h2">Ingresa tus datos</h2>
        <form runat="server">
            <div class="row row-cols-1 mt-5 row-cols-md-3">

                <div class="col mt-2">
                    <p>Nombre</p>
                    <asp:TextBox ID="txtNombre" runat="server" MaxLength="50" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col mt-2">

                    <p>Primer Apellido</p>
                    <asp:TextBox ID="txtApellido1" runat="server" MaxLength="50" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col mt-2">
                    <p>Segundo Apellido</p>
                    <asp:TextBox ID="txtApellido2" runat="server" MaxLength="50" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col mt-2">
                    <p>Identificación</p>
                    <asp:TextBox ID="txtID" runat="server" MaxLength="15" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col mt-2">
                    <p>Correo Electrónico</p>
                    <asp:TextBox ID="txtEmail" runat="server" MaxLength="50" CssClass="form-control"></asp:TextBox>
                </div>


                <div class="col mt-2">
                    <p>Teléfono</p>
                    <asp:TextBox ID="txtTelefono" runat="server" MaxLength="50" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col mt-2">
                    <p>Provincia</p>
                    <asp:DropDownList ID="ddlProvincia" runat="server" class="form-control"></asp:DropDownList>

                </div>
                <div class="col mt-2">
                    <p>Cantón</p>
                    <asp:TextBox ID="txtCanton" runat="server" MaxLength="50" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col mt-2">
                    <p>Fecha de nacimiento</p>
                    <%--<asp:Calendar ID="calFechaNacimiento" runat="server" SelectionMode="DayWeekMonth"></asp:Calendar>--%>
                    <asp:TextBox ID="txtFechaNacimiento" runat="server" CssClass="form-control" placeholder="Ejemplo: 1999-12-31"></asp:TextBox>
                    <span id="datetimepicker" class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>

                </div>


            </div>
            <div class="row row-cols-1 my-2">
                <div class="col">
                    <p>Dirección</p>
                    <textarea id="txtDireccion" cols="20" rows="2" runat="server" class="form-control"></textarea>
                </div>

                <div class="col my-5 ">
                    <asp:Button ID="btnRegistrar" runat="server" Text="Registrar" class="btn btn-warning" OnClick="btnRegistrar_Click" />
                </div>
            </div>

        </form>
    </div>
</asp:Content>
