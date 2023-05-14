using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using mvp3.Helpers;
using mvp3.Model;
using GalaSoft.MvvmLight.Command;
using System.Collections.ObjectModel;
using System.Windows.Input;
using System.Net.Mime;

namespace mvp3.ViewModel
{
    public class EditClassroomVM : BaseVM
    {
        private SchoolEntities4 context = new SchoolEntities4();
        public ObservableCollection<CLASSROOM> Classrooms { get; set; }
        public ObservableCollection<SUBJECT> Subjects { get; set; }

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
         
        private string subjectName;
        public string SubjectName
        {
            get { return subjectName; }
            set
            {
                subjectName = value;
                NotifyPropertyChanged(nameof(SubjectName));
            }
        }

        public ICommand AddSubjectToClassromCommand => new RelayCommand(AddSubjectToClassroom);

        private void AddSubjectToClassroom()
        {
            context.AddSubjectClassroomLink(SelectedSubject.SubjectId, SelectedClassroom.ClassroomId , Thesis);
        }

        private bool thesis;
        public bool Thesis
        {
            get { return thesis; }
            set
            {
                if (thesis != value)
                {
                    thesis = value;
                    NotifyPropertyChanged(nameof(Thesis));
                }
            }
        }

        public ICommand AddNewSubjectCommand => new RelayCommand(AddNewSubject);

        private void AddNewSubject()
        {
            context.AddSubject(SubjectName, Thesis);
        }


        public EditClassroomVM()
        {
            LoadClassrooms();
            LoadSubjects();
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

    }
}
