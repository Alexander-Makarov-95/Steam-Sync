const sqlite3 = require('sqlite3').verbose();

// open the database
let db = new sqlite3.Database('D:\\automatehdmi\\db\\gamesListDatabase.sqlite');

// run the delete query to wipe all data from the table
db.run('DELETE FROM Games', function(err) {
    if (err) {
        return console.error(err.message);
    }
    console.log(`All records deleted`);
});

// close the database connection
db.close();