CREATE DATABASE class_occupancy_tracker;
USE class_occupancy_tracker;

-- 1. semesters table
CREATE TABLE semesters (
    semester_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- 2. sections table
CREATE TABLE sections (
    section_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    semester_id INT,
    FOREIGN KEY (semester_id) REFERENCES semesters(semester_id)
);

-- 3. subjects table
CREATE TABLE subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_code VARCHAR(20) NOT NULL,
    name VARCHAR(100) NOT NULL
);

-- . teachers table (replacing faculty)
CREATE TABLE teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- 5. section_subject_teacher junction table
CREATE TABLE section_subject_teacher (
    id INT AUTO_INCREMENT PRIMARY KEY,
    section_id INT NOT NULL,
    subject_id INT NOT NULL,
    teacher_id INT NOT NULL,
    FOREIGN KEY (section_id) REFERENCES sections(section_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id),
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id),
    UNIQUE KEY (section_id, subject_id) -- Ensures a subject isn't assigned twice to same section
);

-- 6. classrooms table
CREATE TABLE classrooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    capacity INT,
    room_type ENUM('Lecture Theater', 'Classroom', 'Laboratory')
);

-- 7. timetable table (for scheduling)
CREATE TABLE timetable (
    timetable_id INT AUTO_INCREMENT PRIMARY KEY,
    section_subject_teacher_id INT,
    room_id INT,
    day_of_week ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday') NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    FOREIGN KEY (section_subject_teacher_id) REFERENCES section_subject_teacher(id),
    FOREIGN KEY (room_id) REFERENCES classrooms(room_id)
);

-- 8. room_status table
CREATE TABLE room_status (
    room_id INT PRIMARY KEY,
    current_status ENUM('Occupied', 'Vacant', 'Maintenance') DEFAULT 'Vacant',
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by INT,
    update_method ENUM('auto', 'manual') DEFAULT 'auto',
    FOREIGN KEY (room_id) REFERENCES classrooms(room_id),
    FOREIGN KEY (updated_by) REFERENCES teachers(teacher_id)
);

-- Insert semesters
INSERT INTO semesters (name) VALUES 
('BCA 2nd Semester'),
('BCA 4th Semester'),
('BCA 6th Semester'),
('BCA AI & DS 2nd'),
('BCA AI & DS 4th'),
('BCA CS & CL 2nd');

-- Insert teachers
INSERT INTO teachers (name, email) VALUES
-- BCA 2 Faculty
('MR. GAURAV SHARMA', 'gaurav.sharma@graphicera.edu'),
('MS. TABISH', 'tabish@graphicera.edu'),
('MS. NEHA BHATT', 'neha.bhatt@graphicera.edu'),
('DR. PRIVANKA ALMIA', 'privanka.almia@graphicera.edu'),
('MS. MANSHI', 'manshi@graphicera.edu'),
('MS. ANAMIKA', 'anamika@graphicera.edu'),
('MS. KAJAL', 'kajal@graphicera.edu'),
('MS. PRIYA KOHLI', 'priya.kohli@graphicera.edu'),
('DR. PRIYANSHU ARYA', 'priyanshu.arya@graphicera.edu'),
('MS. HARSHITA', 'harshita@graphicera.edu'),
('MS. DEEPTI', 'deepti@graphicera.edu'),
('MR. MOHIT', 'mohit@graphicera.edu'),
('DR. ANUPRIYA', 'anupriya@graphicera.edu'),
('MR. AMIT JUVAL', 'amit.juval@graphicera.edu'),
('DR. SHUBHAM KUMAR', 'shubham.kumar@graphicera.edu'),
('DR. RAJESH MISHRA', 'rajesh.mishra@graphicera.edu'),
('MS. SHOBHA ASWAL', 'shobha.aswal@graphicera.edu'),
('MR. DEEPAK CHAUHAN', 'deepak.chauhan@graphicera.edu'),
('MS. ATIKA GUPTA', 'atika.gupta@graphicera.edu' ),
('MR. CHETAN PANDEY', 'chetan.pandey@graphicera.edu'),
('MR. SAURABH FULARA', 'saurabh.fulara@graphicera.edu'),
('MS. POOJA', 'pooja@graphicera.edu'),
('MS. TAMANNA', 'tamanna@graphicera.edu'),
('DR. CHANDRAKALA', 'chandrakala@graphicera.edu'),
('DR. JYOTI PARSOLA', 'jyoti.parsola@graphicera.edu'),
('MR. ABHISHEK SHARMA', 'abhishek.sharma@graphicera.edu'),
('DR. VIVEK CHAMOLI', 'vivek.chamoli@graphicera.edu'),
('MR. VINEET DEOPA', 'vineet.deopa@graphicera.edu'),

-- BCA 4 Faculty
('DR. HIMANI', 'himani@graphicera.edu' ),
('MS. DIVYA KAPIL', 'divya.kapil@graphicera.edu' ),
('MS. NIDHI MEHRA', 'nidhi.mehra@graphicera.edu' ),
('MS. NIDHI JOSHI', 'nidhi.joshi@graphicera.edu' ),
('DR. LUXMI', 'luxmi@graphicera.edu' ),
('DR. NISHA CHANDRAN', 'nisha.chandran@graphicera.edu' ),
('MS. POONAM VERMA', 'poonam.verma@graphicera.edu' ),
('MR. TARUN BHATT', 'tarun.bhatt@graphicera.edu' ),
('DR. R.K BISHT', 'rk.bisht@graphicera.edu' ),
('DR. SUNIL SHUKLA', 'sunil.shukla@graphicera.edu' ),
('DR. ALKA PANT', 'alka.pant@graphicera.edu' ),
('MR. MADHUR', 'madhur@graphicera.edu' ),

-- BCA AI & DS Faculty
('MR. ADITYA HARBOLA', 'aditya.harbola@graphicera.edu' ),
('MS. DEEPTI NEGI', 'deepti.negi@graphicera.edu' ),
('DR. MAKARAND DHYANI', 'makarand.dhyani@graphicera.edu' ),
('MR. SUHAIL', 'suhail@graphicera.edu' ),
('MR. AMIR', 'amir@graphicera.edu' ),
('Dr. Mohit Payal', 'mohitpayal@graphicera.edu' ),
('Dr. Priyanka Almia', 'PriyankaAlmia@graphicera.edu' ),

-- missing 
('MR.NEERAJ PANWAR', 'NeerajPanwar@graphicera.edu'),
('MR.BHAVNESH', 'Bhavnesh@graphicera.edu');

-- Insert subjects
INSERT INTO subjects (subject_code, name) VALUES
-- BCA Semester 2 subjects
('TBC201', 'Introduction to Data Structures'),
('TBC202', 'Introduction to Object-Oriented Programming'),
('TBC203', 'Introduction to Operating Systems'),
('TBC204', 'Probability and Statistics for Data Science'),
('TBC211', 'Discipline-Specific Elective – 1 Fundamentals of Python Programming'),
('PBC201', 'Data Structures Laboratory'),
('PBC202', 'Object-Oriented Programming Laboratory'),

-- BCA Semester 4 subjects
('TBC401', 'Introduction to Design and Analysis of Algorithms'),
('TBC402', 'Introduction to Software Engineering'),
('TBC403', 'Computer Organization'),
('TBC404', 'Data Communication and Computer Networks'),
('TBC405', 'Discipline-Specific Elective – 2 (Big Data Analytics)'),
('XBC401', 'Career Skills – 2'),
('PBC401', 'Design and Analysis of Algorithms Laboratory'),
('PBC402', 'Data Communications and Computer Networks Laboratory'),

-- BCA Semester 6 subjects
('TBC601', 'Computer Graphics'),
('TBC602', 'Network Security and Cyber Law'),
('TBC603', 'Fundamentals of Machine Learning'),
('TBC604', 'Elective – II'),
('PBC601', 'Computer Graphics Lab'),
('PBC602', 'Machine Learning Lab'),

-- BCA AI & DS 2nd Semester 
('TBD201', 'Introduction to Data Structures'),  
('TBD202', 'Fundamentals of Python Programming'),  
('TBD203', 'Foundations of AI'),  
('TBD204', 'Probability and Statistics for Data science'),
('TBD212', 'Discipline-Specific Elective – 1(Operating System)'),  
('PBD201', 'Data Structures Laboratory'),  
('PBD202', 'Python Programming Laboratory'), 

-- BCA CS & CL 2nd Semester 
('TBL201', 'Introduction to Data Structures'),
('TBL202', 'Computer Networks'),
('TBL203', 'Cyber Security Essentials'),
('TBL204', 'Digital Principles and Computer Organization'),
('TBL212', 'Discipline-Specific Elective – 1, DISCRETE MATHEMATICS'),
('PBL201', 'Data Structures Laboratory'),
('PBL202', 'Computer Networks Lab Cyber Security Lab'),

-- BCA AI & DS 4th Semester 
('TBD401', 'Full Stack Development'), 
('TBD402', 'Data Analytics with R'),  
('TBD403', 'Data Communication and Networks'), 
('TBD404', 'Introduction to Software Engineering'), 
('TBD405', 'Discipline-Specific Elective – 2 (Computer Organization)'), 
('TBD406', 'Career Skills – 2'),
('PBD401', 'Full Stack Development Laboratory'), 
('PBD402', 'Data Analytics R Laboratory'); 

-- Insert sections
INSERT INTO sections (name, semester_id) VALUES
-- BCA 2nd Semester (semester_id = 1)
('BCA 2 A1+B1', 1),
('BCA 2 C1', 1),
('BCA 2 D1', 1),
('BCA 2 E1', 1),
('BCA 2 A2+B2', 1),
('BCA 2 C2', 1),
('BCA 2 D2', 1),
('BCA 2 E2', 1),

-- BCA 4th Semester (semester_id = 2)
('BCA 4 A1+B1', 2),
('BCA 4 C1+D1', 2),
('BCA 4 E1', 2),
('BCA 4 F1', 2),
('BCA 4 G1', 2),
('BCA 4 H1', 2),
('BCA 4 A2', 2),
('BCA 4 B2', 2),
('BCA 4 C2', 2),
('BCA 4 D2', 2),
('BCA 4 E2', 2),
('BCA 4 F2', 2),
('BCA 4 G2', 2),

-- BCA 6th Semester (semester_id = 3)
('BCA 6 A1+B1', 3),
('BCA 6 C1+D1', 3),
('BCA 6 E1', 3),
('BCA 6 F1', 3),
('BCA 6 G1', 3),
('BCA 6 A2+B2', 3),
('BCA 6 C2+D2', 3),
('BCA 6 E2', 3),
('BCA 6 F2', 3),

-- BCA AI & DS 2nd (semester_id = 4)
('BCA AI & DS 2nd (A1+B1+C1)', 4),
('BCA AI & DS 2nd A2', 4),

-- BCA AI & DS TH (semester_id = 5)
('BCA AI & DS 4th (A1+B1)', 5),
('BCA AI & DS 4th (A2+B2)', 5),

-- BCA CS & CL 2nd (semester_id = 6)
('BCA CS & CL 2nd', 6);

-- Insert classrooms
INSERT INTO classrooms (name, capacity, room_type) VALUES
-- Lecture Theaters
('LT-401', 180, 'Lecture Theater'),
('LT-402', 180, 'Lecture Theater'),
('LT-501', 180, 'Lecture Theater'),
('LT-502', 180, 'Lecture Theater'),

-- Classrooms
('CR-101', 90, 'Classroom'),
('CR-102', 90, 'Classroom'),
('CR-103', 100, 'Classroom'),
('CR-104', 90, 'Classroom'),
('CR-105', 90, 'Classroom'),
('CR-201', 90, 'Classroom'),
('CR-202', 90, 'Classroom'),
('CR-203', 90, 'Classroom'),
('CR-204', 90, 'Classroom'),
('CR-304', 90, 'Classroom'),
('CR-403', 90, 'Classroom'),
('CR-404', 100, 'Classroom'),
('CR-405', 90, 'Classroom'),
('CR-406', 90, 'Classroom'),

-- Laboratories
('LAB 4', 90, 'Laboratory'),
('LAB 6', 90, 'Laboratory'),
('LAB 7', 90, 'Laboratory'),
('IOT LAB', 90, 'Laboratory'),
('TCL-4 LAB', 90, 'Laboratory'),
('TCL-1 LAB', 90, 'Laboratory'),
('TCL-2 LAB', 90, 'Laboratory'),
('TCL-3 LAB', 90, 'Laboratory'),

-- MISSING
('LT-202', 180, 'Lecture Theater');

