import mongoose from 'mongoose'
import { ICard } from '../utils/interface'

const cardSchema = new mongoose.Schema<ICard>({
  user: {
    type: mongoose.Types.ObjectId,
    ref: 'user'
  },
  title: {
    type: String,
    required: true,
    trim: true
  },
  name: {
    type: String,
    required: true,
    trim: true
  },
  no: {
    type: String,
    required: true,
    trim: true
  },
  type: {
    type: String,
    required: true,
    enum: ['mastercard', 'visa']
  },
  contactless: {
    type: Boolean,
    required: true
  },
  expDate: {
    type: String,
    required: true,
    trim: true
  },
  color: {
    type: String,
    required: true,
    enum: ['red', 'blue', 'orange', 'green', 'purple']
  }
}, {
  timestamps: true
})

export default mongoose.model<ICard>('card', cardSchema)