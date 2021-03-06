# Lokalise CLI DEMO

1. [https://github.com/lokalise/apps/tree/main/examples/lokalise-cli-demo](https://github.com/lokalise/apps/tree/main/examples/lokalise-cli-demo)
2. [Lokalise CLI demo project on Glitch](https://glitch.com/edit/#!/lokalise-cli-demo?path=README.md)

## Step 1: Install Lokalise CLI

Install Lokalise CLI by running the following command in the terminal. 

```shell
curl -sfL https://raw.githubusercontent.com/lokalise/lokalise-cli-2-go/master/install.sh | sh
```

## Step 2: Add environment variables 

Create a `.env` file in the project root and add `LOKALISE_API_TOKEN` and `LOKALISE_PROJECT_ID` environment variables. More details on [how to get Lokalise API token](https://docs.lokalise.com/en/articles/1929556-api-tokens) and [how to get the Lokalise project id](https://docs.lokalise.com/en/articles/1400460-projects#project-id).


## Step 3: Upload file to Lokalise project
Run the following command to upload the `locale/en.json` file to your Lokalise project.

```shell
npm run upload-files
```
Above npm command executes the following lokalise CLI command. 
```shell
lokalise2  --token process.env.LOKALISE_API_TOKEN  --project-id process.env.LOKALISE_PROJECT_ID   file upload  --file locale/en.json  --lang-iso en
```

You can also directly run the lokalise cli command on your terminal by replacing YOUR_LOKALISE_API_TOKEN and YOUR_LOKALISE_PROJECT_ID values.
```shell
lokalise2  --token YOUR_LOKALISE_API_TOKEN  --project-id YOUR_LOKALISE_PROJECT_ID   file upload  --file locale/en.json  --lang-iso en
```