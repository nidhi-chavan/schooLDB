import mysql.connector
from faker import Faker
import random

# Step 1: Connect to MySQL
db = mysql.connector.connect(
    host='localhost',
    user='root',
    password='lowkey',
    database='school'
)
cursor = db.cursor()
fake = Faker()

# Step 2: Predefined lists
gender_list = ['Male', 'Female', 'Other']
class_names = ['First', 'Second', 'Third', 'Fourth', 'Fifth',
               'Sixth', 'Seventh', 'Eight', 'Nineth', 'Tenth']
grades = ['A+', 'A', 'B+', 'B', 'C', 'D', 'F']

# Step 3: Insert 1000 records
for i in range(1000):
    # Student details
    first_name = fake.first_name()
    last_name = fake.last_name()
    gender = random.choice(gender_list)
    dob = fake.date_of_birth(minimum_age=6, maximum_age=18)
    class_name = random.choice(class_names)

    # Insert into Student table
    cursor.execute("""
        INSERT INTO Student (FirstName, LastName, Gender, DOB, Class)
        VALUES (%s, %s, %s, %s, %s)
    """, (first_name, last_name, gender, dob, class_name))

    student_id = cursor.lastrowid

    # Parent table
    for relation in ['Father', 'Mother']:
        if relation == 'Father':
            parent_first = fake.first_name_male()
        else:
            parent_first = fake.first_name_female()

        parent_last = fake.last_name()
        phone = fake.phone_number()
        email = fake.email()
        occupation = fake.job()
        address = fake.address()

     # Insert into parent table
        cursor.execute("""
            INSERT INTO Parent (StudentID, Relation, FirstName, LastName, Phone, Email, Occupation, Address)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """, (student_id, relation, parent_first, parent_last, phone, email, occupation, address))

    # Insert into Grade table
    grade = random.choice(grades)
    cursor.execute("""
        INSERT INTO Grade (StudentID, ParentID, ClassName, Grade)
        VALUES (%s, %s, %s, %s)
    """, (student_id, cursor.lastrowid, class_name, grade))

# commit changes and close 
db.commit()
cursor.close()
db.close()

print("1000 student records inserted successfully!")
