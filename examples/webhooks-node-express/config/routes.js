import express from "express"

import { StaticPagesController } from "../controllers/staticPagesController.js"
import { WebhooksController } from "../controllers/webhooksController.js"

export const router = express.Router()

router.get('/', (req, res) => {
  StaticPagesController.index(req, res)
})

router.post('/webhooks', (req, res) => {
  WebhooksController.create(req, res)
})