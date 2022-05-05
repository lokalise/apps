import { ApplicationController } from "./application_controller.js"

export class StaticPagesController extends ApplicationController { 
  static index(req, res) {
    this.renderView(req, res, 'static_pages/index', {title: 'Register Lokalise webhook'})
  }
}