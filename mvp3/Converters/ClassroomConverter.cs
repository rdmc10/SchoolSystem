using mvp3.Model;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Data;

namespace mvp3.Converters
{
    public class ClassroomConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is int classroomId && parameter is ObservableCollection<CLASSROOM> classrooms)
            {
                return classrooms.FirstOrDefault(c => c.ClassroomId == classroomId);
            }

            return null;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is CLASSROOM classroom)
            {
                return classroom.ClassroomId;
            }

            return null;
        }
    }
}
