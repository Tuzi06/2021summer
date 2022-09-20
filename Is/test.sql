EXPLAIN SELECT name
FROM student
WHERE name = "Hashimoto";

EXPLAIN CREATE INDEX name 
ON student(name);

EXPLAIN SELECT student.name 
FROM student JOIN advisor 
WHERE  student.ID= advisor.s_ID;

EXPLAIN SELECT course_id 
FROM section 
WHERE semester = 'Fall' 
GROUP BY building;

EXPLAIN UPDATE section
SET course_id ='001',
    sec_id = '1',
    semester = 'Winter',
    year = 2020,
    building = 'Gates',
    room_number = '844',
    time_slot_id = 'D'
WHERE course_id= '747';

EXPLAIN UPDATE section
SET course_id ='001',
    sec_id = '1',
    semester = 'Winter',
    year = 2020,
    building = 'Gates',
    room_number = '844',
    time_slot_id = 'D'
WHERE semester = 'Winter';