<%@ Page Title="" Language="C#" MasterPageFile="~/Plantilla.Master" AutoEventWireup="true" CodeBehind="frmRegistro.aspx.cs" Inherits="Fase3_POO.frmRegistro" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function mm(mensaje) {
            alert(mensaje);
        }


        function mostrarModalJS() {
            const errorModal = new bootstrap.Modal(document.getElementById("modalError"));
            errorModal.show();
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <div class="container bd-main col">
        <h2 class="h2">Ingresa tus datos</h2>

        <form runat="server" id="formRegistro">
            <asp:ScriptManager runat="server" ID="ScriptManager" />

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
                    <asp:TextBox ID="txtID" runat="server" MaxLength="15" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage='El campo "Identificación" es requerido' ControlToValidate="txtID" Text="*" ValidationGroup="Registro"></asp:RequiredFieldValidator>

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
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage='El campo "Provincia" es requerido' ControlToValidate="ddlProvincia" Text="*" ValidationGroup="Registro"></asp:RequiredFieldValidator>

                </div>
                <div class="col mt-2">
                    <p>Cantón</p>
                    <asp:TextBox ID="txtCanton" runat="server" MaxLength="50" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage='El campo "Cantón" es requerido' ControlToValidate="txtCanton" Text="*" ValidationGroup="Registro"></asp:RequiredFieldValidator>

                </div>

                <div class="col mt-2">
                    <p>Fecha de nacimiento</p>
                    <%--<asp:Calendar ID="calFechaNacimiento" runat="server" SelectionMode="DayWeekMonth"></asp:Calendar>--%>
                    <asp:TextBox ID="txtFechaNacimiento" runat="server" CssClass="form-control" placeholder="Ejemplo: 1999-12-31"></asp:TextBox>
                    <span id="datetimepicker" class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage='El campo "Fecha de Nacimiento" es requerido' ControlToValidate="txtFechaNacimiento" Text="*" ValidationGroup="Registro"></asp:RequiredFieldValidator>

                </div>


            </div>
            <div class="row row-cols-1 my-2">
                <div class="col">
                    <p>Dirección</p>
                    <textarea id="txtDireccion" cols="20" rows="2" runat="server" class="form-control"></textarea>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage='El campo "Dirección" es requerido' ControlToValidate="txtDireccion" Text="*" ValidationGroup="Registro"></asp:RequiredFieldValidator>

                </div>

                <div class="col my-5 ">
                    <asp:Button ID="btnRegistrar" runat="server" Text="Registrar" class="btn btn-warning" OnClick="btnRegistrar_Click" ValidationGroup="Registro" />
                </div>

                <div class="col my-5 ">
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="Registro" />

                </div>
            </div>

            <!-- Button trigger modal -->
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalError">
                Launch static backdrop modal
            </button>

            <!-- Modal -->
            <div class="modal fade" id="modalError" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="staticBackdropLabel">Algo salio mal!!</h1>
                        </div>
                        <div class="modal-body">
                            <p id="mensaje" runat="server">.</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

        </form>

    </div>
</asp:Content>
