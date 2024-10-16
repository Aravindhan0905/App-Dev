const mysqlConnection = require('../config/mysql');

// Fetch a student by ID
const getStudentById = (studentId, callback) => {
    const query = 'SELECT * FROM students WHERE studentId = ?';
    mysqlConnection.query(query, [studentId], (err, results) => {
        if (err) {
            return callback(err, null);
        }
        callback(null, results);
    });
};

module.exports = {
    getStudentById,
};
