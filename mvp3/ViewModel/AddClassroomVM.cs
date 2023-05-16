using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using GalaSoft.MvvmLight.Command;
using mvp3.Helpers;
using mvp3.Model;

namespace mvp3.ViewModel
{
    public class AddClassroomVM : BaseVM
    {
        private SchoolEntities4 context = new SchoolEntities4();
        public AddClassroomVM() 
        {
            LoadSpecializations();
        }
        private ObservableCollection<SPECIALIZATION> specializations { get; set; }


        public ObservableCollection<SPECIALIZATION> Specializations
        {
            get { return specializations; }
            set
            {
                specializations = value;
                NotifyPropertyChanged(nameof(Specializations));
            }
        }

        private SPECIALIZATION selectedSpecialization;
        public SPECIALIZATION SelectedSpecialization
        {
            get { return selectedSpecialization; }
            set
            {
                selectedSpecialization = value;
                NotifyPropertyChanged(nameof(SelectedSpecialization));
            }
        }

        private string specName;
        public string SpecName
        {
            get { return specName; }
            set
            {
                specName = value;
                NotifyPropertyChanged(nameof(SpecName));
            }
        }
        private void LoadSpecializations()
        {
            var result = context.GetAllSpecializations();

            var specs = result.Select(r => new SPECIALIZATION()
            {
                SpecializationId = r.SpecializationId,
                Name = r.Name
            }).ToList();

            Specializations = new ObservableCollection<SPECIALIZATION>(specs);
        }

        public ICommand AddSpecCommand => new RelayCommand(AddSpecialization);

        private void AddSpecialization()
        {
            context.AddSpecialization(SpecName);
            LoadSpecializations();
        }

        private string classroomName;
        public string ClassroomName
        {
            get { return classroomName; }
            set
            {
                classroomName = value;
                NotifyPropertyChanged(nameof(ClassroomName));
            }
        }

        private string year;
        public string Year
        {
            get { return year; }
            set
            {
                year = value;
                NotifyPropertyChanged(nameof(Year));
            }
        }

        public ICommand AddClassroomCommand => new RelayCommand(AddClassroom);

        private void AddClassroom()
        {
            context.AddClassroom(SelectedSpecialization.SpecializationId,int.Parse(Year), ClassroomName);
        }


    }
}
