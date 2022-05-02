import { LokaliseAuth } from '@lokalise/node-api'
import cookie from "cookie";

// This gets called on every request
export async function getServerSideProps({ query, req, res}) {
  const authtoken = query.code || '';
  var cookies = cookie.parse(req.headers.cookie || '');

  if (!cookies['lokalise-api-token']) {
    console.log(`cookies['lokalise-api-token'] --->`, cookies['lokalise-api-token']);
    const lokaliseAuth = new LokaliseAuth(process.env.LOKALISE_APP_CLIENT_ID, process.env.LOKALISE_APP_CLIENT_SECRET);
    const { access_token } = await lokaliseAuth.token(authtoken);

    res.setHeader(
      "Set-Cookie",
      cookie.serialize("lokalise-api-token", access_token, {
        httpOnly: true,
        maxAge: 60 * 60,
        sameSite: "strict",
        path: "/",
      })
    );
  }

  res.writeHead(301, { Location: '/?authorized=true' });
  res.end();

  return { props: {}};
}

export default function Callback( ) {
  return (
    <div>
     {/* CALLBACK PAGE */}
    </div>
  )
}
