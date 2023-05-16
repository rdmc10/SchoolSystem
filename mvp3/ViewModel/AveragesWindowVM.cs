using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.Entity.Migrations.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using mvp3.Helpers;
using mvp3.Model;

namespace mvp3.ViewModel
{
    public class AveragesWindowVM : BaseVM
    {
        public AveragesWindowVM() { }

        public string HeaderString { get; set; }

        private SchoolEntities4 context = new SchoolEntities4();
        public ObservableCollection<object> Averages { get; set; }
        private USER Student { get; set; }
        public AveragesWindowVM(USER student)
        {
            Student = student;
            LoadAverages();
            HeaderString = Student.Name + "'s averages";
            double firstSemAvg = GetSemAvg(1);
            double secSemAvg = GetSemAvg(2);
            if (firstSemAvg > 0 && secSemAvg > 0)
            {
                double finalAvg = (firstSemAvg + secSemAvg) / 2;
                HeaderString += ". Final AVG: " + finalAvg.ToString();
            }
        }

        private void LoadAverages()
        {
            var result = context.GetAveragesForStudent(Student.UserId);

            var avgs = result.Select(r => new
            {
                AverageId = r.AverageId,
                Value = r.Value,
                Semester = r.Semester,
                SubjectId = r.SubjectId,
                StudentId = r.StudentId,
                SubjectName = GetSubjectName(r.SubjectId)
            })
            .ToList();

            var formattedAverages = avgs.Select(a => new
            {
                a.AverageId,
                a.Value,
                a.Semester,
                a.SubjectId,
                a.StudentId,
                SubjectName = a.SubjectName ?? string.Empty
            });

            Averages = new ObservableCollection<object>(formattedAverages);
        }

        private double GetSemAvg(int sem)
        {
            var result = context.GetAveragesForStudent(Student.UserId);

            var avgs = result
                .Where(r => r.Semester == sem)
                .Select(r => new AVERAGE
                {
                    AverageId = r.AverageId,
                    Value = r.Value,
                    Semester = r.Semester,
                    SubjectId = r.SubjectId,
                    StudentId = r.StudentId
                })
                .ToList();

            double total = 0;
            foreach ( var avg in avgs)
            {
                total += avg.Value;
            }
            total/=avgs.Count;

            return total;
        }

        private string GetSubjectName(int subjectId)
        {
            var subject = context.GetAllSubjects().FirstOrDefault(s => s.SubjectId == subjectId);
            return subject?.Name ?? string.Empty; 
        }
    }
}
