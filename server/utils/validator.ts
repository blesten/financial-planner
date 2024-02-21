export const isValidHandphoneNo = (handphoneNo: string) => {
  const phoneNumberRegex = /^(\+?62|0)[0-9]{8,15}$/
  return phoneNumberRegex.test(handphoneNo)
}