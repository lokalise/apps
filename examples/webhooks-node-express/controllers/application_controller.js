import { LokaliseApi } from '@lokalise/node-api'

export class ApplicationController {
  static renderView(req, res, view, data = {}) {
    data.flash_messages = req.flash('data')
    res.render(view, data)
  }
  
  static lokaliseApi() {
    return new LokaliseApi({ apiKey: "c5e1d865f52abe6d1660c5441a0da83006759c9d"})
  }
}