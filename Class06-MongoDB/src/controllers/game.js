const Game = require('../models/game');
const mongoose = require('mongoose');


// New game controller
module.exports.newGame =async (req,res,next)=>{
  try{
    // Creation of the new game entity
    const newGame = new Game(req.body);
    // Persist
    const savedGame= await newGame.save();
    // return a 201 status
    res.status(201).json(savedGame);

  }catch(error){
    res.status(400).json({ error:error.message});
  }
}

// Update a game controller
module.exports.updateGame =async (req,res,next)=>{
  const gameId=req.params.id;

  try{
    // Verify if the game exists
    const updatedGame= await Game.findByIdAndUpdate(gameId,req.body,{new:true});
    if(!updatedGame){
      return res.status(404).json({error:"Game not found"});
    }
    res.status(200).json(updatedGame);
  }catch(error){
    res.status(400).json({ error:error.message});
  }
}

// Delete a game controller
module.exports.deleteGame =async (req,res,next)=>{
  const gameId=req.params.id;

  try{
    // Verify if the game exists
    const deletedGame= await Game.findByIdAndDelete(gameId);
    if(!deletedGame){
      return res.status(404).json({error:"Game not found"});
    }
    res.status(200).json({
      status:200,
      message:"Game deleted successfully ✔"
    });
  }catch(error){
    res.status(400).json({ error:error.message});
  }
}

// Get Game by Id controller

module.exports.getGameById =async (req,res,next)=>{
  const gameId=req.params.id;

  try{
    // Verify if the game exists
    const game= await Game.findById(gameId);
    if(!game){
      return res.status(404).json({error:"Game not found"});
    }
    res.status(200).json(game);
  }catch(error){
    res.status(400).json({ error:error.message});
  }
}


// Get All games controller

module.exports.allGames =async (req,res,next)=>{
  try{
    // Verify if the game exists
    const games= await Game.find();
    console.log(games);
    res.status(200).json(games);
  }catch(error){
    res.status(400).json({ error:error.message});
  }
}