CREATE INDEX idx_doctors_department
    ON clinic.doctors(department_id);

CREATE INDEX idx_slots_doctor_date
    ON clinic.schedule_slots(doctor_id, slot_date);

CREATE INDEX idx_slots_room_date
    ON clinic.schedule_slots(room_id, slot_date);

CREATE INDEX idx_appointments_patient
    ON clinic.appointments(patient_id);

CREATE INDEX idx_appointments_status
    ON clinic.appointments(appointment_status);

CREATE VIEW clinic.vw_doctor_daily_schedule AS
SELECT
    d.doctor_id,
    d.full_name AS doctor_name,
    dep.department_name,
    r.room_number,
    s.slot_date,
    s.start_time,
    s.end_time,
    s.slot_status,
    a.appointment_id,
    p.full_name AS patient_name,
    a.appointment_status
FROM clinic.schedule_slots s
JOIN clinic.doctors d
    ON s.doctor_id = d.doctor_id
JOIN clinic.departments dep
    ON d.department_id = dep.department_id
JOIN clinic.rooms r
    ON s.room_id = r.room_id
LEFT JOIN clinic.appointments a
    ON s.slot_id = a.slot_id
LEFT JOIN clinic.patients p
    ON a.patient_id = p.patient_id;

GRANT CONNECT ON DATABASE clinic_project
TO clinic_admin, registrar_user, doctor_user, analyst_user;

GRANT USAGE ON SCHEMA clinic
TO clinic_admin_role, registrar_role, doctor_role, analyst_role;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA clinic
TO clinic_admin_role;

GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA clinic
TO clinic_admin_role;

GRANT SELECT ON clinic.departments, clinic.rooms, clinic.doctors,
               clinic.specializations, clinic.doctor_specializations,
               clinic.schedule_slots, clinic.vw_doctor_daily_schedule
TO registrar_role;

GRANT SELECT, INSERT, UPDATE ON clinic.patients, clinic.appointments
TO registrar_role;

GRANT USAGE, SELECT ON SEQUENCE clinic.patient_seq, clinic.appointment_seq
TO registrar_role;

GRANT SELECT ON ALL TABLES IN SCHEMA clinic
TO doctor_role;

GRANT UPDATE (appointment_status) ON clinic.appointments
TO doctor_role;

GRANT UPDATE (slot_status) ON clinic.schedule_slots
TO doctor_role;

GRANT SELECT ON ALL TABLES IN SCHEMA clinic
TO analyst_role;
