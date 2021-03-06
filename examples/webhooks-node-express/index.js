import cookieSession from 'cookie-session'
import express from 'express'
import flash from 'connect-flash'
import { router } from "./config/routes.js"
import { setupAssets } from "./config/assets.js"

const app = express()
app.use(express.urlencoded({extended: true}))
app.use(express.json())
app.use(cookieSession({
  name: 'session',
  secret: 'my_super_secret',
  maxAge: 24 * 60 * 60 * 1000
}))

app.use(flash())
app.use('/', router)

const port = process.env.PORT || 3000
app.listen(port, () => {
  console.log(`Express web app on port ${port}`)
})

setupAssets(app)