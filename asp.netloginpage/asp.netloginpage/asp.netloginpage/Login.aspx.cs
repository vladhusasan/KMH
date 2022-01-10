using System;
using System.Net.Http;
using System.Net.Http.Headers;
namespace asp.netloginpage
{
    public partial class Login : System.Web.UI.Page
    {
        Server server = new Server();
        protected void Page_Load(object sender, EventArgs e)
        {
            lblErrorMessage.Visible = false;
        }
        //functie de login(user, parola) async ->(asta inb functia de login if status=200,ce contine un body: [{nume:nuem,parola:,eraore:,}]-json decoede to a calss, clasa user)->  return user
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Session["user"] = server.Login_POST_Request(txtUserName.Text, txtPassword.Text);
            Session["server"] = server;
            Response.Redirect("Dashboard.aspx");
            /*}
            else { lblErrorMessage.Visible = true; }
        }*/
        }
        protected void btnLogin_Click1(object sender, EventArgs e)
        {
            Response.Redirect("createUser.aspx");
            
            /* //GET
             HttpClient client = new HttpClient();
             client.BaseAddress = new Uri("http://18.196.30.43:1997/");
             // Add an Accept header for JSON format.
             client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
             // List all Names.
             HttpResponseMessage response = client.GetAsync("/user").Result;  // Blocking call!
             if (response.IsSuccessStatusCode)
             {
                 var products = response.Content.ReadAsStringAsync().Result;
                 Session["user"] = products;
                 Response.Redirect("Dashboard.aspx");
             }
             else
             {
                 Console.WriteLine("{0} ({1})", (int)response.StatusCode, response.ReasonPhrase);
             }
             /*
                 //Post
                 var user = new User("John Doe", "gardener");

                var json = JsonSerializer.Serialize(user);
                 var data = new StringContent(json, Encoding.UTF8, "application/json");

                var url = "https://httpbin.org/post";
                 using var client = new HttpClient();

                var response = await client.PostAsync(url, data);

                 string result = response.Content.ReadAsStringAsync().Result;
                 Console.WriteLine(result);
                 /*}
                 else { lblErrorMessage.Visible = true; }
             }*/
        }
    }
    public class User
    {
        public string nume { get; set; }
        public string parola { get; set; }
        public User(string nume,string parola)
        {
            this.nume = nume;
            this.parola = parola;
        }
        public String getNume() { return this.nume; }
    }
    
    public class Locatie
    {
        public double latitudine { get; set; }
        public double longitudine { get; set; }
        public string nume { get; set; }
        public int puncte { get; set; }
        public Locatie(double latitudine,double longitudine,string nume,int puncte)
        {
            this.latitudine = latitudine;
            this.longitudine = longitudine;
            this.nume = nume;
            this.puncte = puncte;
        }
    }
    


}