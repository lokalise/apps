const { LokaliseApi } = require("@lokalise/node-api");
require("dotenv").config();
const {
  LOKALISE_API_TOKEN,
  LOKALISE_PROJECT_ID
} = process.env;
const lokaliseApi = new LokaliseApi({
  apiKey: LOKALISE_API_TOKEN
});

const fs = require('fs');
const path = require('path');
const AdmZip = require("adm-zip");
const got = require('got');

async function download(translationsUrl, archive) {
  try {
    const response = await got.get(translationsUrl).buffer();
    fs.writeFileSync(archive, response);
  } catch (error) {
    console.log(error);
  }
}

(async function () {
  try {
    const i18nFolder = path.resolve(__dirname, 'translations')

    const downloadResponse = await lokaliseApi.files().download(LOKALISE_PROJECT_ID, {
      format: "json",
      original_filenames: true,
      directory_prefix: '',
      filter_langs: ['en'],
      indentation: '2sp',
    })

    const translationsUrl = downloadResponse.bundle_url
    const archive = path.resolve(i18nFolder, 'archive.zip')

    await download(translationsUrl, archive)

    const zip = new AdmZip(archive)
    zip.extractAllTo(i18nFolder, true)
  
    fs.unlink(archive, (err) => {
      if (err) throw err
    })
  } catch (error) {
    console.log("ERROR --->", error);
  }
})();