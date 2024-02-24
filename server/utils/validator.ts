export const isValidHandphoneNo = (handphoneNo: string) => {
  const phoneNumberRegex = /^(\+?62|0)[0-9]{8,15}$/
  return phoneNumberRegex.test(handphoneNo)
}

export const isValidEmail = (text: string) => {
  const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/
  return emailPattern.test(text);
}