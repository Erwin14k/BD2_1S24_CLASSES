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


/*
$lt= Selecciona documentos donde el valor del campo es menor al especificado
$gt= Selecciona documentos donde el valor del campo es mayor al especificado  (Greather than)
$avg = Calcula el promedio de un campo específico en los documentos
$match= Busca coincidencias de propiedades
$regex= Busca coincidencias de texto en base a un parámetro
$and= Evalúa varias expresiones, y funciona o es verdadero si todas se cumplan




*/

// Get games by genre
module.exports.getGamesByGenre= async(req,res,next)=>{
  const genre= req.params.genre; // Genre param
  try{
    const games= await Game.find({genre:genre});
    // return games with specified genre
    res.status(200).json(games);

  }catch(error){
    res.status(500).json({
      error:error.message
    });
  }
}
// Games by limit price (less than)
module.exports.gamesWithPriceLessThan= async(req,res,next)=>{
  const priceLimit= req.params.price; // Price limit param
  try{
    const games= await Game.find({
      price:{$lt: priceLimit}
    });
    res.status(200).json(games);
  }catch(error){
    res.status(500).json({
      error:error.message
    });
  }
}

// Games by price range
module.exports.gamesByPriceRance= async (req,res,next)=>{

  const minPrice= req.params.minPrice; // Minimum price param
  const maxPrice=req.params.maxPrice; // Maximim price param

  try{
    const games= await Game.find({
      price:{
        $gt: minPrice,
        $lt: maxPrice
      }
    })

    res.status(200).json(games);
  }catch(error){
    res.status(500).json({
      error:error.message
    });
  }
}


// Games sorted by genre
module.exports.getGamesSortedByGenre = async (req,res,next)=>{
  try{
    const games = await Game.find().sort({
      genre:-1
    })
    res.status(200).json(games);
  }catch(error){
    res.status(500).json({
      error:error.message
    });
  }
}

// Get price average of all games
module.exports.getPriceAverageOfAllGames=async(req,res,next)=>{
  try{
    const priceAverage= await Game.aggregate([
      {
        $group:{
          _id:null,
          priceAverage: {$avg: "$price"}
        }
      }
    ]);

    if (priceAverage.length===0){
      // No games
      res.status(404).json({
        error: "No games found"
      });
    }
    res.status(200).json({
      priceAverage: priceAverage[0].priceAverage
    });
  }catch(error){
    res.status(500).json({
      error: error.message
    });
  }
}


// Get price average of all games by genre
module.exports.getPriceAverageByGenre=async(req,res,next)=>{
  const genre= req.params.genre; // Genre param
  try{
    const priceAverage= await Game.aggregate([
      {
        $match:{
          genre:genre
        }
      },
      {
        $group:{
          _id:null,
          priceAverage: {$avg: "$price"}
        }
      }
    ]);

    if (priceAverage.length===0){
      // No games
      res.status(404).json({
        error: "No games found"
      });
    }
    res.status(200).json({
      priceAverage: priceAverage[0].priceAverage
    });
  }catch(error){
    res.status(500).json({
      error: error.message
    });
  }
}

// Get games by partial title match controoler
module.exports.getGamesByPartialTitle = async (req,res,next)=>{
  const partialTitle=req.params.partialTitle; // Partial title param
  const games= await Game.find({
    title:{
      $regex:partialTitle,
      $options:"i"
    }
  })
  res.status(200).json(games);
  try{

  }catch(error){
    res.status(500).json({
      error:error.message
    });
  }
}

// Multiple conditions ( AND 1. Genre 2. Price limit)
module.exports.getGamesByMultipleConditions= async(req,res,next)=>{
  const {genre, price}= req.params;
  var conditions=[];

  conditions.push( {
    genre:genre
  });

  conditions.push({
    price:{$lt: price}
  })

  const games= await Game.find({
    $and:conditions
  });

  res.status(200).json(games);


}