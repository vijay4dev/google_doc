// Express framework ko import kar rahe hai jo server banane ke liye use hota hai
const express = require('express');

// Mongoose ko import kar rahe hai jo MongoDB se connect hone ke liye use hota hai
const mongoose = require('mongoose');

const cors = require("cors");

// Apna custom authentication routes ko import kar rahe hai
const authrouter = require('./routes/auth');

// Express app create kar liya
const app = express();

// Server ka port define kar diya
const port = 3001;

// MongoDB Atlas ka connection string (is se database se connect honge)
const DB  = "mongodb+srv://tashviyadav9_db_user:6BX99Qpnv4yI1UUX@cluster0.mgtnrvb.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

app.use(cors());

// Middleware - JSON data ko samajhne ke liye
app.use(express.json());

// Apne authentication routes ko app me use kar lmbkiya
app.use(authrouter);

// MongoDB se connect kar rahe hai
mongoose.connect(DB).then(()=>{
    console.log('db connected') // Agar connection successful ho jata hai to ye print hoga
})

// Server ko listen/start kar rahe hai specific port pe
app.listen(port , '0.0.0.0' , function(){
    console.log('server started'); // Server start hone ke baad ye message show hoga
});
