import mongoose from 'mongoose'
import { IUser } from '../utils/interface'

const userSchema = new mongoose.Schema<IUser>({
  name: {
    type: String,
    default: '',
    trim: true
  },
  email: {
    type: String,
    default: '',
    trim: true,
    unique: true
  },
  handphoneNo: {
    type: String,
    required: true,
    unique: true
  },
  pin: {
    type: String,
    required: true
  }
}, {
  timestamps: true
})

export default mongoose.model<IUser>('user', userSchema)