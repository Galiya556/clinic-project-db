CREATE ROLE clinic_admin_role NOLOGIN;
CREATE ROLE registrar_role NOLOGIN;
CREATE ROLE doctor_role NOLOGIN;
CREATE ROLE analyst_role NOLOGIN;

CREATE USER clinic_admin WITH PASSWORD 'Admin123!';
CREATE USER registrar_user WITH PASSWORD 'Registrar123!';
CREATE USER doctor_user WITH PASSWORD 'Doctor123!';
CREATE USER analyst_user WITH PASSWORD 'Analyst123!';

GRANT clinic_admin_role TO clinic_admin;
GRANT registrar_role TO registrar_user;
GRANT doctor_role TO doctor_user;
GRANT analyst_role TO analyst_user;
