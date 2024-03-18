function getInstalledGames() {

    const fs = require('fs');
    const {parse} = require('vdf-parser');
    require('jsonpath-plus');
    const {JSONPath} = require('jsonpath-plus');
    const valuesToRemove = ['228980'];

// Read the contents of the libraryfolders.vdf file
    const fileContents = fs.readFileSync('C:/Program Files (x86)/Steam/steamapps/libraryfolders.vdf', 'utf-8');

// Parse the file contents using the vdf-parser library
    const parsedData = parse(fileContents);

    const appsKeys = JSONPath({path: '$.libraryfolders..apps.*~', json: parsedData});

    for (let i = 0; i < valuesToRemove.length; i++) {
        const value = valuesToRemove[i];
        const index = appsKeys.indexOf(value);
        if (index !== -1) {
            appsKeys.splice(index, 1);
        }
    }

    console.log("The List count of currently installed steam games is: " + appsKeys.length + ": " + appsKeys);

    return appsKeys
}

module.exports = { getInstalledGames };