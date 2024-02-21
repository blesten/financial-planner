import twilio from 'twilio'

export const sendVerificationCode = async(phoneNumber: string) => {
  const client = twilio(process.env.TWILIO_ACCOUNT_SID, process.env.TWILIO_AUTH_TOKEN)

  const response = await client
                            .verify
                            .v2
                            .services(`${process.env.TWILIO_SERVICE_SID}`)
                            .verifications
                            .create({ to: phoneNumber, channel: 'whatsapp' })

  return response
}

export const verifyVerificationCode = async(phoneNumber: string, code: string) => {
  const client = twilio(process.env.TWILIO_ACCOUNT_SID, process.env.TWILIO_AUTH_TOKEN)

  const response = await client
                            .verify
                            .v2
                            .services(`${process.env.TWILIO_SERVICE_SID}`)
                            .verificationChecks
                            .create({ to: phoneNumber, code })

  return response
}