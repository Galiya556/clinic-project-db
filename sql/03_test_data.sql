INSERT INTO clinic.departments (department_name) VALUES
('Кардиология'),
('Терапия'),
('Педиатрия');

INSERT INTO clinic.rooms (room_number, floor_no) VALUES
('101', 1),
('102', 1),
('205', 2);

INSERT INTO clinic.specializations (specialization_name) VALUES
('Кардиолог'),
('Терапевт'),
('Педиатр');

INSERT INTO clinic.doctors (full_name, phone, email, department_id, hire_date, status) VALUES
('Айдос Сәрсенов', '+77010000001', 'aidossarsenov@clinic.kz', 1, '2023-01-10', 'ACTIVE'),
('Мадина Ермекова', '+77010000002', 'madinaermekova@clinic.kz', 2, '2022-09-01', 'ACTIVE'),
('Данияр Қуатов', '+77010000003', 'daniyarquatov@clinic.kz', 3, '2024-02-15', 'ACTIVE');

INSERT INTO clinic.doctor_specializations (doctor_id, specialization_id) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO clinic.patients (full_name, birth_date, gender, phone) VALUES
('Аружан Нұрланқызы', '2003-05-14', 'Female', '+77070000001'),
('Әлихан Серікұлы', '2001-11-20', 'Male', '+77070000002'),
('Жанель Төлеген', '2005-08-09', 'Female', '+77070000003'),
('Нұрбек Асқаров', '1999-12-02', 'Male', '+77070000004');

INSERT INTO clinic.schedule_slots (doctor_id, room_id, slot_date, start_time, end_time, slot_status) VALUES
(1, 1, '2026-02-20', '09:00', '09:30', 'BOOKED'),
(1, 1, '2026-02-20', '09:30', '10:00', 'OPEN'),
(2, 2, '2026-02-20', '10:00', '10:30', 'BOOKED'),
(2, 2, '2026-02-20', '10:30', '11:00', 'BOOKED'),
(3, 3, '2026-02-21', '11:00', '11:30', 'OPEN');

INSERT INTO clinic.appointments (slot_id, patient_id, reason, appointment_status, fee_amount) VALUES
(1, 1, 'Жүрек тұсының ауыруы', 'BOOKED', 12000),
(3, 2, 'Жалпы тексеру', 'COMPLETED', 8000),
(4, 3, 'Суық тию белгілері', 'BOOKED', 7000);
