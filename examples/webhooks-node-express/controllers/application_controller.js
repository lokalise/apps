import { LokaliseApi } from '@lokalise/node-api'

export class ApplicationController {
  static renderView(req, res, view, data = {}) {
    data.flash_messages = req.flash('data')
    res.render(view, data)
  }
  
  static lokaliseApi() {
    return new LokaliseApi({ apiKey: process.env.LOKALISE_API_TOKEN})
  }
}