import { Request } from 'express'
import { ObjectId, Date } from 'mongoose'

export interface IGeneralField {
  _id: string
  createdAt: Date
  updatedAt: Date
  _doc?: any
}

export interface IDecodedToken {
  id: string
}

export interface IUser extends IGeneralField {
  name: string
  email: string
  handphoneNo: string
  pin: string
}

export interface IReqUser extends Request {
  user?: IUser
}

export interface ICard extends IGeneralField {
  user: ObjectId
  title: string
  name: string
  no: string
  type: string
  contactless: boolean
  expDate: string
  color: string
}

export interface INotification extends IGeneralField {
  user: ObjectId
  title: string
  description: string
  isRead: boolean
}

export interface ITransaction extends IGeneralField {
  user: ObjectId
  card: ObjectId
  transactionCategory: string
  amount: number
  expenseCategory: string
}