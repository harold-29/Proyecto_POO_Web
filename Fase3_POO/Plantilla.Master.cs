using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Fase3_POO
{
    public partial class Plantilla : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Convert.ToInt32(Session["CODCliente"]) > 0)
            {
                aLogin.Visible = false;
                aCarrito.Visible = true;
                aCuenta.Visible = true;
            }
            else
            {
                aLogin.Visible = true;
                aCarrito.Visible = false;
                aCuenta.Visible = false;
            }
        }




    }
}