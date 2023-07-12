<%@ Page Title="" Language="C#" MasterPageFile="~/Plantilla.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Fase3_POO.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">

    <div class="container">

        <%--Carrusel--%>
        <div class="row ">
            <div class="carrusel col-12 mb-5">
                <div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item">
                            <img src="Assets/Img/tienda.png" class="d-block w-100" alt="...">
                        </div>
                        <div class="carousel-item active">
                            <img src="Assets/Img/promo.png" class="d-block w-100" alt="...">
                        </div>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
            </div>
        </div>

        <%--Destacados--%>
        <div class="row mb-2">
            <h2>Destacados</h2>
        </div>

        <asp:Panel ID="Panel1" runat="server" class="row row-cols-1 row-cols-md-4 g-4 mb-3">
        </asp:Panel>
    </div>


</asp:Content>

