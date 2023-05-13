﻿using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;
using GalaSoft.MvvmLight.Command;
using mvp3.Helpers;
using mvp3.Model;


namespace mvp3.ViewModel
{
    public class EditTeacherVM : BaseVM
    {
        private SchoolEntities3 context = new SchoolEntities3();
        public ObservableCollection<USER> Teachers { get; set; }
        private string _name { get; set; }
        public string Name
        {
            get { return _name; }
            set
            {
                _name = value;
                NotifyPropertyChanged(nameof(Name));
            }
        }

        public ICommand CreateTeacherCommand => new RelayCommand(CreateTeacher);

        private void CreateTeacher()
        {
            if (Name != null)
            {
                string username = Name.Replace(" ", "").ToLower() + "@prof.ro";
                string password = Name.Replace(" ", "").ToLower() + "123";
                int typeId = 2;

                USER newUser = new USER()
                {
                    Name = Name,
                    Password = password,
                    Username = username,
                    UserTypeId = typeId
                };

                Teachers.Add(newUser);
                context.AddUser(Name, username, password, typeId);
            }
            else
            {
                MessageBox.Show("You can't create a user without a name!");
            }
        }

        public ICommand DeleteTeacherCommand => new RelayCommand(DeleteTeacher);
        private void DeleteTeacher()
        {
            context.DeleteUser(SelectedTeacher.UserId);
            Teachers.Remove(SelectedTeacher);
        }

        private USER selectedTeacher;
        public USER SelectedTeacher
        {
            get { return selectedTeacher; }
            set
            {
                if (selectedTeacher != value)
                {
                    selectedTeacher = value;
                    NotifyPropertyChanged(nameof(SelectedTeacher));
                }
            }
        }
        public void LoadTeachers()
        {
            var result = context.GetAllUsers();

            var users = result
                .Where(r => r.UserTypeId == 2)
                .Select(r => new USER
                {
                    UserId = r.UserId,
                    UserTypeId = r.UserTypeId,
                    Username = r.Username,
                    Name = r.Name,
                    Password = r.Password
                }) 
                .ToList();

            Teachers = new ObservableCollection<USER>(users);
        }


        public EditTeacherVM() 
        {
            LoadTeachers();
        }
    }
}