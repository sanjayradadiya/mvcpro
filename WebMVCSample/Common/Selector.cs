using System.Collections.Generic;
using System.Web.Mvc;
using System.Text;
using System.Linq;

namespace WebInventory.Common
{
    //DropDownListbox helper
    public class SelectListCodeItem
    {
        public string Text { get; set; }
        public string Value { get; set; }
        public decimal Seq { get; set; }
    }

    // CheckBoxList helper.
    public class MultiListInfo
    {
        public MultiListInfo(string value, string displayText, decimal? seq, bool isChecked)
        {
            this.Value = value;
            this.DisplayText = displayText;
            this.Seq = seq ?? -999;
            this.IsChecked = isChecked;
        }

        public string Value { get; private set; }
        public string DisplayText { get; private set; }
        public decimal Seq { get; private set; }
        public bool IsChecked { get; private set; }
    }

    public static class Selector
    {
        public static MvcHtmlString SelectorDropDownList(this HtmlHelper htmlHelper, string name, IEnumerable<SelectListCodeItem> selectList, object htmlAttributes, string optionLabel)
        {
            var select = new TagBuilder("select");

            var options = "";
            TagBuilder option;

            if (!string.IsNullOrEmpty(optionLabel))
            {
                option = new TagBuilder("option");
                option.MergeAttribute("value", "");
                option.MergeAttribute("selected", "selected");
                option.SetInnerText(optionLabel);
                options += option.ToString(TagRenderMode.Normal) + "\n";
            }

            foreach (var item in selectList)
            {
                option = new TagBuilder("option");
                option.MergeAttribute("value", item.Value.ToString());
                option.MergeAttribute("Seq", item.Seq.ToString());
                option.SetInnerText(item.Text);
                options += option.ToString(TagRenderMode.Normal) + "\n";
            }

            //select.MergeAttribute("data-val", "true");
            //select.MergeAttribute("data-val-required", "The field is required.");
            select.MergeAttribute("id", name);
            select.MergeAttribute("name", name);

            IDictionary<string, object> htmlAttributes1 = (IDictionary<string, object>)HtmlHelper.AnonymousObjectToHtmlAttributes(htmlAttributes);
            select.MergeAttributes<string, object>(htmlAttributes1);

            select.InnerHtml = options;

            return new MvcHtmlString(select.ToString(TagRenderMode.Normal));
        }

        public static MvcHtmlString CheckBoxList(this HtmlHelper htmlHelper, string name, IEnumerable<MultiListInfo> listInfo, object htmlAttributes, bool Optional, string OptionalPrefix = "Select All")
        {
            StringBuilder sb = new StringBuilder();

            if (Optional)
            {
                string optTagNm = "am" + name.Substring(1);
                TagBuilder ulOptTag = new TagBuilder("ul");
                TagBuilder liOptTag = new TagBuilder("li");
                liOptTag.SetInnerText(OptionalPrefix);
                liOptTag.MergeAttribute("class", "btn btn-default");
                ulOptTag.InnerHtml = liOptTag.ToString();
                ulOptTag.MergeAttribute("class", "list-unstyled");
                ulOptTag.MergeAttribute("id", optTagNm);
                ulOptTag.MergeAttribute("name", optTagNm);
                sb.Append(ulOptTag.ToString(TagRenderMode.Normal));
            }

            TagBuilder divTag = new TagBuilder("div");
            TagBuilder ulTag = new TagBuilder("ul");
            var liTags = "";
            foreach (MultiListInfo info in listInfo)
            {
                TagBuilder liTag = new TagBuilder("li");
                TagBuilder spanTag = new TagBuilder("span");
                spanTag.MergeAttributes<string, object>((IDictionary<string, object>)HtmlHelper.AnonymousObjectToHtmlAttributes("style=\"padding:0px 8px;\""));
                spanTag.SetInnerText(info.DisplayText);
                liTag.MergeAttribute("value", info.Value);
                liTag.MergeAttribute("text", info.DisplayText);

                if (info.Seq != -999)
                    liTag.MergeAttribute("seq", info.Seq.ToString());

                liTag.SetInnerText(info.DisplayText);
                liTag.MergeAttribute("class", "btn btn-default");
                liTags += liTag.ToString(TagRenderMode.Normal) + "\n";
            }
            ulTag.InnerHtml = liTags.ToString();
            ulTag.MergeAttribute("id", name);
            ulTag.MergeAttribute("name", name);
            IDictionary<string, object> htmlAttributes1 = (IDictionary<string, object>)HtmlHelper.AnonymousObjectToHtmlAttributes(htmlAttributes);
            ulTag.MergeAttributes<string, object>(htmlAttributes1);
            divTag.InnerHtml = ulTag.ToString();
            string divTagNm = "dm" + name.Substring(1);
            divTag.MergeAttribute("id", divTagNm);
            sb.Append(divTag.ToString(TagRenderMode.Normal));
            return MvcHtmlString.Create(sb.ToString());
        }

        public static List<List<T>> ChunkBy<T>(this List<T> source, int chunkSize)
        {
            return source
                .Select((x, i) => new { Index = i, Value = x })
                .GroupBy(x => x.Index / chunkSize)
                .Select(x => x.Select(v => v.Value).ToList())
                .ToList();
        }

        public static string RootUrl(this string ReqUrl)
        {
            var segments = ReqUrl.Split(new char[] { '/' }).ToArray().Reverse().Skip(2).Reverse();

            return string.Join("/", segments);
        }

        public static string GetIPAddress()
        {
            System.Web.HttpContext context = System.Web.HttpContext.Current;
            string ipAddress = context.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (!string.IsNullOrEmpty(ipAddress))
            {
                string[] addresses = ipAddress.Split(',');
                if (addresses.Length != 0)
                {
                    return addresses[0];
                }
            }

            return context.Request.ServerVariables["REMOTE_ADDR"];
        }
    }
}