import express from 'express'
import dotenv from 'dotenv'
import connectDB from './config/db'

dotenv.config({
  path: 'config/.env'
})

const app = express()

app.use(express.json())
app.use(express.urlencoded({ extended: true }))

connectDB()
app.listen(process.env.PORT, () => console.log(`Server is running on PORT ${process.env.PORT}`))