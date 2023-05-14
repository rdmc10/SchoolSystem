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
    public class EditMarksVM : BaseVM
    {
        public string HeaderString { get; set; }
        private bool firstSemClosed = false;
        private bool secSemClosed = false;
        public EditMarksVM() { }
        private SchoolEntities4 context = new SchoolEntities4();
        public ObservableCollection<int> SemesterOptions { get; set; }

        public ObservableCollection<MARK> Marks { get; set; }
        private USER Student { get; set; }
        private SUBJECT Subject { get; set; }
        public EditMarksVM(SUBJECT subject, USER student) 
        {
            SemesterOptions = new ObservableCollection<int> { 1, 2 };
            Student = student;
            Subject = subject;
            LoadMarks();
            HeaderString = Student.Name + "'s marks for " + Subject.Name;
            GetFirtSemAvg();
            GetSecSemAvg();
        }


        private MARK selectedMark;
        public MARK SelectedMark
        {
            get { return selectedMark; }
            set
            {
                selectedMark = value;
                NotifyPropertyChanged(nameof(SelectedMark));
            }
        }

        private string secsemstring;
        public string SecSemString
        {
            get { return secsemstring; }
            set
            {
                secsemstring = value;
                NotifyPropertyChanged(nameof(SecSemString));
            }
        }

        private string firstsemstring;
        public string FirstSemString
        {
            get { return firstsemstring; }
            set
            {
                firstsemstring = value;
                NotifyPropertyChanged(nameof(FirstSemString));
            }
        }
        private bool isThesis;
        public bool IsThesis
        {
            get { return isThesis; }
            set
            {
                isThesis = value;
                NotifyPropertyChanged(nameof(IsThesis));
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

        private int val;
        public int Value
        {
            get { return val; }
            set
            {
                val = value;
                NotifyPropertyChanged(nameof(Value));
            }
        }

        public ICommand CalculateAverageCommand => new RelayCommand(CalculateAverage);

        private void CalculateAverage()
        {
            context.MakeAverage(Semester, Subject.SubjectId, Student.UserId);
            if(Semester == 1)
            {
                var result = context.GetAveragesForStudent(Student.UserId);
                var avg = result.FirstOrDefault(r => r.SubjectId == Subject.SubjectId && r.Semester == Semester);

                FirstSemString = "Average for 1st sem: " + avg.Value.ToString();
            }
            if(Semester == 2)
            {
                var result = context.GetAveragesForStudent(Student.UserId);
                var avg = result.FirstOrDefault(r => r.SubjectId == Subject.SubjectId && r.Semester == Semester);

                SecSemString = "Average for 2nd sem: " + avg.Value.ToString();

            }
        }

        private void GetFirtSemAvg()
        {
            var result = context.GetAveragesForStudent(Student.UserId);
            var avg = result.FirstOrDefault(r => r.SubjectId == Subject.SubjectId && r.Semester == 1);
            if (avg != null)
            {
                FirstSemString = "Average for 1st sem: " + avg.Value.ToString();
                firstSemClosed = true;
            }
        }
        private void GetSecSemAvg()
        {
            var result = context.GetAveragesForStudent(Student.UserId);
            var avg = result.FirstOrDefault(r => r.SubjectId == Subject.SubjectId && r.Semester == 2);
            if (avg != null)
            {
                SecSemString = "Average for 2nd sem: " + avg.Value.ToString();
                secSemClosed = true;
            }
        }

        public ICommand DeleteMarkCommand => new RelayCommand(DeleteMark);
        private void DeleteMark()
        {
            if(SelectedMark != null)
            {
                context.DeleteMark(SelectedMark.MarkId);
                Marks.Remove(SelectedMark);
                SelectedMark = null;
            }
        }
        public ICommand AddMarkCommand => new RelayCommand(AddMark);
        private void AddMark()
        {
            if((Semester == 1 && !firstSemClosed) || (Semester == 2 && !secSemClosed) )
            {
                context.AddMark(Subject.SubjectId, Value, SelectedDate.ToString(), Semester, Student.UserId, IsThesis);
                MARK mark = new MARK()
                {
                    SubjectId = Subject.SubjectId,
                    Value = Value,
                    Date = SelectedDate.ToString(),
                    Semester = Semester,
                    StudentId = Student.UserId,
                    IsThesis = IsThesis.ToString()
                };
                Marks.Add(mark);
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

        private void LoadMarks()
        {
            var result = context.GetMarksForASubject(Student.UserId, Subject.SubjectId);

            var marks = result
                .Select(r => new MARK
                {
                    MarkId = r.MarkId,
                    SubjectId = r.SubjectId,
                    Value = r.Value,
                    Date = r.Date,
                    Semester = r.Semester,
                    StudentId = r.StudentId,
                    IsThesis = r.IsThesis
                }) 
                .ToList();
            Marks = new ObservableCollection<MARK>(marks);
        }

    }
}
