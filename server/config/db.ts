import mongoose from 'mongoose'

const connectDB = async() => {
  await mongoose.connect(`${process.env.MONGO_URL}`)

  console.log('Successfully connected to MongoDB')
}

export default connectDB