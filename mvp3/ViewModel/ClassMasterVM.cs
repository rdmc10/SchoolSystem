using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using GalaSoft.MvvmLight.Command;
using mvp3.Helpers;
using mvp3.Model;
using mvp3.View;

namespace mvp3.ViewModel
{
    public class ClassMasterVM : BaseVM
    {
        private SchoolEntities4 context = new SchoolEntities4();

        public string HeaderString { get; set; }
        public ClassMasterVM() { }  

        private ObservableCollection<USER> students = new ObservableCollection<USER>();
        public ObservableCollection<USER> Students
        {
            get { return students; }
            set
            {
                students = value;
                NotifyPropertyChanged(nameof(Students));
            }
        }

        private USER selectedStudent;
        public USER SelectedStudent
        {
            get { return selectedStudent; }
            set
            {
                if (selectedStudent != value)
                {
                    selectedStudent = value;
                    NotifyPropertyChanged(nameof(SelectedStudent));
                    LoadSubjects();
                }
            }
        }

        public ICommand ViewAbsencesCommand => new RelayCommand(ViewAbsences);

        private void ViewAbsences()
        {
            EditAbsencesVM eavm = new EditAbsencesVM(SelectedSubject, SelectedStudent);
            EditAbsencesWindow eaw = new EditAbsencesWindow();
            eaw.DataContext = eavm;
            eaw.ShowDialog();
        }
        
        private CLASSROOM Classroom { get; set; }
        private USER Teacher { get; set; }
        public ClassMasterVM(USER teacher)
        {
            Teacher = teacher;
            GetClassroom();
            LoadStudents();
            HeaderString = "Student evidence for class " + Classroom.Name;
        }

        private void GetClassroom()
        {
            var user = context.GetUser(Teacher.Username.Replace("dirig", "prof"), Teacher.Password).FirstOrDefault();

            var result = context.GetClassMasterClassroom(user.UserId);

            var classroom = result.Select(r => new CLASSROOM
            {
                ClassroomId = r.ClassroomId,
                SpecializationId = r.SpecializationId,
                Year = r.Year,
                Name = r.Name,
            }).FirstOrDefault();
            Classroom = classroom;
        }

        public void LoadSubjects()
        {
            if (Classroom == null) return;
            var result = context.GetSubjectsFromClassroom(Classroom.ClassroomId);

            var subjs = result.Select(r => new SUBJECT
            {
                SubjectId = r.SubjectId,
                Name = r.Name
            })
            .ToList();

            Subjects = new ObservableCollection<SUBJECT>(subjs);
        }
        public void LoadStudents()
        {
            if (Classroom == null) return;
            var result = context.GetStudentsFromClassroom(Classroom.ClassroomId);

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

        private SUBJECT selectedSubject;
        public SUBJECT SelectedSubject
        {
            get { return selectedSubject; }
            set
            {
                selectedSubject = value;
                NotifyPropertyChanged(nameof(SelectedSubject));
            }
        }

        private ObservableCollection<SUBJECT> subjects = new ObservableCollection<SUBJECT>();
        public ObservableCollection<SUBJECT> Subjects
        {
            get { return subjects; }
            set
            {
                subjects = value;
                NotifyPropertyChanged(nameof(Subjects));
            }
        }
    }
}
