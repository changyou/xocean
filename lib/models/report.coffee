
mongoose = require('mongoose')
Schema = mongoose.Schema;

ReportSchema = new Schema({
  title: String
  content: String
  updateAt: Date
  createAt: Date
})

mongoose.model('Report', ReportSchema)
