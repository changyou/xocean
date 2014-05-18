mongoose = require 'mongoose'
Article = mongoose.model 'Article'

exports.list = (req, res)->
    Article.find({"hasSend":true}).sort('-createAt').exec (err, result)->
        return res.json(400, err) if err
        resData = {code:200,data:result}
        res.json resData