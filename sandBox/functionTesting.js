const {getGamesData} = require("../express/GET/getGames");

async function main() {
    const gameDataArray = await getGamesData();
    console.log(gameDataArray);
}

main().catch((error) => {
    console.error(error);
});