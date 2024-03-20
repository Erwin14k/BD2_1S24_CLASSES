const mongoose = require('mongoose');


const gameSchema= new mongoose.Schema({
  title:String,
  genre:String,
  price:Number
},
{
  versionKey:false
});

module.exports=mongoose.model('Game',gameSchema,'Games')