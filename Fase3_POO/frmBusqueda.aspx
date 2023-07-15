<%@ Page Title="" Language="C#" MasterPageFile="~/Plantilla.Master" AutoEventWireup="true" CodeBehind="frmBusqueda.aspx.cs" Inherits="Fase3_POO.frmBusqueda" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">

    <div class="container-xxl contenedor mb-5">
        <aside class="bd-sidebar">
            <h3>Filtro</h3>

            <form runat="server" id="form3" class="row-cols-md-1">
                <div class="col">
                    <p>Precio mínimo</p>
                    <asp:TextBox ID="txtMinPrice" runat="server" class="form-control"></asp:TextBox>
                </div>

                <div class="col">
                    <p>Precio máximo</p>
                    <asp:TextBox ID="txtMaxPrice" runat="server" class="form-control"></asp:TextBox>
                </div>

                <div class="col mt-4 mb-2">
                    <asp:Button ID="btnFiltro" runat="server" Text="Filtrar" OnClick="btnFiltro_Click" CssClass="btn btn-warning"/>

                </div>

                <hr />

                <div class="col">
                    <p>Orden:</p>
                    <asp:Button ID="btnAscendete" runat="server" Text="Menor a Mayor" OnClick="btnAscendete_Click" CssClass="btn btn-warning"/>

                    <asp:CheckBox ID="chkAscendente" runat="server" Checked="True" Visible="False" />
                </div>

                <div class="col mt-4">
                    <asp:Button ID="btnDescendente" runat="server" Text="Mayor a Menor " OnClick="btnDescendente_Click" CssClass="btn btn-warning"/>

                    <asp:CheckBox ID="chkDescendente" runat="server" onclick="toggleAscendente(this.checked)" Visible="False" />
                </div>

            </form>
        </aside>
        <div class="container bd-main">
            <asp:Label ID="lblFiltrado" runat="server" Text="." CssClass="mb-5 row h1"></asp:Label>
            <asp:Panel ID="Panel1" runat="server" class="row row-cols-1 row-cols-md-4 g-4 mb-3 productos">
            </asp:Panel>
        </div>
    </div>

</asp:Content>
