import express from 'express'
import userController from '../controllers/userController'
import { isAuthenticated } from '../middlewares/auth'

const router = express.Router()

router.route('/checkHandphoneNo/:handphoneNo').get(userController.checkHandphoneAvailability)
router.route('/verifyOtp').get(userController.verifyOTP)
router.route('/register').post(userController.register)
router.route('/login').post(userController.login)
router.route('/checkLoginPhone/:handphoneNo').get(userController.checkLoginPhone)
router.route('/profile').patch(isAuthenticated, userController.updateProfile)
router.route('/pin').patch(isAuthenticated, userController.changePIN)

export default router