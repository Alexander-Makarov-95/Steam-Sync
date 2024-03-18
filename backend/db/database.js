const sqlite3 = require('sqlite3').verbose();

const db = new sqlite3.Database('./gamesListDatabase.sqlite', (err) => {
    if (err) {
        console.error(err.message);
    }
    console.log('Connected to the Games List database.');
});

db.run('CREATE TABLE IF NOT EXISTS games (game_id TEXT PRIMARY KEY, name TEXT, image_url TEXT)');