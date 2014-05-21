'use strict'

mail = require 'nodemailer'

exports.send = (req, res, next)->
	console.log("begin to send ... ")

	email   = req.body.e
	content = req.body.c

	smtpTransport = mail.createTransport('SMTP', {
		service: 'smtp.126.com'
		ssl: true
		auth: {
			user: "cxj_liang@126.com"
			pass: "xiaoliang"
		}
	})

	mailOptions = {
		form: "cxj_liang@126.com"
		to: "cxj_liang@126.com"
		subject: "this is for test"
		html: "lalallalala"
	}

	smtpTransport.sendMail mailOptions, (error, response)->
		res.set('Content-Type', 'text/plain')
		if error
			console.log(error)
		else
			console.log("Message sent: " + response.message)
		res.end()