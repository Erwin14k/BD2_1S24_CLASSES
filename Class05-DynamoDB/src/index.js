import express from 'express';
import bodyParser from 'body-parser';
import dotenv from 'dotenv';
import  doctor from  './controller.js'

dotenv.config();
// App init with express
const app=express();
// Json config
app.use(bodyParser.json());

app.get("/",(req,res)=>{
  res.json({"Hi":"We are working on backend"})
})

app.use('/api',doctor)

const PORT=3014;

app.listen(PORT,()=>{
  console.log('App running.....')
})




