namespace ErrorTracking.Repository.DbHelpers
{
    public class DbResult
    {
        public DbResult() { }

        public string ErrorCode { set; get; } = "1";

        public string Msg { set; get; } = "Error";

        public string Id { set; get; } = "0";

        public string Extra { set; get; } = "";

        public string Extra2 { get; set; }

        public void SetError(string errorCode, string msg, string id)
        {
            ErrorCode = errorCode;
            Msg = msg;
            Id = id;
        }
    }
}