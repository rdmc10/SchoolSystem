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
    public class TeacherWindowVM : BaseVM
    {
        public ObservableCollection<CLASSROOM> Classrooms { get; set; }

        private SchoolEntities4 context = new SchoolEntities4();

        private USER Teacher { get; set; }
        public TeacherWindowVM()
        {
        }    

        public TeacherWindowVM(USER teacher)
        {
            Teacher = teacher;
            LoadClassrooms();
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
    }
}
