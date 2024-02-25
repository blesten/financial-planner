import { Response } from 'express'
import { IReqUser } from './../utils/interface'
import Transaction from './../models/Transaction'
import Card from '../models/Card'
import mongoose from 'mongoose'

const transactionController = {
  create: async(req: IReqUser, res: Response) => {
    const {
      cardId,
      transactionCategory,
      amount,
      expenseCategory
    } = req.body

    if (!cardId || !transactionCategory || !amount)
      return res.status(400).json({ msg: 'Please provide required field.' })

    if (transactionCategory !== 'income' && transactionCategory !== 'investment' && transactionCategory !== 'saving' && transactionCategory !== 'expense')
      return res.status(400).json({ msg: 'Please provide valid transaction category.' })

    if (transactionCategory === 'expense' && !expenseCategory)
      return res.status(400).json({ msg: 'Please provide expense category' })

    if (transactionCategory === 'expense' && (expenseCategory !== 'food' && expenseCategory !== 'snack' && expenseCategory !== 'selfReward' && expenseCategory !== 'monthlyNeeds' && expenseCategory !== 'transportation'))
      return res.status(400).json({ msg: 'Please provide valid expense category' })

    try {
      const card = await Card.findById(cardId)
      if (!card)
        return res.status(404).json({ msg: 'Card not found' })

      const transaction = new Transaction({
        user: req.user?._id,
        card: cardId,
        transactionCategory,
        amount,
        expenseCategory: transactionCategory === 'expense' ? expenseCategory : ''
      })
      await transaction.save()

      return res.status(201).json({
        msg: 'Transaction has been saved successfully',
        transaction
      })
    } catch (error: any) {
      return res.status(500).json({ msg: error.message })
    }
  },
  read: async(req: IReqUser, res: Response) => {
    const { id } = req.params
    const currentDate = new Date();
    const firstDayOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);
    const lastDayOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0);

    try {
      const transactions = await Transaction.find({ user: req.user?._id, card: id, createdAt: { $gte: firstDayOfMonth, $lte: lastDayOfMonth } }).sort({ createdAt: -1 })

      if (transactions.length === 0)
        return res.status(204).json({ msg: 'Transactions is empty.' })

      return res.status(200).json({ transactions })
    } catch (error: any) {
      return res.status(500).json({ msg: error.message })
    }
  },
  readRecent: async(req: IReqUser, res: Response) => {
    const { id } = req.params
    const currentDate = new Date();
    const firstDayOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);
    const lastDayOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0);

    try {
      const transactions = await Transaction.find({ user: req.user?._id, card: id, createdAt: { $gte: firstDayOfMonth, $lte: lastDayOfMonth } }).sort({ createdAt: -1 }).limit(5)

      return res.status(200).json({ transactions })
    } catch (error: any) {
      return res.status(500).json({ msg: error.message })
    }
  },
  summarize: async(req: IReqUser, res: Response) => {
    const { id } = req.params
    const currentDate = new Date();
    const firstDayOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);
    const lastDayOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0);

    try {
      const incomeAggregation = await Transaction.aggregate([
        {
          $match: {
            user: new mongoose.Types.ObjectId(req.user?._id),
            card: new mongoose.Types.ObjectId(id),
            transactionCategory: 'income',
            createdAt: {
              $gte: firstDayOfMonth,
              $lte: lastDayOfMonth
            }
          }
        },
        {
          $group: {
            _id: null,
            totalAmount: { $sum: '$amount' }
          }
        }
      ])

      const investmentAggregation = await Transaction.aggregate([
        {
          $match: {
            user: new mongoose.Types.ObjectId(req.user?._id),
            card: new mongoose.Types.ObjectId(id),
            transactionCategory: 'investment',
            createdAt: {
              $gte: firstDayOfMonth,
              $lte: lastDayOfMonth
            }
          }
        },
        {
          $group: {
            _id: null,
            totalAmount: { $sum: '$amount' }
          }
        }
      ])

      const savingAggregation = await Transaction.aggregate([
        {
          $match: {
            user: new mongoose.Types.ObjectId(req.user?._id),
            card: new mongoose.Types.ObjectId(id),
            transactionCategory: 'saving',
            createdAt: {
              $gte: firstDayOfMonth,
              $lte: lastDayOfMonth
            }
          }
        },
        {
          $group: {
            _id: null,
            totalAmount: { $sum: '$amount' }
          }
        }
      ])

      const expenseAggregation = await Transaction.aggregate([
        {
          $match: {
            user: new mongoose.Types.ObjectId(req.user?._id),
            card: new mongoose.Types.ObjectId(id),
            transactionCategory: 'expense',
            createdAt: {
              $gte: firstDayOfMonth,
              $lte: lastDayOfMonth
            }
          }
        },
        {
          $group: {
            _id: null,
            totalAmount: { $sum: '$amount' }
          }
        }
      ])

      const foodAggregation = await Transaction.aggregate([
        {
          $match: {
            user: new mongoose.Types.ObjectId(req.user?._id),
            card: new mongoose.Types.ObjectId(id),
            transactionCategory: 'expense',
            expenseCategory: 'food',
            createdAt: {
              $gte: firstDayOfMonth,
              $lte: lastDayOfMonth
            }
          }
        },
        {
          $group: {
            _id: null,
            totalAmount: { $sum: '$amount' }
          }
        }
      ])

      const snackAggregation = await Transaction.aggregate([
        {
          $match: {
            user: new mongoose.Types.ObjectId(req.user?._id),
            card: new mongoose.Types.ObjectId(id),
            transactionCategory: 'expense',
            expenseCategory: 'snack',
            createdAt: {
              $gte: firstDayOfMonth,
              $lte: lastDayOfMonth
            }
          }
        },
        {
          $group: {
            _id: null,
            totalAmount: { $sum: '$amount' }
          }
        }
      ])

      const selfRewardAggregation = await Transaction.aggregate([
        {
          $match: {
            user: new mongoose.Types.ObjectId(req.user?._id),
            card: new mongoose.Types.ObjectId(id),
            transactionCategory: 'expense',
            expenseCategory: 'selfReward',
            createdAt: {
              $gte: firstDayOfMonth,
              $lte: lastDayOfMonth
            }
          }
        },
        {
          $group: {
            _id: null,
            totalAmount: { $sum: '$amount' }
          }
        }
      ])

      const monthlyNeedsAggregation = await Transaction.aggregate([
        {
          $match: {
            user: new mongoose.Types.ObjectId(req.user?._id),
            card: new mongoose.Types.ObjectId(id),
            transactionCategory: 'expense',
            expenseCategory: 'monthlyNeeds',
            createdAt: {
              $gte: firstDayOfMonth,
              $lte: lastDayOfMonth
            }
          }
        },
        {
          $group: {
            _id: null,
            totalAmount: { $sum: '$amount' }
          }
        }
      ])

      const transportationAggregation = await Transaction.aggregate([
        {
          $match: {
            user: new mongoose.Types.ObjectId(req.user?._id),
            card: new mongoose.Types.ObjectId(id),
            transactionCategory: 'expense',
            expenseCategory: 'transportation',
            createdAt: {
              $gte: firstDayOfMonth,
              $lte: lastDayOfMonth
            }
          }
        },
        {
          $group: {
            _id: null,
            totalAmount: { $sum: '$amount' }
          }
        }
      ])

      const income = incomeAggregation.length > 0 ? incomeAggregation[0].totalAmount : 0
      const investment = investmentAggregation.length > 0 ? investmentAggregation[0].totalAmount : 0
      const saving = savingAggregation.length > 0 ? savingAggregation[0].totalAmount : 0
      const expense = expenseAggregation.length > 0 ? expenseAggregation[0].totalAmount : 0

      const food = foodAggregation.length > 0 ? foodAggregation[0].totalAmount : 0
      const snack = snackAggregation.length > 0 ? snackAggregation[0].totalAmount : 0
      const selfReward = selfRewardAggregation.length > 0 ? selfRewardAggregation[0].totalAmount : 0
      const monthlyNeeds = monthlyNeedsAggregation.length > 0 ? monthlyNeedsAggregation[0].totalAmount : 0
      const transportation = transportationAggregation.length > 0 ? transportationAggregation[0].totalAmount : 0
      
      return res.status(200).json({
        income,
        investment,
        saving,
        expense,
        food,
        snack,
        selfReward,
        monthlyNeeds,
        transportation,
      })
    } catch (error: any) {
      return res.status(500).json({ msg: error.message })
    }
  }
}

export default transactionController