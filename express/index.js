const express = require('express');
const app = express();
const {getGamesData} = require("../express/GET/getGames");
const { runGame } = require('../src/runGame');

//http://localhost:3000/games
app.get('/games', async (req, res) => {
    try {
        const data = await getGamesData();
        res.send(data);
    } catch (error) {
        res.status(500).send('An error occurred');
    }
});

app.get('/runGame/:gameId', (req, res) => {
    const gameId = req.params.gameId;

    try {
        runGame(gameId);
        res.send(`Running game with ID ${gameId}`);
    } catch (error) {
        console.error(`Error running game: ${error}`);
        res.status(500).send('Error running game due to ' + error);
    }
});

//http://localhost:3000/
app.listen(3000, () => {
    console.log('Server listening on port 3000!');
});