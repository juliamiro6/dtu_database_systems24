-- Query 1
SELECT Patient.Patient_ID, First_Name, Last_Name, Patient.Doctor_ID
FROM Patient
WHERE Patient.Patient_ID IN
(SELECT Prescription.Patient_id
FROM Prescription WHERE Prescription.Medicine_ID IN
(SELECT Medicine.Medicine_ID
FROM Medicine
WHERE Medicine.Type = 'Antibiotic'));
--

-- Query 2
SELECT Department.Department_Name,
COUNT(*) AS Num_Rooms
FROM Department
INNER JOIN Room ON Department.Department_ID = Room.Department_ID
WHERE Room.Capacity > 2
GROUP BY Department.Department_name;
--

-- Query 3
(SELECT Appointment.Room_ID, Appointment.day, Appointment.Start_Time,
Appointment.end_time, Room.Capacity, 'Available'
AS Availability_Status
FROM Appointment
INNER JOIN Room ON Appointment.Room_ID = Room.Room_ID
WHERE Appointment.Day = 'Monday'
AND Appointment.Start_Time >= '08:00'
AND Appointment.End_Time <= '12:00'
AND Room.Capacity > 0)
UNION
(SELECT Appointment.Room_ID, Appointment.day, Appointment.Start_Time,
Appointment.end_time, Room.Capacity, 'Unavailable'
AS Availability_Status
FROM Appointment
INNER JOIN Room ON Appointment.Room_ID = Room.Room_ID
WHERE Appointment.Day = 'Tuesday'
AND Appointment.Start_Time >= '08:00'
AND Appointment.End_Time <= '12:00'
AND Room.Capacity = 0);