-- Insert section-subject-teacher relationships
INSERT INTO section_subject_teacher (section_id, subject_id, teacher_id) VALUES
-- BCA 2 A1+B1 (Section 1)
(1, 1, 1),   -- Introduction to Data Structures by MR. GAURAV SHARMA
(1, 2, 2),   -- Introduction to Object-Oriented Programming by MS. TABISH
(1, 3, 3),   -- Introduction to Operating Systems by MS. NEHA BHATT
(1, 4, 4),   -- Probability and Statistics for Data Science by DR. PRIVANKA ALMIA
(1, 5, 5),   -- Discipline-Specific Elective – 1 by MS. MANSHI
(1, 6, 1),   -- Data Structures Laboratory by MR. GAURAV SHARMA
(1, 7, 2),   -- Object-Oriented Programming Laboratory by MS. TABISH

-- BCA 2 C1 (Section 2)
(2, 1, 6),   -- Introduction to Data Structures by MS. ANAMIKA
(2, 2, 7),   -- Introduction to Object-Oriented Programming by MS. KAJAL
(2, 3, 8),   -- Introduction to Operating Systems by MS. PRIYA KOHLI
(2, 4, 9),   -- Probability and Statistics for Data Science by DR. PRIYANSHU ARYA
(2, 5, 5),   -- Discipline-Specific Elective – 1 by MS. MANSHI
(2, 6, 6),   -- Data Structures Laboratory by MS. ANAMIKA
(2, 7, 10),  -- Object-Oriented Programming Laboratory by MS. HARSHITA

-- BCA 2 D1 (Section 3)
(3, 1, 2),   -- Introduction to Data Structures by MS. TABISH
(3, 2, 11),  -- Introduction to Object-Oriented Programming by MS. DEEPTI
(3, 3, 8),  -- Introduction to Operating Systems by  MS. PRIYA KOHLI
(3, 4, 4),   -- Probability and Statistics for Data Science by DR. PRIVANKA ALMIA
(3, 5, 12),  -- Discipline-Specific Elective – 1 by MR. MOHIT
(3, 6, 2),   -- Data Structures Laboratory by MS. TABISH
(3, 7, 11),  -- Object-Oriented Programming Laboratory by MS. DEEPTI

-- BCA 2 E1 (Section 4)
(4, 1, 1),   -- Introduction to Data Structures by MR. GAURAV SHARMA
(4, 2, 7),   -- Introduction to Object-Oriented Programming by MS. KAJAL
(4, 3, 13),  -- Introduction to Operating Systems by DR. ANUPRIYA
(4, 4, 9),   -- Probability and Statistics for Data Science by DR. PRIYANSHU ARYA
(4, 5, 5),   -- Discipline-Specific Elective – 1 by MS. MANSHI
(4, 6, 1),   -- Data Structures Laboratory by MR. GAURAV SHARMA
(4, 7, 7),   -- Object-Oriented Programming Laboratory by MS. KAJAL

-- BCA 2 A2+B2 (Section 5)
(5, 1, 48),  -- Introduction to Data Structures by MR. NEERAJ PANWAR
(5, 2, 7),   -- Introduction to Object-Oriented Programming by MS. KAJAL
(5, 3, 13),  -- Introduction to Operating Systems by DR. ANUPRIYA
(5, 4, 9),   -- Probability and Statistics for Data Science by DR. PRIYANSHU ARYA
(5, 5, 12),  -- Discipline-Specific Elective – 1 by MR. MOHIT
(5, 6, 2),  -- Data Structures Laboratory by MS. TABISH RAO
(5, 7, 7),   -- Object-Oriented Programming Laboratory by MS. KAJAL

-- BCA 2 C2 (Section 6)
(6, 1, 1),    -- Introduction to Data Structures by MR. GAURAV SHARMA
(6, 2, 11),   -- Introduction to Object-Oriented Programming by MS. DEEPTI
(6, 3, 3),    -- Introduction to Operating Systems by MS. NEHA BHATT
(6, 4, 9),    -- Probability and Statistics for Data Science by DR. PRIYANSHU ARYA
(6, 5, 5),    -- Discipline-Specific Elective – 1 by MS. MANSHI
(6, 6, 1),    -- Data Structures Laboratory by MR. GAURAV SHARMA
(6, 7, 10),   -- Object-Oriented Programming Laboratory by MS. HARSHITA

-- BCA 2 D2 (Section 7)
(7, 1, 1),    -- Introduction to Data Structures by MR. GAURAV SHARMA
(7, 2, 2),   -- Introduction to Object-Oriented Programming by MS. TABISH RAO
(7, 3, 8),   -- Introduction to Operating Systems by MS. PRIVA KOHLI
(7, 4, 9),    -- Probability and Statistics for Data Science by DR. PRIVANKA ALMIA
(7, 5, 12),   -- Discipline-Specific Elective – 1 by MR. MOHIT
(7, 6, 1),    -- Data Structures Laboratory by MR. GAURAV SHARMA
(7, 7, 2),   -- Object-Oriented Programming Laboratory by MS. TABISH RAO

-- BCA 2 E2 (Section 8)
(8, 1, 6),    -- Introduction to Data Structures by MS. ANAMIKA
(8, 2, 14),   -- Introduction to Object-Oriented Programming by MR. AMIT JUVAL
(8, 3, 8),   -- Introduction to Operating Systems by MS. PRIVA KOHLI
(8, 4, 9),    -- Probability and Statistics for Data Science by DR. PRIVANKA ALMIA
(8, 5, 5),    -- Discipline-Specific Elective – 1 by MS. MANSHI
(8, 6, 6),    -- Data Structures Laboratory by MS. ANAMIKA
(8, 7, 14),   -- Object-Oriented Programming Laboratory by MR. AMIT JUVAL

-- BCA 4 A1+B1 (Section 9)
(9, 8, 24),   -- Introduction to Design and Analysis of Algorithms by DR. HIMANI
(9, 10, 18),  -- Computer Organization by MR. DEEPAK CHAUHAN
(9, 11, 19),  -- Data Communication and Computer Networks by MS. DIVYA KAPIL
(9, 12, 25),  -- Discipline-Specific Elective – 2 (Big Data Analytics) by DR. JYOTI PARSOLA
(9, 13, 21),  -- Career Skills – 2 by MR. SAURABH FULARA
(9, 14, 24),  -- Design and Analysis of Algorithms Laboratory by DR. HIMANI
(9, 15, 19),  -- Data Communications and Computer Networks Laboratory by MS. DIVYA KAPIL

-- BCA 4 C1+D1 (Section 10)
(10, 8, 17),  -- Introduction to Design and Analysis of Algorithms by MS. SHOBHA ASWAL
(10, 10, 18), -- Computer Organization by MR. DEEPAK CHAUHAN
(10, 11, 19), -- Data Communication and Computer Networks by MS. ATIKA GUPTA
(10, 12, 20), -- Discipline-Specific Elective – 2 (Big Data Analytics) by MR. CHETAN PANDEY
(10, 13, 21), -- Career Skills – 2 by MR. SAURABH FULARA
(10, 14, 17), -- Design and Analysis of Algorithms Laboratory by MS. SHOBHA ASWAL
(10, 15, 19), -- Data Communications and Computer Networks Laboratory by MS. ATIKA GUPTA

-- BCA 4 E1 (Section 11)
(11, 8, 24),   -- Introduction to Design and Analysis of Algorithms by DR. HIMANI
(11, 10, 27),  -- Computer Organization by DR. VIVEK CHAMOLI
(11, 11, 19),  -- Data Communication and Computer Networks by MS. ATIKA GUPTA
(11, 12, 25),  -- Discipline-Specific Elective – 2 (Big Data Analytics) by DR. JYOTI PARSOLA
(11, 13, 26),  -- Career Skills – 2 by MR. ABHISHEK SHARMA
(11, 14, 24),  -- Design and Analysis of Algorithms Laboratory by DR. HIMANI
(11, 15, 19),  -- Data Communications and Computer Networks Laboratory by MS. ATIKA GUPTA

-- BCA 4 F1 (Section 12)
(12, 8, 6),    -- Introduction to Design and Analysis of Algorithms by MS. ANAMIKA
(12, 10, 27),  -- Computer Organization by DR. VIVEK CHAMOLI
(12, 11, 23),  -- Data Communication and Computer Networks by MS. TAMANNA
(12, 12, 25),  -- Discipline-Specific Elective – 2 (Big Data Analytics) by DR. JYOTI PARSOLA
(12, 13, 21),  -- Career Skills – 2 by MR. SAURABH FULARA
(12, 14, 6),   -- Design and Analysis of Algorithms Laboratory by MS. ANAMIKA
(12, 15, 23),  -- Data Communications and Computer Networks Laboratory by MS. TAMANNA

-- BCA 4 G1 (Section 13)
(13, 8, 17),   -- Introduction to Design and Analysis of Algorithms by MS. SHOBHA ASWAL
(13, 10, 28),  -- Computer Organization by MR. VINEET DEOPA
(13, 11, 23),  -- Data Communication and Computer Networks by MS. TAMANNA
(13, 12, 20),  -- Discipline-Specific Elective – 2 (Big Data Analytics) by MR. CHETAN PANDEY
(13, 13, 26),  -- Career Skills – 2 by MR. ABHISHEK SHARMA
(13, 14, 17),  -- Design and Analysis of Algorithms Laboratory by MS. SHOBHA ASWAL
(13, 15, 23),  -- Data Communications and Computer Networks Laboratory by MS. TAMANNA

-- BCA 4 H1 (Section 14)
(14, 8, 6),    -- Introduction to Design and Analysis of Algorithms by MS. ANAMIKA
(14, 10, 28),  -- Computer Organization by MR. VINEET DEOPA
(14, 11, 24),  -- Data Communication and Computer Networks by DR. CHANDRAKALA
(14, 12, 20),  -- Discipline-Specific Elective – 2 (Big Data Analytics) by MR. CHETAN PANDEY
(14, 13, 26),  -- Career Skills – 2 by MR. ABHISHEK SHARMA
(14, 14, 6),   -- Design and Analysis of Algorithms Laboratory by MS. ANAMIKA
(14, 15, 24),  -- Data Communications and Computer Networks Laboratory by DR. CHANDRAKALA

-- BCA 4 A2 (Section 15)
(15, 8, 24),   -- Introduction to Design and Analysis of Algorithms by DR. HIMANI
(15, 10, 28),  -- Computer Organization by MR. VINEET DEOPA
(15, 11, 23),  -- Data Communication and Computer Networks by MS. TAMANNA
(15, 12, 25),  -- Discipline-Specific Elective – 2 (Big Data Analytics) by DR. JYOTI PARSOLA
(15, 13, 21),  -- Career Skills – 2 by MR. SAURABH FULARA
(15, 14, 24),  -- Design and Analysis of Algorithms Laboratory by DR. HIMANI
(15, 15, 23),  -- Data Communications and Computer Networks Laboratory by MS. TAMANNA

-- BCA 4 B2 (Section 16)
(16, 8, 24),   -- Introduction to Design and Analysis of Algorithms by DR. HIMANI
(16, 10, 18),  -- Computer Organization by MR. DEEPAK CHAUHAN
(16, 11, 19),  -- Data Communication and Computer Networks by MS. DIVYA KAPIL
(16, 12, 20),  -- Discipline-Specific Elective – 2 (Big Data Analytics) by MR. CHETAN PANDEY
(16, 13, 26),  -- Career Skills – 2 by MR. ABHISHEK SHARMA
(16, 14, 24),  -- Design and Analysis of Algorithms Laboratory by DR. HIMANI
(16, 15, 19),  -- Data Communications and Computer Networks Laboratory by MS. DIVYA KAPIL

-- BCA 4 C2 (Section 17)
(17, 8, 6),    -- Introduction to Design and Analysis of Algorithms by MS. ANAMIKA
(17, 10, 27),  -- Computer Organization by DR. VIVEK CHAMOLI
(17, 11, 19),  -- Data Communication and Computer Networks by MS. ATIKA GUPTA
(17, 12, 20),  -- Discipline-Specific Elective – 2 (Big Data Analytics) by MR. CHETAN PANDEY
(17, 13, 21),  -- Career Skills – 2 by MR. SAURABH FULARA
(17, 14, 6),   -- Design and Analysis of Algorithms Laboratory by MS. ANAMIKA
(17, 15, 19),  -- Data Communications and Computer Networks Laboratory by MS. ATIKA GUPTA

