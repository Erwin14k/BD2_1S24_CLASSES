const express = require("express");

const router = express.Router();

const {newGame, updateGame,getGameById,deleteGame,allGames,
getGamesByGenre,gamesWithPriceLessThan,gamesByPriceRance,getGamesSortedByGenre,
getPriceAverageOfAllGames,getPriceAverageByGenre,getGamesByPartialTitle,
getGamesByMultipleConditions } =require('../controllers/game');


// Game entity CRUD->CREATE
router.post('/game/new-game',newGame);
// Game entity CRUD->UPDATE
router.post('/game/update-game/:id',updateGame);
// Game entity CRUD->DELETE
router.delete('/game/delete-game/:id',deleteGame);
// ALL GAMES ENDPOINT
router.get('/game/get-games',allGames);

// Games by genre
router.get("/game/games-by-genre/:genre",getGamesByGenre);
// Games by price limit (less than)
router.get("/game/games-price-less-than/:price",gamesWithPriceLessThan);
// Games by price range
router.get("/game/games-by-price-range/:minPrice/:maxPrice",gamesByPriceRance);
// Games sorted by genre
router.get("/game/games-sorted-by-genre",getGamesSortedByGenre);
// Price average of all games
router.get("/game/price-average",getPriceAverageOfAllGames);
// Price average by games
router.get("/game/price-average-by-genre/:genre",getPriceAverageByGenre);
// Games by partial title
router.get("/game/games-by-partial-title/:partialTitle",getGamesByPartialTitle);
// 1. Genre  2. Price lt
router.get("/game/multiple-conditions/:genre/:price",getGamesByMultipleConditions);
// GAME ENTITY CRUD -> READ
router.get("/game/:id",getGameById);
module.exports=router;

