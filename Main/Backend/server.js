const express = require('express');
const xlsx = require('xlsx');
const mysql = require('mysql2');
const path = require('path');

const app = express();
const port = 3000;

// Create a MySQL connection
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'backupdb'
});

// Connect to MySQL
connection.connect((err) => {
    if (err) {
        console.error('Error connecting to MySQL:', err.message);
        return;
    }
    console.log('Connected to MySQL');
});

// Route to hardcode Excel file processing
app.get('/process-excel', (req, res) => {
    // Hardcoded Excel file path
    const filePath = path.join(Backend, 'student_erp.xlsx'); // Replace with your actual file path

    // Read the Excel file
    const workbook = xlsx.readFile(filePath);
    const sheetName = workbook.SheetNames[0];
    const worksheet = workbook.Sheets[sheetName];

    // Convert the sheet to JSON
    const data = xlsx.utils.sheet_to_json(worksheet);

    // Iterate through the JSON and update the database
    data.forEach(row => {

        // Extract only the necessary columns
        const student_id = row['RegisterNo'];  // Assuming this is unique and maps to student_id
        const name = row['Student Name with Initial( Should be in Capital Letters as per SSLC mark sheet)'];  // Adjust to the correct name field
        const email = row['EmailId (Instutution Id)'];
        const dept = row['Programme Name'];  // Assuming this corresponds to department
        const year = row['Year Of Admission'];
        const password = 'default_password'; // You can set a default password or generate one

        // Construct query to insert/update the student record in the database
        const query = `
      INSERT INTO students (student_id, name, email, password, department, year)
      VALUES (?, ?, ?, ?, ?, ?)
      ON DUPLICATE KEY UPDATE 
        name = VALUES(name),
        email = VALUES(email),
        department = VALUES(department),
        year = VALUES(year);
    `;

        // Execute the query with data
        connection.query(query, [student_id, name, email, password, dept, year], (err, result) => {
            if (err) {
                console.error('Error updating database:', err.message);
            }
        });
    });

    res.send('Excel file processed and database updated.');
});

// Start the server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});

app.get('/', (req, res) => {
    res.send('Welcome to the Excel Upload App! Use /process-excel to process the hardcoded file.');
});
