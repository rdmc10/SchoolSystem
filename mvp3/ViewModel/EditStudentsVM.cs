using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using mvp3.Helpers;
using mvp3.Model;

namespace mvp3.ViewModel
{
    public class EditStudentsVM : BaseVM
    {
        private SchoolEntities3 context = new SchoolEntities3();
        public ObservableCollection<USER> Students { get; set; }

        public EditStudentsVM()
        {
            LoadStudents();
        }

        public void LoadStudents()
        {
            var result = context.GetAllUsers();

            var users = result
                .Where(r => r.UserTypeId == 1)
                .Select(r => new USER
                {
                    UserId = r.UserId,
                    UserTypeId = r.UserTypeId,
                    Username = r.Username,
                    Name = r.Name,
                    Password = r.Password
                }) 
                .ToList();

            Students = new ObservableCollection<USER>(users);
        }

    }
}
