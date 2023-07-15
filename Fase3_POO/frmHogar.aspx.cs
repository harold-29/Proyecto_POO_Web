using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Fase3_POO
{
    public partial class frmMuebles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Asignar los valores mínimos y máximos de los productos de esta categoría
            if (!IsPostBack)
            {
                txtMinPrice.Text = Convert.ToString(0);
                txtMaxPrice.Text = Convert.ToString(PrecioMaximo());

                GenerarProductos();
            }
        }
        private void mostrarError(string msj)
        {

            string script = $"mostrarMensaje({msj});";

            ScriptManager.RegisterStartupScript(this, GetType(), "mostrarError", script, true);
        }

        private List<int> ProductoAscendete()
        {

            BD_PAG_WEBDataContext dc = new BD_PAG_WEBDataContext();

            var minPrice = Convert.ToDecimal(txtMinPrice.Text);
            var maxPrice = Convert.ToDecimal(txtMaxPrice.Text);

            List<int> idsProductos = new List<int>();

            try
            {

                var consulta = from producto in dc.PRODUCTOS
                               where (producto.CATEGORIA_PRODUCTO == 3) && (producto.COSTO_PRODUCTO >= minPrice) && (producto.COSTO_PRODUCTO <= maxPrice)
                               orderby producto.COSTO_PRODUCTO ascending
                               select producto.ID_PRODUCTO;
                if (consulta.Count() > 0)
                {
                    idsProductos = consulta.ToList();
                    return idsProductos;

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
            return idsProductos;


        }

        private List<int> ProductosDescendente()
        {
            BD_PAG_WEBDataContext dc = new BD_PAG_WEBDataContext();

            var minPrice = Convert.ToDecimal(txtMinPrice.Text);
            var maxPrice = Convert.ToDecimal(txtMaxPrice.Text);
            List<int> idsProductos = new List<int>();


            try
            {

                var consulta = from producto in dc.PRODUCTOS
                               where (producto.CATEGORIA_PRODUCTO == 3) && (producto.COSTO_PRODUCTO >= minPrice) && (producto.COSTO_PRODUCTO <= maxPrice)
                               orderby producto.COSTO_PRODUCTO descending
                               select producto.ID_PRODUCTO;


                if (consulta.Count() > 0)
                {
                    idsProductos = consulta.ToList();
                    return idsProductos;

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
            return idsProductos;

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


        private decimal PrecioMaximo()
        {
            BD_PAG_WEBDataContext dc = new BD_PAG_WEBDataContext();

            try
            {
                var consulta = (from producto in dc.PRODUCTOS
                                where producto.CATEGORIA_PRODUCTO == 3
                                orderby producto.COSTO_PRODUCTO descending
                                select producto.COSTO_PRODUCTO).FirstOrDefault();

                return consulta;

            }
            catch (Exception ex)
            {
                mostrarError(ex.Message);
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