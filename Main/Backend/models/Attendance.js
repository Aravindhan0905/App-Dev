const mysqlConnection = require('../config/mysql');

// Fetch attendance details by student ID
const getAttendanceByStudentId = (studentId, callback) => {
    const query = 'SELECT * FROM attendance WHERE studentId = ?';
    mysqlConnection.query(query, [studentId], (err, results) => {
        if (err) {
            return callback(err, null);
        }
        callback(null, results);
    });
};

module.exports = {
    getAttendanceByStudentId,
};
