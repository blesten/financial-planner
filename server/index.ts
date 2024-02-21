import express from 'express'
import dotenv from 'dotenv'
import connectDB from './config/db'
import routers from './routes'
import cors from 'cors';

dotenv.config({
  path: 'config/.env'
})

const app = express()

app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use(cors())

app.use('/api/v1/users', routers.userRoute)

connectDB()
app.listen(process.env.PORT, () => console.log(`Server is running on PORT ${process.env.PORT}`))