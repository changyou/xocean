mongoose = require 'mongoose'
Report = mongoose.model 'Report'
Article = mongoose.model 'Article'
Emailer = require '../modules/sendmail'
path = require('path')
exports.create = (req, res, next)->
    newReport = new Report(req.body)
    newReport.userId = req.user._id
    newReport.from = req.user.email
    newReport.html = req.body.html
    newReport.updateAt = newReport.createAt = new Date()

    shareArticle =  new Article({
            content : req.body.html
            author: req.user.name
            contentTxt: req.body.cleanHtml
            reportId: newReport.id
    })

    shareArticle.save (err) ->
        newReport.artId = shareArticle.id
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
        report.to = req.body.to
        report.cc = req.body.cc
        report.updateAt = new Date()
        report.curWeek = req.body.curWeek
        report.nextWeek = req.body.nextWeek
        report.html = req.body.html

        Article.findById report.artId , (err, art)->
            return res.json(400, err) if err
            if !art
                report.save (err)->
                    return res.json(400, err) if err
                    res.json report.toObject()  
                return
            else 
                art.content = req.body.html
                art.contentTxt = req.body.cleanHtml
                art.save (err) ->
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
            Article.findById report.artId, (err, art)->
                return res.json(400, err) if err
                art.hasSend = true
                art.save (artErr)->
                    return res.json(500, artErr) if artErr
                    report.save ->
                        res.json {
                            success: true
                        }
            return

exports.preview = (req,res,next)->
    reportId = req.params.id
    stripped = req.url.split('.')[0];
    requestedView = path.join('./', stripped);
    console.log requestedView
    Report.findById reportId, (err,repo)->
        return res.json(500,err) if err
        preHtml = Emailer.previewHtml repo
        res.render 'partials/reportPreview.html',{html:preHtml}

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


