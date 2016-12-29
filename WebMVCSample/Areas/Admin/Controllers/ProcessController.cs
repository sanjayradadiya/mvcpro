using System;
using System.Data;
using System.Linq;
using System.Web.Mvc;
using WebInventory.Areas.Admin.Models;
using WebInventory.Areas.Admin.ViewModels;
using WebInventory.Common;
using WebInventory.Filters;

namespace WebInventory.Areas.Admin.Controllers
{
    public class ProcessController : Controller
    {
        //
        // GET: /Admin/Process/
        /*----------------------------------------------------------process master*/
        #region ProcessMaster
        public ActionResult Processes()
        {
            Session["ProcMas"] = null;
            ViewBag.ProcessGrp = ProcessMaster.GetProcGroups();
            return View();
        }

        [HttpPost]
        [ActionName("Processes")]
        public ActionResult Processes_Post(JQueryDataTableParamModel param, string searchParams)
        {
            var procGrp = Convert.ToString(Request["procGrp"]);
            param = param ?? new JQueryDataTableParamModel();

            ProcessMaster processMaster = new ProcessMaster();
            DataTable procData = null;
            DataTable filteredData = null;

            if (Session["ProcMas"] == null)
            {
                procData = processMaster.GetProcDetails();
                Session["ProcMas"] = procData;
            }
            //else
            //{
            procData = (DataTable)Session["ProcMas"];
            if (!string.IsNullOrEmpty(procGrp))
            {
                var rows = procData.AsEnumerable().Where(dr => dr.Field<string>("PROCGROUP") == procGrp);
                filteredData = rows.Any() ? rows.CopyToDataTable() : procData.Clone();
            }
            else
            {
                filteredData = procData;
            }
            //}

            var pdPageData = filteredData.Select().Skip(param.iDisplayStart).Take(param.iDisplayLength);
            var pdResults = pdPageData.Select(dr => dr.ItemArray.Select(x => Convert.ToString(x)).ToArray()).ToList();

            return Json(new
            {
                sEcho = param.sEcho,
                iTotalRecords = filteredData.Rows.Count,
                iTotalDisplayRecords = filteredData.Rows.Count,
                aaData = pdResults,
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult HandleProcesses(ProcMasVM procMasObj, string procflag)
        {
            if (procflag == "0") procMasObj.PrcId = 0;
            if (ModelState.IsValid)
            {
                int resval = 0;

                switch (procflag)
                {
                    case "0": resval = ProcessMaster.AddProcDets(procMasObj); break;
                    case "1": resval = ProcessMaster.UpdateProcDets(procMasObj); break;
                    case "2": resval = ProcessMaster.DeleteProcDets(procMasObj); break;
                    default: resval = -1; break;
                }

                if (resval > -1) { Session["ProcMas"] = null; }

                switch (resval)
                {
                    case 0: return Json(new { isError = false, msg = "Process Details has been added successfully", url = @Url.Action("Processes", "Process") }, JsonRequestBehavior.AllowGet);
                    case 1: return Json(new { isError = false, msg = "Process Details has been modified successfully", url = @Url.Action("Processes", "Process") }, JsonRequestBehavior.AllowGet);
                    case 2: return Json(new { isError = false, msg = "Process Details has been deleted successfully", url = @Url.Action("Processes", "Process") }, JsonRequestBehavior.AllowGet);
                    default: return Json(new { isError = true, msg = "Something went wrong, Please try again", url = @Url.Action("Processes", "Process") }, JsonRequestBehavior.AllowGet);
                }

            }
            else
            {
                return Json(new { isError = true, msg = "Something went wrong, Please try again", url = @Url.Action("Processes", "Process") }, JsonRequestBehavior.AllowGet);
            }
        }

        #endregion

        /*----------------------------------------------------------color master*/
        #region ColorMaster

        public ActionResult ColorDets()
        {
            Session["ColorMas"] = null;
            ViewBag.ProcessGrp = ProcessMaster.GetProcGroups();
            return View();
        }

        [HttpPost]
        [ValidateUser]
        [ActionName("ColorDets")]        
        public ActionResult ColorDets_Post(JQueryDataTableParamModel param, string searchParams)
        {
            var isFancy = Convert.ToString(Request["isfancy"]);
            param = param ?? new JQueryDataTableParamModel();

            ProcessMaster processMaster = new ProcessMaster();
            DataTable procData = null;
            DataTable filteredData = null;

            if (Session["ColorMas"] == null)
            {
                procData = processMaster.GetColorDetails();
                Session["ColorMas"] = procData;
            }
            //else
            //{
            procData = (DataTable)Session["ColorMas"];
            if (!string.IsNullOrEmpty(isFancy))
            {
                var rows = procData.AsEnumerable().Where(dr => dr.Field<string>("ISFANCY") == isFancy);
                filteredData = rows.Any() ? rows.CopyToDataTable() : procData.Clone();
            }
            else
            {
                filteredData = procData;
            }
            //}

            var pdPageData = filteredData.Select().Skip(param.iDisplayStart).Take(param.iDisplayLength);
            var pdResults = pdPageData.Select(dr => dr.ItemArray.Select(x => Convert.ToString(x)).ToArray()).ToList();

            return Json(new
            {
                sEcho = param.sEcho,
                iTotalRecords = filteredData.Rows.Count,
                iTotalDisplayRecords = filteredData.Rows.Count,
                aaData = pdResults,
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        [ValidateUser]
        public ActionResult HandleColors(ColorProcMasVM procMasObj, string procflag)
        {
            if (procflag == "0") procMasObj.PrcId = 0;
            if (ModelState.IsValid)
            {
                int resval = 0;

                switch (procflag)
                {
                    case "0": resval = ProcessMaster.AddColorDets(procMasObj); break;
                    case "1": resval = ProcessMaster.UpdateColorDets(procMasObj); break;
                    case "2": resval = ProcessMaster.DeleteColorDets(procMasObj); break;
                    default: resval = -1; break;
                }

                if (resval > -1) { Session["ColorMas"] = null; }

                switch (resval)
                {
                    case 0: return Json(new { isError = false, msg = "Process Details has been added successfully", url = @Url.Action("Processes", "Process") }, JsonRequestBehavior.AllowGet);
                    case 1: return Json(new { isError = false, msg = "Process Details has been modified successfully", url = @Url.Action("Processes", "Process") }, JsonRequestBehavior.AllowGet);
                    case 2: return Json(new { isError = false, msg = "Process Details has been deleted successfully", url = @Url.Action("Processes", "Process") }, JsonRequestBehavior.AllowGet);
                    default: return Json(new { isError = true, msg = "Something went wrong, Please try again", url = @Url.Action("Processes", "Process") }, JsonRequestBehavior.AllowGet);
                }

            }
            else
            {
                return Json(new { isError = true, msg = "Something went wrong, Please try again", url = @Url.Action("Processes", "Process") }, JsonRequestBehavior.AllowGet);
            }
        }

        #endregion
    }
}
