using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Fase3_POO
{
    public class ImgsProducto : WebControl
    {

        private List<string> _listIMG;

        public List<string> ListIMG { get => _listIMG; set => _listIMG = value; }

        protected override void RenderContents(HtmlTextWriter writer)
        {
            writer.AddAttribute(HtmlTextWriterAttribute.Class, "col");
            writer.RenderBeginTag(HtmlTextWriterTag.Div);

            writer.AddAttribute(HtmlTextWriterAttribute.Class, "card-img-top");
            writer.AddAttribute(HtmlTextWriterAttribute.Src, $"{ListIMG[0]}");
            writer.AddAttribute(HtmlTextWriterAttribute.Alt, "...");
            writer.AddAttribute(HtmlTextWriterAttribute.Id, "imgPrincipal");
            writer.RenderBeginTag(HtmlTextWriterTag.Img);
            writer.RenderEndTag();

            writer.AddAttribute(HtmlTextWriterAttribute.Class, "row row-cols-4");
            writer.AddAttribute(HtmlTextWriterAttribute.Id, "imgsProducto");
            writer.RenderBeginTag(HtmlTextWriterTag.Div);

            foreach (string img in ListIMG)
            {
                writer.AddAttribute(HtmlTextWriterAttribute.Class, "col");
                writer.RenderBeginTag(HtmlTextWriterTag.Div);

                writer.AddAttribute(HtmlTextWriterAttribute.Class, "card-img-top");
                writer.AddAttribute(HtmlTextWriterAttribute.Src, $"{img}");
                writer.AddAttribute(HtmlTextWriterAttribute.Alt, "...");
                writer.RenderBeginTag(HtmlTextWriterTag.Img);
                writer.RenderEndTag();

                writer.RenderEndTag();//col
            }

            writer.RenderEndTag();//row

            writer.RenderEndTag();//outcol
        }




    }
}