const express = require('express');

const authrouter = express.Router();

authrouter.post('/api/signup' , async (req,res)=>{
    try {
        const {name , email , pfp} = res.body;
        
    } catch (error) {
        console.log(error)
    }
})