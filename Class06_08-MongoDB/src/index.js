const express= require("express");
const app = express();
const {server} = require("./config/config");
const cors =require('cors');
const cookies =require('cookie-parser');

const mongoDB = require('./db/mongo');

const gamesRoutes = require('./routes/games');
const invalidRoutes = require('./routes/404');

 
// Middlewares

app.use(cors({
  origin:true,
  credentials:true
}));

app.use(cookies());

app.use(express.json());

app.use(gamesRoutes);
app.use(invalidRoutes);


mongoDB();

app.listen(server.port,()=>{
  console.log("Server running on port: "+server.port );
})