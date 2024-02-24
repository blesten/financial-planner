import mongoose from 'mongoose'
import { INotification } from '../utils/interface'

const notificationSchema = new mongoose.Schema<INotification>({
  user: {
    type: mongoose.Types.ObjectId,
    ref: 'user'
  },
  title: {
    type: String,
    required: true,
    trim: true
  },
  description: {
    type: String,
    required: true,
    trim: true
  },
  isRead: {
    type: Boolean,
    default: false
  }
}, {
  timestamps: true
})

export default mongoose.model<INotification>('notification', notificationSchema)