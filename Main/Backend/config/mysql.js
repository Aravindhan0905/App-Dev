const mysql = require('mysql2');

const mysqlConnection = mysql.createConnection({
    host: 'localhost',
    user: 'root',           // Your MySQL username
    password: 'root',       // Your MySQL password
    database: 'studenterp',  // Your database name
    multipleStatements: true,        // Allows executing multiple queries at once
});

// Connect to the MySQL database
mysqlConnection.connect((err) => {
    if (!err) {
        console.log('Connected to MySQL');
        return;
    } else {
        console.log('MySQL Connection Failed: ', err);
    }
});

module.exports = mysqlConnection;
