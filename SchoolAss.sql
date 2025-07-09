use school;


-- Create student table
CREATE TABLE Student (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Gender ENUM('Male', 'Female', 'Other'),
    DOB DATE,
    Class VARCHAR(50)
);    

-- Create Parent table
CREATE TABLE Parent (
    ParentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,          -- Defining Column before referring
    Relation ENUM('Father', 'Mother'),
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Phone VARCHAR(100),
    Email VARCHAR(100),
    Occupation VARCHAR(100),
    Address TEXT,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);

-- Create Grade table
CREATE TABLE Grade (
    GradeID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    ParentID INT,
    ClassName ENUM('First', 'Second', 'Third', 'Fourth', 'Fifth', 
                   'Sixth', 'Seventh', 'Eight', 'Nineth', 'Tenth'),
    Grade VARCHAR(10),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (ParentID) REFERENCES Parent(ParentID)
);
    
describe Student;

SELECT * FROM Student;
SELECT * FROM Parent;
SELECT * FROM Grade;