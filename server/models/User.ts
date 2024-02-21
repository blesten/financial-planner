import mongoose from 'mongoose'

const userSchema = new mongoose.Schema({
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
  password: {
    type: String,
    default: ''
  },
  pin: {
    type: String,
    required: true
  }
}, {
  timestamps: true
})

export default mongoose.model('user', userSchema)