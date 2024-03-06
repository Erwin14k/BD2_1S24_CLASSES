const { mongoConfig} =require("../config/config");

const mongoose= require('mongoose');

const MONGO_URI =mongoConfig.ATLAS_URI;


const mongoDBConnection = async ()=>{
  try{
    await mongoose.connect(MONGO_URI,{
      useNewUrlParser:true,
      useUnifiedTopology:true,
    });
    console.log('Mongo DB connected successfully :)');
  }catch(error){
    console.error('Error connection Mongo :( ',error);
  }

}

module.exports= mongoDBConnection;
