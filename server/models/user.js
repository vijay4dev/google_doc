// 'mongoose' ko import kar rahe hai jo MongoDB ke saath kaam karne ke liye ek library hai
const mongoose  = require('mongoose');

// Ek schema define kar rahe hai jo bataayega ki humare 'User' collection ke documents ka structure kaisa hoga
// Matlab database me user ke data ko kis format me store karna hai
const userSchema = mongoose.Schema({
    // 'name' field - isme user ka naam store hoga
    name:{
        type:String,      // Ye field string type ki hogi (text)
        required:true     // Iska matlab hai ki name dena mandatory hai, bina iske data save nahi hoga
    },
    // 'email' field - user ka email address store karega
    email:{
        type:String,      // Ye bhi string type ki hogi
        required:true     // Email dena bhi compulsory hai
    },
    // 'pfp' field - user ka profile picture (pfp = profile picture) ka link store karega
    pfp:{
        type:String,      // Isme image ka URL (string) store karenge
        required:true     // Profile picture ka URL dena bhi zaroori hai
    },
});

// Ab schema ko ek model me convert kar rahe hai
// 'User' naam se ek model banega jo 'users' collection ke saath link hoga database me
// 'usermodel' ke through hum database me user ka data create, read, update aur delete (CRUD) kar sakte hai
const usermodel = mongoose.model('User', userSchema);

// Model ko export kar rahe hai taaki isse dusre files me use kiya ja sake
module.exports = usermodel;
