import { ApplicationController } from "./application_controller.js"

export class NotificationsController extends ApplicationController {
  static async create(req, res) {
    const payload = req.body
    if (Array.isArray(payload)) {
      if (payload[0] === "ping") {
        res.sendStatus(200)
        return
      } else {
        res.sendStatus(400)
        return
      }
    }

    if(payload.event === 'project.key.added') {
      await this.lokaliseApi().comments().create([
          { comment: "@Bob please review this new key" }
        ],
        { project_id: payload.project.id, key_id: payload.key.id }
      )

      await this.lokaliseApi().keys().update(payload.key.id, {
        "is_hidden": true
      }, { project_id: payload.project.id })
    }

    res.sendStatus(200)
  }
}