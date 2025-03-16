SET client_min_messages = WARNING;

CREATE TABLE IF NOT EXISTS Semester (
  id SERIAL PRIMARY KEY, 
  name VARCHAR(50) NOT NULL,
  start_date DATE,
  end_date DATE,
  active BOOL 
);

CREATE TABLE IF NOT EXISTS Discipline (
  id SERIAL PRIMARY KEY, 
  name VARCHAR(50) NOT NULL,
  semester_id INT,
  FOREIGN KEY (semester_id) REFERENCES Semester(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Lab (
  id SERIAL PRIMARY KEY, 
  name VARCHAR(50) NOT NULL,
  deadline DATE,
  completed BOOL, 
  mark INT,
  discipline_id INT,
  FOREIGN KEY (discipline_id) REFERENCES Discipline(id) ON DELETE CASCADE
);
