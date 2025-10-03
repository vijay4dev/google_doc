const express = require('express');
const Document = require("../models/document_model");
const auth = require("../middleware/authmiddleware");
const docroute = express.Router();

docroute.post("/doc/create", auth, async (req, res) => {
    try {

        const { createdAt } = req.body;



        let document = new Document({
            uid: req.user,
            title: "Untitle Document",
            createdAt,
        });

        document = await document.save();

        console.log("document======== ", document);

        res.json(document);

    } catch (error) {
        res.status(500).json(error)
        // Agar koi error aata hai to console me print kar denge
        console.log(error)
    }
});

docroute.post('/docs/me', auth, async (req, res) => {
    try {

        let documents = await Document.find({uid: req.user});

        res.json(documents);


    } catch (error) {
        res.status(500).json(error)
        // Agar koi error aata hai to console me print kar denge
        console.log("error in fetchionmg docs",error)
    }
});

docroute.get("/doc/:id", auth, async (req, res) => {
  try {
    const document = await Document.findById(req.params.id);
    res.json(document);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


module.exports = docroute;