-- BCA 4 D2 (Section 18)
(18, 8, 17),   -- Introduction to Design and Analysis of Algorithms by MS. SHOBHA ASWAL
(18, 10, 28),  -- Computer Organization by MR. VINEET DEOPA
(18, 11, 23),  -- Data Communication and Computer Networks by MS. TAMANNA
(18, 12, 25),  -- Discipline-Specific Elective – 2 (Big Data Analytics) by DR. JYOTI PARSOLA
(18, 13, 26),  -- Career Skills – 2 by MR. ABHISHEK SHARMA
(18, 14, 17),  -- Design and Analysis of Algorithms Laboratory by MS. SHOBHA ASWAL
(18, 15, 23),  -- Data Communications and Computer Networks Laboratory by MS. TAMANNA

-- BCA 4 E2 (Section 19)
(19, 8, 17),   -- Introduction to Design and Analysis of Algorithms by MS. SHOBHA ASWAL
(19, 10, 18),  -- Computer Organization by MR. DEEPAK CHAUHAN
(19, 11, 19),  -- Data Communication and Computer Networks by MS. ATIKA GUPTA
(19, 12, 25),  -- Discipline-Specific Elective – 2 (Big Data Analytics) by DR. JYOTI PARSOLA
(19, 13, 26),  -- Career Skills – 2 by MR. ABHISHEK SHARMA
(19, 14, 17),  -- Design and Analysis of Algorithms Laboratory by MS. SHOBHA ASWAL
(19, 15, 19),  -- Data Communications and Computer Networks Laboratory by MS. ATIKA GUPTA

-- BCA 4 F2 (Section 20)
(20, 8, 17),   -- Introduction to Design and Analysis of Algorithms by MS. SHOBHA ASWAL
(20, 10, 27),  -- Computer Organization by DR. VIVEK CHAMOLI
(20, 11, 19),  -- Data Communication and Computer Networks by MS. DIVYA KAPIL
(20, 12, 20),  -- Discipline-Specific Elective – 2 (Big Data Analytics) by MR. CHETAN PANDEY
(20, 13, 26),  -- Career Skills – 2 by MR. ABHISHEK SHARMA
(20, 14, 17),  -- Design and Analysis of Algorithms Laboratory by MS. SHOBHA ASWAL
(20, 15, 19),  -- Data Communications and Computer Networks Laboratory by MS. DIVYA KAPIL

-- BCA 4 G2 (Section 21)
(21, 8, 24),   -- Introduction to Design and Analysis of Algorithms by DR. HIMANI
(21, 10, 18),  -- Computer Organization by MR. DEEPAK CHAUHAN
(21, 11, 24),  -- Data Communication and Computer Networks by DR. CHANDRAKALA
(21, 12, 25),  -- Discipline-Specific Elective – 2 (Big Data Analytics) by DR. JYOTI PARSOLA
(21, 13, 26),  -- Career Skills – 2 by MR. ABHISHEK SHARMA
(21, 14, 24),  -- Design and Analysis of Algorithms Laboratory by DR. HIMANI
(21, 15, 24),  -- Data Communications and Computer Networks Laboratory by DR. CHANDRAKALA

-- BCA 6th Semester Sections
-- BCA 6 A1+B1 (Section 22)
(22, 16, 31),   -- Computer Graphics by MS. NIDHI MEHRA
(22, 17, 32),   -- Network Security and Cyber Law by MS. NIDHI JOSHI
(22, 18, 33),   -- Fundamentals of Machine Learning by DR. R.K LUXMI
(22, 19, 34),   -- Elective – II (Data Warehousing and Mining) by MS. NIDHI MEHRA
(22, 20, 31),   -- Computer Graphics Lab by MS. NIDHI MEHRA
(22, 21, 33),   -- Machine Learning Lab by DR.LUXMI

-- BCA 6 C1+D1 (Section 23)
(23, 16, 40),   -- Computer Graphics by MR. MADHUR
(23, 17, 3),   -- Network Security and Cyber Law by MS. NEHA BHATT
(23, 18, 24),   -- Fundamentals of Machine Learning by DR. CHANDRAKALA
(23, 19, 33),   -- Elective – II (Data Warehousing and Mining) by DR. LUXMI
(23, 20, 40),   -- Computer Graphics Lab by MR. MADHUR
(23, 21, 24),   -- Machine Learning Lab by DR. CHANDRAKALA

-- BCA 6 E1 (Section 24)
(24, 16, 38),   -- Computer Graphics by DR. SUNIL SHUKLA
(24, 17, 32),   -- Network Security and Cyber Law by MS. NIDHI JOSHI
(24, 18, 39),   -- Fundamentals of Machine Learning by DR. ALKA PANT
(24, 19, 36),   -- Elective – II by MR. TARUN BHATT
(24, 20, 38),   -- Computer Graphics Lab by DR. SUNIL SHUKLA
(24, 21, 39),   -- Machine Learning Lab by DR. ALKA PANT

-- BCA 6 F1 (Section 25)
(25, 16, 36),   -- Computer Graphics by MR. TARUN BHATT
(25, 17, 32),   -- Network Security and Cyber Law by MS. NIDHI JOSHI
(25, 18, 35),   -- Fundamentals of Machine Learning by MS. POONAM VERMA
(25, 19, 33),   -- Elective – II (Data Warehousing and Mining) by DR. LUXMI
(25, 20, 36),   -- Computer Graphics Lab by MR. TARUN BHATT
(25, 21, 35),   -- Machine Learning Lab by MS. POONAM VERMA

-- BCA 6 G1 (Section 26)
(26, 16, 40),   -- Computer Graphics by MR. MADHUR
(26, 17, 3),   -- Network Security and Cyber Law by MS. NEHA BHATT
(26, 18, 39),   -- Fundamentals of Machine Learning by DR. ALKA PANT
(26, 19, 36),   -- Elective – II by MR. TARUN BHATT
(26, 20, 40),   -- Computer Graphics Lab by MR. MADHUR
(26, 21, 39),   -- Machine Learning Lab by DR. ALKA PANT

-- BCA 6 A2+B2 (Section 27)
(27, 16, 31),   -- Computer Graphics by MS. NIDHI MEHRA
(27, 17, 3),   -- Network Security and Cyber Law by MS. NEHA BHATT
(27, 18, 37),   -- Fundamentals of Machine Learning by DR. R.K BISHT
(27, 19, 33),   -- Elective – II (Data Warehousing and Mining) by DR. LUXMI
(27, 20, 31),   -- Computer Graphics Lab by MS. NIDHI MEHRA
(27, 21, 37),   -- Machine Learning Lab by DR. R.K. BISHT

-- BCA 6 C2+D2 (Section 28)
(28, 16, 31),   -- Computer Graphics by MS. NIDHI MEHRA
(28, 17, 3),   -- Network Security and Cyber Law by MS. NIDHI JOSHI
(28, 18, 35),   -- Fundamentals of Machine Learning by MS. POONAM VERMA
(28, 19, 36),   -- Elective – II (Data Warehousing and Mining) by MR. TARUN BHATT
(28, 20, 31),   -- Computer Graphics Lab by MS. NIDHI MEHRA
(28, 21, 35),   -- Machine Learning Lab by MS. POONAM VERMA

-- BCA 6 E2 (Section 29)
(29, 16, 40),   -- Computer Graphics by MR.MADHUR
(29, 17, 3),   -- Network Security and Cyber Law by MS. NEHA BHATT
(29, 18, 39),   -- Fundamentals of Machine Learning by DR. ALKA PANT
(29, 19, 34),   -- Elective – II by MR. NISHA CHANDRAN
(29, 20, 40),   -- Computer Graphics Lab by MR. MADHUR
(29, 21, 39),   -- Machine Learning Lab by DR. ALKA PANT

-- BCA 6 F2 (Section 30)
(30, 16, 38),   -- Computer Graphics by DR. SUNIL SHUKLA
(30, 17, 32),   -- Network Security and Cyber Law by MS. NIDHI JOSHI
(30, 18, 35),   -- Fundamentals of Machine Learning by MS. POONAM VERMA
(30, 19, 36),   -- Elective – II (Data Warehousing and Mining) by MR. TARUN BHATT
(30, 20, 38),   -- Computer Graphics Lab by DR. SUNIL SHUKLA
(30, 21, 35),   -- Machine Learning Lab by MS. POONAM VERMA

-- BCA AI & DS 2nd A1+B1+C1 (Section 32)
(31, 22, 41),   -- Introduction to Data Structures by MR. ADITYA HARBOLA
(31, 23, 42),   -- Fundamentals of Python Programming by MS. DEEPTI NEGI
(31, 24, 34),   -- Foundations of AI by DR. NISHA 
(31, 25, 43),   -- Probability and Statistics for Data science by DR. MAKARAND DHYANI
(31, 26, 7),   -- Discipline-Specific Elective – 1(Operating System) by MS. KAJAL
(31, 27, 41),   -- Data Structures Laboratory by MR. ADITYA HARBOLA
(31, 28, 42),   -- Python Programming Laboratory by MS. DEEPTI NEGI

-- BCA AI & DS 2nd A2 (Section 32)
(32, 22, 41),   -- Introduction to Data Structures by MR. ADITYA HARBOLA
(32, 23, 42),   -- Fundamentals of Python Programming by MS. DEEPTI NEGI
(32, 24, 34),   -- Foundations of AI by DR. NISHA CHANDRAN
(32, 25, 43),   -- Probability and Statistics for Data science by DR. MAKARAND DHYANI
(32, 26, 12),   -- Discipline-Specific Elective – 1(Operating System) by MS. PRIVA KOHLI
(32, 27, 41),   -- Data Structures Laboratory by MR. ADITYA HARBOLA
(32, 28, 42),   -- Python Programming Laboratory by MS. DEEPTI NEGI

-- BCA AI & DS 4th (Section 33)
(33, 36, 10),    -- Full Stack Development by MS. HARSHITA
(33, 38, 46),   -- Data Communication and Networks by DR. MOHIT PAYAL
(33, 37, 13),   -- Data Analytics with R by DR. ANUPRIYA
(33, 40, 25),   -- Discipline-Specific Elective – 2 by DR. JYOTI PARSOLA
(33, 41, 44),   -- Career Skills – 2 by MR. SUHAIL
(33, 42, 10),   -- Full Stack Development Laboratory by MS. HARSHITA
(33, 43, 13),   -- Data Analytics R Laboratory by DR. ANUPRIYA

-- BCA AI & DS 4th (Section 34)
(34, 36, 10),    -- Full Stack Development by MS. HARSHITA
(34, 38, 24),   -- Data Communication and Networks by DR. CHANDRAKALA
(34, 37, 13),   -- Data Analytics with R by DR. ANUPRIYA
(34, 40, 46),   -- Discipline-Specific Elective – 2 by DR. MOHIT PAYAL
(34, 41, 44),   -- Career Skills – 2 by MR. SUHAIL
(34, 42, 10),   -- Full Stack Development Laboratory by MS. HARSHITA
(34, 43, 13),   -- Data Analytics R Laboratory by DR. ANUPRIYA

-- BCA CS & CL 2nd (Section 35)
(35, 29, 41), -- Introduction to Data Structures by MR. ADITYA HARBOLA
(35, 30, 30), -- Computer Networks by MS. DIVYA KAPIL
(35, 31, 48), -- Cyber Security Essentials by MR. BHAVNESH
(35, 32, 46), -- Digital Principles and Computer Organization by MR. MOHIT PAYAL
(35, 33, 43), -- Discipline-Specific Elective – 1, DISCRETE MATHEMATICS by DR. MAKARAND DHYANI
(35, 34, 41), -- Data Structures Laboratory by MR. ADITYA HARBOLA
(35, 35, 30); -- Computer Networks Lab by MS. DIVYA KAPIL

-- Insert timetable entries
 INSERT INTO timetable (section_subject_teacher_id, room_id, day_of_week, start_time, end_time) VALUES
 
-- BCA 2 A1+B1 (Section 1)
(1, 4, 'Monday', '08:00:00', '08:55:00'),  -- TBC201 LT-502
(2, 4, 'Monday', '08:55:00', '09:50:00'),  -- TBC202 LT-502
(5, 4, 'Monday', '10:10:00', '11:05:00'),  -- TBC211 LT-502
(4, 4, 'Monday', '11:05:00', '12:00:00'),  -- TBC204 LT-502

(3, 2, 'Tuesday', '08:00:00', '08:55:00'),  -- TBC203 LT-402
(1, 2, 'Tuesday', '08:55:00', '09:50:00'),  -- TBC201 LT-402
(2, 2, 'Tuesday', '10:10:00', '11:05:00'),  -- TBC202 LT-402

