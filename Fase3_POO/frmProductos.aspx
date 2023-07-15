<%@ Page Title="" Language="C#" MasterPageFile="~/Plantilla.Master" AutoEventWireup="true" CodeBehind="frmProductos.aspx.cs" Inherits="Fase3_POO.frmProductos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <script type="text/javascript">
        function mostrarMensaje(mensaje) {
            alert(mensaje);
        }
        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">

    <form runat="server" id="form3" class="container mt-2 mb-5">

        <div class="row row-cols-1 row-cols-md-2 g-4 mb-3">

            <asp:Panel ID="pnlImagenes" runat="server" class="col px-5">
            </asp:Panel>

            <div class="col m-auto my-auto">
                <div class="row text-center my-5">
                    <asp:Label ID="lblNombre" runat="server" Text="Label" class="h4 col"></asp:Label>
                </div>
                <div class="row row-cols-1 text-center ">
                    <asp:Label ID="lblStock" runat="server" Text="Label" class="col my-2 h5"></asp:Label>

                    <asp:TextBox ID="txtCantidad" runat="server" TextMode="Number" Text="1" min="0" class="mx-auto h5 form-control my-2" Width="60%"></asp:TextBox>

                    <asp:Label ID="lblCosto" runat="server" Text="Label" class="col h5 my-2" ></asp:Label>

                    <asp:Button ID="btnAgregar" runat="server" Text="Agregar" class="mx-auto h5 btn btn-warning my-2" width="60%" OnClick="btnAgregar_Click"/>
                </div>
            </div>
        </div>

        <div class="row g-4 mb-3 my-5">
            <h3>Descripción</h3>

            <asp:Label ID="lblFabricante" runat="server" Text="Label"></asp:Label>

            <asp:Label ID="lblDescripcion" runat="server" Text="Label"></asp:Label>

        </div>


        <div class="row g-4 mb-3 my-5">
            <h3>Comentarios</h3>

            <div class="col">
                <div class="card">
                    <div class="card-body">
                        <asp:Label ID="lblUC1" runat="server" Text="Label" class="card-title"></asp:Label>
                        <asp:Label ID="lblDC1" runat="server" Text="Label" class="card-text"></asp:Label>
                    </div>
                </div>
            </div>

            <div class="col">
                <div class="card" >
                    <div class="card-body">
                        <asp:Label ID="lblUC2" runat="server" Text="Label" class="card-title"></asp:Label>
                        <asp:Label ID="lblDC2" runat="server" Text="Label" class="card-text"></asp:Label>
                    </div>
                </div>
            </div>

            <div class="col">
                <div class="card">
                    <div class="card-body">
                        <asp:Label ID="lblUC3" runat="server" Text="Label" class="card-title"></asp:Label>
                        <asp:Label ID="lblDC3" runat="server" Text="Label" class="card-text"></asp:Label>
                    </div>
                </div>
            </div>

        </div>

    </form>

</asp:Content>
