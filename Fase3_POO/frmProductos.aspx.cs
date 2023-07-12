using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Fase3_POO
{
    public partial class frmProductos : System.Web.UI.Page
    {
        int id = 0;


        protected void Page_Load(object sender, EventArgs e)
        {
            id = Convert.ToInt32(Request.QueryString["id"]);

            List<int> listComentarios = new List<int>();

            GenerarImagenes();

            GenerarInfo();

        }


        private void GenerarImagenes()
        {
            BD_PAG_WEBDataContext dc = new BD_PAG_WEBDataContext();

            try
            {

                var consulta = (from img in dc.IMG_PRODUCTOS
                                where img.ID_PRODUCTO == id   //TODO: cambiar 1 por id
                                select img.RUTA_IMG).Take(4);  //selecciono 4 en caso de que el producto tenga mas ya que no necesito más

                if (consulta != null)
                {
                    ImgsProducto imagenes = new ImgsProducto();
                    imagenes.ListIMG = consulta.ToList();

                    pnlImagenes.Controls.Add(imagenes);
                }
                else
                {

                    //TODO: agregar mensaje de null
                }


            }
            catch (Exception)
            {
                //TODO: agregar mensaje de null

            }


        }

        private void GenerarInfo()
        {

            BD_PAG_WEBDataContext dc = new BD_PAG_WEBDataContext();


            try
            {

                var consulta = from producto in dc.PRODUCTOS
                               where producto.ID_PRODUCTO == id //TODO: cambiar 1 por id
                               select producto;

                var primerRegistro = consulta.FirstOrDefault();

                if (consulta != null)
                {
                    lblNombre.Text = primerRegistro.NOMBRE_PRODUCTO.ToString();
                    lblCosto.Text = $"Costo por unidad: ¢{primerRegistro.COSTO_PRODUCTO}";
                    lblFabricante.Text = $"Fabricante: {primerRegistro.FABRICANTE}";
                    lblDescripcion.Text = $"Especificaciones: {primerRegistro.DESCRIPCION}";

                    if (primerRegistro.CANTIDAD_STOCK > 0)
                    {
                        lblStock.Text = "En stock";
                    }
                    else
                    {
                        lblStock.Text = "No hay stock";
                    }

                    txtCantidad.Attributes["max"] = $"{primerRegistro.CANTIDAD_STOCK}";
                    //txtCantidad.Attributes["validationMessage"] = $"Solo disponemos con una cantidad de {primerRegistro.CANTIDAD_STOCK} unidades en este momento";


                }


            }
            catch (Exception)
            {
                //TODO: agregar mensaje de null

            }

        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {

            BD_PAG_WEBDataContext dc = new BD_PAG_WEBDataContext();

            List<PRODUCTOS> listaProductos = Session["ListaProductos"] as List<PRODUCTOS>;

            int cant = Convert.ToInt32(txtCantidad.Text);


            try
            {

                var consulta = from p in dc.PRODUCTOS
                               where p.ID_PRODUCTO == id
                               select p;
                var producto = consulta.FirstOrDefault();

                 
                if (producto != null)
                {

                    if ( (Convert.ToInt32(Session["cantAdd"]) <= producto.CANTIDAD_STOCK) && (Convert.ToInt32(Session["cantAdd"]) + cant <= producto.CANTIDAD_STOCK)  ) 
                    {

                        for (int i = 0; i < cant; i++)
                        {
                            listaProductos.Add(producto);

                        }
                        Session["cantAdd"] = Convert.ToInt32(Session["cantAdd"]) + cant;

                        Session["ListaProductos"] = listaProductos;
                    }
                    else
                    {
                        //TODO: agregar mensaje de no hay cantidad suficiente

                    }


                }


            }
            catch (Exception)
            {

                //TODO: agregar mensaje de null

            }

        }
    }
}