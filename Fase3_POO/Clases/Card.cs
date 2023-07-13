using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Fase3_POO
{
    public class Card : WebControl
    {
        private int id;
        private string nombre;
        private decimal costo;
        private int stock;
        private string img;

        public int Id { get => id; set => id = value; }
        public string Nombre { get => nombre; set => nombre = value; }
        public decimal Costo { get => costo; set => costo = value; }
        public int Stock { get => stock; set => stock = value; }
        public string Img { get => img; set => img = value; }


        protected override void RenderContents(HtmlTextWriter writer)
        {
            writer.AddAttribute(HtmlTextWriterAttribute.Class, "col");
            writer.RenderBeginTag(HtmlTextWriterTag.Div);

            writer.AddAttribute(HtmlTextWriterAttribute.Class, "card-img-top");
            writer.AddAttribute(HtmlTextWriterAttribute.Src, $"{img}");
            writer.AddAttribute(HtmlTextWriterAttribute.Alt, "...");
            writer.RenderBeginTag(HtmlTextWriterTag.Img);
            writer.RenderEndTag();

            writer.AddAttribute(HtmlTextWriterAttribute.Class, "card-body");
            writer.RenderBeginTag(HtmlTextWriterTag.Div);

            writer.AddAttribute(HtmlTextWriterAttribute.Class, "card-title");
            writer.RenderBeginTag(HtmlTextWriterTag.Div);
            writer.WriteEncodedText(Nombre);
            writer.RenderEndTag();//End card-title

            writer.AddAttribute(HtmlTextWriterAttribute.Class, "card-text");
            writer.RenderBeginTag(HtmlTextWriterTag.Div);
            writer.WriteEncodedText(string.Format("¢{0}", costo));
            writer.RenderEndTag();//End card-text


            writer.AddAttribute(HtmlTextWriterAttribute.Class, "btn btn-warning");
            writer.AddAttribute(HtmlTextWriterAttribute.Value, "Detalles");
            writer.AddAttribute(HtmlTextWriterAttribute.Type, "button");
            writer.AddAttribute(HtmlTextWriterAttribute.Id, $"{id}");
            writer.AddAttribute("onclick", $"redirectToProduct('{id}')");
            writer.RenderBeginTag(HtmlTextWriterTag.Button);
            writer.Write("Detalles");
            writer.RenderEndTag(); //End button

            writer.RenderEndTag();//End card-body

            writer.RenderEndTag(); //End Col

        }

    }
}