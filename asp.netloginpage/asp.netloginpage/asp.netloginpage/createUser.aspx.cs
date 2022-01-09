using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.netloginpage
{
    public partial class createUser : System.Web.UI.Page
    {
        Server server = new Server();
        protected void Page_Load(object sender, EventArgs e)
        {
            lblErrorMessage.Visible = false;
        }
        protected void btnCreateClick(object sender, EventArgs e)
        {

            server.User_POST_Request(txtUserName.Text, txtPassword.Text, txtEmail.Text);
            Response.Redirect("Login.aspx");
        }
       
    }
}