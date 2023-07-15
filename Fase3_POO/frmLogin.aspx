<%@ Page Title="" Language="C#" MasterPageFile="~/Plantilla.Master" AutoEventWireup="true" CodeBehind="frmLogin.aspx.cs" Inherits="Fase3_POO.frmLogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
     <div class="login m-5">
        <h1 class="h1">Iniciar Sesión</h1>

        <form id="form1" runat="server" class="container mx-5 px-5">
            <div class="row row-cols-1">

                <div class="col">
                    <p class="card-title">Usuario</p>
                    <asp:TextBox ID="txtUsuario" runat="server" class="form-control mt-3" MaxLength="15"></asp:TextBox>
                </div>

                <%--                <div class="col">
                    <p class="card-title">Contraseña</p>
                    <asp:TextBox ID="txtPassword" runat="server" class="form-control"></asp:TextBox>
                </div>--%>

                <div class="col mt-5"> 
                    <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-dark" Text="Ingresar" OnClick="btnLogin_Click" />
                </div>

                <div class="col mt-4 mb-5">
                    <a href="frmRegistro.aspx" class="nav-link">Registrarse</a>
                </div>

            </div>
        </form>

    </div>
</asp:Content>
