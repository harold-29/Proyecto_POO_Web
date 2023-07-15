using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Fase3_POO
{
    public partial class frmCliente : System.Web.UI.Page
    {
        int idC = -1;

        protected void Page_Load(object sender, EventArgs e)
        {


            if (!IsPostBack)
            {
                idC = Convert.ToInt32(Session["CODCliente"]);

                ObtenerCliente(idC);

                ObtenerProvincias();

            }

        }
        private void mostrarError(string msj)
        {

            string script = $"mostrarMensaje({msj});";

            ScriptManager.RegisterStartupScript(this, GetType(), "mostrarError", script, true);
        }

        private void ObtenerProvincias()
        {
            // Cargar provincias
            List<string> provincias = new List<string>
                {
                    "Alajuela",
                    "Heredia",
                    "Guanacaste",
                    "San José",
                    "Puntarenas",
                    "Limón",
                    "Cartago"

                };

            ddlProvincia.DataSource = provincias;
            ddlProvincia.DataBind();

        }

        private void ObtenerCliente(int id)
        {

            BD_PAG_WEBDataContext dc = new BD_PAG_WEBDataContext();


            try
            {

                var consulta = from c in dc.CLIENTES
                               where c.COD_CLIENTE == id
                               select c;

                var cliente = consulta.FirstOrDefault();


                if (consulta != null)
                {
                    txtNombre.Text = cliente.NOMBRE;
                    txtApellido1.Text = cliente.APELLIDO1;
                    txtApellido2.Text = cliente.APELLIDO2;
                    txtID.Text = cliente.ID_CLIENTE;
                    txtEmail.Text = cliente.E_MAIL;
                    txtTelefono.Text = cliente.TELEFONO;
                    ddlProvincia.Text = cliente.PROVINCIA;
                    txtCanton.Text = cliente.CANTON;

                    txtDireccion.Value = cliente.DIRECCION;

                    DateTime fecha = cliente.FECHA_NACIMIENTO; // Obtén la fecha desde la base de datos

                    string fechaFormateada = fecha.ToString("yyyy-MM-dd"); // Formatea la fecha en el formato deseado

                    txtFechaNacimiento.Text = fechaFormateada; // Asigna la fecha formateada al TextBox en tu página ASP.NET

                }
                else
                {
                    mostrarError("No se encontraron registros");

                }

            }
            catch (Exception ex)
            {

                mostrarError(ex.Message);

            }

        }


        private bool ValidarArgumentos()
        {

            if (string.IsNullOrEmpty(txtNombre.Text) ||
                string.IsNullOrEmpty(txtApellido1.Text) ||
                string.IsNullOrEmpty(txtApellido2.Text) ||
                string.IsNullOrEmpty(txtDireccion.Value) ||
                string.IsNullOrEmpty(txtCanton.Text) ||
                string.IsNullOrEmpty(ddlProvincia.Text) ||
                string.IsNullOrEmpty(txtFechaNacimiento.Text))
            {
                return false;
            }


            return true;
        }


        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            BD_PAG_WEBDataContext dc = new BD_PAG_WEBDataContext();

            string msj = string.Empty;

            int? i = idC; // ID del cliente

            DateTime? fn = Convert.ToDateTime(txtFechaNacimiento.Text); // Fecha de nacimiento

            try
            {

                if (ValidarArgumentos())
                {
                    dc.SP_AGREGAR_ACTUALIZAR_CLIENTE(ref i, txtID.Text, txtNombre.Text, txtApellido1.Text, txtApellido2.Text, txtEmail.Text, txtTelefono.Text, ddlProvincia.Text, txtCanton.Text, txtDireccion.Value, fn, ref msj);
                }

                ObtenerCliente(idC);

            }
            catch (Exception ex)
            {

                mostrarError(ex.Message);
            }


        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {

            Session["CODCliente"] = -1;
            Response.Redirect("Default.aspx");

        }



    }
}