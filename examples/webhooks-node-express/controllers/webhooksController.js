import { ApplicationController } from "./application_controller.js"

export class WebhooksController extends ApplicationController { 
  static async create(req, res) {
    try {
      await this.lokaliseApi().webhooks().create(
        {url: process.env.NOTIFY_URL,
				events: ['project.key.added']},
        {project_id: req.body.project_id}
      )
    } catch(e) {
      console.error(e)
    }

    req.flash('data', {success: `Registered webhook for ${req.body.project_id} project ID`})
    res.redirect('/')
  }
}