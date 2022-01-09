using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.netloginpage
{
    public partial class Dashboard : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            User user = (User)Session["user"];
            if (Session["user"] == null)
                Response.Redirect("login.aspx");
            lblUserDetails.Text = "Username : " + user.getNume();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            User user = (User)Session["user"];
            Server server = (Server)Session["server"];
            server.User_Detele_Request(user.nume, user.parola);
            Response.Redirect("Login.aspx");
        }

    }
}