const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

// Initialize the app
const app = express();

// Middleware
app.use(bodyParser.json());
app.use(cors());

// Database connections
require('./config/mongoose'); // MongoDB connection for notes
const mysqlConnection = require('./config/mysql'); // MySQL connection for students, fees, and attendance

// Import routes
const noteRoutes = require('./routes/noteRoutes');           // MongoDB (Notes)
const studentRoutes = require('./routes/studentRoutes');     // MySQL (Students)
const feeRoutes = require('./routes/feeRoutes');             // MySQL (Fees)
const attendanceRoutes = require('./routes/attendanceRoutes'); // MySQL (Attendance)

// Use routes
app.use('/Notes', noteRoutes);         // Routes for managing notes (MongoDB)
app.use('/Students', studentRoutes);   // Routes for managing students (MySQL)
app.use('/Fees', feeRoutes);           // Routes for managing fees (MySQL)
app.use('/Attendance', attendanceRoutes); // Routes for managing attendance (MySQL)

// Home route
app.get('/', (req, res) => {
    res.send('Student ERP backend is running');
});

// Start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
