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