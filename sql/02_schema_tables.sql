CREATE SCHEMA clinic;

CREATE SEQUENCE clinic.department_seq START 1 INCREMENT 1;
CREATE SEQUENCE clinic.room_seq START 1 INCREMENT 1;
CREATE SEQUENCE clinic.specialization_seq START 1 INCREMENT 1;
CREATE SEQUENCE clinic.doctor_seq START 1 INCREMENT 1;
CREATE SEQUENCE clinic.patient_seq START 1 INCREMENT 1;
CREATE SEQUENCE clinic.slot_seq START 1 INCREMENT 1;
CREATE SEQUENCE clinic.appointment_seq START 1 INCREMENT 1;

CREATE TABLE clinic.departments (
    department_id INTEGER PRIMARY KEY DEFAULT nextval('clinic.department_seq'),
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE clinic.rooms (
    room_id INTEGER PRIMARY KEY DEFAULT nextval('clinic.room_seq'),
    room_number VARCHAR(10) NOT NULL UNIQUE,
    floor_no INTEGER NOT NULL CHECK (floor_no > 0)
);

CREATE TABLE clinic.specializations (
    specialization_id INTEGER PRIMARY KEY DEFAULT nextval('clinic.specialization_seq'),
    specialization_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE clinic.doctors (
    doctor_id INTEGER PRIMARY KEY DEFAULT nextval('clinic.doctor_seq'),
    full_name VARCHAR(150) NOT NULL,
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(120) UNIQUE,
    department_id INTEGER NOT NULL,
    hire_date DATE NOT NULL DEFAULT CURRENT_DATE,
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT chk_doctor_status CHECK (status IN ('ACTIVE', 'ON_LEAVE', 'DISMISSED')),
    CONSTRAINT fk_doctor_department
        FOREIGN KEY (department_id) REFERENCES clinic.departments(department_id)
);

CREATE TABLE clinic.doctor_specializations (
    doctor_id INTEGER NOT NULL,
    specialization_id INTEGER NOT NULL,
    PRIMARY KEY (doctor_id, specialization_id),
    CONSTRAINT fk_ds_doctor
        FOREIGN KEY (doctor_id) REFERENCES clinic.doctors(doctor_id) ON DELETE CASCADE,
    CONSTRAINT fk_ds_specialization
        FOREIGN KEY (specialization_id) REFERENCES clinic.specializations(specialization_id) ON DELETE CASCADE
);

CREATE TABLE clinic.patients (
    patient_id INTEGER PRIMARY KEY DEFAULT nextval('clinic.patient_seq'),
    full_name VARCHAR(150) NOT NULL,
    birth_date DATE NOT NULL CHECK (birth_date <= CURRENT_DATE),
    gender VARCHAR(10) NOT NULL CHECK (gender IN ('Male', 'Female')),
    phone VARCHAR(20) UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE clinic.schedule_slots (
    slot_id INTEGER PRIMARY KEY DEFAULT nextval('clinic.slot_seq'),
    doctor_id INTEGER NOT NULL,
    room_id INTEGER NOT NULL,
    slot_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    slot_status VARCHAR(20) NOT NULL DEFAULT 'OPEN',
    CONSTRAINT chk_slot_time CHECK (start_time < end_time),
    CONSTRAINT chk_slot_status CHECK (slot_status IN ('OPEN', 'BOOKED', 'CANCELLED')),
    CONSTRAINT uq_doctor_slot UNIQUE (doctor_id, slot_date, start_time),
    CONSTRAINT fk_slot_doctor
        FOREIGN KEY (doctor_id) REFERENCES clinic.doctors(doctor_id),
    CONSTRAINT fk_slot_room
        FOREIGN KEY (room_id) REFERENCES clinic.rooms(room_id)
);

CREATE TABLE clinic.appointments (
    appointment_id INTEGER PRIMARY KEY DEFAULT nextval('clinic.appointment_seq'),
    slot_id INTEGER NOT NULL UNIQUE,
    patient_id INTEGER NOT NULL,
    reason VARCHAR(255) NOT NULL,
    appointment_status VARCHAR(20) NOT NULL DEFAULT 'BOOKED',
    fee_amount NUMERIC(10,2) NOT NULL DEFAULT 0 CHECK (fee_amount >= 0),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_appointment_status CHECK (
        appointment_status IN ('BOOKED', 'COMPLETED', 'CANCELLED', 'NO_SHOW')
    ),
    CONSTRAINT fk_appointment_slot
        FOREIGN KEY (slot_id) REFERENCES clinic.schedule_slots(slot_id),
    CONSTRAINT fk_appointment_patient
        FOREIGN KEY (patient_id) REFERENCES clinic.patients(patient_id)
);
