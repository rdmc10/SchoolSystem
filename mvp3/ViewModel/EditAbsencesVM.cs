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

namespace mvp3.ViewModel
{
    public class EditAbsencesVM : BaseVM
    {
        private USER Student { get; set; }
        public string HeaderString { get; set; }
        private SUBJECT Subject { get; set; }
        private SchoolEntities4 context = new SchoolEntities4();

        private ObservableCollection<ABSENCE> absences = new ObservableCollection<ABSENCE>();
        public ObservableCollection<ABSENCE> Absences
        {
            get { return absences; }
            set
            {
                absences = value;
                NotifyPropertyChanged(nameof(Absences));
            }
        }
        public ObservableCollection<int> SemesterOptions { get; set; }
        public EditAbsencesVM() { }
        public EditAbsencesVM(SUBJECT subject, USER student)
        {
            SemesterOptions = new ObservableCollection<int> { 1, 2 };
            Student = student;
            Subject = subject;
            LoadAbsences();
            HeaderString = Student.Name + "'s absences for " + Subject.Name;
        }

        private ABSENCE selectedAbsence;
        public ABSENCE SelectedAbsence
        {
            get { return selectedAbsence; }
            set
            {
                selectedAbsence = value;
                NotifyPropertyChanged(nameof(SelectedAbsence));
            }
        }

        private int semester;
        public int Semester
        {
            get { return semester; }
            set
            {
                semester = value;
                NotifyPropertyChanged(nameof(Semester));
            }
        }

        public ICommand AddAbsenceCommand => new RelayCommand(AddAbsence);
        private void AddAbsence()
        {
            context.AddAbsence(Subject.SubjectId, SelectedDate.ToString(), Semester, true, false, Student.UserId);
            ABSENCE abs = new ABSENCE()
            {
                SubjectId = Subject.SubjectId,
                Date = SelectedDate.ToString(),
                Semester = Semester,
                CanBeExcused = true,
                Excused = false,
                StudentId = Student.UserId
            };
            Absences.Add(abs);
        }

        public ICommand ExcuseAbsenceCommand => new RelayCommand(ExcuseAbsence);

        private void ExcuseAbsence()
        {
            Console.WriteLine(SelectedAbsence.AbsenceId.ToString());
            context.ExcuseAbsence(SelectedAbsence.AbsenceId);
        }

        private void LoadAbsences()
        {
            if(Subject != null)
            {
                var result = context.GetAbsencesForASubject(Student.UserId, Subject.SubjectId);

                var absences = result
                    .Select(r => new ABSENCE
                    {
                        AbsenceId = r.AbsenceId,
                        SubjectId = r.SubjectId,
                        Date = r.Date,
                        Semester = r.Semester,
                        CanBeExcused = r.CanBeExcused,
                        Excused = r.Excused,
                        StudentId = r.StudentId,
                    }) 
                    .ToList();
                Absences = new ObservableCollection<ABSENCE>(absences);
            }
        }

        private DateTime selectedDate = DateTime.Today;
        public DateTime SelectedDate
        {
            get { return selectedDate; }
            set
            {
                selectedDate = value;
                NotifyPropertyChanged(nameof(SelectedDate));
            }
        }
    }
}
