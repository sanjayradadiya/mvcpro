
namespace WebInventory.Common
{
    public class JQueryDataTableParamModel
    {
        public string more_data { get; set; }

        public string sEcho { get; set; }
        public string sSearch { get; set; }
        public int iDisplayLength { get; set; }
        public int iDisplayStart { get; set; }
        public int iColumns { get; set; }
        public int iSortingCols { get; set; }
        public string sColumns { get; set; }
        public string oSearch { get; set; }

        public decimal ipTotals { get; set; }
        public decimal igTotals { get; set; }
        public string Greeting { get; set; }
    }

    public class InvnTotals
    {
        public decimal Cts { get; set; }
        public decimal Amount { get; set; }
        public decimal Rate { get; set; }
        public decimal Rrate { get; set; }
        public decimal Disc { get; set; }
    }
}