This is a [Next.js](https://nextjs.org/) [Lokalise](https://lokalise.com) Oauth2 flow demo project bootstrapped with [`create-next-app`](https://github.com/vercel/next.js/tree/canary/packages/create-next-app).

[Nextjs Lokalise Oauth2 flow demo example](https://nextjs-lokalise-oauth2-flow-demo.vercel.app/)


## Prerequisites

You need to have `client_id` and `client_secret` by registering your app with Lokalise, you should contact our support team. For more details refer [here](https://docs.lokalise.com/en/articles/5574713-oauth-2#h_8d9d4e1024). Create `env.local` file and add `client_id`, `client_secret` and callback url(example: http://localhost:3001/callback) as shown below.
```
LOKALISE_APP_CLIENT_ID=<YOUR_APP_CLIENT_ID>
LOKALISE_APP_CLIENT_SECRET=<YOUR_APP_SECRET_ID>
LOKALISE_APP_CALLBACK_URL=<YOUR_CALLBACK_URL>
```


## Getting Started

First, run the development server:

```bash
npm run dev
# or
yarn dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

You can start editing the page by modifying `pages/index.js`. The page auto-updates as you edit the file.

[API routes](https://nextjs.org/docs/api-routes/introduction) can be accessed on [http://localhost:3000/api/hello](http://localhost:3000/api/hello). This endpoint can be edited in `pages/api/hello.js`.

The `pages/api` directory is mapped to `/api/*`. Files in this directory are treated as [API routes](https://nextjs.org/docs/api-routes/introduction) instead of React pages.

## Learn More

To learn more about Next.js, take a look at the following resources:

- [Lokalise Oauth2](https://docs.lokalise.com/en/articles/5574713-oauth-2) - Loaklise Oauth2 flow.
- [Next.js Documentation](https://nextjs.org/docs) - learn about Next.js features and API.
- [Learn Next.js](https://nextjs.org/learn) - an interactive Next.js tutorial.

## Deploy on Vercel

The easiest way to deploy your Next.js app is to use the [Vercel Platform](https://vercel.com/new?utm_medium=default-template&filter=next.js&utm_source=create-next-app&utm_campaign=create-next-app-readme) from the creators of Next.js.

Check out our [Next.js deployment documentation](https://nextjs.org/docs/deployment) for more details.