(6, 22, 'Wednesday', '08:00:00', '09:50:00'),  -- PBC201 B1 IOT LAB
(7, 22, 'Wednesday', '10:10:00', '12:00:00'),  -- PBC202 A1 IOT LAB

(5, 2, 'Thursday', '08:00:00', '08:55:00'),  -- TBC211 LT-402
(4, 2, 'Thursday', '08:55:00', '09:50:00'),  -- TBC204 LT-402
(3, 2, 'Thursday', '10:10:00', '11:05:00'),  -- TBC203 LT-402
(5, 2, 'Thursday', '11:05:00', '12:00:00'),  -- TBC211 LT-402
(2, 2, 'Thursday', '12:00:00', '12:55:00'),  -- TBC202 LT-402

(6, 21, 'Friday', '12:00:00', '13:50:00'),  -- PBC201 A1 LAB7
(3, 2, 'Friday', '15:05:00', '16:00:00'),   -- TBC203 LT-402
(1, 2, 'Friday', '16:00:00', '17:55:00'),   -- TBC201 LT-402
(4, 2, 'Friday', '17:55:00', '18:50:00'),   -- TBC204 LT-402

-- BCA 2 C1 (Section 2)
(10, 13, 'Tuesday', '08:55:00', '09:50:00'),  -- TBC 203 CR-102
(14, 21, 'Tuesday', '10:10:00', '12:00:00'),  -- PBC 202 LAB 7
(9, 14, 'Tuesday', '12:05:00', '13:00:00'),   -- TBC 202 CR-304

(11, 15, 'Wednesday', '08:00:00', '08:55:00'),  -- TBC204 CR-403
(12, 15, 'Wednesday', '08:55:00', '09:50:00'),  -- TBC 211 CR-403
(8, 15, 'Wednesday', '10:10:00', '11:05:00'),  -- TBC 201 CR-403
(10, 15, 'Wednesday', '11:05:00', '12:00:00'),  -- TBC 203 CR-403

(13, 19, 'Thursday', '08:00:00', '09:50:00'),  -- PBC 201 Lab 4
(9, 10, 'Thursday', '10:10:00', '11:05:00'),  -- TBC 202 CR-201

(11, 15, 'Friday', '08:00:00', '08:55:00'),  -- TBC 204 CR-403
(8, 15, 'Friday', '08:55:00', '09:50:00'),  -- TBC 201 CR-403
(10, 15, 'Friday', '11:05:00', '12:00:00'),  -- TBC 203 CR-403
(12, 15, 'Friday', '10:10:00', '11:05:00'),   -- TBC 211 CR-403 

(8, 15, 'Saturday', '08:00:00', '08:55:00'),  -- TBC 201 CR-403
(11, 15, 'Saturday', '08:55:00', '09:50:00'),  -- TBC 204 CR-403
(9, 15, 'Saturday', '10:10:00', '11:05:00'),  -- TBC 202 CR-403
(12, 15, 'Saturday', '11:05:00', '12:00:00'),  -- TBC 211 CR-403

-- BCA 2 D1 (Section 3)
(19, 7, 'Monday', '08:00:00', '08:55:00'),  -- TBC 211 CR-103
(17, 7, 'Monday', '08:55:00', '09:50:00'),  -- TBC 203 CR-103
(18, 6, 'Monday', '10:10:00', '11:05:00'),  -- TBC 204 CR-102
(15, 6, 'Monday', '11:05:00', '12:00:00'),  -- TBC 201 CR-102
(17, 6, 'Monday', '12:00:00', '12:55:00'),  -- TBC 203 CR-102

(18, 9, 'Tuesday', '08:00:00', '08:55:00'),  -- TBC 204 CR-105
(21, 22, 'Tuesday', '10:10:00', '12:00:00'),  -- PBC 202 IOT LAB

(15, 6, 'Wednesday', '08:00:00', '08:55:00'),  -- TBC 201 CR-102
(18, 6, 'Wednesday', '10:10:00', '11:05:00'),  -- TBC 204 CR-102
(16, 6, 'Wednesday', '11:05:00', '12:00:00'),  -- TBC 202 CR-102

(15, 15, 'Thursday', '08:00:00', '08:55:00'),  -- TBC 201 CR-403
(17, 15, 'Thursday', '08:55:00', '09:50:00'),  -- TBC 203 CR-403
(16, 15, 'Thursday', '10:10:00', '11:05:00'),  -- TBC 202 CR-403
(19, 15, 'Thursday', '11:05:00', '12:00:00'),  -- TBC 211 CR-403

(19, 6, 'Friday', '08:55:00', '09:50:00'),  -- TBC 211 CR-102
(20, 22, 'Friday', '10:10:00', '12:00:00'),  -- PBC 201 IOT LAB
(16, 6, 'Friday', '12:00:00', '12:55:00'),  -- TBC 202 CR-102

-- BCA 2 E1 (Section 4)
(23, 14, 'Monday', '12:00:00', '12:55:00'),  -- TBC 202 CR-304
(22, 6, 'Monday', '12:55:00', '13:50:00'),  -- TBC 201 CR-102
(27, 20, 'Monday', '14:10:00', '16:00:00'),  -- PBC 201 LAB 6

(25, 7, 'Tuesday', '12:00:00', '12:55:00'),  -- TBC 204 CR-103
(24, 7, 'Tuesday', '14:10:00', '15:05:00'),  -- TBC 203 CR-103
(23, 6, 'Tuesday', '15:05:00', '16:00:00'),  -- TBC 202 CR-102
(28, 22, 'Tuesday', '16:00:00', '17:50:00'),  -- PBC 202 IOT LAB

(22, 17, 'Wednesday', '12:00:00', '12:55:00'),  -- TBC 201 CR-405
(26, 17, 'Wednesday', '14:10:00', '15:05:00'),  -- TBC 211 CR-405
(23, 17, 'Wednesday', '15:05:00', '16:00:00'),  -- TBC 202 CR-405

(26, 7, 'Friday', '08:00:00', '08:55:00'),  -- TBC 211 CR-103
(25, 7, 'Friday', '08:55:00', '09:50:00'),  -- TBC 204 CR-103
(22, 7, 'Friday', '10:10:00', '11:05:00'),  -- TBC 201 CR-103
(24, 7, 'Friday', '11:05:00', '12:00:00'),  -- TBC 203 CR-103
(26, 7, 'Friday', '12:00:00', '12:55:00'),  -- TBC 211 CR-103

(25, 16, 'Saturday', '08:00:00', '08:55:00'),  -- TBC 204 CR-404
(24, 16, 'Saturday', '08:55:00', '09:50:00'),  -- TBC 203 CR-404

-- BCA 2 A2+B2 (Section 5)

(34, 19, 'Tuesday', '08:00:00', '09:50:00'),  -- PBC 201 A2 Lab 4
(33, 1, 'Tuesday', '12:00:00', '12:55:00'),  -- TBC 211 LT-501
(32, 1, 'Tuesday', '14:10:00', '15:05:00'),  -- TBC 204 LT-501
(31, 1, 'Tuesday', '15:05:00', '16:00:00'),  -- TBC 203 LT-501

(29, 4, 'Wednesday', '08:00:00', '08:55:00'),  -- TBC 201 LT-502
(30, 4, 'Wednesday', '08:55:00', '09:50:00'),  -- TBC 202 LT-502
(31, 4, 'Wednesday', '10:10:00', '11:05:00'),  -- TBC 203 LT-502
(33, 4, 'Wednesday', '11:05:00', '12:00:00'),  -- TBC 211 LT-502
(34, 21, 'Wednesday', '12:00:00', '13:50:00'),  -- PBC 201 B2 Lab 7 

(30, 4, 'Thursday', '11:05:00', '12:00:00'),  -- TBC 202 LT-502
(32, 4, 'Thursday', '12:55:00', '13:50:00'),  -- TBC 204 LT-502
(31, 4, 'Thursday', '14:10:00', '15:05:00'),  -- TBC 203 LT-502

(35, 20, 'Friday', '08:00:00', '09:50:00'),  -- PBC 202 A2 LAB 6
(33, 1, 'Friday', '10:10:00', '11:05:00'),  -- TBC 211 LT-401
(30, 1, 'Friday', '11:05:00', '12:00:00'),  -- TBC 202 LT-401
(29, 1, 'Friday', '12:00:00', '12:55:00'),  -- TBC 201 LT-401

(29, 1, 'Saturday', '14:10:00', '15:05:00'),  -- TBC 201 LT-401
(32, 1, 'Saturday', '15:05:00', '16:00:00'),  -- TBC 204 LT-401
(35, 20, 'Saturday', '16:00:00', '17:50:00'),  -- PBC 202 B2 LAB 6

-- BCA 2 C2 (Section 6)
(36, 18, 'Monday', '08:55:00', '09:50:00'),  -- TBC 201 CR-406
(40, 18, 'Monday', '11:05:00', '12:00:00'),  -- TBC 211 CR-406
(38, 18, 'Monday', '12:00:00', '12:55:00'),  -- TBC 203 CR-406

(39, 18, 'Tuesday', '12:55:00', '13:50:00'),  -- TBC 204 CR-406
(40, 18, 'Tuesday', '15:10:00', '16:00:00'),  -- TBC 211 CR-406
(41, 19, 'Tuesday', '16:00:00', '17:50:00'),  -- PBC 201 LAB 4

(37, 6, 'Wednesday', '12:00:00', '12:55:00'),  -- TBC 202 CR-102
(36, 18, 'Wednesday', '14:10:00', '15:05:00'),  -- TBC 201 CR-406
(38, 18, 'Wednesday', '15:05:00', '16:00:00'),  -- TBC 203 CR-406
(42, 20, 'Wednesday', '16:00:00', '17:50:00'),  -- PBC 202 Lab 6

(40, 18, 'Thursday', '12:55:00', '13:50:00'),  -- TBC 211 CR-406
(37, 18, 'Thursday', '15:05:00', '16:00:00'),  -- TBC 202 CR-406
(36, 18, 'Thursday', '16:00:00', '16:55:00'),  -- TBC 201 CR-406
(39, 18, 'Thursday', '16:55:00', '17:50:00'),  -- TBC 204 CR-406

(39, 16, 'Friday', '12:00:00', '12:55:00'),  -- TBC 204 CR-404
(38, 16, 'Friday', '12:55:00', '13:50:00'),  -- TBC 203 CR-404
(37, 2, 'Friday', '14:10:00', '15:05:00'),  -- TBC 202 LT 402

-- BCA 2 D2 (Section 7)
(47, 9, 'Monday', '12:00:00', '12:55:00'),  -- TBC 211 CR-105
(45, 5, 'Monday', '12:55:00', '13:50:00'),  -- TBC 203 CR-101
(44, 5, 'Monday', '15:05:00', '16:00:00'),  -- TBC 202 CR-101
(46, 5, 'Monday', '16:00:00', '16:55:00'),  -- TBC 204 CR-101

(49, 20, 'Tuesday', '12:00:00', '13:50:00'),  -- PBC 202 LAB 6
(43, 5, 'Tuesday', '14:10:00', '15:05:00'),  -- TBC 201 CR-101

(45, 7, 'Wednesday', '12:00:00', '12:55:00'),  -- TBC 203 CR-103
(43, 6, 'Wednesday', '14:10:00', '15:05:00'),  -- TBC 201 CR-102
(44, 6, 'Wednesday', '15:05:00', '16:00:00'),  -- TBC 202 CR-102

(46, 7, 'Thursday', '12:00:00', '12:55:00'),  -- TBC 204 CR-103
(42, 6, 'Thursday', '12:55:00', '13:50:00'),  -- TBC 202 CR-102
(48, 22, 'Thursday', '14:10:00', '16:00:00'),  -- PBC 201 IOT LAB
(47, 16, 'Thursday', '16:00:00', '16:55:00'),  -- TBC 211 CR-404

(46, 9, 'Friday', '12:55:00', '13:50:00'),  -- TBC 204 CR-105
(45, 7, 'Friday', '15:05:00', '16:00:00'),  -- TBC 203 CR-103
(47, 7, 'Friday', '16:00:00', '16:55:00'),  -- TBC 211 CR-103
(43, 7, 'Friday', '16:55:00', '17:50:00'),  -- TBC 201 CR-103

-- BCA 2 E2 (Section 8)
(56, 20, 'Monday', '12:00:00', '13:50:00'),  -- PBC 202 LAB 6
(51, 9, 'Monday', '15:05:00', '16:00:00'),  -- TBC 202 CR-105
(54, 9, 'Monday', '16:00:00', '16:50:00'),  -- TBC 211 CR-105

