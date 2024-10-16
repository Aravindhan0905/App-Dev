const express = require('express');
const router = express.Router();
const multer = require('multer');
const csvParser = require('csv-parser');
const fs = require('fs');
const connection = require('../config/mysql'); // MySQL connection

// Set up multer for file upload
const upload = multer({ dest: 'uploads/' }); // Files will be uploaded to the 'uploads/' directory

// CSV upload route
router.post('/upload-students', upload.single('file'), (req, res) => {
    if (!req.file) {
        return res.status(400).json({ message: 'No file uploaded' });
    }

    const results = [];
    fs.createReadStream(req.file.path)
        .pipe(csvParser())
        .on('data', (row) => {
            results.push(row); // Parse each row of the CSV file
        })
        .on('end', () => {
            // Once the file is fully parsed, insert each student into the MySQL database
            results.forEach(student => {
                const { email, password, name, dept } = student;
                connection.query(
                    'INSERT INTO students (email, password, name, department) VALUES (?, ?, ?, ?)',
                    [email, password, name, dept],
                    (err, result) => {
                        if (err) {
                            console.error('Error inserting student:', err);
                        } else {
                            console.log('Student inserted:', result);
                        }
                    }
                );
            });
            res.status(200).json({ message: 'Students uploaded and inserted into database' });
        })
        .on('error', (error) => {
            console.error('Error reading CSV file:', error);
            res.status(500).json({ message: 'Error reading CSV file' });
        });
});

module.exports = router;
