import express from 'express'
import transactionController from './../controllers/transactionController'
import { isAuthenticated } from './../middlewares/auth'

const router = express.Router()

router.route('/').post(isAuthenticated, transactionController.create)

router.route('/card/:id').get(isAuthenticated, transactionController.read)

router.route('/recent/card/:id').get(isAuthenticated, transactionController.readRecent)
router.route('/summarize/card/:id').get(isAuthenticated, transactionController.summarize)

export default router