(53, 16, 'Wednesday', '12:00:00', '12:55:00'),  -- TBC 204 CR-404
(51, 7, 'Wednesday', '12:55:00', '13:50:00'),  -- TBC 202 CR-103
(50, 7, 'Wednesday', '14:10:00', '15:05:00'),  -- TBC 201 CR-103
(52, 18, 'Wednesday', '16:00:00', '16:55:00'),  -- TBC 203 CR-406

(50, 9, 'Thursday', '12:55:00', '13:50:00'),  -- TBC 201 CR-105
(54, 9, 'Thursday', '14:10:00', '15:05:00'),  -- TBC 211 CR-105
(52, 9, 'Thursday', '15:05:00', '16:00:00'),  -- TBC 203 CR-105
(53, 9, 'Thursday', '16:00:00', '16:55:00'),  -- TBC 204 CR-105

(50, 9, 'Friday', '12:00:00', '12:55:00'),  -- TBC 201 CR-105
(52, 9, 'Friday', '14:10:00', '15:05:00'),  -- TBC 203 CR-105
(51, 9, 'Friday', '15:05:00', '16:00:00'),  -- TBC 202 CR-105
(53, 9, 'Friday', '16:00:00', '16:55:00'),  -- TBC 204 CR-105

(54, 9, 'Saturday', '08:55:00', '09:50:00'),  -- TBC 211 CR-105
(55, 22, 'Saturday', '10:10:00', '12:00:00'),  -- PBC 201 IOT LAB

-- BCA 6 A1+B1 (Section 16)
(151, 1, 'Tuesday', '08:00:00', '08:55:00'), -- TBC 604 LT-401
(149, 1, 'Tuesday', '08:55:00', '09:50:00'), -- TBC 602 LT-401
(150, 1, 'Tuesday', '10:10:00', '11:05:00'), -- TBC 603 LT-401
(148, 1, 'Tuesday', '11:05:00', '12:00:00'), -- TBC 601 LT-401

(150, 1, 'Wednesday', '08:55:00', '09:50:00'), -- TBC 603 LT-401
(152, 23, 'Wednesday', '10:10:00', '12:00:00'), -- PBC 601(B1) TCL 4 LAB 4
-- (153, 19, 'Wednesday', '10:10:00', '12:00:00'), -- PBC 602(A1) LAB 4

(150, 1, 'Thursday', '08:00:00', '08:55:00'), -- TBC 603 LT-401
(151, 1, 'Thursday', '08:55:00', '09:50:00'), -- TBC 604 LT-401
(148, 1, 'Thursday', '10:10:00', '11:05:00'), -- TBC 601 LT-401
(149, 1, 'Thursday', '11:05:00', '12:00:00'), -- TBC 602 LT-401
(148, 3, 'Thursday', '12:00:00', '12:55:00'), -- TBC 601 LT-501

(149, 1, 'Friday', '08:00:00', '08:55:00'), -- TBC 602 LT-401
(151, 1, 'Friday', '08:55:00', '09:50:00'), -- TBC 604 LT-401
(152, 23, 'Friday', '10:10:00', '12:00:00'), -- PBC 601(A1) TCL 4 LAB 4
-- (153, 19, 'Friday', '10:10:00', '12:00:00'), -- PBC 602(B1) LAB 4

-- BCA 6 C1+D1 (Section 17)
(154, 1, 'Monday', '12:55:00', '13:50:00'), -- TBC 601 LT-401
(157, 1, 'Monday', '14:10:00', '15:05:00'), -- TBC 604 LT-401
(155, 1, 'Monday', '15:05:00', '16:00:00'), -- TBC 602 LT-401

(154, 1, 'Tuesday', '12:55:00', '13:50:00'), -- TBC 601 LT-401
(155, 1, 'Tuesday', '14:10:00', '15:05:00'), -- TBC 602 LT-401
(157, 1, 'Tuesday', '15:05:00', '16:00:00'), -- TBC 604 LT-401
(156, 1, 'Tuesday', '16:00:00', '16:55:00'), -- TBC 603 LT-401

(157, 1, 'Wednesday', '12:55:00', '13:50:00'), -- TBC 603 LT-401
(154, 1, 'Wednesday', '14:10:00', '15:05:00'), -- TBC 601 LT-401
(157, 1, 'Wednesday', '15:05:00', '16:00:00'), -- TBC 603 LT-401
-- (156, 4, 'Wednesday', '15:05:00', '16:00:00'), -- PBC 601 C1 TCL4 LAB
(159, 19, 'Wednesday', '16:00:00', '17:50:00'), -- PBC 602 D1 LAB 4

-- (28, 4, 'Thursday', '10:10:00', '11:05:00'), -- PBC 601 D1 TCL-4 LAB
(159, 19, 'Thursday', '12:00:00', '13:50:00'), -- PBC 602 C1 LAB 4
(157, 1, 'Thursday', '14:10:00', '15:05:00'), -- TBC 604 LT-401
(155, 1, 'Thursday', '15:05:00', '16:00:00'), -- TBC 602 LT-401

-- BCA 6 E1 (Section 18)
(165, 19, 'Monday', '08:00:00', '09:50:00'), -- PBC 602 LAB 4
(164, 23, 'Monday', '10:10:00', '12:00:00'), -- PBC 601 TCL 4 LAB

(163, 17, 'Tuesday', '12:55:00', '13:50:00'), -- TBC 604 CR-405
(160, 17, 'Tuesday', '15:05:00', '16:00:00'), -- TBC 601 CR-405
(161, 17, 'Tuesday', '16:00:00', '16:55:00'), -- TBC 602 CR-405
(162, 17, 'Tuesday', '16:55:00', '17:50:00'), -- TBC 603 CR-405

(160, 17, 'Wednesday', '08:00:00', '08:55:00'), -- TBC 601 CR-405
(162, 17, 'Wednesday', '08:55:00', '09:50:00'), -- TBC 603 CR-405
(161, 17, 'Wednesday', '10:10:00', '11:05:00'), -- TBC 602 CR-405
(163, 17, 'Wednesday', '11:05:00', '12:00:00'), -- TBC 604 CR-405

(163, 17, 'Friday', '12:55:00', '13:50:00'), -- TBC 604 CR-405
(160, 17, 'Friday', '14:10:00', '15:05:00'), -- TBC 601 CR-405
(161, 17, 'Friday', '15:05:00', '16:00:00'), -- TBC 602 CR-405
(162, 17, 'Friday', '16:00:00', '16:55:00'), -- TBC 603 CR-405

-- BCA 6 F1 (Section 19)
(166, 17, 'Tuesday', '08:00:00', '08:55:00'), -- TBC 601 CR-405
(168, 17, 'Tuesday', '08:55:00', '09:50:00'), -- TBC 603 CR-405
(167, 17, 'Tuesday', '10:10:00', '11:05:00'), -- TBC 602 CR-405
(169, 17, 'Tuesday', '11:05:00', '12:00:00'), -- TBC 604 CR-405

(168, 17, 'Thursday', '08:00:00', '08:55:00'), -- TBC 603 CR-405
(169, 17, 'Thursday', '08:55:00', '09:50:00'), -- TBC 604 CR-405
(167, 17, 'Thursday', '10:10:00', '11:05:00'), -- TBC 602 CR-405
(166, 17, 'Thursday', '11:05:00', '12:00:00'), -- TBC 601 CR-405

(169, 17, 'Friday', '08:00:00', '08:55:00'), -- TBC 604 CR-405
(166, 17, 'Friday', '08:55:00', '09:50:00'), -- TBC 601 CR-405
(168, 17, 'Friday', '10:10:00', '11:05:00'), -- TBC 603 CR-405
(167, 17, 'Friday', '11:05:00', '12:00:00'), -- TBC 602 CR-405

(170, 19, 'Saturday', '08:00:00', '09:50:00'), -- PBC 602 LAB 4
(169, 25, 'Saturday', '10:10:00', '12:00:00'), -- PBC 601 TCL-2 LAB

-- BCA 6 G1 (Section 20)
(173, 18, 'Monday', '12:55:00', '13:50:00'), -- TBC 602 CR-406
(174, 18, 'Monday', '14:10:00', '15:05:00'), -- TBC 603 CR-406
(172, 18, 'Monday', '15:05:00', '16:00:00'), -- TBC 601 CR-406

(176, 23, 'Tuesday', '08:00:00', '09:50:00'), -- PBC 601 TCL 4 LAB
(177, 19, 'Tuesday', '10:10:00', '12:00:00'), -- PBC 602 LAB 4
(175, 17, 'Tuesday', '12:00:00', '12:55:00'), -- TBC 604 CR-405

(174, 18, 'Thursday', '08:00:00', '08:55:00'), -- TBC 603 CR-406
(175, 18, 'Thursday', '08:55:00', '09:50:00'), -- TBC 604 CR-406
(172, 18, 'Thursday', '10:10:00', '11:05:00'), -- TBC 601 CR-406
(173, 18, 'Thursday', '11:05:00', '12:00:00'), -- TBC 602 CR-406

(175, 18, 'Friday', '08:00:00', '08:55:00'), -- TBC 604 CR-406
(174, 18, 'Friday', '08:55:00', '09:50:00'), -- TBC 603 CR-406
(173, 18, 'Friday', '10:10:00', '11:05:00'), -- TBC 602 CR-406
(172, 18, 'Friday', '11:05:00', '12:00:00'), -- TBC 601 CR-406

-- BCA 6 A2+B2 (Section 21)
(181, 1, 'Monday', '08:00:00', '08:55:00'), -- TBC 604 LT-401
(180, 1, 'Monday', '08:55:00', '09:50:00'), -- TBC 603 LT-401
(179, 1, 'Monday', '10:10:00', '11:05:00'), -- TBC 602 LT-401

(181, 4, 'Tuesday', '08:00:00', '08:55:00'), -- TBC 604 LT-502
(178, 4, 'Tuesday', '08:55:00', '09:50:00'), -- TBC 601 LT-502
(180, 4, 'Tuesday', '10:10:00', '11:05:00'), -- TBC 603 LT-502
(179, 4, 'Tuesday', '11:05:00', '12:00:00'), -- TBC 602 LT-502
(178, 4, 'Tuesday', '12:00:00', '12:55:00'), -- TBC 601 LT-502

(179, 4, 'Wednesday', '12:55:00', '13:50:00'), -- TBC 602 LT-502
(181, 4, 'Wednesday', '14:10:00', '15:05:00'), -- TBC 604 LT-502
(180, 4, 'Wednesday', '15:05:00', '16:00:00'), -- TBC 603 LT-502
(178, 4, 'Wednesday', '16:00:00', '16:55:00'), -- TBC 601 LT-502

(182, 21, 'Thursday', '08:00:00', '09:50:00'), -- PBC 601 SEC(A2) TCL-1 LAB
(183, 19, 'Thursday', '10:10:00', '12:00:00'), -- PBC 602 SEC(A2) LAB 4

(182, 24, 'Friday', '08:00:00', '09:50:00'), -- PBC 601 SEC(B2) TCL-4 LAB
(183, 21, 'Friday', '10:10:00', '12:00:00'), -- PBC 602 SEC(B2) LAB 7

-- BCA 6 C2+D2 (Section 22)
(186, 2, 'Tuesday', '12:00:00', '12:55:00'), -- TBC 603 LT-402
(185, 2, 'Tuesday', '12:55:00', '13:50:00'), -- TBC 602 LT-402
(187, 4, 'Tuesday', '15:05:00', '16:00:00'), -- TBC 604 LT-502
(186, 4, 'Tuesday', '16:00:00', '16:55:00'), -- TBC 603 LT-502

-- (188, 21, 'Wednesday', '14:10:00', '16:00:00'), -- PBC 601 SEC (D2) TCL-1 LAB
(189, 19, 'Wednesday', '14:10:00', '16:00:00'), -- PBC 602 SEC (C2) LAB 4
(187, 1, 'Wednesday', '16:00:00', '16:55:00'), -- TBC 604 LT-401
(185, 1, 'Wednesday', '16:55:00', '17:50:00'), -- TBC 602 LT-401

(185, 1, 'Friday', '08:00:00', '08:55:00'), -- TBC 602 LT-401
(187, 1, 'Friday', '08:55:00', '09:50:00'), -- TBC 604 LT-401
(184, 1, 'Friday', '10:10:00', '11:05:00'), -- TBC 601 LT-401
(186, 1, 'Friday', '11:05:00', '12:00:00'), -- TBC 603 LT-401

