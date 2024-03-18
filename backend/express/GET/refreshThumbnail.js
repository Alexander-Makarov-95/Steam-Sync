async function updateGameImage(gameId) {
    const { PrismaClient } = require('@prisma/client');
    const prisma = new PrismaClient();
    const { getRandomImage } = require("../../rest/getImages");
    try {
        // Find game by game_id
        const game = await prisma.games.findUnique({
            where: {
                game_id: gameId,
            },
        });

        // Call getRandomImage function to get a new image URL
        const newImageUrl = await getRandomImage(gameId);

        // Update image_url column in db
        const updatedGame = await prisma.games.update({
            where: {
                game_id: gameId,
            },
            data: {
                image_url: newImageUrl,
            },
        });

        console.log(`Game ${updatedGame.game_id} image URL updated to ${updatedGame.image_url}`);
    } catch (err) {
        console.error(err);
    } finally {
        await prisma.$disconnect();
    }
}

updateGameImage(1517290)