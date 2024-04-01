CREATE DATABASE IF NOT EXISTS HospitalDB;
USE HospitalDB;

-- Department Table
CREATE TABLE Department (
    Department_ID INT AUTO_INCREMENT PRIMARY KEY,
    Department_Name VARCHAR(100) NOT NULL  
);

-- Doctor Table
CREATE TABLE Doctor (
    Doctor_ID INT AUTO_INCREMENT PRIMARY KEY,
    First_Name VARCHAR(45) NOT NULL,  -
    Last_Name VARCHAR(45),
    Contact_Info VARCHAR(100)  
);

-- Medicine Table
CREATE TABLE Medicine (
    Medicine_ID INT AUTO_INCREMENT PRIMARY KEY,
    Medicine_Name VARCHAR(100) NOT NULL,  -- Medicine names can vary in length
    Dosage VARCHAR(45),  
    Type VARCHAR(45) 
);

-- Patient Table
CREATE TABLE Patient (
    Patient_ID INT AUTO_INCREMENT PRIMARY KEY,
    First_Name VARCHAR(45) NOT NULL,
    Last_Name VARCHAR(45),
    Contact_Info VARCHAR(100),
    Date_of_Birth DATE,
    Age INT  -- can be calculated from date of birth not sure if we want to store it??
);

-- Room Table
CREATE TABLE Room (
    Room_ID INT AUTO_INCREMENT PRIMARY KEY,
    Capacity INT NOT NULL 
);

-- Appointment Table
CREATE TABLE Appointment (
    Appointment_ID INT AUTO_INCREMENT PRIMARY KEY,
    Day DATE NOT NULL,
    Start_Time TIME NOT NULL,
    End_Time TIME NOT NULL,
    Doctor_ID INT,
    Patient_ID INT,
    Room_ID INT,
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID)
);

-- Doctor to Department (Specializes)
CREATE TABLE Specializes (
    Doctor_ID INT,
    Department_ID INT,
    PRIMARY KEY (Doctor_ID, Department_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID),
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);

-- Doctor to Medicine (Prescribes)
CREATE TABLE Prescribes (
    Doctor_ID INT,
    Medicine_ID INT,
    PRIMARY KEY (Doctor_ID, Medicine_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID),
    FOREIGN KEY (Medicine_ID) REFERENCES Medicine(Medicine_ID)
);

-- Patient to Room (Occupies)
CREATE TABLE Occupies (
    Patient_ID INT,
    Room_ID INT,
    PRIMARY KEY (Patient_ID, Room_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID)
);

-- Prescription Table
CREATE TABLE Prescription (
    Medicine_ID INT,
    Patient_ID INT,
    Prescription_Info TEXT,  
    PRIMARY KEY (Medicine_ID, Patient_ID),
    FOREIGN KEY (Medicine_ID) REFERENCES Medicine(Medicine_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);