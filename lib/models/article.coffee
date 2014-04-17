
mongoose = require('mongoose')
Schema = mongoose.Schema;

ArticleSchema = new Schema({
	reportId: Schema.Types.ObjectId

	subject: String
	tag: [String]
	content: String

	createAt: {
		type: Date
		default: Date.now
	}

})

mongoose.model('Article', ArticleSchema)