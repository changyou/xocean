'use strict'

describe 'Directive: recipient', () ->

	# load the directive's module
	beforeEach module 'xoceanApp'

	scope = {}
	element = null


	beforeEach inject ($rootScope,$compile,$templateCache,$httpBackend) ->
		element = $templateCache.put('partials/recipients.html', '<div recipient ng-recp-data="foo"></div>');
		scope = $rootScope.$new()
		res = $httpBackend.when('GET','/api/users').respond(200,[{'name':'moe','email':'444984@qq.com'}])
		element = $compile(element) scope
		scope.$digest()


		return

	it 'should have user`s list', inject ($compile) ->

		spanEle = element.find('span')
		expect(spanEle).not.tobe("")
		return
