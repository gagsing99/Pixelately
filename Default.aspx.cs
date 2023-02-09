using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;

public partial class Default : System.Web.UI.Page
{

    public static string getUserID()
    {
        string ID = RemoveDomain(HttpContext.Current.User.Identity.Name).ToLower();
        if (ID == "")
        {
            ID = Environment.UserName;
        }
        return ID;
    }

    public static string RemoveDomain(string userName)
    {
        if (userName.Contains("\\"))
        {
            return userName.Split('\\')[1];
        }
        else
        {
            return userName;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [System.Web.Services.WebMethod]
    public static string GetData()
    {
        string constring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constring))
        {
            using (SqlCommand cmd = new SqlCommand("spGetDataForPixelately", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@userID", getUserID());

                using (SqlDataReader sdr = cmd.ExecuteReader())
                {

                    if (sdr.HasRows)
                    {
                        sdr.Read();
                        return string.Format("{0};{1};{2};{3};{4}", sdr["id"], sdr["imageURl"], sdr["imageAnswer"], sdr["timeTaken"], sdr["SavedID"]);
                    }
                    else
                        return "Game record exists";

                    sdr.Close();
                }
                con.Close();
            }
        }


    }





    [System.Web.Services.WebMethod]
    public static void SaveData(string id, float time)
    {
        string constring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constring))
        {
            using (SqlCommand cmd = new SqlCommand("spSavePixelatelyUserdata", con)) //spSavePixelatelyUserdata
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@userID", getUserID());
                cmd.Parameters.AddWithValue("@ImageNumber", id);
                cmd.Parameters.AddWithValue("@TimeTaken", time);

                cmd.ExecuteNonQuery();
                con.Close();
            }
        }


    }
}