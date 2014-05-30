mongoose = require 'mongoose'
Article = mongoose.model 'Article'

exports.list = (req, res)->
    Article.find({"hasSend":true}).sort('-createAt').exec (err, result)->
        return res.json(400, err) if err
        resData = {code:200,data:result}
        res.json resData

exports.getNews = (req,res)->
    Article.find({"hasSend":true}).sort('-createAt').limit(10).exec (err, result)->
        return res.json(400, err) if err
        resData = {code:200,data:result}
        res.json resData

exports.queryByID = (req,res)->
    artId = req.params.id
    Article.findById artId, (err,repo)->
        return res.json(400, err) if err
        resData = {code:200,data:repo}
        res.json resData