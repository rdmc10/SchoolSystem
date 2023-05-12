using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;
using GalaSoft.MvvmLight.Command;
using mvp3.Helpers;
using System.Configuration;
using mvp3.Model;
using mvp3.View;

namespace mvp3.ViewModel
{
    public class LoginVM : BaseVM
    {
        private SchoolEntities3 context = new SchoolEntities3();
        private string _username {  get; set; }
        public string Username
        {
            get { return _username; }
            set
            {
                _username = value;
                NotifyPropertyChanged(nameof(Username));
            }
        }
        private string _passwd {  get; set; }
        public string Password
        {
            get { return _passwd; }
            set
            {
                _passwd = value;
                NotifyPropertyChanged(nameof(Password));
            }
        }

        public List<USER> GetAllUsers()
        {
            var result = context.GetAllUsers();
            List<USER> users = result.Select(r => new USER
            {
                UserId = r.UserId,
                Username = r.Username,
                Password = r.Password,
                Name = r.Name,
                UserTypeId = r.UserTypeId
            }).ToList();

            return users;
        }

        public bool UsernameAlreadyExists(string username)
        {
            bool usernameExists = GetAllUsers().Any(u => u.Username == username);
            return usernameExists;
        }

        public ICommand LoginCommand => new RelayCommand(Login);
        private void Login()
        {
            var user = context.GetUser(Username, Password).FirstOrDefault();

            if (user != null)
            {
                int usertype = user.UserTypeId;
                switch (usertype)
                {
                    case 1:
                        MessageBox.Show(usertype.ToString());
                        break;
                    case 2:
                        break;
                    case 3:
                        break;
                    case 4:
                        AdminWindow adminWindow = new AdminWindow();
                        adminWindow.ShowDialog();
                        break;
                }
            }
            else
            {
                if (UsernameAlreadyExists(Username))
                {
                    MessageBox.Show("Wrong password!");
                }
            }
        }

        public ICommand CheckConCommand => new RelayCommand(CheckConnection);
        private void CheckConnection()
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString))
                {
                    try
                    {
                        connection.Open();
                        if (connection.State == ConnectionState.Open) // if connection.Open was successful
                        {
                            MessageBox.Show("Successful DB connection!");
                        }
                        else
                        {
                            MessageBox.Show("Connection failed.");
                        }
                    }
                    catch (SqlException) { }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR" + ex);
            }
        }


    }
}
