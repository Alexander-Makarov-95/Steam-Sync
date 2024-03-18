function getNameById(gameId) {
    const axios = require('axios');
    return new Promise((resolve, reject) => {
        // Use the environment variable for the Steam API key
        const STEAM_API_KEY = process.env.STEAM_API_KEY;

        // Ensure the API key is available
        if (!STEAM_API_KEY) {
            console.error('Steam API key is not set in environment variables');
            reject('Steam API key is not set in environment variables');
            return;
        }

        const url = `https://store.steampowered.com/api/appdetails/?appids=${gameId}&key=${STEAM_API_KEY}`;

        axios.get(url)
            .then(response => {
                const gameName = response.data[gameId].data.name;
                resolve(gameName);
            })
            .catch(error => {
                console.error(`${error} for ID ${gameId}`);
                reject(error);
            });
    });
}

module.exports = { getNameById };
