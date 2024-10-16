const express = require('express');
const { getAttendanceByStudent, markAttendance } = require('../controllers/attendanceController');
const router = express.Router();

// Get attendance for a student
router.get('/attendance/:register_number', getAttendanceByStudent);

// Mark attendance for a student
router.post('/attendance', markAttendance);

module.exports = router;
