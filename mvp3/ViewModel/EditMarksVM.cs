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
        public string HeaderString;
        public EditMarksVM() { }
        private SchoolEntities4 context = new SchoolEntities4();

        public ObservableCollection<MARK> Marks { get; set; }
        private USER Student { get; set; }
        private SUBJECT Subject { get; set; }
        public EditMarksVM(SUBJECT subject, USER student) 
        { 
            Student = student;
            Subject = subject;
            LoadMarks();
            HeaderString = Student.Name + "'s marks for " + Subject.Name;
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

        public ICommand DeleteMarkCommand => new RelayCommand(DeleteMark);
        private void DeleteMark()
        {
            context.DeleteMark(SelectedMark.MarkId);
            Marks.Remove(SelectedMark);
            SelectedMark = null;
        }
        public ICommand AddMarkCommand => new RelayCommand(AddMark);
        private void AddMark()
        {
            context.AddMark(Subject.SubjectId, Value, SelectedDate.ToString(), 1, Student.UserId, IsThesis);
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
