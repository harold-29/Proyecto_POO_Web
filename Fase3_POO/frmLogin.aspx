<%@ Page Title="" Language="C#" MasterPageFile="~/Plantilla.Master" AutoEventWireup="true" CodeBehind="frmLogin.aspx.cs" Inherits="Fase3_POO.frmLogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
     <div class="login mt-5">
        <h1 class="h1">Iniciar Sesión</h1>

        <form id="form1" runat="server" class="container">
            <div class="row row-cols-1">

                <div class="col">
                    <p class="card-title">Usuario</p>
                    <asp:TextBox ID="txtUsuario" runat="server" class="form-control" MaxLength="15"></asp:TextBox>
                </div>

                <%--                <div class="col">
                    <p class="card-title">Contraseña</p>
                    <asp:TextBox ID="txtPassword" runat="server" class="form-control"></asp:TextBox>
                </div>--%>

                <div class="col">
                    <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary" Text="Ingresar" OnClick="btnLogin_Click" />
                </div>

                <div class="col">
                    <a href="frmRegistro.aspx">Registrarse</a>
                </div>

            </div>
        </form>

    </div>
</asp:Content>
