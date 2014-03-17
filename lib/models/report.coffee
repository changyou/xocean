
mongoose = require('mongoose')
Schema = mongoose.Schema;

ReportSchema = new Schema({
  userId: Schema.Types.ObjectId
  to: [String]
  cc: [String]
  subject: String
  html: String

  # 0 - draft
  # 1 - send success
  # 3 - send error
  # 4 - deleted
  status: {
    type: Number
    default: 0
  }

  updateAt: Date
  createAt: Date
  sendAt: Date

})

mongoose.model('Report', ReportSchema)
