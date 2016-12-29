using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using OfficeOpenXml;
using OfficeOpenXml.Drawing;
using OfficeOpenXml.Style;
using System.Data;
using System.Drawing;
using System.IO;
using System.Globalization;

namespace WebInventory.Models
{
    public class ExcelExporter
    {
        public static ExcelRange FilterFirstCell, FilterLastCell;
        private static int beginRowIndex;
        private static ExcelWorksheet CreateSheet(ExcelPackage p, string sheetName)
        {
            p.Workbook.Worksheets.Add(sheetName);
            ExcelWorksheet ws = p.Workbook.Worksheets[1];
            ws.Name = sheetName; //Setting Sheet's name
            ws.Cells.Style.Font.Size = 10; //Default font size for whole sheet
            ws.Cells.Style.Font.Name = "Cambria"; //Default Font name for whole sheet

            return ws;
        }

        private static void SetWorkbookProperties(ExcelPackage p)
        {
            //Here setting some document properties
            p.Workbook.Properties.Author = "SiliconInfovision";
            p.Workbook.Properties.Title = "Silicon_Inventory";
        }

        private static void CreateHeader(ExcelWorksheet ws, ref int rowIndex, DataTable dt)
        {
            TextInfo textInfo = new CultureInfo("en-US", false).TextInfo;
            int colIndex = 1;
            foreach (DataColumn dc in dt.Columns) //Creating Headings
            {
                var cell = ws.Cells[rowIndex, colIndex];

                if (colIndex == 1) FilterFirstCell = cell;

                //Setting the background color of header cells to Gray
                var fill = cell.Style.Fill;
                fill.PatternType = ExcelFillStyle.Solid;
                //fill.BackgroundColor.SetColor(Color.FromArgb(49, 132, 155));
                fill.BackgroundColor.SetColor(Color.FromArgb(55, 96, 145));

                cell.Style.Font.Bold = true;
                cell.Style.Font.Color.SetColor(Color.White);
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

                //Setting Top/left,right/bottom borders.
                var border = cell.Style.Border;
                border.Bottom.Style = border.Top.Style = border.Left.Style = border.Right.Style = ExcelBorderStyle.Thin;

                //Setting Value in cell
                string ColumnTitle = string.Empty;
                switch (dc.ColumnName.ToUpper())
                {
                    case "CTS": ColumnTitle = "WEIGHT"; break;
                    case "ASKRATE_FC": ColumnTitle = "RATE ($)"; break;
                    case "ASKDISC_FC": ColumnTitle = "DISCOUNT (%)"; break;
                    case "ASKAMT_FC": ColumnTitle = "AMOUNT ($)"; break;
                    case "DIATABLE": ColumnTitle = "TABLE (%)"; break;
                    case "GIRDLEPER": ColumnTitle = "GIRDLE (%)"; break;
                    default: ColumnTitle = dc.ColumnName.ToUpper(); break;
                }

                cell.Value = textInfo.ToTitleCase(ColumnTitle.ToLower());

                FilterLastCell = cell;
                colIndex++;
            }
        }

        private static void CreateData(ExcelWorksheet ws, ref int rowIndex, DataTable dt)
        {
            int colIndex = 0;
            foreach (DataRow dr in dt.Rows) // Adding Data into rows
            {
                colIndex = 1;
                rowIndex++;

                foreach (DataColumn dc in dt.Columns)
                {
                    var cell = ws.Cells[rowIndex, colIndex];

                    var curval = dr[dc.ColumnName];

                    bool isDbNull = Convert.IsDBNull(curval);

                    //Setting Value in cell
                    if (!isDbNull)
                    {
                        switch (dc.DataType.Name.ToLower())
                        {
                            case "int32":
                            case "int":
                                cell.Value = Convert.ToInt32(curval);
                                cell.Style.Numberformat.Format = "00.00"; break;
                            case "double":
                                cell.Value = Convert.ToDouble(curval);
                                cell.Style.Numberformat.Format = "00.00"; break;
                            case "decimal":
                                cell.Value = Convert.ToDecimal(curval);
                                cell.Style.Numberformat.Format = "00.00"; break;
                            default:
                                cell.Value = Convert.ToString(curval);
                                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center; break;
                        }
                    }

                    if (dc.ColumnName.ToLower() == "certificate")
                    {
                        string CertType = Convert.ToString(curval);

                        if (CertType.ToUpper() != "OWN")
                        {
                            cell.Hyperlink = new Uri(SetCetificateURL(CertType, Convert.ToString(dr["CERTINO"]), Convert.ToInt32(dr["CTS"])));
                            cell.Style.Font.Color.SetColor(Color.Blue);
                            cell.Style.Font.UnderLine = true;
                        }

                        cell.Value = Convert.ToString(curval);
                    }

                    //Setting borders of cell
                    var border = cell.Style.Border;
                    border.Left.Style = border.Right.Style = border.Top.Style = border.Bottom.Style = ExcelBorderStyle.Thin;
                    colIndex++;
                }
            }
        }

