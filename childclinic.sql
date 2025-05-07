CREATE DATABASE child_clinic_db;
USE child_clinic_db;
-- drop database child_clinic_db;

-- 1. Parent/Guardian Table - Stores parent/guardian details.
CREATE TABLE Parent (
    ParentID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100),
    Address VARCHAR(255)
);

-- 2. Child Table - Stores details of each child and links them to their parent.
CREATE TABLE Child (
    ChildID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender ENUM('Male', 'Female') NOT NULL,
    ParentID INT,
    FOREIGN KEY (ParentID) REFERENCES Parent(ParentID)
);

-- 3. Appointment Table - Logs each clinic visit and the reason for the visit. 
CREATE TABLE Appointment (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    ChildID INT,
    AppointmentDate DATE NOT NULL,
    Reason VARCHAR(255),
    Notes TEXT,
    FOREIGN KEY (ChildID) REFERENCES Child(ChildID)
);

-- 4. Child Measurement Table - LOG CHILDS METRICS (WEIGHT, HEIGHT, HEAD CIRCUMFERENCE) AT EACH VISIT
-- This table will also include the appointment ID to link it to the appointment table.
CREATE TABLE ChildMeasurement (
    MeasurementID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT,
    Weight DECIMAL(5,2),
    Height DECIMAL(5,2),
    HeadCircumference DECIMAL(5,2),
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
);

-- 5. Vaccination Table - UPDATE CHILD VACCINATION RECORDS, tracks the vaccinations each child has received.
-- This table will also include the date of vaccination and any notes related to the vaccination.
CREATE TABLE Vaccination (
    VaccinationID INT AUTO_INCREMENT PRIMARY KEY,
    ChildID INT,
    VaccineName VARCHAR(100) NOT NULL,
    DoseNumber INT,
    VaccinationDate DATE NOT NULL,
    Notes TEXT,
    FOREIGN KEY (ChildID) REFERENCES Child(ChildID)
);

-- 6. Observation Table - PAEDITRICIAN notes AND SETS NEXT APPOINTMENT
CREATE TABLE Observation (
    ObservationID INT AUTO_INCREMENT PRIMARY KEY,
    MeasurementID INT,
    NextVisitDate DATE NOT NULL,
    Diagnosis TEXT,
    TreatmentPlan TEXT,
    FOREIGN KEY (MeasurementID) REFERENCES ChildMeasurement(MeasurementID)
);

-- 7. Referral Table - LOGS ANY REFERRALS MADE TO SPECIALISTS Used when a child needs further care or specialist evaluation.
CREATE TABLE Referral (
    ReferralID INT AUTO_INCREMENT PRIMARY KEY,
    ObservationID INT,
    ReferralDate DATE NOT NULL,
    ReferredTo VARCHAR(100) NOT NULL,
    Reason TEXT,
    FOREIGN KEY (ObservationID) REFERENCES Observation(ObservationID)
);
