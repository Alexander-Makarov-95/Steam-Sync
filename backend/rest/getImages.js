function getRandomImage(steamAppId) {

    const axios = require('axios');
    const {JSONPath} = require('jsonpath-plus');
    const token = '033b97a583ea40ee8f7cd93134584947';
    let randomImageArt = "";

    return axios.get(`https://www.steamgriddb.com/api/v2/grids/steam/${steamAppId}?dimensions=600x900`, {
        headers: {
            Authorization: `Bearer ${token}`,
            Accept: 'application/json'
        }
    })
        .then(response => {
            const imageURLs = JSONPath({path: '$.data..url', json: response});
            const randomIndex = Math.floor(Math.random() * Object.keys(imageURLs).length);
            randomImageArt = imageURLs[randomIndex]
            //console.log("Random Image URL for game " + steamAppId + ": " + randomImageArt)
            return randomImageArt;
        })
        .catch(error => {
            console.log(error);
        });
}

module.exports = { getRandomImage };