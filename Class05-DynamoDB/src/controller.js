import express from 'express';
import {createUpdate,readAllDoctors,getDoctorById,deleteDoctorById} from './model.js';


const router =express.Router();

// Read all doctors controller

router.get('/doctors',async(req,res)=>{
  const {success,data}=await readAllDoctors();
  if(success){
    return res.json({success,data});
  }
  return res.status(500).json({success:false,message:"Error"});
})


// Get doctor by ID
router.get('/doctor/:doctor_id',async(req,res)=>{
  const {doctor_id}= req.params;
  const {success,data}= await getDoctorById(doctor_id);
  if (success){
    return res.json({success,data});
  }
  return res.status(500).json({success:false,message:"Error"});
})


// Create doctor controller
router.post('/doctor',async(req,res)=>{
  const { success,data}=await createUpdate(req.body);
  if(success){
    return res.json({success,data})
  }
  return res.status(500).json({success:false,message:"Error"})
})

// Update a doctor controller

router.put('/doctor/:doctor_id',async(req,res)=>{
  const doctor=req.body;
  const {doctor_id}=req.params;
  doctor.doctor_id=parseInt(doctor_id);

  const {success,data}=await createUpdate(doctor);

  if (success){
    return res.json({success,data});
  }
  return res.status(500).json({success:false,message:"Error"});
})

// Delete a doctor by ID
router.delete('/doctor/:doctor_id', async(req,res)=>{
  var {doctor_id}=req.params;
  const {success,data}= await deleteDoctorById(doctor_id);
  if(success){
    return res.json({success,data});
  }
  return res.status(500).json({success:false,message:"Error"})
})

export default router;