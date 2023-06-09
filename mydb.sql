USE [master]
GO
/****** Object:  Database [School]    Script Date: 16/05/2023 17:14:15 ******/
CREATE DATABASE [School]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'School', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\School.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'School_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\School_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [School] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [School].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [School] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [School] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [School] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [School] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [School] SET ARITHABORT OFF 
GO
ALTER DATABASE [School] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [School] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [School] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [School] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [School] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [School] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [School] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [School] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [School] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [School] SET  DISABLE_BROKER 
GO
ALTER DATABASE [School] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [School] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [School] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [School] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [School] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [School] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [School] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [School] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [School] SET  MULTI_USER 
GO
ALTER DATABASE [School] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [School] SET DB_CHAINING OFF 
GO
ALTER DATABASE [School] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [School] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [School] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [School] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [School] SET QUERY_STORE = OFF
GO
USE [School]
GO
/****** Object:  Table [dbo].[ABSENCE]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ABSENCE](
	[AbsenceId] [int] IDENTITY(1,1) NOT NULL,
	[SubjectId] [int] NOT NULL,
	[Date] [varchar](50) NOT NULL,
	[Semester] [int] NOT NULL,
	[CanBeExcused] [bit] NOT NULL,
	[Excused] [bit] NOT NULL,
	[StudentId] [int] NOT NULL,
 CONSTRAINT [PK_ABSENCE] PRIMARY KEY CLUSTERED 
(
	[AbsenceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AVERAGE]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AVERAGE](
	[AverageId] [int] IDENTITY(1,1) NOT NULL,
	[Value] [float] NOT NULL,
	[Semester] [int] NOT NULL,
	[SubjectId] [int] NOT NULL,
	[StudentId] [int] NOT NULL,
 CONSTRAINT [PK_AVERAGE] PRIMARY KEY CLUSTERED 
(
	[AverageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CLASS_MASTER_CLASSROOM]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLASS_MASTER_CLASSROOM](
	[ClassMasterId] [int] NOT NULL,
	[ClassroomId] [int] NOT NULL,
 CONSTRAINT [PK_CLASS_MASTER_CLASSROOM] PRIMARY KEY CLUSTERED 
(
	[ClassMasterId] ASC,
	[ClassroomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CLASSROOM]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLASSROOM](
	[ClassroomId] [int] IDENTITY(1,1) NOT NULL,
	[SpecializationId] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[Name] [varchar](50) NULL,
 CONSTRAINT [PK_CLASSROOM] PRIMARY KEY CLUSTERED 
(
	[ClassroomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MARK]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MARK](
	[MarkId] [int] IDENTITY(1,1) NOT NULL,
	[SubjectId] [int] NOT NULL,
	[Value] [int] NOT NULL,
	[Date] [varchar](50) NOT NULL,
	[Semester] [int] NOT NULL,
	[StudentId] [int] NOT NULL,
	[IsThesis] [varchar](10) NULL,
 CONSTRAINT [PK_MARK] PRIMARY KEY CLUSTERED 
(
	[MarkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SPECIALIZATION]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SPECIALIZATION](
	[SpecializationId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_SPECIALIZATION] PRIMARY KEY CLUSTERED 
(
	[SpecializationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[STUDENT_CLASSROOM]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STUDENT_CLASSROOM](
	[StudentId] [int] NOT NULL,
	[ClassroomId] [int] NOT NULL,
 CONSTRAINT [PK_STUDENT_CLASSROOM] PRIMARY KEY CLUSTERED 
(
	[StudentId] ASC,
	[ClassroomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SUBJECT]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SUBJECT](
	[SubjectId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_SUBJECT] PRIMARY KEY CLUSTERED 
(
	[SubjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SUBJECT_CLASSROOM]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SUBJECT_CLASSROOM](
	[SubjectId] [int] NOT NULL,
	[ClassroomId] [int] NOT NULL,
	[Thesis] [bit] NULL,
 CONSTRAINT [PK_SUBJECT_CLASSROOM] PRIMARY KEY CLUSTERED 
(
	[SubjectId] ASC,
	[ClassroomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SUBJECT_TEACHER]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SUBJECT_TEACHER](
	[SubjectId] [int] NOT NULL,
	[TeacherId] [int] NOT NULL,
 CONSTRAINT [PK_SUBJECT_TEACHER] PRIMARY KEY CLUSTERED 
(
	[SubjectId] ASC,
	[TeacherId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TEACHER_CLASSROOM]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TEACHER_CLASSROOM](
	[TeacherId] [int] NOT NULL,
	[ClassroomId] [int] NOT NULL,
 CONSTRAINT [PK_CLASSROOM_TEACHER] PRIMARY KEY CLUSTERED 
(
	[TeacherId] ASC,
	[ClassroomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USER]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USER](
	[UserId] [int] IDENTITY(100,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[UserTypeId] [int] NOT NULL,
 CONSTRAINT [PK_USER] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USER_TYPE]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USER_TYPE](
	[UserTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Type] PRIMARY KEY CLUSTERED 
(
	[UserTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ABSENCE]  WITH CHECK ADD  CONSTRAINT [FK_STUDENT_ABSENCE] FOREIGN KEY([StudentId])
REFERENCES [dbo].[USER] ([UserId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ABSENCE] CHECK CONSTRAINT [FK_STUDENT_ABSENCE]
GO
ALTER TABLE [dbo].[ABSENCE]  WITH CHECK ADD  CONSTRAINT [FK_SUBJECT_ABSENCE] FOREIGN KEY([SubjectId])
REFERENCES [dbo].[SUBJECT] ([SubjectId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ABSENCE] CHECK CONSTRAINT [FK_SUBJECT_ABSENCE]
GO
ALTER TABLE [dbo].[AVERAGE]  WITH CHECK ADD  CONSTRAINT [FK_SUBJECT_AVERAGE] FOREIGN KEY([SubjectId])
REFERENCES [dbo].[SUBJECT] ([SubjectId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AVERAGE] CHECK CONSTRAINT [FK_SUBJECT_AVERAGE]
GO
ALTER TABLE [dbo].[AVERAGE]  WITH CHECK ADD  CONSTRAINT [FK_USER_AVERAGE] FOREIGN KEY([StudentId])
REFERENCES [dbo].[USER] ([UserId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AVERAGE] CHECK CONSTRAINT [FK_USER_AVERAGE]
GO
ALTER TABLE [dbo].[CLASS_MASTER_CLASSROOM]  WITH CHECK ADD  CONSTRAINT [FK_CLASS_MASTER_CLASS_MASTER_CLASSROOM] FOREIGN KEY([ClassMasterId])
REFERENCES [dbo].[USER] ([UserId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CLASS_MASTER_CLASSROOM] CHECK CONSTRAINT [FK_CLASS_MASTER_CLASS_MASTER_CLASSROOM]
GO
ALTER TABLE [dbo].[CLASS_MASTER_CLASSROOM]  WITH CHECK ADD  CONSTRAINT [FK_CLASSROOM_CLASS_MASTER_CLASSROOM1] FOREIGN KEY([ClassroomId])
REFERENCES [dbo].[CLASSROOM] ([ClassroomId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CLASS_MASTER_CLASSROOM] CHECK CONSTRAINT [FK_CLASSROOM_CLASS_MASTER_CLASSROOM1]
GO
ALTER TABLE [dbo].[CLASSROOM]  WITH CHECK ADD  CONSTRAINT [FK_SPECIALIZATION_CLASSROOM] FOREIGN KEY([SpecializationId])
REFERENCES [dbo].[SPECIALIZATION] ([SpecializationId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CLASSROOM] CHECK CONSTRAINT [FK_SPECIALIZATION_CLASSROOM]
GO
ALTER TABLE [dbo].[MARK]  WITH CHECK ADD  CONSTRAINT [FK_STUDENT_MARK] FOREIGN KEY([StudentId])
REFERENCES [dbo].[USER] ([UserId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MARK] CHECK CONSTRAINT [FK_STUDENT_MARK]
GO
ALTER TABLE [dbo].[MARK]  WITH CHECK ADD  CONSTRAINT [FK_SUBJECT_MARK] FOREIGN KEY([SubjectId])
REFERENCES [dbo].[SUBJECT] ([SubjectId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MARK] CHECK CONSTRAINT [FK_SUBJECT_MARK]
GO
ALTER TABLE [dbo].[STUDENT_CLASSROOM]  WITH CHECK ADD  CONSTRAINT [FK_CLASSROOM_STUDENT_CLASSROOM] FOREIGN KEY([ClassroomId])
REFERENCES [dbo].[CLASSROOM] ([ClassroomId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[STUDENT_CLASSROOM] CHECK CONSTRAINT [FK_CLASSROOM_STUDENT_CLASSROOM]
GO
ALTER TABLE [dbo].[STUDENT_CLASSROOM]  WITH CHECK ADD  CONSTRAINT [FK_STUDENT_STUDENT_CLASSROOM] FOREIGN KEY([StudentId])
REFERENCES [dbo].[USER] ([UserId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[STUDENT_CLASSROOM] CHECK CONSTRAINT [FK_STUDENT_STUDENT_CLASSROOM]
GO
ALTER TABLE [dbo].[SUBJECT_CLASSROOM]  WITH CHECK ADD  CONSTRAINT [FK_CLASSROOM_SUBJECT_CLASSROOM] FOREIGN KEY([ClassroomId])
REFERENCES [dbo].[CLASSROOM] ([ClassroomId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SUBJECT_CLASSROOM] CHECK CONSTRAINT [FK_CLASSROOM_SUBJECT_CLASSROOM]
GO
ALTER TABLE [dbo].[SUBJECT_CLASSROOM]  WITH CHECK ADD  CONSTRAINT [FK_SUBJECT_SUBJECT_CLASSROOM] FOREIGN KEY([SubjectId])
REFERENCES [dbo].[SUBJECT] ([SubjectId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SUBJECT_CLASSROOM] CHECK CONSTRAINT [FK_SUBJECT_SUBJECT_CLASSROOM]
GO
ALTER TABLE [dbo].[SUBJECT_TEACHER]  WITH CHECK ADD  CONSTRAINT [FK_SUBJECT_SUBJECT_TEACHER] FOREIGN KEY([SubjectId])
REFERENCES [dbo].[SUBJECT] ([SubjectId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SUBJECT_TEACHER] CHECK CONSTRAINT [FK_SUBJECT_SUBJECT_TEACHER]
GO
ALTER TABLE [dbo].[SUBJECT_TEACHER]  WITH CHECK ADD  CONSTRAINT [FK_TEACHER_SUBJECT_TEACHER] FOREIGN KEY([TeacherId])
REFERENCES [dbo].[USER] ([UserId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SUBJECT_TEACHER] CHECK CONSTRAINT [FK_TEACHER_SUBJECT_TEACHER]
GO
ALTER TABLE [dbo].[TEACHER_CLASSROOM]  WITH CHECK ADD  CONSTRAINT [FK_CLASSROOM_TEACHER_CLASSROOM] FOREIGN KEY([ClassroomId])
REFERENCES [dbo].[CLASSROOM] ([ClassroomId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TEACHER_CLASSROOM] CHECK CONSTRAINT [FK_CLASSROOM_TEACHER_CLASSROOM]
GO
ALTER TABLE [dbo].[TEACHER_CLASSROOM]  WITH CHECK ADD  CONSTRAINT [FK_TEACHER_TEACHER_CLASSROOM] FOREIGN KEY([TeacherId])
REFERENCES [dbo].[USER] ([UserId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TEACHER_CLASSROOM] CHECK CONSTRAINT [FK_TEACHER_TEACHER_CLASSROOM]
GO
ALTER TABLE [dbo].[USER]  WITH NOCHECK ADD  CONSTRAINT [FK_USER_TYPE_USER] FOREIGN KEY([UserTypeId])
REFERENCES [dbo].[USER_TYPE] ([UserTypeId])
GO
ALTER TABLE [dbo].[USER] CHECK CONSTRAINT [FK_USER_TYPE_USER]
GO
/****** Object:  StoredProcedure [dbo].[AddAbsence]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AddAbsence] @subjectId int, @date varchar(50), @semester int, @canBeExcused bit, @excused bit, @studentId int
as
insert into ABSENCE values (@subjectId, @date, @semester, @canBeExcused, @excused, @studentId)
GO
/****** Object:  StoredProcedure [dbo].[AddClassMasterClassroomLink]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddClassMasterClassroomLink] @classMasterId int, @classroomId int
as
if not exists (select * from CLASS_MASTER_CLASSROOM where ClassMasterId = @classMasterId)
begin
insert into CLASS_MASTER_CLASSROOM values (@classMasterId, @classroomId)
end
GO
/****** Object:  StoredProcedure [dbo].[AddClassroom]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddClassroom] @specializationId int, @year int, @name varchar(50)
as
insert into CLASSROOM values(@specializationId, @year, @name)
GO
/****** Object:  StoredProcedure [dbo].[AddMark]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AddMark] @subjectId int, @value int, @date varchar(50), @semester int, @studentId int, @boolIsThesis bit
as
declare @isThesis as varchar(10)=''
if(@boolIsThesis = 1)
begin
set @isThesis = 'Yes'
end
insert into MARK values (@subjectId, @value, @date, @semester, @studentId, @isThesis)
GO
/****** Object:  StoredProcedure [dbo].[AddSpecialization]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddSpecialization] @name varchar(50)
as
insert into SPECIALIZATION values (@name)
GO
/****** Object:  StoredProcedure [dbo].[AddStudentClassroomLink]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AddStudentClassroomLink] @studentId int, @classroomId int
as
if not exists (select STUDENT_CLASSROOM.StudentId from STUDENT_CLASSROOM where STUDENT_CLASSROOM.StudentId = @studentId)
begin
insert into STUDENT_CLASSROOM values(@studentId, @classroomId)
end
GO
/****** Object:  StoredProcedure [dbo].[AddSubject]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AddSubject] @name varchar(50)
as
insert into [subject] values(@name)
GO
/****** Object:  StoredProcedure [dbo].[AddSubjectClassroomLink]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddSubjectClassroomLink] 
    @subjectId INT,
    @classroomId INT,
    @thesis BIT
AS
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM SUBJECT_CLASSROOM
        WHERE SubjectId = @subjectId AND ClassroomId = @classroomId
    )
    BEGIN
        INSERT INTO SUBJECT_CLASSROOM (SubjectId, ClassroomId, Thesis)
        VALUES (@subjectId, @classroomId, @thesis)
    END
END
GO
/****** Object:  StoredProcedure [dbo].[AddSubjectTeacherLink]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddSubjectTeacherLink] 
    @subjectId INT,
    @teacherId INT
AS
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM SUBJECT_TEACHER
        WHERE SubjectId = @subjectId AND TeacherId = @teacherId
    )
    BEGIN
        INSERT INTO SUBJECT_TEACHER (SubjectId, TeacherId)
        VALUES (@subjectId, @teacherId)
    END
END
GO
/****** Object:  StoredProcedure [dbo].[AddTeacherClassroomLink]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddTeacherClassroomLink] 
    @teacherId INT,
    @classroomId INT
AS
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM TEACHER_CLASSROOM
        WHERE TeacherId = @teacherId AND ClassroomId = @classroomId
    )
    BEGIN
        INSERT INTO TEACHER_CLASSROOM (TeacherId, ClassroomId)
        VALUES (@teacherId, @classroomId)
    END
END
GO
/****** Object:  StoredProcedure [dbo].[AddUser]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddUser]
    @name varchar(50),
    @username varchar(50),
    @password varchar(50),
    @typeId int,
    @userId int OUTPUT
AS
BEGIN
    INSERT INTO [USER] (Name, Username, Password, UserTypeId)
    VALUES (@name, @username, @password, @typeId)
    
    SET @userId = SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [dbo].[AddUserType]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddUserType] @name varchar(50)
as
insert into USER_TYPE values(@name)
GO
/****** Object:  StoredProcedure [dbo].[DeleteClassMasterClassroomLink]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DeleteClassMasterClassroomLink] @classMasterId int
as

delete from CLASS_MASTER_CLASSROOM  where ClassMasterId = @classMasterId
GO
/****** Object:  StoredProcedure [dbo].[DeleteClassroom]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DeleteClassroom] @classroomId int
as
delete from CLASSROOM where ClassroomId = @classroomId
GO
/****** Object:  StoredProcedure [dbo].[DeleteMark]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DeleteMark] @markId int
as
delete from MARK where MarkId = @markId
GO
/****** Object:  StoredProcedure [dbo].[DeleteSpecialization]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DeleteSpecialization] @specializationId int
as
delete from SPECIALIZATION where SpecializationId = @specializationId
GO
/****** Object:  StoredProcedure [dbo].[DeleteStudentClassroomLink]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DeleteStudentClassroomLink] @studentId int, @classroomId int
as

delete from STUDENT_CLASSROOM where STUDENT_CLASSROOM.StudentId = @studentId and STUDENT_CLASSROOM.ClassroomId = @classroomId
GO
/****** Object:  StoredProcedure [dbo].[DeleteSubject]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DeleteSubject] @subjectId int
as
delete from [subject] where SubjectId = @subjectId
GO
/****** Object:  StoredProcedure [dbo].[DeleteSubjectClassroomLink]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DeleteSubjectClassroomLink] @subjectId int, @classroomId int
as

delete from SUBJECT_CLASSROOM where ClassroomId=@classroomId and SubjectId=@subjectId
GO
/****** Object:  StoredProcedure [dbo].[DeleteSubjectTeacherLink]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DeleteSubjectTeacherLink] @subjectId int, @teacherId int
as

delete from SUBJECT_TEACHER where SubjectId = @subjectId and TeacherId = @teacherId
GO
/****** Object:  StoredProcedure [dbo].[DeleteTeacherClassroomLink]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DeleteTeacherClassroomLink] @teacherId int, @classroomId int
as

delete from TEACHER_CLASSROOM where TeacherId = @teacherId and ClassroomId = @classroomId
GO
/****** Object:  StoredProcedure [dbo].[DeleteUser]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DeleteUser] @userId int
as
delete from [USER] where UserId = @userId
GO
/****** Object:  StoredProcedure [dbo].[DeleteUserType]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DeleteUserType] @userTypeId int
as
delete from USER_TYPE where UserTypeId = @userTypeId
GO
/****** Object:  StoredProcedure [dbo].[ExcuseAbsence]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ExcuseAbsence] @absenceId int
as
update ABSENCE set Excused = 1 where ABSENCE.AbsenceId = @absenceId and ABSENCE.CanBeExcused = 1
GO
/****** Object:  StoredProcedure [dbo].[GetAbsencesForASubject]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetAbsencesForASubject] @studentId int, @subjectId int
as
select ABSENCE.AbsenceId, ABSENCE.SubjectId, ABSENCE.[Date], ABSENCE.Semester, ABSENCE.CanBeExcused, ABSENCE.Excused, ABSENCE.StudentId, [SUBJECT].[Name]
from ABSENCE inner join [SUBJECT] on [SUBJECT].SubjectId = ABSENCE.SubjectId
where ABSENCE.StudentId = @studentId and [SUBJECT].SubjectId = @subjectId
GO
/****** Object:  StoredProcedure [dbo].[GetAbsencesForStudentForSubject]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetAbsencesForStudentForSubject] @studentId int, @subjectId int, @semester int
as
select ABSENCE.AbsenceId, ABSENCE.SubjectId, ABSENCE.[Date], ABSENCE.Semester, ABSENCE.CanBeExcused, ABSENCE.Excused, ABSENCE.StudentId, [SUBJECT].[Name]
from ABSENCE inner join [SUBJECT] on [SUBJECT].SubjectId = ABSENCE.SubjectId
where ABSENCE.StudentId = @studentId and ABSENCE.SubjectId = @subjectId and ABSENCE.Semester = @semester
GO
/****** Object:  StoredProcedure [dbo].[GetAbsencesPerClassroom]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetAbsencesPerClassroom] @classroomId int
as
select AbsenceId, ABSENCE.SubjectId, [Date], Semester, CanBeExcused, Excused, ABSENCE.StudentId, [Name] 
from ABSENCE inner join STUDENT_CLASSROOM on
ABSENCE.StudentId = STUDENT_CLASSROOM.StudentId 
inner join [SUBJECT] on [SUBJECT].SubjectId = ABSENCE.SubjectId where STUDENT_CLASSROOM.ClassroomId = @classroomId
GO
/****** Object:  StoredProcedure [dbo].[GetAllAbsencesForStudent]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetAllAbsencesForStudent] @studentId int, @semester int
AS
select ABSENCE.AbsenceId, ABSENCE.SubjectId, ABSENCE.[Date], ABSENCE.Semester, ABSENCE.CanBeExcused, ABSENCE.Excused, ABSENCE.StudentId, [SUBJECT].[Name]
from ABSENCE inner join [SUBJECT] on [SUBJECT].SubjectId = ABSENCE.SubjectId
where ABSENCE.StudentId = @studentId and ABSENCE.Semester = @semester
GO
/****** Object:  StoredProcedure [dbo].[GetAllClassMasterClassroomLinks]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetAllClassMasterClassroomLinks] 
as

select* from CLASS_MASTER_CLASSROOM
GO
/****** Object:  StoredProcedure [dbo].[GetAllClassrooms]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetAllClassrooms]
as
select* from CLASSROOM
GO
/****** Object:  StoredProcedure [dbo].[GetAllMarks]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetAllMarks]
as
select * from MARK
GO
/****** Object:  StoredProcedure [dbo].[GetAllSpecializations]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetAllSpecializations]
as
select * from SPECIALIZATION
GO
/****** Object:  StoredProcedure [dbo].[GetAllStudentClassroomLinks]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetAllStudentClassroomLinks]
as
select* from STUDENT_CLASSROOM
GO
/****** Object:  StoredProcedure [dbo].[GetAllSubjectClassroomLinks]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetAllSubjectClassroomLinks]
as

select * from SUBJECT_CLASSROOM
GO
/****** Object:  StoredProcedure [dbo].[GetAllSubjects]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetAllSubjects]
as
select * from [SUBJECT]
GO
/****** Object:  StoredProcedure [dbo].[GetAllSubjectTeacherLinks]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetAllSubjectTeacherLinks] 
as

select* from SUBJECT_TEACHER
GO
/****** Object:  StoredProcedure [dbo].[GetAllTeacherClassroomLinks]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetAllTeacherClassroomLinks]
as

select * from TEACHER_CLASSROOM
GO
/****** Object:  StoredProcedure [dbo].[GetAllUsers]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllUsers]
AS
SELECT * FROM [USER]
GO
/****** Object:  StoredProcedure [dbo].[GetAllUserTypes]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetAllUserTypes] 
as
select* from USER_TYPE
GO
/****** Object:  StoredProcedure [dbo].[GetAveragesForStudent]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetAveragesForStudent] @studentId int
as
select [AVERAGE].AverageId, [AVERAGE].[Value], [AVERAGE].Semester, [AVERAGE].SubjectId, [AVERAGE].StudentId, [SUBJECT].[Name]
from [AVERAGE] inner join [SUBJECT] on [AVERAGE].SubjectId = [SUBJECT].SubjectId
where [AVERAGE].StudentId = @studentId order by [AVERAGE].Semester
GO
/****** Object:  StoredProcedure [dbo].[GetClassMasterClassroom]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetClassMasterClassroom] 
    @teacherId INT
AS
BEGIN
    SELECT
        CLASSROOM.ClassroomId,
		CLASSROOM.SpecializationId,
        CLASSROOM.Year,
		CLASSROOM.Name
    FROM
        CLASSROOM
    INNER JOIN
        CLASS_MASTER_CLASSROOM ON CLASSROOM.ClassroomId = CLASS_MASTER_CLASSROOM.ClassroomId
    WHERE
        CLASS_MASTER_CLASSROOM.ClassMasterId = @teacherId
END
GO
/****** Object:  StoredProcedure [dbo].[GetClassroomIdForStudent]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetClassroomIdForStudent] @studentId int
as
begin
select CLASSROOM.ClassroomId from CLASSROOM inner join STUDENT_CLASSROOM on CLASSROOM.ClassroomId = STUDENT_CLASSROOM.ClassroomId
inner join [USER] on [USER].UserId = STUDENT_CLASSROOM.StudentId where [USER].UserId = @studentId
end
GO
/****** Object:  StoredProcedure [dbo].[GetMarksForASubject]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetMarksForASubject] @studentId int, @subjectId int
as
select MARK.MarkId, MARK.SubjectId, MARK.[Value], MARK.[Date], MARK.Semester, MARK.StudentId, [SUBJECT].[Name], MARK.IsThesis
from MARK inner join [SUBJECT] on [SUBJECT].SubjectId = MARK.SubjectId
where MARK.StudentId = @studentId and [SUBJECT].SubjectId = @subjectId
GO
/****** Object:  StoredProcedure [dbo].[GetMarksForStudent]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetMarksForStudent] @studentId int, @subjectId int, @semester int
as
begin
select MARK.MarkId, MARK.SubjectId, MARK.[Value], MARK.[Date], MARK.Semester, MARK.StudentId, [SUBJECT].[Name], MARK.IsThesis
from MARK inner join [SUBJECT] on [SUBJECT].SubjectId = MARK.SubjectId
where MARK.StudentId = @studentId and MARK.SubjectId = @subjectId and MARK.Semester = @semester
end
GO
/****** Object:  StoredProcedure [dbo].[GetStudentsFromClassroom]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetStudentsFromClassroom] @classroomId int
as
select * from [USER] inner join STUDENT_CLASSROOM on [USER].UserId = STUDENT_CLASSROOM.StudentId
where STUDENT_CLASSROOM.ClassroomId=@classroomId
GO
/****** Object:  StoredProcedure [dbo].[GetSubjectsForTeacherForSelectedClassroom]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetSubjectsForTeacherForSelectedClassroom] @teacherId int, @classroomId int
as
select [SUBJECT].SubjectId, [Name], Thesis from [SUBJECT] 
inner join SUBJECT_TEACHER on [SUBJECT].SubjectId = SUBJECT_TEACHER.SubjectId
inner join SUBJECT_CLASSROOM on SUBJECT_CLASSROOM.SubjectId = SUBJECT_TEACHER.SubjectId
where SUBJECT_TEACHER.TeacherId = @teacherId and SUBJECT_CLASSROOM.ClassroomId = @classroomId
GO
/****** Object:  StoredProcedure [dbo].[GetSubjectsFromClassroom]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetSubjectsFromClassroom] @classroomId int=null
as
begin
select SUBJECT.SubjectId,
       SUBJECT.Name
from [SUBJECT] inner join SUBJECT_CLASSROOM on [SUBJECT].SubjectId = SUBJECT_CLASSROOM.SubjectId
inner join CLASSROOM on CLASSROOM.ClassroomId = SUBJECT_CLASSROOM.ClassroomId where CLASSROOM.ClassroomId = @classroomId
end
GO
/****** Object:  StoredProcedure [dbo].[GetTeachersClassrooms]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTeachersClassrooms] 
    @teacherId INT
AS
SELECT 
    CLASSROOM.ClassroomId as ClassroomId,
    CLASSROOM.SpecializationId as SpecializationId,
    CLASSROOM.Year as Year,
    CLASSROOM.Name as Name
FROM 
    CLASSROOM
INNER JOIN 
    TEACHER_CLASSROOM ON CLASSROOM.ClassroomId = TEACHER_CLASSROOM.ClassroomId
WHERE 
    TEACHER_CLASSROOM.TeacherId = @teacherId
GO
/****** Object:  StoredProcedure [dbo].[GetUnexcusedAbsencesForStudent]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetUnexcusedAbsencesForStudent] @studentId int, @semester int
AS
select ABSENCE.AbsenceId, ABSENCE.SubjectId, ABSENCE.[Date], ABSENCE.Semester, ABSENCE.CanBeExcused, ABSENCE.Excused, ABSENCE.StudentId, [SUBJECT].[Name]
from ABSENCE inner join [SUBJECT] on [SUBJECT].SubjectId = ABSENCE.SubjectId
where ABSENCE.StudentId = @studentId and ABSENCE.Semester = @semester and ABSENCE.Excused = 0
GO
/****** Object:  StoredProcedure [dbo].[GetUnexcusedAbsencesPerClassroom]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetUnexcusedAbsencesPerClassroom] @classroomId int
as
select AbsenceId, ABSENCE.SubjectId, [Date], Semester, CanBeExcused, Excused, ABSENCE.StudentId, [Name] 
from ABSENCE inner join STUDENT_CLASSROOM on
ABSENCE.StudentId = STUDENT_CLASSROOM.StudentId 
inner join [SUBJECT] on [SUBJECT].SubjectId = ABSENCE.SubjectId where STUDENT_CLASSROOM.ClassroomId = @classroomId 
and ABSENCE.Excused = 0
GO
/****** Object:  StoredProcedure [dbo].[GetUser]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetUser] @username varchar(50), @password varchar(50)
as

begin
select * from [USER] where Username = @username and Password = @password
end

GO
/****** Object:  StoredProcedure [dbo].[GetUserType]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetUserType] @userTypeId int
as
begin
select USER_TYPE.Name from USER_TYPE inner join [USER] on USER_TYPE.UserTypeId = [USER].UserTypeId where USER_TYPE.UserTypeId = @userTypeId
end
GO
/****** Object:  StoredProcedure [dbo].[MakeAverage]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MakeAverage]
    @semester int,
    @subjectId int,
    @studentId int
AS
BEGIN
    DECLARE @valueOfAverage float = (SELECT SUM([Value]) FROM Mark 
                                      WHERE SubjectId = @subjectId
                                        AND StudentId = @studentId
                                        AND Semester = @semester
                                        AND IsThesis = '')
    DECLARE @numberOfGrades int = (SELECT COUNT(MarkId) FROM Mark 
                                   WHERE SubjectId = @subjectId
                                     AND StudentId = @studentId
                                     AND Semester = @semester
                                     AND IsThesis = '')

    IF EXISTS (SELECT 1
               FROM SUBJECT_CLASSROOM SC
               WHERE SC.SubjectId = @subjectId
                 AND SC.ClassroomId = (SELECT ClassroomId
                                       FROM STUDENT_CLASSROOM
                                       WHERE StudentId = @studentId)
                 AND SC.Thesis = 1)
    BEGIN
        DECLARE @thesisValue int = (SELECT [Value]
                                    FROM Mark
                                    WHERE SubjectId = @subjectId
                                      AND StudentId = @studentId
                                      AND Semester = @semester
                                      AND IsThesis = 'Yes')

        IF (@numberOfGrades >= 3 AND @thesisValue >= 1)
        BEGIN
            SET @valueOfAverage = ((@valueOfAverage / @numberOfGrades) * 3 + @thesisValue) / 4

            -- Check if the average record already exists for the same semester, subject, and student
            IF NOT EXISTS (SELECT 1 FROM [AVERAGE] WHERE Semester = @semester AND SubjectId = @subjectId AND StudentId = @studentId)
            BEGIN
                -- Insert the average record if it doesn't already exist
                INSERT INTO [AVERAGE] (Value, Semester, SubjectId, StudentId) VALUES (@valueOfAverage, @semester, @subjectId, @studentId)
            END
        END
    END
    ELSE
    BEGIN
        IF (@numberOfGrades >= 3)
        BEGIN
            SET @valueOfAverage = @valueOfAverage / @numberOfGrades

            -- Check if the average record already exists for the same semester, subject, and student
            IF NOT EXISTS (SELECT 1 FROM [AVERAGE] WHERE Semester = @semester AND SubjectId = @subjectId AND StudentId = @studentId)
            BEGIN
                -- Insert the average record if it doesn't already exist
                INSERT INTO [AVERAGE] (Value, Semester, SubjectId, StudentId) VALUES (@valueOfAverage, @semester, @subjectId, @studentId)
            END
        END
    END
END
GO
/****** Object:  StoredProcedure [dbo].[ModifyClassMasterClassroomLink]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ModifyClassMasterClassroomLink] @classMasterId int, @classroomId int
as

update CLASS_MASTER_CLASSROOM set ClassroomId = @classroomId where ClassMasterId = @classMasterId
GO
/****** Object:  StoredProcedure [dbo].[ModifyClassroom]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ModifyClassroom] @classroomId int, @specializationId int, @year int, @name varchar(50)
as
update CLASSROOM set SpecializationId = @specializationId, [Year] = @year, [Name] = @name where ClassroomId = @classroomId
GO
/****** Object:  StoredProcedure [dbo].[ModifySpecialization]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ModifySpecialization] @specializationId int, @name varchar(50)
as
update SPECIALIZATION set [Name] = @name where SpecializationId = @specializationId
GO
/****** Object:  StoredProcedure [dbo].[ModifyStudentClassroomLink]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ModifyStudentClassroomLink] @studentId int, @classroomId int
as

update STUDENT_CLASSROOM set STUDENT_CLASSROOM.ClassroomId = @classroomId where STUDENT_CLASSROOM.StudentId = @studentId
GO
/****** Object:  StoredProcedure [dbo].[ModifySubject]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ModifySubject] @subjectId int, @name varchar(50), @thesis bit
as
update [subject] set [Name] = @name, Thesis = @thesis where SubjectId = @subjectId
GO
/****** Object:  StoredProcedure [dbo].[ModifyUser]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ModifyUser] @userId int, @name varchar(50), @username varchar(50), @password varchar(50)
as
update [USER] set [Name] = @name, Username = @username, [Password] = @password where UserId = @userId
GO
/****** Object:  StoredProcedure [dbo].[ModifyUserType]    Script Date: 16/05/2023 17:14:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ModifyUserType] @userTypeId int, @name varchar(50)
as
update USER_TYPE set [Name] = @name where UserTypeId = @userTypeId
GO
USE [master]
GO
ALTER DATABASE [School] SET  READ_WRITE 
GO
