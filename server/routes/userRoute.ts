import express from 'express'
import userController from '../controllers/userController'

const router = express.Router()

router.route('/checkHandphoneNo/:handphoneNo').get(userController.checkHandphoneAvailability)
router.route('/verifyOtp').get(userController.verifyOTP)
router.route('/register').post(userController.register)
router.route('/login').post(userController.login)

export default router