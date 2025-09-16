const express = require('express');
const mongoose = require('mongoose');

const app = express();

const port = 3001;

const DB  = "mongodb+srv://tashviyadav9_db_user:6BX99Qpnv4yI1UUX@cluster0.mgtnrvb.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

mongoose.connect(DB).then(()=>{
    console.log('db connected')
})

app.listen(port , '0.0.0.0' , function(){
    console.log('server started');
});

