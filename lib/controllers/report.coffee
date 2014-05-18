mongoose = require 'mongoose'
Report = mongoose.model 'Report'
Article = mongoose.model 'Article'
Emailer = require '../modules/sendmail'

exports.create = (req, res, next)->
    newReport = new Report(req.body)
    newReport.userId = req.user._id
    newReport.from = req.user.email
    newReport.art = Article.create({
            content : req.body.html
            author: req.user.name
            contentTxt: req.body.cleanHtml
        })
    newReport.html = req.body.html
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
        Article.findById report.artId , (err, art)->
            art.content = req.body.html
            art.contentTxt = req.body.cleanHtml
            art.save (err) ->
                report.subject = req.body.subject
                report.html = art.content
                report.to = req.body.to
                report.cc = req.body.cc
                report.updateAt = new Date()
                report.curWeek = req.body.curWeek
                report.nextWeek = req.body.nextWeek
                report.save (err)->
                    return res.json(400, err) if err

                    res.json report.toObject()  
            return

        
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
            report.save ->
                res.json {
                    success: true
                }

exports.workList = (req, res, next)->
    userId = req.user._id
    currentReportId = req.param('reportId') or null

    result = Report.find({
        userId: userId
    })
    result.not({ _id: currentReportId }) if currentReportId

    result.sort('-sendAt')
    .limit(1)
    .exec (err, lastReport)->
        return next(err) if err
        if lastReport?.length is 0
            res.json {}
        else

            res.json lastReport


