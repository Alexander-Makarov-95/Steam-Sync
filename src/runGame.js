function runGame(gameId) {
    const { exec } = require('child_process');
    exec(`start steam://rungameid/${gameId}`, (error, stdout, stderr) => {
        if (error) {
            console.error(`exec error: ${error}`);
            return;
        }
        console.log(`stdout: ${stdout}`);
        console.error(`stderr: ${stderr}`);
    });
}

module.exports = { runGame };