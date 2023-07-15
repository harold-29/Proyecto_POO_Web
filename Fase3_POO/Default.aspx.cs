using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Fase3_POO
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                GenerarProductos();

                if (Session["ListaProductos"] == null)
                {
                    Session["ListaProductos"] = new List<PRODUCTOS>();
                }


                if (Session["CODCliente"] == null)
                {
                    Session["CODCliente"] = -1;
                }

            }

        }
        private void mostrarError(string msj)
        {

            string script = $"mostrarMensaje({msj});";

            ScriptManager.RegisterStartupScript(this, GetType(), "mostrarError", script, true);
        }

        private List<int> ObtenerIdsProductos()
        {

            BD_PAG_WEBDataContext dc = new BD_PAG_WEBDataContext();

            //Obtener los productos en orden de más comprados
            List<int> productos = new List<int>();

            try
            {
                var consulta = from detallePedido in dc.DETALLE_PEDIDO
                               group detallePedido by detallePedido.ID_PRODUCTO into grupo
                               orderby grupo.Count() descending
                               select grupo.Key;

                if (consulta.Count() > 0)
                {
                    productos = consulta.Take(4).ToList();
                    return productos;

                }
                else
                {
                    mostrarError("No se encontraron productos");
                }


            }
            catch (Exception ex)
            {

                mostrarError(ex.Message);


            }

            return productos;

        }

        private void GenerarProductos()
        {
            BD_PAG_WEBDataContext dc = new BD_PAG_WEBDataContext();

            List<int> productos = ObtenerIdsProductos();

            try
            {

                foreach (int p in productos)
                {


                    var consulta = from producto in dc.PRODUCTOS
                                   join imagen in dc.IMG_PRODUCTOS on producto.ID_PRODUCTO equals imagen.ID_PRODUCTO
                                   where producto.ID_PRODUCTO == p
                                   select new
                                   {
                                       nombre = producto.NOMBRE_PRODUCTO,
                                       costo = producto.COSTO_PRODUCTO,
                                       img = imagen.RUTA_IMG

                                   };

                    if (consulta.Count() > 0)
                    {
                        var primerElemento = consulta.FirstOrDefault();

                        // Crea una nueva instancia del control Card y establece sus propiedades
                        Card card = new Card();
                        card.Id = p;
                        card.Nombre = primerElemento.nombre;
                        card.Costo = primerElemento.costo;
                        card.Img = primerElemento.img;

                        // Agrega la card al contenedor de productos
                        Panel1.Controls.Add(card);

                    }
                    else
                    {
                        mostrarError("No se encontrón el producto");
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