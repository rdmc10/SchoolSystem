using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
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
        public ObservableCollection<AVERAGE> Averages { get; set; }
        private USER Student { get; set; }
        public AveragesWindowVM(USER student)
        {
            Student = student;
            LoadAverages();
            HeaderString = Student.Name + "'s averages";
        }

        private void LoadAverages()
        {
            var result = context.GetAveragesForStudent(Student.UserId);

            var avgs = result.Select(r => new AVERAGE
            {
                AverageId = r.AverageId,
                Value = r.Value,
                Semester = r.Semester,
                SubjectId = r.SubjectId,
                StudentId = r.StudentId,
            })
            .ToList();

            Averages = new ObservableCollection<AVERAGE>(avgs);
        }
    }
}
