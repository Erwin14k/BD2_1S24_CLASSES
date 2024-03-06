const express = require("express");

const router = express.Router();

const {newGame, updateGame,getGameById,deleteGame,allGames } =require('../controllers/game');


// Game entity CRUD->CREATE
router.post('/game/new-game',newGame);
// Game entity CRUD->UPDATE
router.post('/game/update-game/:id',updateGame);
// Game entity CRUD->DELETE
router.delete('/game/delete-game/:id',deleteGame);
// ALL GAMES ENDPOINT
router.get('/game/get-games',allGames);
// GAME ENTITY CRUD -> READ
router.get("/game/:id",getGameById);

module.exports=router;

