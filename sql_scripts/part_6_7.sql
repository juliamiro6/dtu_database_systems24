-- QUERIES

-- Query 1: Find the patient’s information (patient ID, first and last name) and their corresponding
-- doctor (doctor ID) for patients who have been prescribed Antibiotic-Type medications.
SELECT Patient.Patient_ID, Patient.First_Name, Patient.Last_Name, 
Appointment.Doctor_ID, Medicine.Dosage
FROM Patient
NATURAL JOIN Prescription
NATURAL JOIN Medicine
NATURAL JOIN Appointment
WHERE Medicine.Type = 'Antibiotic';


-- Query 2: Find the number of rooms and the total capacity of each department
SELECT Department.Department_Name, 
COUNT(*) AS Department_Rooms, SUM(Room.Capacity) AS Department_Total_Capacity
FROM Department
NATURAL JOIN Specializes
NATURAL JOIN Appointment
NATURAL JOIN Room 
GROUP BY Department.Department_Name;

-- Query 3

-- Function
DELIMITER //
CREATE FUNCTION GetAverageAgeInDepartment(Department_Name INT)
RETURNS DECIMAL(5, 2)
BEGIN
	DECLARE Average_Age DECIMAL(5, 2);
	SELECT AVG(YEAR(CURRENT_DATE()) - YEAR(Date_of_birth)) INTO Average_Age
	FROM Patient NATURAL JOIN Occupies
    WHERE Occupies.Room_ID = Department_ID;
	RETURN Average_Age;
END //
DELIMITER ;

SELECT GetAverageAgeInDepartment(8);
SELECT Department_ID, Department_Name, GetAverageAgeInDepartment(Department_ID) AS Average_Age
FROM Department;

-- Procedure
DELIMITER //

CREATE PROCEDURE ScheduleAppointment(
    IN p_patient_id INT,
    IN p_doctor_id INT,
    IN p_room_id INT,
    IN p_day DATE,
    IN p_start_time TIME,
    IN p_end_time TIME
)
BEGIN
    -- Check if the doctor is available
    DECLARE doctor_available INT DEFAULT 0;
    
    SELECT COUNT(*)
    INTO doctor_available
    FROM Appointment
    WHERE Doctor_ID = p_doctor_id
    AND Day = p_day
    AND ((Start_Time < p_end_time AND End_Time > p_start_time));

    -- Proceed only if the doctor is available
    IF doctor_available = 0 THEN
        INSERT INTO Appointment (Day, Start_Time, End_Time, Doctor_ID, Patient_ID, Room_ID)
        VALUES (p_day, p_start_time, p_end_time, p_doctor_id, p_patient_id, p_room_id);
        SELECT "Appointment scheduled successfully." AS Message;
    ELSE
        SELECT "Doctor is not available in the given time slot." AS Message;
    END IF;
END //

DELIMITER ;

SELECT*FROM Appointment;
CALL ScheduleAppointment(18, 4, 6, '2024-04-01', '11:00:00', '11:30:00');

