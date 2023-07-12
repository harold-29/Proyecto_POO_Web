using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Fase3_POO
{
    public class GCCard : WebControl
    {
        private string nombre;
        private decimal costo;
        private int stock;
        private string img;

        public string Nombre { get => nombre; set => nombre = value; }
        public decimal Costo { get => costo; set => costo = value; }
        public int Stock { get => stock; set => stock = value; }
        public string Img { get => img; set => img = value; }

        protected override void RenderContents(HtmlTextWriter writer)
        {
            writer.AddAttribute(HtmlTextWriterAttribute.Class, "col");
            writer.RenderBeginTag(HtmlTextWriterTag.Div);

            writer.AddAttribute(HtmlTextWriterAttribute.Class, "card");
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
            writer.RenderEndTag();

            writer.AddAttribute(HtmlTextWriterAttribute.Class, "card-text");
            writer.RenderBeginTag(HtmlTextWriterTag.Div);
            writer.WriteEncodedText(string.Format("¢{0}", costo));
            writer.RenderEndTag();

            writer.RenderEndTag();

            writer.RenderEndTag();

            writer.RenderEndTag();

        }




    }
}