const { getStudentById } = require('../models/Student');
const mysqlConnection = require('../config/mysql');

// Get student by ID
const getStudent = (req, res) => {
    const studentId = req.params.studentId;

    getStudentById(studentId, (err, student) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.json(student);
    });
};

module.exports = {
    getStudent,
};
