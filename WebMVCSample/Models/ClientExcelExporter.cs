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
    public class ClientExcelExporter
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
            p.Workbook.Properties.Title = "Silicon_ClientDetails";
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
                    case "SC_CNT": ColumnTitle = "Cart"; break;
                    case "BR_CNT": ColumnTitle = "Orders"; break;
                    case "WL_CNT": ColumnTitle = "Watchlist"; break;
                    case "STATUSDESC": ColumnTitle = "Status"; break;
                    case "TRACKED_IP": ColumnTitle = "Last Tracked IP"; break;
                    case "APPOINTMENTREQUEST": ColumnTitle = "Appointments"; break;
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

            foreach (DataColumn dc in dt.Columns) //Creating Formula in footers
            {
                colIndex++;
                var cell = ws.Cells[rowIndex + 1, colIndex];

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
                ws.Cells[1, 1].Value = "Silicon Infovision Pvt. Ltd.";
                ws.Cells[1, 1, 1, dt.Columns.Count].Merge = true;
                ws.Cells[1, 1, 1, dt.Columns.Count].Style.Font.Bold = true;
                ws.Cells[1, 1, 1, dt.Columns.Count].Style.Font.Size = 12;
                ws.Cells[1, 1, 1, dt.Columns.Count].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                ws.Cells[1, 1, 1, dt.Columns.Count].Style.Font.Color.SetColor(Color.FromArgb(151, 72, 7));

                int rowIndex = 3;
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
    }
}