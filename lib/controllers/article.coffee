mongoose = require 'mongoose'
Article = mongoose.model 'Article'

exports.list = (req, res)->

	Article.find {}, (err, result)->
		return res.json(400, err) if err
		res.json result