const express = require('express');
const { getStudent } = require('../controllers/studentController');
const router = express.Router();

// Route to get student by ID
router.get('/:studentId', getStudent);

module.exports = router;
