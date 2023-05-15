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
    public class StudentWindowVM : BaseVM
    {
        public StudentWindowVM() { }
        public ObservableCollection<object> Marks { get; set; }
        public ObservableCollection<object> Absences { get; set; }

        private SchoolEntities4 context = new SchoolEntities4();
        private USER Student { get; set; }

        public StudentWindowVM(USER student)
        {
            Student = student;
            LoadMarks();
            LoadAbsences();
        }

        private void LoadAbsences()
        {
            var result1 = context.GetAllAbsencesForStudent(Student.UserId, 1);

            var abs1 = result1.Select(r => new ABSENCE()
            {
                AbsenceId = r.AbsenceId,
                SubjectId = r.SubjectId,
                Date = r.Date,
                Semester = r.Semester,
                Excused = r.Excused,
                StudentId = r.StudentId
            }).ToList();
            var result2 = context.GetAllAbsencesForStudent(Student.UserId, 1);

            var abs2 = result2.Select(r => new ABSENCE()
            {
                AbsenceId = r.AbsenceId,
                SubjectId = r.SubjectId,
                Date = r.Date,
                Semester = r.Semester,
                Excused = r.Excused,
                StudentId = r.StudentId
            }).ToList();

            var allabs = abs1.Concat(abs2);

            var formattedAbs = allabs.Select(a => new
            {
                Date = a.Date,
                Semester = a.Semester,
                Excused = a.Excused,
                Subject = GetSubjectName(a.SubjectId)
            });

                Absences = new ObservableCollection<object>(formattedAbs);
        }

        private void LoadMarks()
        {
            var result = context.GetAllMarks();

            var avgs = result.Where(r=>r.StudentId == Student.UserId).Select(r => new MARK()
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

            var formattedAverages = avgs.Select(a => new
            {
                Value = a.Value,
                Date = a.Date,
                Semester = a.Semester,
                Subject = GetSubjectName(a.SubjectId),
                IsThesis = a.IsThesis
            });

            Marks = new ObservableCollection<object>(formattedAverages);

        }

        public ICommand ViewAveragesCommand => new RelayCommand(ViewAverages);

        private void ViewAverages()
        {
            AveragesWindowVM averagesWindowVM = new AveragesWindowVM(Student);
            AveragesWindow averagesWindow = new AveragesWindow();
            averagesWindow.DataContext = averagesWindowVM;
            averagesWindow.ShowDialog();
        }
        private string GetSubjectName(int subjectId)
        {
            // Retrieve the subject name from the database based on the subjectId
            var subject = context.GetAllSubjects().FirstOrDefault(s => s.SubjectId == subjectId);
            return subject?.Name ?? string.Empty; // Return the subject name or an empty string if not found
        }

    }
}
