using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using WebInventory.Models;
using System.Data;
using WebInventory.Common;
using WebInventory.Filters;
using System;

namespace WebInventory.Controllers
{
    public class InventorySearchController : Controller
    {
        private Dictionary<string, string> ProcGroup(DataTable ProcessTable, string pProcType)
        {
            return ProcessTable.AsEnumerable().Where(r => r.Field<string>("PROCGROUP") == pProcType).Select(r => new
            {
                Value = r.Field<string>("PROCNM"),
                Key = r.Field<string>("PROCNM")
            }).ToDictionary(t => t.Key, t => t.Value);
        }

        private IEnumerable<SelectListCodeItem> ProcGroupSeq(DataTable ProcessTable, string pProcType)
        {
            return ProcessTable.AsEnumerable().Where(r => r.Field<string>("PROCGROUP") == pProcType).Select(r => new SelectListCodeItem
            {
                Value = r.Field<string>("PROCNM"),
                Text = r.Field<string>("PROCNM"),
                Seq = r.Field<decimal>("ORD")
            });
        }

        private IEnumerable<MultiListInfo> ProcGroupCbl(DataTable ProcessTable, string pProcType)
        {
            return ProcessTable.AsEnumerable().Where(r => r.Field<string>("PROCGROUP") == pProcType).Select(r =>
                 new MultiListInfo(r.Field<string>("PROCNM"), r.Field<string>("PROCNM"), null, false));
        }

        private IEnumerable<MultiListInfo> ProcGroupSeqCbl(DataTable ProcessTable, string pProcType)
        {
            return ProcessTable.AsEnumerable().Where(r => r.Field<string>("PROCGROUP") == pProcType).Select(r =>
                 new MultiListInfo(r.Field<string>("PROCNM"), r.Field<string>("PROCNM"), r.Field<decimal>("ORD"), false));
        }

        private IEnumerable<SelectListItem> GetSavedList(DataTable ClientSavedList)
        {
            return ClientSavedList.AsEnumerable().Select(dr => (
                new SelectListItem { Text = dr.Field<string>("SEARCHNAME"), Value = Convert.ToString(dr.Field<decimal>("SID")) }));
        }

        private Dictionary<string, string> ShowOnlyList()
        {
            Dictionary<string, string> lis = new Dictionary<string, string>();
            lis.Add("Available", "A");
            lis.Add("UnAvailable", "U");
            lis.Add("New Arrival", "N");
            lis.Add("New Arrival + Available", "NA");
            lis.Add("New Arrival + UnAvailable", "NU");
            lis.Add("New Cert", "NC");
            return lis;
        }

        //
        // GET: /home/
        [HttpGet]
        [ValidateUserAttribute]
        public ActionResult Index()
        {
            ProcMas procMas = new ProcMas();
            DataTable processes = procMas.GetProcesses();
            DataTable ClientSavedList = procMas.GetClientSavedList(Convert.ToString(Session["Clientcd"]));
            ViewData["Shape"] = ProcGroup(processes, "SHAPE");
            ViewData["Color"] = ProcGroupSeq(processes, "COLOR");
            ViewData["Clarity"] = ProcGroupSeq(processes, "CLARITY");
            ViewData["Cut"] = ProcGroupSeq(processes, "CUT");
            ViewData["Polish"] = ProcGroupSeq(processes, "POLISH");
            ViewData["Sym"] = ProcGroupSeq(processes, "SYM");
            ViewData["Fl"] = ProcGroupSeq(processes, "FLOURENCE");
            ViewData["Certificate"] = ProcGroup(processes, "CERTIFICATE");
            ViewData["Location"] = ProcGroup(processes, "LOCATION");
            ViewData["Girdle"] = ProcGroupSeq(processes, "GIRDLE");
            ViewData["Culet"] = ProcGroupSeq(processes, "CULET");

            ViewData["MColor"] = ProcGroupSeqCbl(processes, "COLOR");
            ViewData["MClarity"] = ProcGroupSeqCbl(processes, "CLARITY");
            ViewData["MCut"] = ProcGroupSeqCbl(processes, "CUT");
            ViewData["MPolish"] = ProcGroupSeqCbl(processes, "POLISH");
            ViewData["MSym"] = ProcGroupSeqCbl(processes, "SYM");
            ViewData["MFl"] = ProcGroupSeqCbl(processes, "FLOURENCE");

            ViewData["SHOW_ONLY"] = ShowOnlyList();
            ViewData["SAVED_LIST"] = GetSavedList(ClientSavedList);

            if (Session["dicSearchParams"] != null)
            {
                Dictionary<string, string> dicSearchParams;
                dicSearchParams = (Dictionary<string, string>)Session["dicSearchParams"];
                var srcparams = string.Join("@", dicSearchParams.Select(x => x.Key + ":" + x.Value).ToArray());
                TempData["callbackSearchParams"] = srcparams;
            }

            return View();
        }

        string resVal = null;
        string retVal = null;

        [HttpPost]
        [ValidateUserAttribute]
        public ActionResult Index(string[][] invokers, string srcparam)
        {
            retVal = string.Empty;
            Dictionary<string, string> dicSearchParams = new Dictionary<string, string>();
            if (invokers != null)
            {
                if (invokers.Length > 0)
                {
                    int maxSelections = invokers.Length;
                    foreach (string[] item in invokers)
                    {
                        string vKey = item[0];
                        string vVal = item[1];

                        /*----------------------------------------------------------store to web call backs*/
                        dicSearchParams.Add(vKey, vVal);

                        /*----------------------------------------------------------generate where clause*/
                        if (!string.IsNullOrEmpty(vKey) && !string.IsNullOrEmpty(vVal))
                            OperatorHelper.whereBuilder(item, ref resVal);
                    }

                    Int32 SearchId = InventoryModel.SaveSearchParams(invokers, "N", Convert.ToString(Session["Clientcd"]));
                }
            }

            Session["searchQuery"] = resVal;

            Session["dicSearchParams"] = dicSearchParams;

            Session["searchParams"] = srcparam;
            //to clear previous search results...
            Session["MainData"] = null;
            return RedirectToAction("Index", "InventoryResults");
            //return Json(Url.Action("Index", "InventoryResults")); 
        }

        [HttpPost]
        [ValidateUserAttribute]
        public ActionResult SaveSearch(string[][] invokers, string srcname)
        {
            Int32 retval = -1;
            if (invokers != null)
            {
                if (invokers.Length > 0)
                {
                    int maxSelections = invokers.Length;
                    foreach (string[] item in invokers)
                    {
                        string vKey = item[0];
                        string vVal = item[1];

                        /*----------------------------------------------------------generate where clause*/
                        if (!string.IsNullOrEmpty(vKey) && !string.IsNullOrEmpty(vVal))
                            OperatorHelper.whereBuilder(item, ref resVal);
                    }

                    retval = InventoryModel.SaveSearchParams(invokers, "Y", Convert.ToString(Session["Clientcd"]), srcname);
                }
            }

            return Json(retval, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult IndexReset()
        {
            Session["dicSearchParams"] = null;
            return Json(@Url.Action("Index", "InventorySearch"), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult SetSavedList(string sid, string sname)
        {
            if ((sid == null || sid == "") && (sname == null || sname == "SAVED LIST")) { return Json(new { retval = "0" }); }
            Dictionary<string, string> savedParams = InventoryModel.GetSavedListCollection(Convert.ToString(Session["Clientcd"]), sid, sname);
            string retString = InventoryModel.SetSavedSearchParams(savedParams);
            return Json(new { retval = "1", Results = retString }, JsonRequestBehavior.AllowGet);
        }
    }
}