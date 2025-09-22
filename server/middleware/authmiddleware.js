const { json } = require("express");
const jwt = require("jsonwebtoken")

const auth = async (req , res , next ) => {
    try {
        const token = req.header(
            "x-auth-token"
        );

        if(!token){
            req.status(401).json({msg:"no auth token was provided"});
        }
        const verified = jwt.verify(token, "passwordKey");
        
        if(!verified){
            res.status(202 , json({msg:"not authorized user"}));
        }
    req.user = verified.id;
    req.token = token;
    next();

    } catch (error) {
        res.status(500 , json({error:error.message}));
    }
}

module.exports = auth;