import { Request, Response } from 'express'
import { isValidHandphoneNo } from '../utils/validator'
import { sendVerificationCode, verifyVerificationCode } from '../utils/verification'
import bcrypt from 'bcrypt'
import User from '../models/User'

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

      console.log(handphoneNo, pin)
  
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
  }
}

export default userController