using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.IO;
using OfficeOpenXml;

namespace WebInventory.Common
{
    public class XlsxToDatatable
    {
        public static DataTable GenerateDataTable(string filePath)
        {
            DataTable dt = new DataTable();

            FileInfo fi = new FileInfo(filePath);

            // Check if the file exists
            if (!fi.Exists)
                throw new Exception("File " + filePath + " Does Not Exists");

            using (ExcelPackage xlPackage = new ExcelPackage(fi))
            {
                // get the first worksheet in the workbook

                ExcelWorksheet worksheet = xlPackage.Workbook.Worksheets.First();

                //// Fetch the WorkSheet size
                //ExcelCellAddress startCell = worksheet.Dimension.Start;
                //ExcelCellAddress endCell = worksheet.Dimension.End;

                //// create all the needed DataColumn
                //for (int col = startCell.Column; col <= endCell.Column; col++)
                //    dt.Columns.Add(col.ToString());

                bool hasHeader = true; // adjust it accordingly( i've mentioned that this is a simple approach)
                foreach (var firstRowCell in worksheet.Cells[1, 1, 1, worksheet.Dimension.End.Column])
                {
                    dt.Columns.Add(hasHeader ? firstRowCell.Text.ToUpper() : string.Format("Column {0}", firstRowCell.Start.Column));
                }

                var startRow = hasHeader ? 2 : 1;

                // place all the data into DataTable
                for (var rowNum = startRow; rowNum <= worksheet.Dimension.End.Row; rowNum++)
                {
                    var wsRow = worksheet.Cells[rowNum, 1, rowNum, worksheet.Dimension.End.Column];
                    var row = dt.NewRow();
                    foreach (var cell in wsRow)
                    {
                        row[cell.Start.Column - 1] = cell.Text;
                    }
                    dt.Rows.Add(row);
                }
            }
            return dt;
        }

        public static List<string> GetExcelFileHeaders(string path)
        {
            List<string> ExcelColumns = new List<string>();
            if (System.IO.File.Exists(path))
            {
                DataTable dt = XlsxToDatatable.GenerateDataTable(path);

                ExcelColumns = (from colNm in dt.Columns.Cast<DataColumn>()
                                select colNm.ColumnName).ToList();

            }
            return ExcelColumns;
        }

        public static DataTable GetExcelColumnMapper()
        {
            string vQry = "SELECT COLUMN_NAME,SHOWCOLUMN_NAME,ISREQUIRED,ORD, COLUMN_MAPPING FROM UPLOAD_EXCEL_FORMAT ORDER BY ORD";
            return ComFunc.excDataTable(vQry, null, CommandType.Text);
        }
    }

    public class ExcelFormatter
    {
        public string ColumnName { get; set; }
        public string ShowColumnName { get; set; }
        public bool IsRequired { get; set; }
        public decimal Ord { get; set; }
        public string[] MatchCols { get; set; }
    }
}