import express from 'express'
import notificationController from './../controllers/notificationController'
import { isAuthenticated } from './../middlewares/auth'

const router = express.Router()

router.route('/').get(isAuthenticated, notificationController.read)
router.route('/:id').patch(isAuthenticated, notificationController.updateReadStatus)

export default router