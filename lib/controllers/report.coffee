mongoose = require 'mongoose'
Report = mongoose.model 'Report'
Emailer = require '../modules/sendmail'

exports.create = (req, res, next)->
	newReport = new Report(req.body)

	newReport.userId = req.user._id
	newReport.from = req.user.email
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

		report.subject = req.body.subject
		report.html = req.body.html
		report.to = req.body.to
		report.cc = req.body.cc
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

exports.sendEmail = (req, res, next)->
	reportId = req.params.id
	Report.findById reportId, (err, report)->
		Emailer.sendReport report, (err, response)->
			return res.json(500, err) if err
			console.log response
			report.save ->
				res.json {
					success: true
				}
