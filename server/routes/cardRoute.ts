import express from 'express'
import cardController from './../controllers/cardController'
import { isAuthenticated } from './../middlewares/auth'

const router = express.Router()

router.route('/')
  .post(isAuthenticated, cardController.create)
  .get(isAuthenticated, cardController.read)

router.route('/:id')
  .patch(isAuthenticated, cardController.update)
  .delete(isAuthenticated, cardController.delete)

export default router