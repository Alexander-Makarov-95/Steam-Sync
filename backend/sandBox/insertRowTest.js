// // const { PrismaClient } = require("@prisma/client");
// //
// // const prisma = new PrismaClient();
// //
// // async function main() {
// //     const gameIds = [1, 2, 3, 4]; // replace with the array of game IDs to check
// //
// //     // Find the games that exist in the database
// //     const existingGames = await prisma.game.findMany({
// //         where: { id: { in: gameIds } },
// //         select: { id: true },
// //     });
// //
// //     // Log the existing game IDs
// //     const existingGameIds = existingGames.map((game) => game.id);
// //     console.log("Existing game IDs:", existingGameIds);
// //
// //     // Log the missing game IDs
// //     const missingGameIds = gameIds.filter((id) => !existingGameIds.includes(id));
// //     console.log("Missing game IDs:", missingGameIds);
// //
// //     // Add the missing games to the database
// //     if (missingGameIds.length > 0) {
// //         const newGames = missingGameIds.map((id) => ({
// //             id,
// //             image_url: "https://example.com/game-image.jpg", // replace with the actual URL
// //         }));
// //
// //         await prisma.game.createMany({ data: newGames });
// //     }
// //
// //     // Disconnect the Prisma client
// //     await prisma.$disconnect();
// // }
// //
// // main().catch((e) => {
// //     console.error(e);
// //     process.exit(1);
// // });
//
//
//
//
//
//
//
//
//
//
//
//
// const sqlite3 = require('sqlite3').verbose();
//
// // open the database connection
// const db = new sqlite3.Database('D:\\automatehdmi\\db\\gamesListDatabase.sqlite');
//
// // define the new row to be inserted
// const newGame = {
//     game_id: '21,
//     name: 'Half Life 2',
//     image_url: 'https://cdn2.steamgriddb.com/file/sgdb-cdn/grid/c93d35706ee684295c04dbfa3171eb3c.png'
// };
//
// // insert the new row into the games table
// db.run('INSERT INTO games (game_id, name, image_url) VALUES (?, ?, ?)',
//     [newGame.game_id, newGame.name, newGame.image_url],
//     function(err) {
//         if (err) {
//             throw err;
//         }
//         console.log(`New game inserted with ID ${this.lastID}`);
//     });
//
// // close the database connection
// db.close();