export class ApplicationController {
  static renderView(req, res, view, data = {}) {
    data.flash_messages = req.flash('data')
    res.render(view, data)
  }
}