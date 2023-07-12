<%@ Page Title="" Language="C#" MasterPageFile="~/Plantilla.Master" AutoEventWireup="true" CodeBehind="frmCarrito.aspx.cs" Inherits="Fase3_POO.frmCarrito" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">

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

            </div>
        </aside>
        <div class="container bd-main col">
            <h2 class="h2">Carrito de Compra</h2>

            <form runat="server">

                <asp:GridView ID="gvCarrito" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" EmptyDataText="No se ingresado productos al carrito de compra" ForeColor="#333333" GridLines="None" Width="100%" OnRowDataBound="gvCarrito_RowDataBound">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="NOMBRE_PRODUCTO" HeaderText="Producto">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="COSTO_PRODUCTO" HeaderText="Costo">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="btnEliminar" runat="server" CommandArgument='<%# Eval("ID_PRODUCTO").ToString() %>' Height="30px" ImageUrl="/Assets/Img/cancelar (1).png" OnCommand="btnEliminar_Command" Width="30px" />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="ID_PRODUCTO" HeaderText="Id" Visible="False" />
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

                <div class="my-5 d-flex justify-content-end">
                    <asp:Label ID="lblCostoTotal" runat="server" Text="." CssClass="me-5"></asp:Label>
                    <asp:Button ID="btnRealizarPedido" runat="server" Text="Realizar Pedido" class="btn btn-warning ms-5" OnClick="btnRealizarPedido_Click" />
                </div>


            </form>

        </div>
    </div>



</asp:Content>
