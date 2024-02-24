import { Request, Response } from 'express'
import { isValidEmail, isValidHandphoneNo } from '../utils/validator'
import { sendVerificationCode, verifyVerificationCode } from '../utils/verification'
import bcrypt from 'bcrypt'
import jwt from 'jsonwebtoken'
import User from '../models/User'
import { IReqUser } from '../utils/interface'

const userController = {
  checkHandphoneAvailability: async(req: Request, res: Response) => {
    try {
      const { handphoneNo } = req.params
  
      if (!isValidHandphoneNo(`+62${handphoneNo}`))
        return res.status(400).json({ msg: 'Please provide valid phone no' })
  
      const checkHandphoneNo = await User.findOne({ handphoneNo: `+62${handphoneNo}` })
      if (checkHandphoneNo)
        return res.status(400).json({ msg: 'Handphone no has been used before' })
  
      await sendVerificationCode(`+62${handphoneNo}`)
      return res.status(200).json({ msg: `OTP has been sent to +62${handphoneNo}` })
    } catch (error: any) {
      return res.status(500).json({ msg: error.message })
    }
  },
  verifyOTP: async(req: Request, res: Response) => {
    try {
      const { handphoneNo, code } = req.query
  
      if (!isValidHandphoneNo(`+62${handphoneNo}`))
        return res.status(400).json({ msg: 'Please provide valid handphone no' })
  
      const checkHandphoneNo = await User.findOne({ handphoneNo })
      if (checkHandphoneNo)
        return res.status(400).json({ msg: 'Handphone no has been used before' })
  
      const response = await verifyVerificationCode(`+62${handphoneNo}`, code as string)
      if (!response.valid)
        return res.status(400).json({ msg: 'Verification code is incorrect' })
  
      return res.status(200).json({ msg: 'OTP is verified' })
    } catch (error: any) {
      return res.status(500).json({ msg: error.message })
    }
  },
  register: async(req: Request, res: Response) => {
    try {
      const { handphoneNo, pin } = req.body

      if (!isValidHandphoneNo(`+62${handphoneNo}`))
        return res.status(400).json({ msg: 'Please provide valid handphone no' })
  
      const checkHandphoneNo = await User.findOne({ handphoneNo })
      if (checkHandphoneNo)
        return res.status(400).json({ msg: 'Handphone no has been used before' })
  
      const hashedPin = await bcrypt.hash(pin, 12)
  
      const user = new User({
        handphoneNo: `+62${handphoneNo}`,
        pin: hashedPin
      })
      await user.save()
  
      return res.status(200).json({ msg: 'User has been registered sucecssfully' })
    } catch (error: any) {
      return res.status(500).json({ msg: error.message })
    }
  },
  login: async(req: Request, res: Response) => {
    try {
      const { handphoneNo, pin } = req.body

      const user = await User.findOne({ handphoneNo: `+62${handphoneNo}` })
      if (!user)
        return res.status(401).json({ msg: 'Invalid credential' })

      const isPwMatch = await bcrypt.compare(pin, user.pin)
      if (!isPwMatch)
        return res.status(401).json({ msg: 'Invalid credential' })

      const accessToken = jwt.sign({ id: user._id }, `${process.env.ACCESS_TOKEN_SECRET}`, { expiresIn: '21d' })

      return res.status(200).json({
        accessToken,
        user: {
          ...user._doc,
          pin: ''
        }
      })
    } catch (error: any) {
      return res.status(500).json({ msg: error.message })
    }
  },
  checkLoginPhone: async(req: Request, res: Response) => {
    try {
      const { handphoneNo } = req.params

      if (!isValidHandphoneNo(`+62${handphoneNo}`))
        return res.status(400).json({ msg: 'Please provide valid handphone no' })

      const user = await User.findOne({ handphoneNo: `+62${handphoneNo}` })
      if (!user)
        return res.status(401).json({ msg: 'Handphone number not registered' })

      return res.status(200).json({ msg: 'Handphone no is registered' })
    } catch (error: any) {
      return res.status(500).json({ msg: error.message })
    }
  },
  updateProfile: async(req: IReqUser, res: Response) => {
    const {
      name,
      email
    } = req.body

    if (email && !isValidEmail(email))
      return res.status(400).json({ msg: 'Please provide valid email address' })

    try {
      const findEmail = await User.findOne({ email, _id: { $ne: req.user?._id } })
      if (findEmail)
        return res.status(400).json({ msg: 'Email has been used before' })

      const user = await User.findById(req.user?._id)
      if (!user)
        return res.status(404).json({ msg: 'User not found.' })

      user.name = name
      user.email = email
      await user.save()

      return res.status(200).json({
        msg: 'Profile has been updated successfully.',
        user
      })
    } catch (error: any) {
      return res.status(500).json({ msg: error.message })
    }
  },
  changePIN: async(req: IReqUser, res: Response) => {
    const { currentPIN, newPIN } = req.body

    if (!currentPIN || !newPIN)
      return res.status(400).json({ msg: 'Please provide required field.' })

    if (currentPIN.length < 4 || currentPIN.length > 4 || newPIN.length < 4 || newPIN.length > 4)
      return res.status(400).json({ msg: 'PIN should be 4 digit number.' })

    try {
      const user = await User.findById(req.user?._id)
      if (!user)
        return res.status(404).json({ msg: 'User not found.' })

      const checkCurrentPIN = await bcrypt.compare(currentPIN, user.pin)
      if (!checkCurrentPIN)
        return res.status(400).json({ msg: 'Current PIN is incorrect.'})

      const newPinHash = await bcrypt.hash(newPIN, 12)

      user.pin = newPinHash
      await user.save()

      return res.status(200).json({ msg: 'PIN has been changed successfully' })
    } catch (error: any) {
      return res.status(500).json({ msg: error.message })
    }
  }
}

export default userController