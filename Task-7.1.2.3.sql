Create Table Faculties (
FacultyID INT Primary Key,
FacultyName Nvarchar(50)
);

Create Table Students (
StudentID Int Primary Key,
FullName Nvarchar(100),
Age int,
FacultyID int Foreign Key References Faculties(FacultyID)
);

Create Table Grades (
GradeID int Primary Key,
StudentID int Foreign Key References Students(StudentID),
Score int
);

Insert into Faculties (FacultyID, FacultyName)
values
(1, 'IT'),
(2, 'Engineering'),
(3, 'Economics'),
(4, 'Business');

Insert into Students (StudentID, FullName, Age, FacultyID)
values
(1, 'Aysel Aliyeva' , 20, 1),
(2, 'Elvin Mammadov' , 21, 1),
(3, 'Nigar Hasanli' , 19, 2),
(4, 'Rauf Karimov' , 22, 2),
(5, 'Leyla Huseynova' , 20, 3),
(6, 'Tural Abbasov' , 23, 3),
(7, 'Sabina Aliyeva' , 21, 4),
(8, 'Orkhan Mammadov' , 24, 4);

Insert into Grades (GradeID, StudentID, Score)
values
(1, 1, 85),
(2, 1, 90),
(3, 2, 65),
(4, 2, 75),
(5, 3, 95),
(6, 3, 88),
(7, 4, 60),
(8, 4, 70),
(9, 5, 80),
(10, 5, 90),
(11, 6, 55),
(12, 6, 65),
(13, 7, 90),
(14, 7, 95),
(15, 8, 75),
(16, 8, 85);

Select * From Students;

Select * From Faculties;

Select * From Grades;

Select COUNT(*) AS TotalStudents
From Students;

Select 
AVG(Age) AS AverageAge,
MIN(Age) AS MinimumAge,
MAX(Age) AS MaximumAge
From Students;

Select 
FacultyID,
Count(*) AS StudentCount
From Students
Group By FacultyID;

Select
StudentID,
AVG(Score * 1.0) AS AverageScore
From Grades
Group by StudentID
Having AVG(Score * 1.0) > 70;

--Task-7.2

Select 
Students.FullName,
Faculties.FacultyName
From Students
Inner Join Faculties
On Students.FacultyID = Faculties.FacultyID;

Select
Students.FullName,
Faculties.FacultyName
From Students
Left Join Faculties
On Students.FacultyID = Faculties.FacultyID;

Select
Faculties.FacultyName,
Count(Students.StudentID) AS StudentCount
From Faculties
Left Join Students
On Faculties.FacultyID = Students.FacultyID
Group by Faculties.FacultyName;

--Task-7.3

Create table Courses (
CourseID int primary key,
CourseName nvarchar(50)
);

Alter table Grades
Add CourseID int;

Alter table Grades
Add constraint FK_Gades_Courses
foreign key (CourseID)
References Courses(CourseID);

insert into courses (CourseID, CourseName)
values
(1, 'C#'),
(2, 'Java'),
(3, 'SQL'),
(4, 'Python');

update grades
set CourseID = 
Case
When GradeID %4 =1 then 1
When GradeID %4 =2 then 2
When GradeID %4 =3 then 3
When GradeID %4 =0 then 4
End;

select 
students.FullName,
Courses.CourseName,
grades.Score
from grades
inner join students
on grades.StudentID = students.studentID
inner join courses
on grades.CourseID = courses.CourseID;

select
students.FullName,
Courses.CourseName,
Grades.Score
from Grades
inner join Students
on grades.StudentID = Students.StudentID
inner join Courses
on Grades.CourseID = Courses.CourseID
where Courses.CourseName = 'C#'
Order by Grades.Score DESC;

select
Courses.CourseName,
AVG(Grades.Score * 1.0) AS AverageScore
from grades
inner join Courses
on Grades.CourseID = Courses.CourseID
group by Courses.CourseName;

select
s.StudentID,
s.FullName
from Students AS s
left join Grades AS g
on s.StudentID = g.StudentID
where g.GradeID is null;