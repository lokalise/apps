import { ApplicationController } from "./application_controller.js"
import { LokaliseApi } from '@lokalise/node-api'

export class WebhooksController extends ApplicationController { 
  static async create(req, res) {
    const lokaliseApi = new LokaliseApi({ apiKey: process.env.LOKALISE_API_TOKEN})

    await lokaliseApi.webhooks().create(
      {url: process.env.NOTIFY_URL, events: ['project.key.added']},
      {project_id: req.body.project_id}
    );

    req.flash('data', {success: `Registered webhook for ${req.body.project_id} project ID`})
    res.redirect('/')
  }
}