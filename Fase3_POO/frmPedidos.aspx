<%@ Page Title="" Language="C#" MasterPageFile="~/Plantilla.Master" AutoEventWireup="true" CodeBehind="frmPedidos.aspx.cs" Inherits="Fase3_POO.frmPedidos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <form runat="server">

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


                <div>
                    <div>
                        <asp:GridView ID="gvPedidos" runat="server" AutoGenerateColumns="False" AllowPaging="True" CellPadding="10" ForeColor="#333333" GridLines="None" Width="100%" OnPageIndexChanging="gvPedidos_PageIndexChanging" OnRowDataBound="gvPedidos_RowDataBound">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="ID_PEDIDO" HeaderText="N° de Pedido" />
                                <asp:BoundField DataField="FECHA_PEDIDO" HeaderText="Fecha" />
                                <asp:BoundField DataField="COSTO_TOTAL" HeaderText="Costo Total" />
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="btnMostrar" runat="server" CommandArgument='<%# Eval("ID_PEDIDO").ToString() %>' OnCommand="btnMostrar_Command" Text="Detalles" class="btn btn-warning" CommandName="btnMostrar" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                            <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                            <SortedAscendingCellStyle BackColor="#FDF5AC" />
                            <SortedAscendingHeaderStyle BackColor="#4D0000" />
                            <SortedDescendingCellStyle BackColor="#FCF6C0" />
                            <SortedDescendingHeaderStyle BackColor="#820000" />
                        </asp:GridView>

                    </div>

                    <div class="my-5">
                        <h3 class="h3">Detalle Pedido</h3>
                        <textarea id="txtInfo" cols="20" rows="2" runat="server" class="my-5 form-control" readonly="true"> </textarea>
                    </div>
                </div>


            </div>
        </div>
    </form>

</asp:Content>
