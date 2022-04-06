var shell = require('shelljs');
require("dotenv").config();

console.log('START uploading ----->');
shell.exec(`lokalise2  --token ${process.env.LOKALISE_API_TOKEN}  --project-id ${process.env.LOKALISE_PROJECT_ID}   file upload  --file locale/en.json  --lang-iso en`);
console.log('END ----->');
