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
    public class TeacherWindowVM : BaseVM
    {
        public ObservableCollection<CLASSROOM> Classrooms { get; set; }
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

        private SchoolEntities4 context = new SchoolEntities4();

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

        private USER Teacher { get; set; }
        public TeacherWindowVM()
        {
        }    

        public TeacherWindowVM(USER teacher)
        {
            Teacher = teacher;
            LoadClassrooms();
        }    

        public void LoadStudents()
        {
            var result = context.GetStudentsFromClassroom(SelectedClassroom.ClassroomId);

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

        private CLASSROOM selectedClassroom;
        public CLASSROOM SelectedClassroom
        {
            get { return selectedClassroom; }
            set
            {
                selectedClassroom = value;
                NotifyPropertyChanged(nameof(SelectedClassroom));
                LoadStudents();
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

        public ICommand StartMarksCommand => new RelayCommand(StartMarks);
        private void StartMarks()
        {
            EditMarksVM emvm = new EditMarksVM(SelectedSubject, SelectedStudent);
            EditMarksWindow emw = new EditMarksWindow();
            emw.DataContext = emvm;
            emw.ShowDialog();
        }
        public ICommand StartAbsencesCommand => new RelayCommand(StartAbsences);
        private void StartAbsences()
        {
            EditAbsencesVM eavm = new EditAbsencesVM(SelectedSubject, SelectedStudent);
            EditAbsencesWindow eaw = new EditAbsencesWindow();
            eaw.DataContext = eavm;
            eaw.ShowDialog();
        }

        public void LoadClassrooms()
        {
            var result = context.GetTeachersClassrooms(Teacher.UserId);

            var classes = result.Select(r => new CLASSROOM
            {
                ClassroomId = r.ClassroomId,
                SpecializationId = r.SpecializationId,
                Year = r.Year,
                Name = r.Name
            })
            .ToList();

            Classrooms = new ObservableCollection<CLASSROOM>(classes);
        }

        public void LoadSubjects()
        {
            var result = context.GetSubjectsForTeacherForSelectedClassroom(Teacher.UserId, SelectedClassroom.ClassroomId);

            var subjs = result.Select(r => new SUBJECT
            {
                SubjectId = r.SubjectId,
                Name = r.Name
            })
            .ToList();

            Subjects = new ObservableCollection<SUBJECT>(subjs);
        }
    }
}
