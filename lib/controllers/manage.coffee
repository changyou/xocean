'use strict'

path = require 'path'

exports.manage = (req, res)->
	stripped = req.url.split('.')[0]
	requestedView = path.join('./', stripped)
	res.render requestedView, (err, html)->
		if err
			console.log "Error rendering partial '#{requestedView}'\n", err
			res.status(404)
			res.send(404)
		else
			res.send(html)