import express from "express"

import { StaticPagesController } from "../controllers/staticPagesController.js"
import { WebhooksController } from "../controllers/webhooksController.js"
import { NotificationsController } from "../controllers/notificationsController.js"

export const router = express.Router()

router.get('/', (req, res) => {
  StaticPagesController.index(req, res)
})

router.post('/webhooks', (req, res) => {
  WebhooksController.create(req, res)
})

router.post('/notify', (req, res) => {
  NotificationsController.create(req, res)
})