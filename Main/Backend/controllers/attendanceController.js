const db = require('../config/mysql');
const mysqlConnection = require('../config/mysql');
// Retrieve attendance for a student
exports.getAttendanceByStudent = (req, res) => {
    const { register_number } = req.params;
    const query = "SELECT * FROM attendance WHERE register_number = ?";
    db.query(query, [register_number], (err, result) => {
        if (err) return res.status(500).send("Error fetching attendance");
        res.status(200).json(result);
    });
};

// Mark attendance for a student
exports.markAttendance = (req, res) => {
    const { register_number } = req.body;
    const { date, status, subject } = req.body;

    const query = "INSERT INTO attendance (register_number, date, status, subject) VALUES (?, ?, ?, ?)";
    db.query(query, [register_number, date, status, subject], (err, result) => {
        if (err) return res.status(500).send("Error marking attendance");
        res.status(200).send("Attendance marked successfully");
    });
};