(184, 1, 'Saturday', '08:00:00', '08:55:00'), -- TBC 601 LT-401
-- (188, 21, 'Saturday', '08:55:00', '09:50:00'), -- PBC 601 SEC (C2) TCL-1 LAB
(189, 21, 'Saturday', '10:10:00', '12:00:00'), -- PBC 602 SEC(D2) LAB 7
(184, 1, 'Saturday', '12:00:00', '12:55:00'), -- TBC 601 LT-401

-- BCA 6 E2 (Section 23)
(191, 5, 'Monday', '08:55:00', '09:50:00'), -- TBC 602 CR-101
(190, 5, 'Monday', '10:10:00', '11:05:00'), -- TBC 601 CR-101
(193, 5, 'Monday', '11:05:00', '12:00:00'), -- TBC 604 CR-101
(192, 5, 'Monday', '12:00:00', '12:55:00'), -- TBC 603 CR-101

(191, 18, 'Tuesday', '08:00:00', '08:55:00'), -- TBC 602 CR-406
(193, 18, 'Tuesday', '08:55:00', '09:50:00'), -- TBC 604 CR-406
(190, 18, 'Tuesday', '10:10:00', '11:05:00'), -- TBC 601 CR-406
(193, 18, 'Tuesday', '11:05:00', '12:00:00'), -- TBC 604 CR-406

(192, 17, 'Thursday', '12:55:00', '13:50:00'), -- TBC 603 CR-405
(191, 17, 'Thursday', '14:10:00', '15:05:00'), -- TBC 602 CR-405
(192, 17, 'Thursday', '15:05:00', '16:00:00'), -- TBC 603 CR-405
(190, 17, 'Thursday', '16:00:00', '16:55:00'), -- TBC 601 CR-405

(194, 24, 'Friday', '12:00:00', '12:55:00'), -- PBC 601 TCL-1 LAB
(195, 20, 'Friday', '12:55:00', '13:50:00'), -- PBC 602 LAB 6

-- BCA 6 F2 (Section 24)
(199, 17, 'Monday', '12:00:00', '12:55:00'), -- TBC 604 CR-405
(196, 17, 'Monday', '12:55:00', '13:50:00'), -- TBC 601 CR-405
(197, 17, 'Monday', '14:10:00', '15:05:00'), -- TBC 602 CR-405
(199, 17, 'Monday', '15:05:00', '16:00:00'), -- TBC 604 CR-405

(196, 15, 'Tuesday', '12:00:00', '12:55:00'), -- TBC 601 CR-403
(197, 15, 'Tuesday', '14:10:00', '15:05:00'), -- TBC 602 CR-403
(198, 15, 'Tuesday', '15:05:00', '16:00:00'), -- TBC 603 CR-403

(198, 18, 'Wednesday', '08:00:00', '08:55:00'), -- TBC 603 CR-406
(198, 18, 'Wednesday', '08:55:00', '09:50:00'), -- TBC 603 CR-406
(199, 18, 'Wednesday', '10:10:00', '11:05:00'), -- TBC 604 CR-406
(196, 18, 'Wednesday', '11:05:00', '12:00:00'), -- TBC 601 CR-406
(197, 18, 'Wednesday', '12:00:00', '12:55:00'), -- TBC 602 CR-406

(200, 26, 'Thursday', '08:00:00', '09:50:00'), -- PBC 601 TCL-3LAB
(201, 10, 'Thursday', '10:10:00', '12:00:00'), -- PBC 602 LAB 6

-- BCA AI & DS 2nd (A1+B1+C1)
-- Monday
(207, 22, 'Monday', '12:00:00', '13:50:00'),  -- PBD 201 IOT LAB B1
(205, 3, 'Monday', '14:10:00', '15:05:00'),   -- TBD 204 LT 501
(202, 3, 'Monday', '15:05:00', '16:00:00'),   -- TBD 201 LT 501
(207, 22, 'Monday', '16:00:00', '17:50:00'),  -- PBD 201 IOT A1

-- Tuesday
(205, 3, 'Tuesday', '14:10:00', '15:05:00'),   -- TBD 204 LT 501
(203, 3, 'Tuesday', '15:05:00', '16:00:00'),   -- TBD 202 LT 501
(202, 2, 'Tuesday', '16:00:00', '16:55:00'),   -- TBD 201 LT 402
(208, 21, 'Tuesday', '16:55:00', '17:50:00'),  -- PBD 202 LAB 7 C1

-- Wednesday
(206, 2, 'Wednesday', '12:55:00', '13:50:00'),  -- TBD 212 LT 402
(204, 2, 'Wednesday', '14:10:00', '15:05:00'),  -- TBD 203 LT 402
(202, 2, 'Wednesday', '15:05:00', '16:00:00'),  -- TBD 201 LT 402
(208, 21, 'Wednesday', '16:00:00', '17:50:00'), -- PBD 202 LAB 7 B1

-- Thursday 
(203, 2, 'Thursday', '12:55:00', '13:50:00'),  -- TBD 202 LT 402
(204, 2, 'Thursday', '14:10:00', '15:05:00'),  -- TBD 203 LT 402
(206, 2, 'Thursday', '15:05:00', '16:00:00'),  -- TBD 212 LT 402
(207, 21, 'Thursday', '16:00:00', '17:50:00'),    -- PBD 201 LAB 7 C1
(208, 22, 'Thursday', '16:00:00', '17:50:00'),    -- PBD 202 IOT LAB A1

-- Friday
(206, 3, 'Friday', '12:55:00', '13:50:00'),      -- TBD 212 LT 501
(204, 3, 'Friday', '14:10:00', '15:05:00'),      -- TBD 203 LT 501
(205, 3, 'Friday', '15:05:00', '16:00:00'),      -- TBD 204 LT 501
(203, 3, 'Friday', '16:00:00', '16:55:00'),      -- TBD 202 LT 501

-- BCA AI & DS 2nd A2
-- Monday
(215, 19, 'Monday', '10:10:00', '12:00:00'),     -- PBD 202(G2) LAB 4
(212, 3, 'Monday', '12:00:00', '12:55:00'),      -- TBD 204 LT 501
(211, 3, 'Monday', '12:55:00', '13:50:00'),      -- TBD 203 LT 501
(212, 4, 'Monday', '15:05:00', '16:00:00'),      -- TBD 204 LT 502
(213, 4, 'Monday', '16:00:00', '16:55:00'),      -- TBD 212 LT 502

-- Tuesday
(210, 4, 'Tuesday', '12:55:00', '13:50:00'),     -- TBD 202 LT 502
(211, 4, 'Tuesday', '14:10:00', '15:05:00'),     -- TBD 203 LT 502
(212, 2, 'Tuesday', '16:00:00', '16:55:00'),     -- TBD 204 LT 402
(209, 2, 'Tuesday', '16:55:00', '17:50:00'),     -- TBD 201 LT 402

-- Wednesday
(209, 1, 'Wednesday', '12:00:00', '12:55:00'),   -- TBD 201 LT 401
(210, 3, 'Wednesday', '14:10:00', '15:05:00'),   -- TBD 202 LT 501
(214, 22, 'Wednesday', '16:00:00', '17:50:00'),  -- PBD 201 (G2) IOT Lab

-- Friday
(209, 2, 'Friday', '12:00:00', '12:55:00'),      -- TBD 201 LT 402
(213, 2, 'Friday', '12:55:00', '13:50:00'),      -- TBD 212 LT 402
(214, 21, 'Friday', '13:10:00', '16:00:00'),     -- PBD 201 LAB 7 G1
(211, 4, 'Friday', '16:00:00', '16:55:00'),      -- TBD 203 LT 502

-- Saturday
(215, 22, 'Saturday', '08:00:00', '09:50:00'),   -- PBD 202 IOT LAB G1
(210, 2, 'Saturday', '12:00:00', '12:55:00'),    -- TBD 202 LT 402
(213, 27, 'Saturday', '12:55:00', '13:50:00'),  -- TBD 212 LT 202

-- BCA AI & DS 4TH (A1+B1)
-- Monday
(219, 2, 'Monday', '12:55:00', '13:50:00'),      -- TBD 405 LT-402
(216, 2, 'Monday', '14:10:00', '15:05:00'),      -- TBD 401 LT-402
(219, 2, 'Monday', '15:05:00', '16:00:00'),      -- TBD 405 LT-402

-- Tuesday
(217, 6, 'Tuesday', '12:55:00', '13:50:00'),   -- TBD 403 CR-102
(216, 6, 'Tuesday', '14:10:00', '15:05:00'),   -- TBD 401 CR-102
(220, 6, 'Tuesday', '16:00:00', '16:55:00'),   -- TBD 406 CR-102
(218, 6, 'Tuesday', '16:55:00', '17:50:00'),   -- TBD 402 CR-102

-- THURSDAY
(219, 6, 'Thursday', '12:00:00', '12:55:00'),    -- TBD 405 CR-102
(216, 7, 'Thursday', '14:10:00', '15:05:00'),    -- TBD 401 CR-103
(220, 7, 'Thursday', '15:05:00', '16:00:00'),    -- TBD 406 CR-103
(218, 7, 'Thursday', '15:05:00', '16:00:00'),    -- TBD 402 CR-103

-- FRIDAY
(218, 6, 'Friday', '12:00:00', '12:55:00'),  -- TBD 402 CR-102
(217, 6, 'Friday', '15:05:00', '16:00:00'),  -- TBD 403 CR-102
(221, 22, 'Friday', '16:00:00', '17:50:00'),   -- PBD 401 B1 IOT LAB
(222, 21, 'Friday', '16:00:00', '17:50:00'),   -- PBD 402 LAB 7 A1

-- SATURDAY
(218, 6, 'Saturday', '12:00:00', '12:55:00'),  -- TBD 402 CR-102
(221, 20, 'Saturday', '14:10:00', '16:00:00'),   -- PBD 401 LAB 6 A1
(222, 21, 'Saturday', '14:10:00', '16:00:00'),   -- PBD 402 LAB 7 B1

-- BCA AI & DS 4th (A2+B2)
-- Monday
(223, 6, 'Monday', '08:00:00', '08:55:00'),   -- TBD 401 CR 102
(226, 6, 'Monday', '08:55:00', '09:50:00'),   -- TBD 405 CR 102
(228, 21, 'Monday', '10:10:00', '12:00:00'),     -- PBD 401 LAB 7 A2

-- Tuesday
(223, 6, 'Tuesday', '08:00:00', '08:55:00'),  -- TBD 401 CR 102
(226, 6, 'Tuesday', '10:10:00', '11:05:00'),  -- TBD 405 CR 102
(225, 6, 'Tuesday', '11:05:00', '12:00:00'),  -- TBD 402 CR 102
(227, 6, 'Tuesday', '12:00:00', '12:55:00'),  -- TBD 406 CR 102

-- Wednesday
(229, 21, 'Wednesday', '08:00:00', '09:50:00'),  -- PBD 402 LAB 7 A2
(228, 21, 'Wednesday', '10:10:00', '12:00:00'),  -- PBD 401 LAB 7 B2

-- Thursday
(223, 6, 'Thursday', '08:00:00', '08:55:00'), -- TBD 401 CR 102
(224, 6, 'Thursday', '08:55:00', '09:50:00'), -- TBD 403 CR 102
(229, 21, 'Thursday', '10:10:00', '12:00:00'),   -- PBD 402 LAB 7 B2

-- Friday
(224, 6, 'Friday', '08:00:00', '08:55:00'),   -- TBD 403 CR 102
(225, 6, 'Friday', '10:10:00', '11:05:00'),   -- TBD 402 CR 102
(227, 6, 'Friday', '11:05:00', '12:00:00'),   -- TBD 406 CR 102

-- Saturday
(226, 6, 'Saturday', '08:00:00', '08:55:00'), -- TBD 405 CR 102
(224, 6, 'Saturday', '08:55:00', '09:50:00'), -- TBD 403 CR 102
(225, 6, 'Saturday', '10:10:00', '11:05:00'), -- TBD 402 CR 102

-- BCA 2 (CS & CL)
-- Monday
(235, 22, 'Monday', '08:55:00', '12:00:00'),     -- PBL 202 CS IOT LAB

-- Tuesday
(234, 18, 'Tuesday', '11:05:00', '12:00:00'),   -- TBL 212 CR 406
(232, 17, 'Tuesday', '12:55:00', '13:50:00'),   -- TBL 203 CR-405
(233, 15, 'Tuesday', '15:05:00', '16:00:00'),   -- TBL 204 CR 403
(230, 2, 'Tuesday', '16:00:00', '17:55:00'),     -- TBL 201 LT 402 

