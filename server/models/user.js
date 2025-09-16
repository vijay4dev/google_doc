const mongoose  = require('mongoose');

const userSchema = mongoose.Schema({
    name:{
        type:String,
        required:True
    },
    email:{
        type:String,
        required:True
    },
    pfp:{
        type:String,
        required:True,
        trim:true
    },
});

const usermodel = mongoose.model('User',userSchema);