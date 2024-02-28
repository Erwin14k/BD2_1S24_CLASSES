import {db, Table} from './config.js';


// Crete or update doctors
const createUpdate= async(data={})=>{
  const params={
    TableName:Table,
    Item:data
  }

  try{
    await db.put(params).promise();
    return {success:true};

  }catch(error){
    return {success:false};
  }
}

// Read all doctors
const readAllDoctors = async()=>{
  const params={
    TableName:Table
  }

  try{
    const {Items=[]}=await db.scan(params).promise();
    return {success:true,data:Items};
  }catch(error){
    return {success:false, data:null};
  }
}

// Read doctor by ID
const getDoctorById = async (value,key='doctor_id')=>{
  const params={
    TableName:Table,
    Key:{
      [key]:parseInt(value)
    }
  }

  try{
    const {Item={}}= await db.get(params).promise();
    return {success:true,data:Item}
  }catch(error){
    return {success:false, data:null};
  }
}


// Delete a doctor by ID
const deleteDoctorById = async(value,key='doctor_id')=>{
  const params={
    TableName:Table,
    Key:{
      [key]:parseInt(value)
    }
  }
  try{
    await db.delete(params).promise();
    return {success:true};

  }catch(error){
    console.log(error);
    return {success:false};
  }
}


export {
  createUpdate,
  readAllDoctors,
  getDoctorById,
  deleteDoctorById
}