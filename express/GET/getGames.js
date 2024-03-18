const { PrismaClient } = require('@prisma/client');
async function getGamesData() {
    const prisma = new PrismaClient();
    try {
        const gamesData = await prisma.games.findMany({
            select: {
                game_id: true,
                image_url: true,
                name: true,
            },
        });
        return gamesData;
    } catch (error) {
        console.error(error);
    } finally {
        await prisma.$disconnect();
    }
}

module.exports = { getGamesData };