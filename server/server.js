const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

// Database connection
const db = mysql.createConnection({
  host: 'localhost',
  user: 'classroom_user',
  password: 'new_secure_password123', 
  database: 'class_occupancy_tracker'
});

// Connect to MySQL
db.connect(err => {
  if (err) {
    console.error('Error connecting to MySQL:', err);
    return;
  }
  console.log('Connected to MySQL database');
  updateRoomStatuses(); // Initial update
});

// Function to get current classes
function getCurrentClasses() {
  const now = new Date();
  const currentDay = now.toLocaleDateString('en-US', { weekday: 'long' });
  const currentTime = now.toTimeString().substring(0, 8);

  return new Promise((resolve, reject) => {
    const query = `
      SELECT tt.room_id, c.name as room_name, 
             s.name as section_name, sub.name as subject_name,
             t.name as teacher_name
      FROM timetable tt
      JOIN classrooms c ON tt.room_id = c.room_id
      JOIN section_subject_teacher sst ON tt.section_subject_teacher_id = sst.id
      JOIN sections s ON sst.section_id = s.s.section_id
      JOIN subjects sub ON sst.subject_id = sub.subject_id
      JOIN teachers t ON sst.teacher_id = t.teacher_id
      WHERE tt.day_of_week = ?
      AND tt.start_time <= ?
      AND tt.end_time >= ?`;
    
    db.query(query, [currentDay, currentTime, currentTime], (err, results) => {
      if (err) return reject(err);
      resolve(results);
    });
  });
}

// Function to update room statuses automatically
async function updateRoomStatuses() {
  try {
    const [classrooms, currentClasses] = await Promise.all([
      new Promise((resolve, reject) => {
        db.query('SELECT room_id FROM classrooms', (err, results) => {
          if (err) reject(err);
          else resolve(results);
        });
      }),
      getCurrentClasses()
    ]);

    // Reset all rooms to vacant first
    await Promise.all(classrooms.map(room => {
      return new Promise((resolve) => {
        db.query(
          `INSERT INTO room_status (room_id, current_status, update_method) 
           VALUES (?, "Vacant", "auto") 
           ON DUPLICATE KEY UPDATE 
           current_status = IF(update_method = 'manual', current_status, "Vacant"),
           last_updated = IF(update_method = 'manual', last_updated, NOW())`,
          [room.room_id],
          resolve
        );
      });
    }));

    // Mark occupied rooms
    await Promise.all(currentClasses.map(cls => {
      return new Promise((resolve) => {
        db.query(
          `UPDATE room_status 
           SET current_status = "Occupied", 
               last_updated = NOW(),
               update_method = "auto",
               updated_by = NULL 
           WHERE room_id = ? AND update_method != 'manual'`,
          [cls.room_id],
          resolve
        );
      });
    }));

    console.log('Room statuses updated automatically at', new Date());
  } catch (err) {
    console.error('Error updating room statuses:', err);
  }
}

// Update room statuses every minute
setInterval(updateRoomStatuses, 60000);

// API Endpoints
app.get('/api/classrooms', (req, res) => {
  const query = `
    SELECT c.room_id, c.name, c.capacity, c.room_type, 
           rs.current_status, rs.last_updated, 
           t.name as updated_by, rs.update_method
    FROM classrooms c
    LEFT JOIN room_status rs ON c.room_id = rs.room_id
    LEFT JOIN teachers t ON rs.updated_by = t.teacher_id
    ORDER BY c.name`;
  
  db.query(query, (err, results) => {
    if (err) {
      console.error('Error fetching classrooms:', err);
      return res.status(500).send('Error fetching classrooms');
    }
    res.json(results);
  });
});

app.put('/api/classrooms/:id/status', (req, res) => {
  const { id } = req.params;
  const { status, teacherId } = req.body;
  
  const query = `
    INSERT INTO room_status (room_id, current_status, updated_by, update_method)
    VALUES (?, ?, ?, 'manual')
    ON DUPLICATE KEY UPDATE
    current_status = VALUES(current_status),
    updated_by = VALUES(updated_by),
    update_method = VALUES(update_method),
    last_updated = NOW()`;
  
  db.query(query, [id, status, teacherId], (err, result) => {
    if (err) {
      console.error('Error updating status:', err);
      return res.status(500).send('Error updating status');
    }
    res.json({ message: 'Status updated successfully' });
  });
});

app.get('/api/classrooms/:id/timetable', (req, res) => {
  const { id } = req.params;
  
  const query = `
    SELECT tt.day_of_week, tt.start_time, tt.end_time,
           s.name as section_name, sub.name as subject_name, 
           t.name as teacher_name
    FROM timetable tt
    JOIN section_subject_teacher sst ON tt.section_subject_teacher_id = sst.id
    JOIN sections s ON sst.section_id = s.section_id
    JOIN subjects sub ON sst.subject_id = sub.subject_id
    JOIN teachers t ON sst.teacher_id = t.teacher_id
    WHERE tt.room_id = ?
    ORDER BY tt.day_of_week, tt.start_time`;
  
  db.query(query, [id], (err, results) => {
    if (err) {
      console.error('Error fetching timetable:', err);
      return res.status(500).send('Error fetching timetable');
    }
    res.json(results);
  });
});

app.get('/api/teachers', (req, res) => {
  const query = 'SELECT teacher_id, name FROM teachers ORDER BY name';
  
  db.query(query, (err, results) => {
    if (err) {
      console.error('Error fetching teachers:', err);
      return res.status(500).send('Error fetching teachers');
    }
    res.json(results);
  });
});

// Add this endpoint to server.js to get all sections
app.get('/api/sections', (req, res) => {
  const query = 'SELECT section_id, name FROM sections ORDER BY name';
  
  db.query(query, (err, results) => {
    if (err) {
      console.error('Error fetching sections:', err);
      return res.status(500).send('Error fetching sections');
    }
    res.json(results);
  });
});

// Add this endpoint to server.js to get timetable for a section
app.get('/api/sections/:id/timetable', (req, res) => {
  const { id } = req.params;
  
  const query = `
    SELECT tt.day_of_week, tt.start_time, tt.end_time,
           c.name as room_name, sub.name as subject_name, 
           t.name as teacher_name
    FROM timetable tt
    JOIN section_subject_teacher sst ON tt.section_subject_teacher_id = sst.id
    JOIN classrooms c ON tt.room_id = c.room_id
    JOIN subjects sub ON sst.subject_id = sub.subject_id
    JOIN teachers t ON sst.teacher_id = t.teacher_id
    WHERE sst.section_id = ?
    ORDER BY tt.day_of_week, tt.start_time`;
  
  db.query(query, [id], (err, results) => {
    if (err) {
      console.error('Error fetching section timetable:', err);
      return res.status(500).send('Error fetching section timetable');
    }
    res.json(results);
  });
});

const PORT = 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});