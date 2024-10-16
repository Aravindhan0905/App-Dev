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
//const noteRoutes = require('./routes/noteRoutes');  
const csvUploadRoutes = require('./routes/csvUpload');
const loginRoutes = require('./routes/loginRoutes');        // MongoDB (Notes)
const studentRoutes = require('./routes/studentRoutes');     // MySQL (Students)
const feeRoutes = require('./routes/feeRoutes');             // MySQL (Fees)
const attendanceRoutes = require('./routes/attendanceRoutes'); // MySQL (Attendance)
const testRoutes = require('./routes/test');

// Use routes
//app.use('/Notes', noteRoutes);         // Routes for managing notes (MongoDB)
app.use('/Upload', csvUploadRoutes);
app.use('/', loginRoutes);
app.use('/Students', studentRoutes);   // Routes for managing students (MySQL)
app.use('/Fees', feeRoutes);           // Routes for managing fees (MySQL)
app.use('/Attendance', attendanceRoutes); // Routes for managing attendance (MySQL)
app.use('/', testRoutes);

// Home route
app.get('/', (req, res) => {
    res.send('Student ERP backend is running');
});

// Start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server running on port ${PORT}`);
});
