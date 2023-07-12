using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Fase3_POO
{
    public partial class frmBusqueda : System.Web.UI.Page
    {

        string busqueda = string.Empty;

        //TODO: CAMBIAR ESTE CÓDIGO
        protected void Page_Load(object sender, EventArgs e)
        {

            busqueda = Convert.ToString(Request.QueryString["buscar"]);

            //Asignar los valores mínimos y máximos de los productos de esta categoría
            if (!IsPostBack)
            {
                txtMinPrice.Text = Convert.ToString(0);
                txtMaxPrice.Text = Convert.ToString(PrecioMaximo());

                GenerarProductos();
            }

        }

        private List<int> ProductoAscendete()
        {

            BD_PAG_WEBDataContext dc = new BD_PAG_WEBDataContext();

            var minPrice = Convert.ToDecimal(txtMinPrice.Text);
            var maxPrice = Convert.ToDecimal(txtMaxPrice.Text);


            try
            {

                var consulta = from producto in dc.PRODUCTOS
                               where (producto.NOMBRE_PRODUCTO.Contains(busqueda)) && (producto.COSTO_PRODUCTO >= minPrice) && (producto.COSTO_PRODUCTO <= maxPrice)
                               orderby producto.COSTO_PRODUCTO ascending
                               select producto.ID_PRODUCTO;

                List<int> idsProductos = consulta.ToList();

                return idsProductos;


            }
            catch (Exception)
            {

                throw;
            }


        }

        private List<int> ProductosDescendente()
        {
            BD_PAG_WEBDataContext dc = new BD_PAG_WEBDataContext();

            var minPrice = Convert.ToDecimal(txtMinPrice.Text);
            var maxPrice = Convert.ToDecimal(txtMaxPrice.Text);


            try
            {

                var consulta = from producto in dc.PRODUCTOS
                               where (producto.NOMBRE_PRODUCTO.Contains(busqueda)) && (producto.COSTO_PRODUCTO >= minPrice) && (producto.COSTO_PRODUCTO <= maxPrice)
                               orderby producto.COSTO_PRODUCTO descending
                               select producto.ID_PRODUCTO;

                List<int> idsProductos = consulta.ToList();

                return idsProductos;


            }
            catch (Exception)
            {

                throw;
            }
        }

        private void GenerarProductos()
        {
            BD_PAG_WEBDataContext dc = new BD_PAG_WEBDataContext();

            List<int> productos;

            try
            {
                if (chkAscendente.Checked)
                {
                    productos = ProductoAscendete();

                }
                else
                {
                    productos = ProductosDescendente();

                }

                if (productos.Count > 0)
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
                    lblFiltrado.Text = $"Resultados de: {busqueda}";

                }
                else
                {

                    lblFiltrado.Text = $"No se encontraron resultados a: {busqueda}";

                }


            }
            catch (Exception)
            {

                //throw;
            }

        }


        private decimal PrecioMaximo()
        {
            BD_PAG_WEBDataContext dc = new BD_PAG_WEBDataContext();

            try
            {
                var consulta = (from producto in dc.PRODUCTOS
                                where producto.NOMBRE_PRODUCTO.Contains(busqueda)
                                orderby producto.COSTO_PRODUCTO descending
                                select producto.COSTO_PRODUCTO).FirstOrDefault();

                return consulta;

            }
            catch (Exception)
            {
                //Mensaje de no encontrado
                return 0;
            }

        }

        protected void btnFiltro_Click(object sender, EventArgs e)
        {
            GenerarProductos();
        }

        protected void btnAscendete_Click(object sender, EventArgs e)
        {
            chkAscendente.Checked = true;
            chkDescendente.Checked = false;
            GenerarProductos();

        }

        protected void btnDescendente_Click(object sender, EventArgs e)
        {
            chkDescendente.Checked = true;
            chkAscendente.Checked = false;
            GenerarProductos();

        }
    }
}