use clinic;

CREATE TABLE PATIENT (
    Patient_ID INT PRIMARY KEY NOT NULL,
    patient_name VARCHAR(100),
    Age INT,
    Gender CHAR(1),
    Address TEXT,
    Blood_Group VARCHAR(5)
);


CREATE TABLE PATIENT_PHONE (
    Patient_ID INT NOT NULL,
    Phone_Number VARCHAR(15),
    PRIMARY KEY (Patient_ID, Phone_Number),
    FOREIGN KEY (Patient_ID) REFERENCES PATIENT(Patient_ID)
);


CREATE TABLE DOCTOR (
    Doctor_ID INT PRIMARY KEY NOT NULL,
    doctor_name VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    Experience INT
);

CREATE TABLE DOCTOR_PHONE (
    Doctor_ID INT not null,
    Phone_Number VARCHAR(15),
    PRIMARY KEY (Doctor_ID, Phone_Number),
    FOREIGN KEY (Doctor_ID) REFERENCES DOCTOR(Doctor_ID)
);
drop table department;
CREATE TABLE DEPARTMENT (
    Department_ID INT PRIMARY KEY not null,
    Department_Name VARCHAR(100) UNIQUE,
    Description_ TEXT
);

CREATE TABLE SPECIALIZATION (
    specialization_name VARCHAR(100) PRIMARY KEY,
    Description_ TEXT,
    Department_ID INT,
    FOREIGN KEY (Department_ID) REFERENCES DEPARTMENT(Department_ID)
);


CREATE TABLE DOCTOR_SPECIALIZATION (
    Doctor_ID INT,
    Specialization_Name VARCHAR(100),
    PRIMARY KEY (Doctor_ID, Specialization_Name),
    FOREIGN KEY (Doctor_ID) REFERENCES DOCTOR(Doctor_ID),
    FOREIGN KEY (Specialization_Name) REFERENCES SPECIALIZATION(specialization_Name)
);


CREATE TABLE ROOM (
    Room_ID INT PRIMARY KEY,
    Room_Number VARCHAR(10),
    room_type VARCHAR(50),
    room_status VARCHAR(20),
    Floor INT
);



CREATE TABLE PATIENT_ROOM (
    Patient_ID INT,
    Room_ID INT,
    From_Date DATE,
    To_Date DATE,
    PRIMARY KEY (Patient_ID, Room_ID, From_Date),
    FOREIGN KEY (Patient_ID) REFERENCES PATIENT(Patient_ID),
    FOREIGN KEY (Room_ID) REFERENCES ROOM(Room_ID)
);


