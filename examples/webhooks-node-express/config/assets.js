import hbs from "hbs"
import path from "path"

const __dirname = path.resolve()

export function setupAssets(app) {
  app.set('view engine', 'hbs')
  hbs.registerPartials(path.join(__dirname, 'views/partials'))
}