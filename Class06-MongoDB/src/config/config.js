const dotenv = require("dotenv");
dotenv.config();

module.exports={
  server:{
    port:process.env.PORT,
  },
  mongoConfig:{
    ATLAS_URI: process.env.DB_URI,
  }
}