        private static void CreateFooter(ExcelWorksheet ws, ref int rowIndex, DataTable dt, params string[] columnsToCalutate)
        {
            int colIndex = 0;

            int amtColIndex = dt.Columns["ASKAMT_FC"].Ordinal + 1;
            int ctsColIndex = dt.Columns["CTS"].Ordinal + 1;

            foreach (DataColumn dc in dt.Columns) //Creating Formula in footers
            {
                colIndex++;
                var cell = ws.Cells[rowIndex + 1, colIndex];

                if (columnsToCalutate.Contains(dc.ColumnName))
                {
                    //Setting Sum Formula
                    switch (dc.ColumnName)
                    {
                        case "ASKRATE_FC":
                            //cell.Formula = "Sum(" + ws.Cells[beginRowIndex + 1, colIndex].Address + ":" + ws.Cells[rowIndex, colIndex].Address + ")";
                            cell.Formula = "ROUND(Sum(" + ws.Cells[beginRowIndex + 1, amtColIndex].Address + ":" + ws.Cells[rowIndex, amtColIndex].Address + ") / Sum(" + ws.Cells[beginRowIndex + 1, ctsColIndex].Address + ":" + ws.Cells[rowIndex, ctsColIndex].Address + "), 2)";
                            break;
                        case "ASKDISC_FC":
                            cell.Formula = "Sum(" + ws.Cells[beginRowIndex + 1, colIndex].Address + ":" + ws.Cells[rowIndex, colIndex].Address + ")";
                            break;
                        default:
                            cell.Formula = "Sum(" + ws.Cells[beginRowIndex + 1, colIndex].Address + ":" + ws.Cells[rowIndex, colIndex].Address + ")";
                            break;
                    }
                }
                else
                {
                    cell.Value = "";
                }
                //Setting Background fill color to Gray
                cell.Style.Font.Color.SetColor(Color.White);
                cell.Style.Fill.PatternType = ExcelFillStyle.Solid;
                //cell.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(49, 132, 155));
                cell.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(55, 96, 145));

                //Setting Top/left,right/bottom borders.
                var border = cell.Style.Border;
                border.Bottom.Style = border.Top.Style = border.Left.Style = border.Right.Style = ExcelBorderStyle.Thin;
            }
        }

        public static byte[] GenerateReport(DataTable dataTable, string sheetName)
        {
            using (ExcelPackage p = new ExcelPackage())
            {
                //set the workbook properties and add a default sheet in it
                SetWorkbookProperties(p);
                //Create a sheet
                ExcelWorksheet ws = CreateSheet(p, sheetName);
                DataTable dt = dataTable; //My Function which generates DataTable

                //Merging cells and create a center heading for out table
                //ws.Cells[1, 1].Value = "Silicon Infovision Pvt. Ltd.";
                //ws.Cells[1, 1, 1, dt.Columns.Count].Merge = true;
                //ws.Cells[1, 1, 1, dt.Columns.Count].Style.Font.Bold = true;
                //ws.Cells[1, 1, 1, dt.Columns.Count].Style.Font.Size = 12;
                //ws.Cells[1, 1, 1, dt.Columns.Count].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                //ws.Cells[1, 1, 1, dt.Columns.Count].Style.Font.Color.SetColor(Color.FromArgb(151, 72, 7));

                ws.Cells[1, 1, 4, dt.Columns.Count].Merge = true;
                AddImage(ws, 0, 0, HttpContext.Current.Server.MapPath("~/Content/Images/logo.png"));

                int rowIndex = 5;
                beginRowIndex = rowIndex;

                CreateHeader(ws, ref rowIndex, dt);

                //filteration on number of columns..
                string filtersOn = FilterFirstCell + ":" + FilterLastCell;
                ws.Cells[filtersOn].AutoFilter = true;
                ////ws.Cells[filtersOn].AutoFitColumns();
                //ws.Cells[ws.Dimension.Address].AutoFitColumns();
                ////ws.Cells.AutoFitColumns();
                //freezrow of header
                //ws.View.FreezePanes(rowIndex + 1, dt.Columns.Count);

                //ws.View.FreezePanes(rowIndex + 1, 2);   //for column freeze second argument
                ws.View.FreezePanes(rowIndex + 1, 1);

                CreateData(ws, ref rowIndex, dt);

                //CreateFooter(ws, ref rowIndex, dt);
                CreateFooter(ws, ref rowIndex, dt, "CTS", "ASKAMT_FC", "ASKRATE_FC");

                for (int i = 1; i < dt.Columns.Count + 1; i++)
                {
                    ws.Column(i).AutoFit();
                }


                //ws.Column(7).OutlineLevel = 1;
                //ws.Column(7).Collapsed = true;

                //Generate A File with Random name
                Byte[] bin = p.GetAsByteArray();
                //string file = Guid.NewGuid().ToString() + ".xlsx";
                //File.WriteAllBytes(file, bin);

                return bin;
            }
        }

        private static string SetCetificateURL(string certType, string certNo, decimal? cts = 0)
        {
            switch (certType.ToLower())
            {
                case "gia": return "http://www.gia.edu/cs/Satellite?reportno=" + certNo + "&childpagename=GIA%2FPage%2FReportCheck&pagename=GIA%2FDispatcher&c=Page&cid=1355954554547";
                case "igi": return "http://www.igiworldwide.com/verify.php?r=" + certNo;
                case "hrd": return "https://my.hrdantwerp.com/?record_number=" + certNo + "+&weight=" + cts + "&L=";
                default: return "#";
            }
        }

        private  static void AddImage(ExcelWorksheet oSheet, int rowIndex, int colIndex, string imagePath)
        {
            Bitmap image = new Bitmap(imagePath);
            ExcelPicture excelImage = null;
            if (image != null)
            {
                excelImage = oSheet.Drawings.AddPicture("Debopam Pal", image);
                excelImage.From.Column = colIndex;
                excelImage.From.Row = rowIndex;
                //excelImage.SetSize(100, 100);
                // 2x2 px space for better alignment
                //excelImage.From.ColumnOff = Pixel2MTU(2);
                //excelImage.From.RowOff = Pixel2MTU(2);
            }
        }

        public static int Pixel2MTU(int pixels)
        {
            int mtus = pixels * 9525;
            return mtus;
        }
    }
}