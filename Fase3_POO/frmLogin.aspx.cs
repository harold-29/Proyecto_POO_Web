using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Fase3_POO
{
    public partial class frmLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        private void mostrarError(string msj)
        {

            string script = $"mostrarMensaje({msj});";

            ScriptManager.RegisterStartupScript(this, GetType(), "mostrarError", script, true);
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            BD_PAG_WEBDataContext dc = new BD_PAG_WEBDataContext();

            try
            {

                if (!string.IsNullOrEmpty(txtUsuario.Text))
                {
                    int id = 0;

                    var consulta = from c in dc.CLIENTES
                                   where c.ID_CLIENTE == txtUsuario.Text
                                   select c.COD_CLIENTE;

                    id = consulta.FirstOrDefault();

                    if (id > 0)
                    {

                        Session["CODCliente"] = id;

                        Response.Redirect("Default.aspx");

                    }
                    else
                    {
                        mostrarError("No se encontro el número de usuario");
                    }

                }

            }
            catch (Exception ex)
            {

                mostrarError(ex.Message);

            }

        }
    }
}