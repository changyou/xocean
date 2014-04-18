'use strict'

angular.module('xoceanApp')
  .directive('recipient', () ->
    templateUrl: '../../views/partials/recipients.html'
    restrict: 'AE'
    scope:{
    	data : "=ngRecpData"
    }
    link: (scope, element, attrs) ->
    	sendersLength = 0
    	scope.$watch "currentSenders", (senders)->
            scope.curindex = 0
            sendersLength = senders.length
            return

	    scope.chooseSender = (e)->
	       if e.keyCode == 13        #enter
	           e.preventDefault()
	           scope.addSender scope.currentSenders[scope.curindex].name
	           scope.currentSender=""
	       else if e.keyCode == 38 #up
	           e.preventDefault()
	           if scope.curindex > 0 then --scope.curindex
	           
	       else if e.keyCode == 40 #down
	           e.preventDefault()
	           if scope.curindex < sendersLength-1 then ++scope.curindex
	       else if e.keyCode == 8 
	           if (scope.currentSenders.length > 0 && !scope.currentSender)
	             scope.currentSenders.pop()
	       return

    controller: ($scope) ->
    	# 所有用户数据源模拟
	    allUser = [
	    	{
		      "name": "周树枫",
		      "email": "zhoushufeng@cyou-inc.com"
		    }, {
		      "name": "蒋志德",
		      "email": "jiangzhide@cyou-inc.com"
		    }, {
		      "name": "白雪娇",
		      "email": "baixuejiao@cyou-inc.com"
		    }, {
		      "name": "周地方"
		      "email": "zhoudifang@cyou-inc.com"
		    }, {
		      "name": "周耳朵",
		      "email": "zhouerduo@cyou-inc.com"
		    }, {
		      "name": "迟晓靓",
		      "email": "chixiaoliang@cyou-inc.com"
		    }, {
		      "name": "李晓露",
		      "email": "lixiaolu@cyou-inc.com"
		    }, {
		      "name": "李毅",
		      "email": "liyi@cyou-inc.com"
		    }, {
		      "name": "夏田",
		      "email": "xiatian@cyou-inc.com"
		    }, {
		      "name": "刘剑锋",
		      "email": "liujianfeng@cyou-inc.com"
		    }, {
		      "name": "陈友国",
		      "email": "chenyouguo@cyou-inc.com"
		    }, {
		      "name": "陈友发",
		      "email": "chenyoufa@cyou-inc.com"
		    }, {
		      "name": "陈友人",
		      "email": "chengyouren@cyou-inc.com"
		    }, {
		      "name": "陈友俄",
		      "email": "chengyoue@cyou-inc.com"
		    }, {
		      "name": "陈友都",
		      "email": "chengyoudu@cyou-inc.com"
		    }, {
		      "name": "陈点国",
		      "email": "chengdianguo@cyou-inc.com"
		    }, {
		      "name": "陈大国",
		      "email": "chengdaguo@cyou-inc.com"
		    }, {
		      "name": "陈宁"
		      "email": "chengning@cyou-inc.com"
		    }, {
		      "name": "石山松"
		      "email": "shishansong@cyou-inc.com"
		    }, {
		      "name": "陈开洪"
		      "email": "chengkaihong@cyou-inc.com"
		    }]

	    # 各个组的快速发件人配置
	    senderConfig = {
	      "1": [{
	        "name": "白雪娇"
	      }, {
	        "name": "陈友国"
	      }, {
	        "name": "迟晓靓"
	      }, {
	        "name": "蒋志德"
	      }, {
	        "name": "李晓露"
	      }, {
	        "name": "李毅"
	      }, {
	        "name": "刘剑锋"
	      }, {
	        "name": "夏田"
	      }, {
	        "name": "周树枫"
	      }],

	      "2": [{
	        "name": "陈友都"
	      }],

	      "3": [{
	        "name": "陈友人"
	      }]
	    }
	 	
	 	# 用户当前输入发件人
	    $scope.currentSender = undefined
	    $scope.currentSenders = []

	    # 添加当前发件人
	    $scope.addSender = (name) ->
	      for user in allUser
	        $scope.data.push(user) if name != "" && user.name == name && !isContainUser($scope.data, name)
	      $scope.currentSender = ""
	      $scope.autoComplateSender($scope.currentSender)

	    # 删除当前发件人
	    $scope.removeSender = (name) ->
	      arr = []
	      for sender in $scope.data
	        arr.push(sender) if sender.name != name
	      $scope.data = arr

	    # 发件人自动提示
	    $scope.autoComplateSender = (name) ->
	      $scope.currentSenders = []
	      for user in allUser
	        $scope.currentSenders.push(user) if name != "" && (user.name.indexOf(name) != -1 || user.email.indexOf(name) == 0) && !isContainUser($scope.data, user.name)

	    # 快速添加收件人
	    $scope.switchSenders = (groupId) ->
	      arr = senderConfig[groupId]
	      $scope.data = arr if arr

	     # 判断数组中是否含有当前名字的人
	    isContainUser = (arr, name) ->
	      for user in arr
	        return true if name != "" && user.name == name
	      return false
	    return

  )