-- Wednesday
(230, 1, 'Wednesday', '11:05:00', '12:00:00'),   -- TBL 201 LT-401
(231, 15, 'Wednesday', '12:00:00', '12:55:00'), -- TBL 202 CR 403
(234, 9, 'Wednesday', '15:05:00', '16:00:00'), -- TBL 212 CR 105
(233, 9, 'Wednesday', '16:00:00', '16:55:00'), -- TBL 204 CR 105

-- Thursday
(232, 4, 'Thursday', '12:00:00', '12:55:00'),    -- TBL 203 LT-502
(231, 6, 'Thursday', '12:55:00', '13:50:00'),  -- TBL 202 CR 102
(233, 6, 'Thursday', '15:05:00', '16:00:00'),  -- TBL 204 CR 102
(234, 6, 'Thursday', '16:00:00', '16:55:00'),  -- TBL 212 CR 102

-- Friday
(236, 21, 'Friday', '08:00:00', '09:50:00'),     -- PBL 201 Lab 7
(231, 4, 'Friday', '08:55:00', '09:50:00'),      -- TBL 202 LT-502
(232, 4, 'Friday', '10:10:00', '11:05:00'),      -- TBL 203 LT-502
(230, 2, 'Friday', '11:05:00', '12:00:00'),     -- TBL 201 LT 402

-- BCA 4TH SEMESTER

-- BCA 4 A1 + B1
-- Tuesday
(58, 3, 'Tuesday', '08:00:00', '08:55:00'),  -- TBC 403 LT-501
(59, 3, 'Tuesday', '08:55:00', '09:50:00'),  -- TBC 404 LT-501
(61, 3, 'Tuesday', '11:05:00', '12:00:00'),  -- XBC 401 LT-501

-- Wednesday
(62, 19, 'Wednesday', '08:00:00', '09:50:00'),  -- PBC 401 LAB 4 
(63, 20, 'Wednesday', '08:00:00', '09:50:00'),  -- PBC 402 lab 6
(58, 1, 'Wednesday', '10:10:00', '11:05:00'),  -- TBC 403 LT-401
(59, 1, 'Wednesday', '11:05:00', '12:00:00'),  -- TBC 404 LT-401

-- thursday
(57, 1, 'Thursday', '12:00:00', '12:55:00'),  -- TBC 401 LT-401
(60, 1, 'Thursday', '12:55:00', '13:50:00'),  -- TBC 405 LT-401
(63, 19, 'Thursday', '14:10:00', '16:00:00'),  -- PBC 202 lab 4 (b1)
(62, 19, 'Thursday', '16:00:00', '17:50:00'),  -- PBC 201 lab 4 (a1)

-- friday
(60, 4, 'Thursday', '12:00:00', '12:55:00'),  -- TBC 405 LT-502
(59, 4, 'Thursday', '14:10:00', '13:05:00'),  -- TBC 404 LT-502
(57, 4, 'Thursday', '13:05:00', '16:00:00'),  -- TBC 401 LT-502

-- SATURDAY
(61, 4, 'Saturday', '08:00:00', '08:55:00'),  -- XBC 401 LT-502
(57, 4, 'Saturday', '08:55:00', '09:50:00'),  -- TBC 401 LT-502
(58, 4, 'Saturday', '10:10:00', '11:05:00'),  -- TBC 403 LT-502
(60, 4, 'Saturday', '11:05:00', '12:00:00'),  -- TBC 405 LT-502

-- BCA 4 C1 + D1
-- tuesday
(70, 20, 'Tuesday', '08:00:00', '09:50:00'),  -- PBC 402 LAB 6 (C1)
(69, 20, 'Tuesday', '10:10:00', '12:00:00'),  -- PBC 401 LAB 6 (C1)
(67, 1, 'Tuesday', '12:00:00', '12:55:00'),  --  TBC 405 LT 401
(70, 20, 'Tuesday', '14:10:00', '16:00:00'),  -- PBC 402 LAB 6 (D1)
(69, 20, 'Tuesday', '16:00:00', '17:50:00'),  -- PBC 401 LAB 6 (D1)

-- wednesday
(66, 3, 'Wednesday', '12:00:00', '12:55:00'),  -- TBC 404 LT-501
(64, 3, 'Wednesday', '12:55:00', '13:50:00'),  -- TBC 401 LT-501
(65, 3, 'Wednesday', '15:05:00', '16:00:00'),  -- TBC 403 LT-501

-- thursday
(68, 4, 'Thursday', '08:00:00', '08:55:00'),  -- XBC 401 LT-502
(66, 4, 'Thursday', '08:55:00', '09:50:00'),  -- TBC 404 LT-502
(65, 4, 'Thursday', '10:10:00', '11:05:00'),  -- TBC 403 LT-502
(67, 4, 'Thursday', '11:05:00', '12:00:00'),  -- TBC 405 LT-502

-- friday
(68, 4, 'Friday', '08:00:00', '08:55:00'),  -- XBC 401 LT-502
(65, 4, 'Friday', '08:55:00', '09:50:00'),  -- TBC 403 LT-502
(66, 3, 'Friday', '11:05:00', '12:00:00'),  -- TBC 404 LT-501

-- SATURDAY
(64, 4, 'Saturday', '12:00:00', '12:55:00'),  -- TBC 401 LT-502
(64, 4, 'Saturday', '14:10:00', '15:05:00'),  -- TBC 401 LT-502
(67, 4, 'Saturday', '15:05:00', '16:00:00'),  -- TBC 405 LT-502

-- BCA 4 E1
-- MONDAY
(71, 16, 'Monday', '08:00:00', '08:55:00'),  -- TBC 401 CR-404
(77, 20, 'Monday', '10:10:00', '12:00:00'),  -- PBC 402 Lab 6

-- tuesday
(73, 16, 'Tuesday', '12:00:00', '12:55:00'),  -- TBC 404 CR-404
(75, 16, 'Tuesday', '14:10:00', '15:05:00'),  -- XBC 401 CR-404
(72, 16, 'Tuesday', '15:05:00', '16:00:00'),  -- TBC 403 CR-404

-- wednesday
(71, 16, 'Wednesday', '12:55:00', '13:50:00'),  -- TBC 401 CR-404
(72, 16, 'Wednesday', '14:10:00', '15:05:00'),  -- TBC 403 CR-404
(73, 17, 'Wednesday', '16:00:00', '16:55:00'),  -- TBC 404 CR-405
(74, 17, 'Wednesday', '16:55:00', '17:50:00'),  -- TBC 405 CR-405

-- thursday
(73, 16, 'Thursday', '12:00:00', '12:55:00'),  -- TBC 404 CR-404
(74, 16, 'Thursday', '14:10:00', '15:05:00'),  -- TBC 405 CR-404
(71, 16, 'Thursday', '15:05:00', '16:00:00'),  -- TBC 401 CR-404

-- SATURDAY
(76, 20, 'Saturday', '08:00:00', '09:50:00'),  -- PBC 401 LAB 6
(74, 16, 'Saturday', '10:10:00', '11:05:00'),  -- TBC 405 CR-404
(71, 16, 'Saturday', '11:05:00', '12:00:00'),  -- TBC 401 CR-404
(75, 16, 'Saturday', '12:00:00', '12:55:00'),  -- XBC 401 CR-404

-- BCA 4 F1
-- MONDAY
(84, 20, 'Monday', '08:00:00', '09:50:00'),  -- PBC 402 LAB 6
(79, 18, 'Monday', '10:10:00', '11:05:00'),  -- TBC 403 CR-406

-- tuesday
(78, 16, 'Tuesday', '12:55:00', '13:50:00'),  -- TBC 401 CR-404
(83, 19, 'Tuesday', '14:10:00', '16:00:00'),  -- TBC 401 LAB 4
(80, 15, 'Tuesday', '16:00:00', '16:55:00'),  -- TBC 404 CR-403

-- wednesday
(82, 5, 'Wednesday', '08:00:00', '08:55:00'),  -- XBC 401 CR-101
(80, 5, 'Wednesday', '08:55:00', '09:50:00'),  -- TBC 404 CR-101
(81, 5, 'Wednesday', '10:10:00', '11:05:00'),  -- TBC 405 CR-101
(78, 5, 'Wednesday', '11:05:00', '12:00:00'),  -- TBC 401 CR-101

-- thursday
(79, 5, 'Thursday', '08:00:00', '08:55:00'),  -- TBC 403 CR-101
(80, 5, 'Thursday', '10:10:00', '11:05:00'),  -- TBC 404 CR-101
(81, 5, 'Thursday', '11:05:00', '12:00:00'),  -- TBC 405 CR-101

-- SATURDAY
(81, 18, 'Saturday', '08:00:00', '08:55:00'),  -- TBC 405 CR-406
(80, 18, 'Saturday', '08:55:00', '09:50:00'),  -- TBC 404 CR-406
(82, 18, 'Saturday', '11:05:00', '12:00:00'),  -- XBC 401 CR-406
(78, 18, 'Saturday', '12:00:00', '12:55:00'),  -- TBC 401 CR-406

-- BCA 4 G1
-- tuesday
(91, 19, 'Tuesday', '12:00:00', '13:50:00'),  -- PBC 402 Lab 4
(85, 18, 'Tuesday', '14:10:00', '15:05:00'),  -- TBC 401 CR 406

-- wednesday
(90, 19, 'Wednesday', '12:00:00', '13:50:00'),  -- PBC 401 LAB 4
(88, 5, 'Wednesday', '15:05:00', '16:00:00'),  -- TBC 405 CR-101
(86, 5, 'Wednesday', '16:00:00', '16:55:00'),  -- TBC 403 CR-101

-- thursday
(87, 17, 'Thursday', '12:00:00', '12:55:00'),  -- TBC 404 CR-405
(86, 16, 'Thursday', '12:55:00', '13:50:00'),  -- TBC 403 CR-404
(88, 5, 'Thursday', '14:10:00', '15:05:00'),  -- TBC 405 CR-101

-- friday
(89, 5, 'Friday', '12:00:00', '12:55:00'),  -- XBC 401 CR-101
(88, 5, 'Friday', '12:55:00', '13:50:00'),  -- TBC 405 CR-101
(85, 5, 'Friday', '14:10:00', '15:05:00'),  -- TBC 401 CR-101
(87, 5, 'Friday', '15:05:00', '16:00:00'),  -- TBC 404 CR-101

-- SATURDAY
(89, 5, 'Saturday', '08:00:00', '08:55:00'),  -- XBC 401 CR-101
(86, 5, 'Saturday', '08:55:00', '09:50:00'),  -- TBC 403 CR-101
(85, 5, 'Saturday', '10:10:00', '11:05:00'),  -- TBC 401 CR-101
(87, 5, 'Saturday', '11:05:00', '12:00:00'),  -- TBC 404 CR-101

-- BCA 4 H1
-- tuesday
(95, 16, 'Tuesday', '08:00:00', '08:55:00'),  -- TBC 405 CR-404
(92, 16, 'Tuesday', '08:55:00', '09:50:00'),  -- TBC 401 CR-404
(96, 16, 'Tuesday', '10:10:00', '11:05:00'),  -- XBC 401 CR-404
(94, 16, 'Tuesday', '11:05:00', '12:00:00'),  -- TBC 404 CR-404

-- wednesday
(92, 16, 'Wednesday', '08:00:00', '08:55:00'),  -- TBC 401 CR-404
(95, 16, 'Wednesday', '08:55:00', '09:50:00'),  -- TBC 405 CR-404
(94, 16, 'Wednesday', '10:10:00', '11:05:00'),  -- TBC 404 CR-404
(93, 16, 'Wednesday', '11:05:00', '12:00:00'),  -- TBC 403 CR-404

-- thursday
(96, 5, 'Thursday', '12:00:00', '12:55:00'),  -- XBC 401 CR-101
(98, 21, 'Thursday', '14:10:00', '16:00:00'),  -- PBC 402 LAB 7

-- friday
(95, 16, 'Friday', '08:00:00', '08:55:00'),  -- TBC 405 CR 404
(94, 16, 'Friday', '08:55:00', '09:50:00'),  -- TBC 404 CR 404
(92, 16, 'Friday', '10:10:00', '11:05:00'),  -- TBC 401 CR 404
(93, 16, 'Friday', '11:05:00', '12:00:00'),  -- TBC 403 CR 404

-- Saturday
(93, 17, 'Saturday', '12:55:00', '13:50:00'),  -- TBC 403 CR-405
(97, 19, 'Saturday', '14:10:00', '16:00:00'),  -- PBC 401 LAB 4

