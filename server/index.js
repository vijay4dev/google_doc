// Express framework ko import kar rahe hai jo server banane ke liye use hota hai
const express = require('express');

// Mongoose ko import kar rahe hai jo MongoDB se connect hone ke liye use hota hai
const mongoose = require('mongoose');

const cors = require('cors');

const http = require('http');

// Apna custom authentication routes ko import kar rahe hai
const authrouter = require('./routes/auth');
const docroute = require('./routes/document');

// Express app create kar liya
const app = express();

var server = http.createServer(app);
var io = require('socket.io')(server, {
  cors: {
    origin: "*",
    methods: ["GET", "POST"]
  }
});

// Server ka port define kar diya
const port = 3001;

// MongoDB Atlas ka connection string (is se database se connect honge)
const DB  = "mongodb+srv://tashviyadav9_db_user:JSHsEMIJojazP6cy@cluster0.mgtnrvb.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

app.use(cors());

// Middleware - JSON data ko samajhne ke liye
app.use(express.json());

// Apne authentication routes ko app me use kar lmbkiya
app.use(authrouter);

app.use(docroute);

// MongoDB se connect kar rahe hai
mongoose.connect(DB, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => console.log('✅ DB connected'))
  .catch(err => console.error('❌ DB connection error:', err));


// Proper connection event
io.on('connection', (socket) => {
  console.log("✅ Socket connected id is " + socket.id);

  socket.on('join', (documentId) => {
    socket.join(documentId);
    console.log(socket.id + " joined room " + documentId);
  });

  socket.on('disconnect', () => {
    console.log("❌ Socket disconnected id is " + socket.id);
  });
});

// Server ko listen/start kar rahe hai specific port pe
app.listen(port , '0.0.0.0' , function(){
    console.log('server started'); // Server start hone ke baad ye message show hoga
});
