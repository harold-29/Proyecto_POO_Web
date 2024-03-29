﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Fase3_POO
{
    public partial class frmRegistro : System.Web.UI.Page
    {
        string script = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {


            if (!IsPostBack)
            {
                ObtenerProvincias();
            }

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


        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            BD_PAG_WEBDataContext dc = new BD_PAG_WEBDataContext();

            string msj = string.Empty;

            int? i = 0;
            DateTime? fn = new DateTime();

            try
            {
                if (!string.IsNullOrEmpty(txtFechaNacimiento.Text))
                {
                    fn = Convert.ToDateTime(txtFechaNacimiento.Text); // Fecha de nacimiento

                }

                if (ValidarArgumentos())
                {
                    dc.SP_AGREGAR_ACTUALIZAR_CLIENTE(ref i, txtID.Text, txtNombre.Text, txtApellido1.Text, txtApellido2.Text, txtEmail.Text, txtTelefono.Text, ddlProvincia.Text, txtCanton.Text, txtDireccion.Value, fn, ref msj);

                    Session["idCLiente"] = txtID.Text;
                    Response.Redirect("frmLogin.aspx");

                }
                else
                {
                    mostrarError(msj);
                }



            }
            catch (Exception ex)
            {

                mostrarError(ex.Message);
            }

        }

        private void mostrarError(string msj)
        {

            string script = $"mostrarMensaje({msj});";

            ScriptManager.RegisterStartupScript(this, GetType(), "mostrarError", script, true);
        }



    }
}