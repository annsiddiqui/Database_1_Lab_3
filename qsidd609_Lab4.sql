/*
Name: Qurrat-al-Ain Siddiqui (Ann Siddiqui)
Date: November 21st, 2018
Date Submitted: Monday, November 26, 2018
Course: COMP 2521-001
Lab 4: Advanced Queries - OUTER JOINS (and INNER) and Sub-queries
Instructor: Shoba Ittyipe
*/

/* Outer Joins */

--1
SELECT loc_id, COUNT(c_sec_id)
FROM location LEFT OUTER JOIN course_section USING(loc_id)
GROUP BY loc_id;

--2
INSERT INTO course_section VALUES
	(14, 5, 3, 3, 5, 'TR', '4:00 PM', '0 00:01:30.00', 13, 50);

DELETE
FROM course_section
WHERE c_sec_id = 14;

SELECT f_last, bldg_code, room, c_sec_id
FROM course_section RIGHT OUTER JOIN faculty USING(f_id)
			        LEFT OUTER JOIN location ON course_section.loc_id = location.loc_id
GROUP BY c_sec_id;

--3
INSERT INTO course_section VALUES
	(14, 5, 3, 3, NULL, 'TR', '4:00 PM', '0 00:01:30.00', 13, 50);

SELECT f_last, bldg_code, room, c_sec_id
FROM course_section LEFT OUTER JOIN faculty USING(f_id)
			        LEFT OUTER JOIN location ON course_section.loc_id = location.loc_id
GROUP BY c_sec_id;

/* Checks Inserted Rows to see if they exist */
SELECT *
FROM course_section;

--4
SELECT c_sec_id, COUNT(s_id)
FROM enrollment RIGHT OUTER JOIN course_section USING(c_sec_id)
GROUP BY c_sec_id;

--5
SELECT term_desc, c_sec_id
FROM term LEFT OUTER JOIN course_section USING(term_id);

--6
SELECT term_desc, c_sec_id
FROM term lEFT OUTER JOIN course_section ON term.term_id = course_section.term_id;

/* Don't need to do questions 7, 7(a), 8 */
--7

--7(a)

--8

/* Sub-Queries */
/* Write the following queries using subquery.
When the question says, write it a different way,
you may write it as a join. */

--9
SELECT f_last
FROM faculty
WHERE f_id IN(SELECT f_id
				FROM course_section
				WHERE term_id IN(SELECT term_id
								 FROM term
								 WHERE term_desc = "Summer 2007"));

--10
SELECT c_sec_day, loc_id
FROM course_section
WHERE term_id IN(SELECT term_id
				FROM term
				WHERE status LIKE "OPEN")
AND course_id IN(SELECT course_id
				FROM course
				WHERE course_name LIKE "Database Management");

--11
SELECT f_id
FROM faculty
WHERE f_id IN(SELECT f_id
			  FROM student
			  WHERE s_first = f_first)
AND  f_id IN(SELECT f_id
			  FROM student
			  WHERE s_last = f_last);

--12
SELECT c_sec_id, max_enrl
FROM course_section
WHERE c_sec_id IN(SELECT c_sec_id
				 FROM course_section
				 WHERE max_enrl = 140);

/* Don't have to do questions 13, 14 */
--13
SELECT c_sec_id, max_enrl
FROM course_section
WHERE c_sec_id IN(SELECT c_sec_id
				 FROM course_section
				 WHERE max_enrl != 140);

--14
SELECT c_sec_id, max_enrl
FROM course_section
Where max_enrl < (SELECT AVG(max_enrl)
				 FROM course_section);

--15
SELECT grade, term_id
FROM course_section Right OUTER JOIN term USING(term_id)
					RIGHT OUTER JOIN enrollment USING(c_sec_id)
WHERE s_id IN(SELECT s_id
			  FROM student
			  WHERE s_id IN(SELECT s_id
						   FROM student
						   WHERE s_last LIKE "Miller"
			  				AND s_first LIKE "Sarah"))
AND course_id IN(SELECT course_id
				FROM course
				WHERE course_name LIKE "Systems Analysis");

/* Don't need to do questions 16, 17, 18 */
--16

--17

--18

/*Union*/
--19
SELECT s_last, s_first
FROM student
GROUP BY s_last
/* end of the student entity */
UNION

SELECT f_last, f_first
FROM faculty
GROUP BY f_last;
/* end of the student entity */
