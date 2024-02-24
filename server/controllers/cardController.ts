import { Response } from 'express'
import { IReqUser } from '../utils/interface'
import Card from './../models/Card'
import Transaction from '../models/Transaction'

const cardController = {
  create: async(req: IReqUser, res: Response) => {
    const {
      title,
      name,
      no,
      type,
      contactless,
      expDate,
      color
    } = req.body

    if (!title || !name || !no || !type || !expDate || !color)
      return res.status(400).json({ msg: 'Please provide required field to create new card.' })

    if (type !== 'mastercard' && type !== 'visa')
      return res.status(400).json({ msg: 'Please provide valid card type.' })

    if (color !== 'red' && color !== 'blue' && color !== 'orange' && color !== 'green' && color !== 'purple')
      return res.status(400).json({ msg: 'Please provid valid card color' })

    try {
      const userCard = await Card.countDocuments({ user: req.user?._id })
      if (userCard == 3)
        return res.status(400).json({ msg: 'User card has reached limit.' })

      const findCardNo = await Card.findOne({ user: req.user?._id, no })
      if (findCardNo)
        return res.status(400).json({ msg: 'Card no has been used before.' })

      const card = new Card({
        user: req.user?._id,
        title,
        name,
        no,
        type,
        contactless,
        expDate,
        color
      })
      await card.save()

      return res.status(201).json({
        msg: 'New card has been created successfully',
        card
      })
    } catch (error: any) {
      return res.status(500).json({ msg: error.message })
    }
  },
  read: async(req: IReqUser, res: Response) => {
    try {
      const cards = await Card.find({ user: req.user?._id }).sort({ createdAt: -1 })
      
      if (cards.length < 1)
        return res.status(204).json({ msg: 'No cards found.' })

      return res.status(200).json({ cards })
    } catch (error: any) {
      return res.status(500).json({ msg: error.message })
    }
  },
  update: async(req: IReqUser, res: Response) => {
    const { id } = req.params

    const {
      title,
      name,
      no,
      type,
      contactless,
      expDate,
      color
    } = req.body

    if (!title || !name || !no || !type || !expDate || !color)
      return res.status(400).json({ msg: 'Please provide required field to create new card.' })

    if (type !== 'mastercard' && type !== 'visa')
      return res.status(400).json({ msg: 'Please provide valid card type.' })

    if (color !== 'red' && color !== 'blue' && color !== 'orange' && color !== 'green' && color !== 'purple')
      return res.status(400).json({ msg: 'Please provide valid card color' })
    
    try {
      const card = await Card.findById(id)
      if (!card)
        return res.status(404).json({ msg: 'Card not found.' })

      const findCardNo = await Card.findOne({ user: req.user?._id, no, _id: { $ne: id } })
      if (findCardNo)
        return res.status(400).json({ msg: 'Card no has been used before.' })

      await Card.findByIdAndUpdate(id, {
        title,
        name,
        no,
        type,
        contactless,
        expDate,
        color
      })

      return res.status(200).json({
        msg: 'Card has been updated successfully',
        card: {
          ...card,
          title,
          name,
          no,
          type,
          contactless,
          expDate,
          color
        }
      })
    } catch (error: any) {
      return res.status(500).json({ msg: error.message })
    }
  },
  delete: async(req: IReqUser, res: Response) => {
    const { id } = req.params

    try {
      const card = await Card.findById(id)
      if (!card)
        return res.status(404).json({ msg: 'Card not found.' })

      await Card.findByIdAndDelete(id)

      await Transaction.deleteMany({ card: id })
    
      return res.status(200).json({ msg: 'Card has been deleted successfully.' })
    } catch (error: any) {
      return res.status(500).json({ msg: error.message })
    }
  }
}

export default cardController