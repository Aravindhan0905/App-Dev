const express = require('express');
const router = express.Router();
const connection = require('../config/mysql'); // Adjust the path if necessary

// Route to fetch and print hod_faculty data
router.get('/print-hod-faculty', (req, res) => {
    connection.query('SELECT * FROM hod_faculty', (error, results) => {
        if (error) {
            console.error('Error fetching hod_faculty data: ', error);
            return res.status(500).json({ message: 'Server error' });
        }

        console.log('hod_faculty data:', results); // Log the data to the console
        res.status(200).json(results); // Optionally send the results as a response
    });
});

module.exports = router;
