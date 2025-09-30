const mongoose = require("mongoose");


const doc_schema = mongoose.Schema({
    uid:{
        required:true,
        type: String
    },
    CreatedAt:{
        required: true,
        type: Number
    },
    Title:{
        required:true,
        type: String,
        trim: true
    },
    Content:{
        type: Array,
        default: []
    }
});

const Document = mongoose.model('Document' , doc_schema)

module.exports = Document;