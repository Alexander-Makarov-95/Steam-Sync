const { PrismaClient } = require("@prisma/client");
const { getRandomImage } = require("../../rest/getImages");
const { getInstalledGames } = require("../../src/installedGames");
const installedGamesArray = getInstalledGames();
const { getNameById } = require("../../rest/getName.js");
const prisma = new PrismaClient();
const gameIds = installedGamesArray.map((str) => parseInt(str, 10));

async function checkGameIds() {
    const existingGameIds = await prisma.games.findMany({
        where: {
            game_id: { in: gameIds },
        },
        select: {
            game_id: true,
        },
    });

    const existingIds = existingGameIds.map((game) => game.game_id);
    const nonExistingIds = gameIds.filter((id) => !existingIds.includes(id));

    if (nonExistingIds.length > 0) {
        const promises = nonExistingIds.map((id) => {
            return Promise.all([getNameById(id), getRandomImage(id)]);
        });
        await Promise.all(promises)
            .then(async (results) => {
                let newGames = results.map(([name, imageUrl], index) => ({
                    game_id: nonExistingIds[index],
                    name,
                    image_url: imageUrl,
                }));
                try {
                    for (const newGame of newGames) {
                        console.log(newGame);
                        await prisma.games.create({ data: newGame });
                    }
                } catch (error) {
                    console.error(error);
                }
            })
            .catch((error) => {
                console.log(error);
            });
    } else console.log("There are no new game ID's to add.");
}

checkGameIds()
    .catch((e) => console.error(e))
    .finally(async () => {
        await prisma.$disconnect();
    });
