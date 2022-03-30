
const { LokaliseApi } = require('@lokalise/node-api');
require('dotenv').config();


const { LOKALISE_API_TOKEN } = process.env;
const lokaliseApi = new LokaliseApi({ apiKey: LOKALISE_API_TOKEN});
const lokaliseProjectId = '<YOUR_PROjECT_ID>'; // replace <YOUR_PROjECT_ID> with yout Lokalise Project id -> https://docs.lokalise.com/en/articles/1400460-projects#project-id


const englishI18nFile = require('./translations/en.json');
const filename = 'en.json';
const lang_iso = 'en';
(async function () {
    try {
        const data_base64 = Buffer.from(JSON.stringify(englishI18nFile)).toString("base64");
        process = await lokaliseApi.files().upload(lokaliseProjectId,
            { data: data_base64, filename, lang_iso }
        );
        console.log('upload process --->', process.status);
    } catch (error) {
        console.log('ERROR --->', error);
    }
})();