-- BCA 4 A2
-- Tuesday
(103, 5, 'Tuesday', '08:00:00', '08:55:00'),  -- XBC 401 CR-101
(99, 5, 'Tuesday', '08:55:00', '09:50:00'),  -- TBC 401 CR-101
(102, 5, 'Tuesday', '10:10:00', '11:05:00'),  -- TBC 405 CR-101
(101, 5, 'Tuesday', '11:05:00', '12:00:00'),  -- TBC 404 CR-101

-- Wednesday
(104, 20, 'Wednesday', '12:00:00', '13:50:00'),  -- PBC 401 LAB 6
(101, 2, 'Wednesday', '16:00:00', '16:55:00'),  -- TBC 404 LT-402
(100, 2, 'Wednesday', '16:55:00', '17:50:00'),  -- TBC 403 LT-402

-- Thursday
(100, 18, 'Thursday', '12:00:00', '12:55:00'),  -- TBC 403 CR-406
(105, 20, 'Thursday', '14:10:00', '16:00:00'),  -- PBC 402 LAB 6

-- Friday
(101, 5, 'Friday', '08:00:00', '08:55:00'),  -- TBC 404 CR 101
(102, 5, 'Friday', '10:10:00', '11:05:00'),  -- TBC 405 CR 101
(99, 5, 'Friday', '11:05:00', '12:00:00'),  -- TBC 401 CR 101

-- Saturday
(100, 5, 'Saturday', '12:00:00', '12:55:00'),  -- TBC 403 CR-101
(99, 5, 'Saturday', '12:55:00', '13:50:00'),  -- TBC 401 CR-101
(102, 5, 'Saturday', '14:10:00', '15:05:00'),  -- TBC 405 CR 101
(103, 5, 'Saturday', '15:05:00', '16:00:00'),  -- XBC 401 CR-101

-- BCA 4 B2
-- Monday
(106, 16, 'Monday', '12:00:00', '12:55:00'),  -- TBC 404 CR-404
(112, 19, 'Monday', '14:10:00', '16:00:00'),  -- PBC 402 LAB 4

-- Tuesday
(108, 5, 'Tuesday', '12:00:00', '12:55:00'),  -- TBC 404 CR-101
(110, 5, 'Tuesday', '12:55:00', '13:50:00'),  -- XBC 401 CR-101
(111, 21, 'Tuesday', '14:10:00', '16:00:00'),  -- PBC 401 LAB 7

-- Wednesday
(110, 17, 'Wednesday', '12:55:00', '13:50:00'),  -- XBC 401 CR-405
(106, 16, 'Wednesday', '15:05:00', '16:00:00'),  -- TBC 401 CR-404
(109, 16, 'Wednesday', '16:00:00', '16:55:00'),  -- TBC 405 CR-404
(107, 16, 'Wednesday', '16:55:00', '17:50:00'),  -- TBC 403 CR-404

-- Thursday
(106, 5, 'Thursday', '12:55:00', '13:50:00'),  -- TBC 401 CR-101
(108, 5, 'Thursday', '15:05:00', '16:00:00'),  -- TBC 404 CR-101
(107, 5, 'Thursday', '16:00:00', '16:55:00'),  -- TBC 403 CR-101
(109, 5, 'Thursday', '16:55:00', '17:50:00'),  -- TBC 405 CR-101

-- Saturday
(109, 18, 'Saturday', '12:55:00', '13:50:00'),  -- TBC 405 CR-406
(107, 18, 'Saturday', '14:10:00', '15:05:00'),  -- TBC 403 CR 406
(106, 18, 'Saturday', '15:05:00', '16:00:00'),  -- TBC 401 CR-406


-- BCA 4 C2
-- Monday
(115, 7, 'Monday', '12:00:00', '12:55:00'),  -- TBC 404 CR-103
(114, 7, 'Monday', '12:55:00', '13:50:00'),  -- TBC 403 CR-103
(119, 21, 'Monday', '14:10:00', '16:00:00'),  -- PBC 402 LAB 7

-- Tuesday
(114, 15, 'Tuesday', '12:55:00', '13:50:00'),  -- TBC 403 CR-403
(116, 5, 'Tuesday', '15:05:00', '16:00:00'),  -- TBC 405 CR-101
(113, 5, 'Tuesday', '16:00:00', '16:55:00'),  -- TBC 401 CR-101

-- Thursday
(115, 16, 'Thursday', '08:00:00', '08:55:00'),  -- TBC 404 CR-404
(114, 16, 'Thursday', '08:55:00', '09:50:00'),  -- TBC 403 CR-404
(116, 16, 'Thursday', '10:10:00', '11:05:00'),  -- TBC 405 CR-404
(113, 16, 'Thursday', '11:05:00', '12:00:00'),  -- TBC 401 CR-404

-- Friday
(117, 18, 'Friday', '12:00:00', '12:55:00'),  -- XBC 401 CR-406
(115, 18, 'Friday', '12:55:00', '13:50:00'),  -- TBC 404 CR-406
(118, 19, 'Friday', '14:10:00', '16:00:00'),  -- PBC 401 LAB 4
(113, 18, 'Friday', '16:00:00', '16:55:00'),  -- TBC 401 CR-406

-- Saturday
(117, 17, 'Saturday', '08:55:00', '09:50:00'),  -- XBC 401 CR-405
(116, 17, 'Saturday', '10:10:00', '11:05:00'),  -- TBC 405 CR-405

-- BCA 4 D2
-- Monday
(126, 21, 'Monday', '12:00:00', '13:50:00'),  -- PBC 402 LAB 7
(122, 16, 'Monday', '15:05:00', '16:00:00'),  -- TBC 404 CR-404

-- Wednesday
(121, 5, 'Wednesday', '12:55:00', '13:50:00'),  -- TBC 403 CR-101
(124, 5, 'Wednesday', '14:10:00', '15:05:00'),  -- XBC 401 CR-101
(123, 6, 'Wednesday', '16:00:00', '16:55:00'),  -- TBC 405 CR-102
(120, 6, 'Wednesday', '16:55:00', '17:50:00'),  -- TBC 401 CR-102

-- Thursday
(123, 7, 'Thursday', '08:00:00', '08:55:00'),  -- TBC 405 CR-103
(122, 7, 'Thursday', '08:55:00', '09:50:00'),  -- TBC 404 CR-103
(121, 7, 'Thursday', '10:10:00', '11:05:00'),  -- TBC 403 CR-103
(120, 7, 'Thursday', '11:05:00', '12:00:00'),  -- TBC 401 CR-103

-- Friday
(122, 15, 'Friday', '12:55:00', '13:50:00'),  -- TBC 404 CR-403
(121, 16, 'Friday', '15:05:00', '16:00:00'),  -- TBC 403 CR-404
(123, 16, 'Friday', '16:00:00', '16:55:00'),  -- TBC 405 CR-404
(124, 16, 'Friday', '16:55:00', '17:50:00'),  -- XBC 401 CR-404

-- Saturday
(125, 21, 'Saturday', '08:00:00', '09:50:00'),  -- PBC 401 LAB 7
(120, 17, 'Saturday', '11:05:00', '12:00:00'),  -- TBC 401 CR-405

-- BCA 4 E2
-- Tuesday
(127, 7, 'Tuesday', '12:55:00', '13:50:00'),  -- TBC 401 CR-103
(128, 7, 'Tuesday', '15:05:00', '16:00:00'),  -- TBC 403 CR-103
(131, 7, 'Tuesday', '16:00:00', '16:55:00'),  -- XBC 401 CR-103
(130, 7, 'Tuesday', '16:55:00', '17:50:00'),  -- TBC 405 CR-103

-- Wednesday
(128, 9, 'Wednesday', '12:55:00', '13:50:00'),  -- TBC 403 CR-105
(129, 7, 'Wednesday', '16:00:00', '16:55:00'),  -- TBC 404 CR-103
(127, 7, 'Wednesday', '16:55:00', '17:50:00'),  -- TBC 401 CR-103

-- Thursday
(129, 7, 'Thursday', '12:55:00', '13:50:00'),  -- TBC 404 CR-103
(131, 6, 'Thursday', '15:05:00', '16:00:00'),  -- XBC 401 CR-102
(132, 20, 'Thursday', '16:00:00', '17:50:00'),  -- PBC 401 LAB 6

-- Friday
(130, 7, 'Friday', '12:55:00', '13:50:00'),  -- TBC 405 CR-103
(129, 7, 'Friday', '14:10:00', '15:05:00'),  -- TBC 404 CR-103
(133, 19, 'Friday', '16:00:00', '17:50:00'),  -- PBC 402 LAB 4

-- Saturday
(128, 7, 'Saturday', '12:00:00', '12:55:00'),  -- TBC 403 CR-103
(127, 7, 'Saturday', '14:10:00', '15:05:00'),  -- TBC 401 CR-103
(130, 17, 'Saturday', '15:05:00', '16:00:00'),  -- TBC 405 CR-405

-- BCA 4 F2
-- Monday
(140, 21, 'Monday', '08:00:00', '09:50:00'),  -- PBC 402 LAB 7
(135, 16, 'Monday', '11:05:00', '12:00:00'),  -- TBC 403 CR-404

-- Tuesday
(136, 7, 'Tuesday', '08:00:00', '08:55:00'),  -- TBC 404 CR-103
(135, 7, 'Tuesday', '08:55:00', '09:50:00'),  -- TBC 403 CR-103
(137, 7, 'Tuesday', '10:10:00', '11:05:00'),  -- TBC 405 CR-103
(134, 7, 'Tuesday', '11:05:00', '12:00:00'),  -- TBC 401 CR-103

-- Wednesday
(135, 7, 'Wednesday', '08:00:00', '08:55:00'),  -- TBC 403 CR-103
(138, 7, 'Wednesday', '08:55:00', '09:50:00'),  -- XBC 401 CR-103
(134, 7, 'Wednesday', '10:10:00', '11:05:00'),  -- TBC 401 CR-103
(137, 7, 'Wednesday', '11:05:00', '12:00:00'),  -- TBC 405 CR-103

-- Thursday
(138, 9, 'Thursday', '08:00:00', '08:55:00'),  -- XBC 401 CR-105
(134, 9, 'Thursday', '10:10:00', '11:05:00'),  -- TBC 401 CR-105
(136, 9, 'Thursday', '11:05:00', '12:00:00'),  -- TBC 404 CR-105

-- Friday
(139, 19, 'Friday', '12:00:00', '13:50:00'),  -- PBC 401 LAB 4
(137, 18, 'Friday', '14:10:00', '15:05:00'),  -- TBC 405 CR-406
(136, 18, 'Friday', '15:05:00', '16:00:00'),  -- TBC 404 CR-406

-- BCA 4 G2
-- Tuesday
(141, 9, 'Tuesday', '12:00:00', '12:55:00'),  -- TBC 401 CR-105
(144, 9, 'Tuesday', '12:55:00', '13:50:00'),  -- TBC 405 CR-105
(142, 9, 'Tuesday', '14:10:00', '15:05:00'),  -- TBC 403 CR-105
(143, 9, 'Tuesday', '15:05:00', '16:00:00'),  -- TBC 404 CR-105

-- Wednesday
(143, 9, 'Wednesday', '12:00:00', '12:55:00'),  -- TBC 404 CR-105
(144, 9, 'Wednesday', '14:10:00', '15:05:00'),  -- TBC 405 CR-105
(145, 9, 'Wednesday', '15:05:00', '16:00:00'),  -- XBC 401 CR-105

-- Thursday
(141, 9, 'Thursday', '08:55:00', '09:50:00'),  -- TBC 401 CR-105
(146, 22, 'Thursday', '10:10:00', '12:00:00'),  -- PBC 401 IOT LAB
(142, 7, 'Thursday', '12:00:00', '12:55:00'),  -- TBC 403 CR-105

-- Friday
(141, 7, 'Friday', '08:00:00', '08:55:00'),  -- TBC 401 CR-105
(144, 7, 'Friday', '08:55:00', '09:50:00'),  -- TBC 405 CR-105
(142, 7, 'Friday', '10:10:00', '11:05:00'),  -- TBC 403 CR-105
(145, 7, 'Friday', '11:05:00', '12:00:00'),  -- XBC 401 CR-105

-- Saturday
(147, 19, 'Saturday', '12:00:00', '13:50:00'),  -- PBC 402 LAB 4
(143, 17, 'Saturday', '15:05:00', '16:00:00');  -- TBC 404 CR-405
