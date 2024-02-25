import mongoose from 'mongoose'
import { ITransaction } from '../utils/interface'

const transactionSchema = new mongoose.Schema<ITransaction>({
  user: {
    type: mongoose.Types.ObjectId,
    ref: 'user'
  },
  card: {
    type: mongoose.Types.ObjectId,
    ref: 'card'
  },
  transactionCategory: {
    type: String,
    required: true,
    enum: ['income', 'investment', 'saving', 'expense']
  },
  amount: {
    type: Number,
    required: true
  },
  expenseCategory: {
    type: String,
    default: '',
    enum: ['food', 'snack', 'selfReward', 'monthlyNeeds', 'transportation', '']
  }
}, {
  timestamps: true
})

export default mongoose.model<ITransaction>('transaction', transactionSchema)