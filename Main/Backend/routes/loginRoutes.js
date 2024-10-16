const express = require('express');
const router = express.Router();
const connection = require('../config/mysql'); // MySQL connection

router.post('/login', (req, res) => {
    const { email, password } = req.body; // Get the email and password from the request body

    if (!email || !password) {
        return res.status(400).json({ message: 'Email and Password are required' });
    }

    // Query the database to check the email and password
    connection.query(
        'SELECT * FROM hod_faculty WHERE email = ? AND password = ?',
        [email, password],
        (error, results) => {
            if (error) {
                return res.status(500).json({ message: 'Server error' });
            }

            if (results.length > 0) {
                // If user is found, send back the user role
                const user = results[0];
                return res.status(200).json({
                    message: 'Login successful',
                    role: user.role, // Assuming the role field is stored in the database
                });
            } else {
                return res.status(401).json({ message: 'Invalid email or password' });
            }
        }
    );
});

module.exports = router;
