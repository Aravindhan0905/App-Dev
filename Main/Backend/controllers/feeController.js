const db = require('../config/mysql');
const mysqlConnection = require('../config/mysql');

// Retrieve fee details for a student
exports.getFeesByStudent = (req, res) => {
    const { register_number } = req.params;
    const query = "SELECT * FROM fees WHERE register_number = ?";
    db.query(query, [register_number], (err, result) => {
        if (err) return res.status(500).send("Error fetching fees");
        res.status(200).json(result);
    });
};

// Update fee payment
exports.updateFeePayment = (req, res) => {
    const { register_number } = req.params;
    const { paid_amount } = req.body;

    const query = "UPDATE fees SET paid_amount = paid_amount + ?, balance_amount = total_amount - paid_amount, fee_status = IF(paid_amount >= total_amount, 'Paid', 'Pending') WHERE register_number = ?";
    db.query(query, [paid_amount, register_number], (err, result) => {
        if (err) return res.status(500).send("Error updating fee payment");
        res.status(200).send("Fee payment updated successfully");
    });
};
