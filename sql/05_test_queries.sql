SELECT
    a.appointment_id,
    p.full_name AS patient_name,
    d.full_name AS doctor_name,
    dep.department_name,
    s.slot_date,
    s.start_time,
    a.appointment_status
FROM clinic.appointments a
JOIN clinic.patients p
    ON a.patient_id = p.patient_id
JOIN clinic.schedule_slots s
    ON a.slot_id = s.slot_id
JOIN clinic.doctors d
    ON s.doctor_id = d.doctor_id
JOIN clinic.departments dep
    ON d.department_id = dep.department_id
ORDER BY s.slot_date, s.start_time;

SELECT
    d.full_name AS doctor_name,
    COUNT(a.appointment_id) AS total_appointments
FROM clinic.doctors d
JOIN clinic.schedule_slots s
    ON d.doctor_id = s.doctor_id
LEFT JOIN clinic.appointments a
    ON s.slot_id = a.slot_id
GROUP BY d.doctor_id, d.full_name
HAVING COUNT(a.appointment_id) >= 1;

SELECT
    dep.department_name,
    COUNT(a.appointment_id) AS total_visits,
    SUM(a.fee_amount) AS total_revenue,
    AVG(a.fee_amount) AS avg_fee
FROM clinic.departments dep
JOIN clinic.doctors d
    ON dep.department_id = d.department_id
JOIN clinic.schedule_slots s
    ON d.doctor_id = s.doctor_id
LEFT JOIN clinic.appointments a
    ON s.slot_id = a.slot_id
GROUP BY dep.department_name
ORDER BY total_revenue DESC NULLS LAST;

SELECT
    p.full_name,
    p.gender,
    a.reason,
    s.slot_date,
    s.start_time,
    a.fee_amount
FROM clinic.appointments a
JOIN clinic.patients p
    ON a.patient_id = p.patient_id
JOIN clinic.schedule_slots s
    ON a.slot_id = s.slot_id
WHERE p.gender = 'Female'
  AND p.birth_date BETWEEN '2000-01-01' AND '2006-12-31'
  AND a.appointment_status IN ('BOOKED', 'COMPLETED')
  AND a.fee_amount >= 7000
ORDER BY s.slot_date, s.start_time;

ANALYZE clinic.schedule_slots;

EXPLAIN ANALYZE
SELECT *
FROM clinic.schedule_slots
WHERE doctor_id = 1
  AND slot_date = '2026-02-20';
