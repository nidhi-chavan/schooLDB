use school;

SELECT *  from student;        --  Shows all student records

# Q1. Count of Students in Each Class ?
SELECT Class,
    COUNT(*) AS TotalStudents
FROM Student GROUP BY Class ORDER BY Class ;   --- gets the total no of students class wise 

# Q2. Count of Male vs Female Students ?
SELECT Gender, COUNT(*) AS Total
FROM Student GROUP BY Gender;

# Q3. List students and their grades by class ?
SELECT s.StudentID, s.FirstName, s.LastName, g.ClassName, g.Grade
FROM Student s JOIN Grade g ON s.StudentID = g.StudentID;         -- gets the student details with current calss and garde

# Q4. Students Who Got Grade 'A+' ?
SELECT s.StudentID, s.FirstName, s.LastName, g.Grade
FROM Student s JOIN Grade g ON s.StudentID = g.StudentID  -- use to retrive data from multiple tables
WHERE g.Grade = 'A+';

# Q5. Get Specific Student's Grade using StudentID ?
SELECT s.StudentID, s.FirstName, s.LastName, g.ClassName,g.Grade
FROM Student as s JOIN Grade as g ON s.StudentID = g.StudentID
WHERE s.StudentID = 22;

# Q6. Get Student details by Name including Parent details ?
SELECT s.StudentID, s.FirstName as studentFirstName, s.LastName as studentLastName,
       p.relation as ParentRelation, p.FirstName as ParentFirstName,
       g.ClassName,g.Grade
FROM Student as s 
JOIN Parent as p ON s.StudentID = p.StudentID
JOIN Grade as g ON s.StudentID = g.StudentID
WHERE s.FirstName = 'Jennifer'AND s.LastName = 'Key';

# Q7. Show students born after 2010 with full name, class, and grade ?
SELECT s.StudentID, s.FirstName as studentFirstName, s.LastName as studentLastName,
      g.ClassName, g.Grade
FROM Student as s
JOIN Grade as g ON s.StudentID = g.StudentID
WHERE s.DOB > '2010-01-01'ORDER BY g.ClassName
LIMIT 0, 1000;

#Q8. Get students whose parents are doctors ?
SELECT s.StudentID,s.FirstName AS StudentName, p.FirstName AS ParentName, p.Occupation
FROM Student as s JOIN Parent as p ON s.StudentID = p.StudentID
WHERE p.Occupation LIKE '%Doctor%'; --- Help to find the text data in the DB

#Q9. Student who is top one student from Class 10th ?
SELECT s.StudentID, s.FirstName, s.LastName, g.ClassName, g.Grade
FROM Student as s JOIN Grade as g ON s.StudentID = g.StudentID
WHERE g.ClassName = 'Tenth'
ORDER BY CASE g.Grade          -- CASE part tells SQL that 'A+' is best, then 'A', then 'B+', and so on.
        WHEN 'A+' THEN 1        
        WHEN 'A' THEN 2
        WHEN 'B+' THEN 3
        WHEN 'B' THEN 4
        WHEN 'C' THEN 5
        WHEN 'D' THEN 6
        WHEN 'F' THEN 7
        ELSE 8
    END ASC                   -- ASC → smallest number comes first → best grade
LIMIT 1;                      -- shows only one student with the top grade

# Q10. Count of Each Grade by Class ?
SELECT g.ClassName,g.Grade,
    COUNT(*) AS GradeCount
FROM Grade as g GROUP BY g.ClassName, g.Grade ORDER BY g.ClassName, GradeCount ;

# Q11. Students with Grade 'F' (Fail List) ?
SELECT s.StudentID, s.FirstName, s.LastName, g.ClassName, g.Grade
FROM Student as s JOIN Grade g ON s.StudentID = g.StudentID
WHERE g.Grade = 'F' ORDER BY g.ClassName;
 
# Q12. List of Students with Only One Parent (Either Father or Mother)
SELECT s.StudentID, s.FirstName AS StudentFirstName, s.LastName AS StudentLastName, 
       p.Relation AS ParentRelation, p.FirstName AS ParentFirstName, p.LastName AS ParentLastName
FROM Student as s JOIN Parent p ON s.StudentID = p.StudentID
WHERE s.StudentID IN (
        SELECT StudentID
        FROM Parent GROUP BY StudentID HAVING COUNT(*) = 1
    );












