mongoose = require 'mongoose'
Report = mongoose.model 'Report'

exports.create = (req, res, next)->
	newReport = new Report(req.body)

	newReport.updateAt = newReport.createAt = new Date()

	newReport.save (err)->
		return res.json(400, err) if err
		res.json newReport.toObject()


exports.list = (req, res, next)->
	Report.find {}, (err, result)->
		return res.json(400, err) if err
		res.json result

exports.update = (req, res, next)->
	reportId = req.params.id

	Report.findById reportId, (err, report)->
		return res.json(400, err) if err

		report.title = req.body.title
		report.content = req.body.content

		report.updateAt = new Date()
		report.save (err)->
			return res.json(400, err) if err

			res.json report.toObject()
exports.get = (req, res, next)->
	reportId = req.params.id
	Report.findById reportId, (err, result)->
		return res.json(400, err) if err

		res.json result.toObject()

exports.del = (req, res, next)->
	reportId = req.params.id
	Report.findByIdAndRemove reportId, (err, result)->
		return res.json(400, err) if err
		console.log arguments
		res.json result