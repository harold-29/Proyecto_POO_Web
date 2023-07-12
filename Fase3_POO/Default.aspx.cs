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

                productos = consulta.Take(4).ToList();


            }
            catch (Exception)
            {

                //TODO: agregar mensaje de null

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
                                   where producto.ID_PRODUCTO == p //TODO: CAMBIAR 1 POR p
                                   select new
                                   {
                                       nombre = producto.NOMBRE_PRODUCTO,
                                       costo = producto.COSTO_PRODUCTO,
                                       img = imagen.RUTA_IMG

                                   };

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

            }
            catch (Exception)
            {

                //TODO: agregar mensaje de null

            }

        }



    }
}