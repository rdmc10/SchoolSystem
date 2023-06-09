﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using GalaSoft.MvvmLight.Command;
using mvp3.Helpers;
using mvp3.View;

namespace mvp3.ViewModel
{
    public class AdminWindowVM : BaseVM
    {
        public ICommand EditStudentsCommand => new RelayCommand(EditStudents);
        private void EditStudents() 
        {
            EditStudentsWindow editStudentsWindow = new EditStudentsWindow();
            editStudentsWindow.ShowDialog();
        }
        public ICommand EditTeachersCommand => new RelayCommand(EditTeachers);
        private void EditTeachers() 
        {
            EditTeacherWindow editTeacherWindow = new EditTeacherWindow();
            editTeacherWindow.ShowDialog(); 
        }
        public ICommand EditClassroomsCommand => new RelayCommand(EditClassrooms);
        private void EditClassrooms() 
        {
            EditClassroomWindow editClassroomWindow = new EditClassroomWindow();
            editClassroomWindow.ShowDialog();
        }

        public ICommand AddClassroomsCommand => new RelayCommand(AddClassrooms);

        private void AddClassrooms()
        {
            AddClassroomWindow addClassroomWindow = new AddClassroomWindow();
            addClassroomWindow.ShowDialog();
        }

    }
}
