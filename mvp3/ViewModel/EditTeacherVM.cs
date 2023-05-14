using System;
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
        private SchoolEntities4 context = new SchoolEntities4();
        public ObservableCollection<USER> Teachers { get; set; }
        public ObservableCollection<CLASSROOM> Classrooms { get; set; }
        public ObservableCollection<SUBJECT> Subjects { get; set; }
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

        private CLASSROOM selectedClassroom;
        public CLASSROOM SelectedClassroom
        {
            get { return selectedClassroom; }
            set
            {
                selectedClassroom = value;
                NotifyPropertyChanged(nameof(SelectedClassroom));
            }
        }
        public void LoadClassrooms()
        {
            var result = context.GetAllClassrooms();

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

        public ICommand CreateTeacherClassroomLinkCommand => new RelayCommand(CreateTeacherClassroomLink);

        private void CreateTeacherClassroomLink()
        {
            context.AddTeacherClassroomLink(SelectedTeacher.UserId, SelectedClassroom.ClassroomId);
        }

        public ICommand MakeClassmasterCommand => new RelayCommand(MakeClassmaster);

        private void MakeClassmaster()
        {
            context.AddClassMasterClassroomLink(SelectedTeacher.UserId, SelectedClassroom.ClassroomId);

            if (SelectedTeacher != null)
            {
                string username = SelectedTeacher.Name.Replace(" ", "").ToLower() + "@dirig.ro";
                string password = SelectedTeacher.Name.Replace(" ", "").ToLower() + "123";
                int typeId = 3;

                USER newUser = new USER()
                {
                    Name = Name,
                    Password = password,
                    Username = username,
                    UserTypeId = typeId
                };

                context.AddUser(SelectedTeacher.Name, username, password, typeId);
            }
        }

        public ICommand RemoveTeacherClassroomLinkCommand => new RelayCommand(RemoveTeacherFromClassroom);

        private void RemoveTeacherFromClassroom()
        {
            context.DeleteTeacherClassroomLink(SelectedTeacher.UserId, SelectedClassroom.ClassroomId);
        }

        public ICommand AssignTeacherToSubjectCommand => new RelayCommand(AssignTeacherToSubject);

        private void AssignTeacherToSubject()
        {
            context.AddSubjectTeacherLink(SelectedSubject.SubjectId, SelectedTeacher.UserId);
        }

        public ICommand RemoveTeacherSubjectCommand => new RelayCommand(RemoveTeacherSubjectLink);

        private void RemoveTeacherSubjectLink()
        {
            context.DeleteSubjectTeacherLink(SelectedSubject.SubjectId, SelectedTeacher.UserId);
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

        public void LoadSubjects()
        {
            var result = context.GetAllSubjects();

            var subjects = result.Select(r => new SUBJECT
            {
                SubjectId = r.SubjectId,
                Name = r.Name
            })
            .ToList();

            Subjects = new ObservableCollection<SUBJECT>(subjects);
        }


        public EditTeacherVM() 
        {
            LoadTeachers();
            LoadClassrooms();
            LoadSubjects();
        }
    }
}
