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
    
    if(payload.event === 'project.translations.updated') {
      console.log(`Project name: #{payload.project.name`)
      console.log(`User name: #{payload.user.full_name`)

      payload.translations.forEach((translation) => {
        console.log(`Translation ID: #{translation.id`)
        console.log(`Translation value: #{translation.value`)
        console.log(`Language: #{translation.language.name`)
        console.log(`Key: #{translation.key.name`)
      }
    }

    res.sendStatus(200)
  }
}
