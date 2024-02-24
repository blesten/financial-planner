import { Response } from 'express'
import { IReqUser } from './../utils/interface'
import Notification from './../models/Notification'

const notificationController = {
  read: async(req: IReqUser, res: Response) => {
    try {
      const notifications = await Notification.find({ user: req.user?._id })

      if (notifications.length === 0)
        return res.status(204).json({ msg: 'Notifications is empty.' })

      return res.status(200).json({ notifications })
    } catch (error: any) {
      return res.status(500).json({ msg: error.message })
    }
  },
  updateReadStatus: async(req: IReqUser, res: Response) => {
    const { id } = req.params

    try {
      const notification = await Notification.findById(id)
      if (!notification)
        return res.status(404).json({ msg: 'Notification not found.' })

      await Notification.findByIdAndUpdate(id, { isRead: true })

      return res.status(200).json({
        notification: {
          ...notification,
          isRead: true
        }
      })
    } catch (error: any) {
      return res.status(500).json({ msg: error.message })
    }
  }
}

export default notificationController