const express = require('express');
const { getFeesByStudent, updateFeePayment } = require('../controllers/feeController');
const router = express.Router();

// Get fee details for a student
router.get('/fees/:register_number', getFeesByStudent);

// Update fee payment
router.put('/fees/:register_number', updateFeePayment);

module.exports = router;
