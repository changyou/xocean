mongoose = require 'mongoose'
Report = mongoose.model 'Report'
Emailer = require '../modules/sendmail'

exports.create = (req, res, next)->
	newReport = new Report(req.body)

	newReport.userId = req.user._id
	newReport.updateAt = newReport.createAt = new Date()

	newReport.save (err)->
		return res.json(400, err) if err
		res.json newReport.toObject()


exports.list = (req, res, next)->
	uid = req.user._id

	Report.find { userId: uid }, (err, result)->
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
		res.json result
