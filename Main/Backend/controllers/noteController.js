const Note = require('../models/Note');

// Get all notes
const getAllNotes = async (req, res) => {
    try {
        const notes = await Note.find();
        res.json(notes);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

// Create a new note
const createNote = async (req, res) => {
    const { title, content } = req.body;
    try {
        const newNote = new Note({
            title,
            content,
        });
        await newNote.save();
        res.json(newNote);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

module.exports = {
    getAllNotes,
    createNote,
};
