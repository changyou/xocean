
nodemailer = require 'nodemailer'

config = require '../config/config'


smtpTransport = nodemailer.createTransport('smtp', config.smtp)

mailOptions = {
	from: "ijse <liyi_nad@cyou-inc.com>"
	to: "liyi_nad@cyou-inc.com"
	subject: "Hello test from nodemailer"
	text: "hello world"
	forceEmbeddedImages: true
	html: """
		Hel<b>lo</b>, abc <br/>
		<b> Test embeded images: </b>
		<img src='http://test.designer.c-launcher.com/resources/upload/53266c66324afcc92a000001/wallpaper/wallpaper-hd.jpg?1395027588730' />
	"""
}

# smtpTransport.sendMail mailOptions, (err, response)->

# 	return console.log err if err

# 	console.log response.message

exports.sendReport = (report, callback)->
	mailOptions = {
		from: report.from
		to: report.to
		cc: report.cc
		subject: report.subject
		forceEmbeddedImages: true
		html: report.html
	}

	smtpTransport.sendMail mailOptions, (err, response)->
		if err
			report.status = 3
			console.log err
			callback(err)
		else
			report.status = 1
			report.sendAt = new Date()
			callback(null, response)
