﻿using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Data.Entity;
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
    public class EditStudentsVM : BaseVM
    {
        private SchoolEntities3 context = new SchoolEntities3();
        public ObservableCollection<USER> Students { get; set; }

        private USER selectedUser;
        public USER SelectedUser
        {
            get { return selectedUser; }
            set
            {
                if (selectedUser != value)
                {
                    selectedUser = value;
                    NotifyPropertyChanged(nameof(SelectedUser));
                }
            }
        }

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
        public EditStudentsVM()
        {
            LoadStudents();
        }

        public ICommand CreateUserCommand => new RelayCommand(CreateUser);

        private void CreateUser()
        {
            if (Name != null)
            {
                string username = Name.Replace(" ", "").ToLower();
                string password = username + "123";
                int typeId = 1;

                USER newUser = new USER()
                {
                    Name = Name,
                    Password = password,
                    Username = username,
                    UserTypeId = typeId
                };

                Students.Add(newUser);
                context.AddUser(Name, username, password, typeId);
            }
            else
            {
                MessageBox.Show("You can't create a user without a name!");
            }
        }

        public ICommand DeleteUserCommand => new RelayCommand(DeleteUser);
        private void DeleteUser()
        {
            context.DeleteUser(SelectedUser.UserId);
            Students.Remove(SelectedUser);
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