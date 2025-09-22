// Express ko import kar rahe hai (server aur routes banane ke liye)
const express = require('express');

// Apna User model import kar rahe hai (ye 'user.js' file se aaya jo schema define karta hai)
const User = require("../models/user");

// Express ka Router banaya - iske andar hum apne routes define karenge
const authrouter = express.Router();

// Signup route banaya (POST request ke liye)
// Jab koi user signup karega to ye route hit hoga
authrouter.post('/api/signup' , async (req,res)=>{

    // Request ke andar aaya hua data (body se) console me print karenge
    console.log("request =====" , req.body)

    // Body se name, email aur profile picture extract kiya
    const {name , email , pfp} = req.body;

    try {
        // Database me check kar rahe hai ki ye email pehle se exist karta hai ya nahi
        let user = await User.findOne({
            email
        });
        
        // Agar user exist nahi karta hai to naya user create karenge
        if(!user){
            // Naya user object banaya
            user = new User({
                name,
                email,
                pfp
            })
            // Database me save kar diya
            user = await user.save();
        }
        else{
            // Agar user already exist karta hai to error return karenge
            return res.status(401).json({erro:"email already exit"});
        }

        // Agar sab sahi hai to user ka data response me bhej denge
        res.json({user});
        
    } catch (error) {
        res.status(500).json(error)
        // Agar koi error aata hai to console me print kar denge
        console.log(error)
    }
})

// Apne router ko export kar diya taaki ise server me use kar sake
module.exports = authrouter;
