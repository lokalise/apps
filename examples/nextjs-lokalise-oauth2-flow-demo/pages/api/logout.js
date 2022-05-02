import cookie from "cookie";

export default (req, res) => {
  res.setHeader(
    "Set-Cookie",
    cookie.serialize("lokalise-api-token", "", {
      httpOnly: true,
      expires: new Date(0),
      sameSite: "strict",
      path: "/",
    })
  );
  res.redirect(200, '/');
  res.end();
};