CREATE TABLE APPOINTMENT (
    Appointment_ID INT PRIMARY KEY,
    Patient_ID INT,
    Doctor_ID INT,
    appoint_Date DATE,
    appoint_time TIME,
    appoint_status VARCHAR(20),
    appoint_type VARCHAR(50),
    FOREIGN KEY (Patient_ID) REFERENCES PATIENT(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES DOCTOR(Doctor_ID)
);


CREATE TABLE MEDICAL_RECORD (
    Record_ID INT PRIMARY KEY,
    Patient_ID INT,
    Doctor_ID INT,
    record_date DATE,
    Diagnosis TEXT,
    Prescription TEXT,
    Notes TEXT,
    FOREIGN KEY (Patient_ID) REFERENCES PATIENT(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES DOCTOR(Doctor_ID)
);


CREATE TABLE MEDICINE (
    Medicine_ID INT PRIMARY KEY,
    medicine_name VARCHAR(100),
    Manufacturer VARCHAR(100),
    Expiry_Date DATE,
    Price int,
    Stock INT
);

CREATE TABLE RECORD_MEDICINE (
    Record_ID INT,
    Medicine_ID INT,
    Dosage VARCHAR(50),
    Frequency VARCHAR(50),
    Duration VARCHAR(50),
    PRIMARY KEY (Record_ID, Medicine_ID),
    FOREIGN KEY (Record_ID) REFERENCES MEDICAL_RECORD(Record_ID),
    FOREIGN KEY (Medicine_ID) REFERENCES MEDICINE(Medicine_ID)
);


;
CREATE TABLE BILL (
    Bill_ID INT PRIMARY KEY,
    Patient_ID INT,
    bill_date DATE,
    Total_Amount int,
    Payment_Status VARCHAR(20),
    Payment_Method VARCHAR(30),
    FOREIGN KEY (Patient_ID) REFERENCES PATIENT(Patient_ID)
);


INSERT INTO PATIENT VALUES 
(1, 'Ravi Kumar', 34, 'M', 'Hyderabad', 'B+'),
(2, 'Anita Rao', 28, 'F', 'Bangalore', 'O+');




INSERT INTO PATIENT_PHONE VALUES 
(1, '9876543210'),
(1, '9123456789'),
(2, '9988776655');




INSERT INTO DOCTOR VALUES 
(101, 'Dr. Meena Sharma', 'meena.sharma@gmail.com', 12),
(102, 'Dr. Arjun Verma', 'arjun.verma@gmail.com', 8);




INSERT INTO DOCTOR_PHONE VALUES 
(101, '9876512345'),
(102, '9123412345');



INSERT INTO DEPARTMENT VALUES 
(1, 'Cardiology', 'Heart-related treatments'),
(2, 'Neurology', 'Brain and nervous system');




INSERT INTO SPECIALIZATION VALUES 
('Cardiologist', 'Heart specialist', 1),
('Neurologist', 'Brain specialist', 2);


INSERT INTO DOCTOR_SPECIALIZATION VALUES 
(101, 'Cardiologist'),
(102, 'Neurologist');

INSERT INTO ROOM VALUES 
(201, 'A101', 'General', 'Available', 1),
(202, 'A102', 'Private', 'Occupied', 2);



INSERT INTO PATIENT_ROOM VALUES 
(1, 201, '2025-06-01', '2025-06-05'),
(2, 202, '2025-06-02', '2025-06-04');



INSERT INTO APPOINTMENT VALUES 
(301, 1, 101, '2025-06-03', '10:00:00', 'Completed', 'Regular Checkup'),
(302, 2, 102, '2025-06-04', '11:30:00', 'Pending', 'Consultation');




INSERT INTO MEDICAL_RECORD VALUES 
(401, 1, 101, '2025-06-03', 'Hypertension', 'Amlodipine 5mg', 'Take BP daily'),
(402, 2, 102, '2025-06-04', 'Migraine', 'Paracetamol 650', 'Avoid stress');



INSERT INTO MEDICINE VALUES 
(501, 'Amlodipine', 'Sun Pharma', '2026-01-01', 15, 100),
(502, 'Paracetamol', 'Cipla', '2025-12-01', 5, 200);




INSERT INTO RECORD_MEDICINE VALUES 
(401, 501, '5mg', 'Once daily', '30 days'),
(402, 502, '650mg', 'Twice daily', '5 days');




INSERT INTO BILL VALUES 
(601, 1, '2025-06-05', 800, 'Paid', 'Cash'),
(602, 2, '2025-06-04', 1000, 'Unpaid', 'UPI');



SELECT p.patient_name, m.Diagnosis, m.Notes
FROM MEDICAL_RECORD m
JOIN PATIENT p ON m.Patient_ID = p.Patient_ID;




SELECT p.patient_name, b.bill_date, b.Total_Amount, b.Payment_Status, b.Payment_Method
FROM BILL b
JOIN PATIENT p ON b.Patient_ID = p.Patient_ID;



SELECT p.patient_name, b.Total_Amount
FROM BILL b
JOIN PATIENT p ON b.Patient_ID = p.Patient_ID
WHERE b.Total_Amount = (
    SELECT MAX(Total_Amount) FROM BILL
);



SELECT d.doctor_name, COUNT(*) AS total_appointments
FROM APPOINTMENT a
JOIN DOCTOR d ON a.Doctor_ID = d.Doctor_ID
GROUP BY d.doctor_name
ORDER BY total_appointments DESC
LIMIT 1;



SELECT p.patient_name, b.Total_Amount
FROM BILL b
JOIN PATIENT p ON b.Patient_ID = p.Patient_ID
ORDER BY b.Total_Amount DESC
LIMIT 2;























