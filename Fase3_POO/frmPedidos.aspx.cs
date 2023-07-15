using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Fase3_POO
{
    public partial class frmPedidos : System.Web.UI.Page
    {

        int id = 0;


        protected void Page_Load(object sender, EventArgs e)
        {
            id = Convert.ToInt32(Session["CODCliente"]);

            if (!IsPostBack)
            {
                CargarGrid();

            }


        }
        private void mostrarError(string msj)
        {

            string script = $"mostrarMensaje({msj});";

            ScriptManager.RegisterStartupScript(this, GetType(), "mostrarError", script, true);
        }
        protected void gvPedidos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Button btnMostrar = (Button)e.Row.FindControl("btnMostrar");
                int idPedido = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "ID_PEDIDO"));
                btnMostrar.Attributes["data-idPedido"] = idPedido.ToString();
            }
        }

        protected void btnMostrar_Command(object sender, CommandEventArgs e)
        {

            BD_PAG_WEBDataContext dc = new BD_PAG_WEBDataContext();

            string texto = string.Empty;


            int idPedido = Convert.ToInt32(((Button)sender).Attributes["data-idPedido"]);


            try
            {
                var consulta = from p in dc.PEDIDOS
                               join c in dc.CLIENTES on p.COD_CLIENTE equals c.COD_CLIENTE
                               where p.ID_PEDIDO == idPedido
                               select new
                               {
                                   p.ID_PEDIDO,
                                   p.COSTO_TOTAL,
                                   p.FECHA_PEDIDO,
                                   c.ID_CLIENTE,
                                   p.DIRECCION_ENVIO,
                                   p.DESCUENTO_PEDIDO,
                               };

                var pr = consulta.FirstOrDefault();

                if (pr != null)
                {

                    var consulta2 = from p in dc.PRODUCTOS
                                    join dp in dc.DETALLE_PEDIDO on p.ID_PRODUCTO equals dp.ID_PRODUCTO
                                    where dp.ID_PEDIDO == pr.ID_PEDIDO
                                    select new
                                    {
                                        p.NOMBRE_PRODUCTO,
                                        p.COSTO_PRODUCTO
                                    };

                    if (consulta2 != null)
                    {

                        texto = $"N° Pedido: {Convert.ToString(pr.ID_PEDIDO).PadRight(25)}Fecha: {Convert.ToString(pr.FECHA_PEDIDO).PadRight(25)}\n\nCliente: {pr.ID_CLIENTE}\n\nLista de Productos:\n";

                        foreach (var a in consulta2)
                        {
                            texto += $"{a.NOMBRE_PRODUCTO.PadRight(40)}¢{a.COSTO_PRODUCTO}\n";

                        }

                        texto += $"\nDescuento aplicado: {Convert.ToString(pr.DESCUENTO_PEDIDO).PadRight(15)}Costo total: ¢{pr.COSTO_TOTAL}\n\n";

                        txtInfo.Value = texto;


                    }
                    else
                    {
                        mostrarError("No se encontraron registros de los pedidos");
                    }




                }
                else
                {
                    mostrarError("No se encontraron registros del cliente");

                }


            }
            catch (Exception ex)
            {

                mostrarError(ex.Message);

            }

        }

        private void CargarGrid()
        {

            BD_PAG_WEBDataContext dc = new BD_PAG_WEBDataContext();

            try
            {

                var consulta = from c in dc.PEDIDOS
                               where c.COD_CLIENTE == id
                               orderby c.ID_PEDIDO descending
                               select c;


                if (consulta != null)
                {

                    gvPedidos.DataSource = consulta;
                    gvPedidos.DataBind();

                }
                else
                {
                    mostrarError("No se encontró el pedido");

                }

            }
            catch (Exception ex)
            {

                mostrarError(ex.Message);

            }


        }

        protected void gvPedidos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvPedidos.PageIndex = e.NewPageIndex;
            CargarGrid();
        }


        protected void btnLogout_Click(object sender, EventArgs e)
        {

            Session["CODCliente"] = -1;
            Response.Redirect("Default.aspx");

        }
    }
}