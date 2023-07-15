using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Fase3_POO
{
    public partial class frmCarrito : System.Web.UI.Page
    {

        List<PRODUCTOS> carrito = new List<PRODUCTOS>();

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                CargarGrid();

            }

            if (carrito.Count > 0)
            {
                GenerarCosto();
            }
            else
            {

                btnRealizarPedido.Visible = false;

                lblCostoTotal.Visible = false;
            }


        }

        private void mostrarError(string msj)
        {

            string script = $"mostrarMensaje({msj});";

            ScriptManager.RegisterStartupScript(this, GetType(), "mostrarError", script, true);
        }

        protected void btnEliminar_Command(object sender, CommandEventArgs e)
        {

            int rowIndex = int.Parse(e.CommandArgument.ToString());

            carrito = Session["ListaProductos"] as List<PRODUCTOS>;

            if (carrito.Count > 0)
            {
                PRODUCTOS producto = carrito[rowIndex];

                carrito.RemoveAt(rowIndex);

                Session["ListaProductos"] = carrito;


                if (carrito.Count > 0) 
                {
                    GenerarCosto(); // generaba un error si no carga denuevo el grid


                    btnRealizarPedido.Visible = true;

                    lblCostoTotal.Visible = true;
                }
                else
                {

                    btnRealizarPedido.Visible = false;

                    lblCostoTotal.Visible = false;
                }
                CargarGrid();
            }
        }


        private void CargarGrid()
        {

            carrito = Session["ListaProductos"] as List<PRODUCTOS>;

            if (carrito != null)
            {

                gvCarrito.DataSource = carrito;
                gvCarrito.DataBind();
            }


        }

        private void GenerarCosto()
        {

            carrito = Session["ListaProductos"] as List<PRODUCTOS>;

            decimal costo = 0;

            if (carrito != null)
            {
                foreach (PRODUCTOS c in carrito)
                {

                    costo += c.COSTO_PRODUCTO;

                }

                lblCostoTotal.Text = $"Costo Total: ¢{costo}";

            }
        }

        protected void gvCarrito_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                ImageButton btnEliminar = (ImageButton)e.Row.FindControl("btnEliminar");
                btnEliminar.CommandArgument = e.Row.RowIndex.ToString();
            }
        }



        protected void btnRealizarPedido_Click(object sender, EventArgs e)
        {

            BD_PAG_WEBDataContext dc = new BD_PAG_WEBDataContext();

            carrito = Session["ListaProductos"] as List<PRODUCTOS>;
            
            int? id = Convert.ToInt32(Session["CODCliente"]);

            string direccion = string.Empty;

            string msjP = string.Empty;

            string msjDP = string.Empty;

            int? idPedido = -1;

            try
            {
                if (id != -1)
                {
                    var consulta = from c in dc.CLIENTES
                                   where c.COD_CLIENTE == id
                                   select c;

                    var cliente = consulta.FirstOrDefault();


                    direccion = $"{cliente.PROVINCIA}, {cliente.CANTON}, {cliente.DIRECCION}";

                    if (carrito.Count > 0)
                    {

                        dc.SP_AGREGAR_ACTUALIZAR_PEDIDO(ref id, ref idPedido, 0, 0, direccion, ref msjP);

                        foreach (PRODUCTOS p in carrito)
                        {

                            int idProducto = p.ID_PRODUCTO;

                            dc.SP_AGREGAR_DETALLE_PEDIDO(idPedido, idProducto, ref msjDP);


                            if (!string.IsNullOrEmpty(msjDP))
                            {

                                // Realizar un rollback de la transacción
                                dc.Transaction.Rollback();


                            }
                            else
                            {
                                mostrarError(msjDP);

                            }


                        }


                        Session["ListaProductos"] = new List<PRODUCTOS>();

                        CargarGrid();
                    }
                    else
                    {
                        mostrarError("No se encontraron registros");

                    }
                }


            }
            catch (Exception ex)
            {
                //lblCostoTotal.Visible = true;

                //lblCostoTotal.Text = "a";
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