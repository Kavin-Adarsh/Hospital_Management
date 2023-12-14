CREATE DATABASE hospital;

USE hospital;

CREATE TABLE patient (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dob DATE NOT NULL,
    gender VARCHAR(10) NOT NULL,
    mobile_number VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL
);


INSERT INTO patient (first_name, last_name, dob, gender, mobile_number, email, password) VALUES
('John', 'Doe', '1990-05-15', 'Male', '1234567890', 'john.doe@example.com', 'patient_password1'),
('Jane', 'Smith', '1985-08-22', 'Female', '9876543210', 'jane.smith@example.com', 'patient_password2'),
('Michael', 'Johnson', '1995-03-10', 'Male', '5551112222', 'michael.j@example.com', 'patient_password3'),
('Emily', 'Williams', '1988-11-18', 'Female', '7778889999', 'emily.w@example.com', 'patient_password4'),
('David', 'Miller', '1992-07-25', 'Male', '4443332222', 'david.m@example.com', 'patient_password5');



CREATE TABLE doctor (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialisation VARCHAR(100) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    dob DATE NOT NULL,
    mobile_number VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL 
);

INSERT INTO doctor (first_name, last_name, specialisation, gender, dob, mobile_number, email, password) VALUES
('Dr. Alex', 'Johnson', 'Cardiology', 'Male', '1978-09-20', '1234567890', 'alex@mail.com', '1234567890'),
('Dr. Sarah', 'Smith', 'Pediatrics', 'Female', '1985-06-15', '9876543210', 'sarah.smith@example.com', 'doctor_password2'),
('Dr. Robert', 'Miller', 'Orthopedics', 'Male', '1972-11-10', '5551112222', 'robert.m@example.com', 'doctor_password3'),
('Dr. Emily', 'Davis', 'Dermatology', 'Female', '1988-04-18', '7778889999', 'emily.d@example.com', 'doctor_password4'),
('Dr. Michael', 'Taylor', 'Ophthalmology', 'Male', '1982-03-25', '4443332222', 'michael.t@example.com', 'doctor_password5');

CREATE TABLE admin (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- Insert a sample admin user
INSERT INTO admin (name, email, password) VALUES
('Kavin Adarsh', 'kavinadarsh@gmail.com', 'kavinadarsh');

-- Add the following SQL statements to create the new tables
CREATE TABLE appointment (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    appointment_time TIME,
    status VARCHAR(20),
    purpose VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
);

CREATE TABLE medical_record (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    admission_date DATE,
    discharge_date DATE,
    diagnosis VARCHAR(255),
    treatment VARCHAR(255),
    medications VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
);

CREATE TABLE lab_test_results (
    result_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    test_date DATE,
    test_type VARCHAR(50),
    result_details VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
);


-- Sample data for appointments
INSERT INTO appointment (patient_id, doctor_id, appointment_date, appointment_time, status, purpose)
VALUES 
(1, 1, '2023-01-15', '10:00:00', 'Scheduled', 'Routine checkup'),
(2, 2, '2023-01-20', '14:30:00', 'Confirmed', 'Follow-up appointment'),
(3, 3, '2023-01-25', '11:45:00', 'Scheduled', 'Initial consultation'),
(4, 4, '2023-01-30', '09:15:00', 'Confirmed', 'Diagnostic test review'),
(5, 5, '2023-02-05', '13:00:00', 'Scheduled', 'Follow-up examination');

-- Sample data for medical records
INSERT INTO medical_record (patient_id, doctor_id, admission_date, discharge_date, diagnosis, treatment, medications)
VALUES
(1, 1, '2022-12-01', '2022-12-10', 'Common cold', 'Rest and fluids', 'Paracetamol'),
(2, 2, '2022-11-15', '2022-11-25', 'Sprained ankle', 'RICE therapy', 'Ibuprofen'),
(3, 3, '2022-10-20', '2022-10-25', 'Upper respiratory infection', 'Antibiotics', 'Cough syrup'),
(4, 4, '2022-09-05', '2022-09-15', 'Hypertension', 'Lifestyle modifications', 'Amlodipine'),
(5, 5, '2022-08-10', '2022-08-20', 'Concussion', 'Rest and monitoring', 'Pain relievers');

-- Sample data for lab test results
INSERT INTO lab_test_results (patient_id, doctor_id, test_date, test_type, result_details)
VALUES
(1, 1, '2022-12-05', 'Blood Test', 'Normal blood cell counts'),
(2, 2, '2022-11-20', 'X-Ray', 'No fractures detected'),
(3, 3, '2022-10-25', 'Molecular Test', 'Positive for viral infection'),
(4, 4, '2022-09-10', 'Blood Pressure Measurement', 'Normal range'),
(5, 5, '2022-08-15', 'CT Scan', 'No abnormalities detected');
