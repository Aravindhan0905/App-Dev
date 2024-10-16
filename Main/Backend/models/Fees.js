const mysqlConnection = require('../config/mysql');

// Fetch fee details by student ID
const getFeesByStudentId = (studentId, callback) => {
    const query = 'SELECT * FROM fees WHERE studentId = ?';
    mysqlConnection.query(query, [studentId], (err, results) => {
        if (err) {
            return callback(err, null);
        }
        callback(null, results);
    });
};

module.exports = {
    getFeesByStudentId,
};
