'use strict'

angular.module('xoceanManage')
	.controller 'NavbarCtrl', ($scope, $location, Auth)->
		$scope.menu = [
			{
				'title': '首页'
				'link': '/'
			}
			{
				'title': '论坛'
				'link': 'http://bb.ijser.cn'
			}
			{
				'title': '周报'
				'submenu': [
					{
						'title': '周报列表'
						'link': '/report'
					}
					{
						'title': '撰写周报'
						'link': '/report/edit'
					}
				]
			}
		]
