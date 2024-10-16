const express = require('express');
const { getAllNotes, createNote } = require('../controllers/noteController');
const router = express.Router();

// Route to get all notes
router.get('/', getAllNotes);

// Route to create a new note
router.post('/', createNote);

module.exports = router;
