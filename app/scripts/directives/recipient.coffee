'use strict'

angular.module('xoceanApp')
  .directive('recipient', () ->
    templateUrl: '../../views/partials/recipients.html'
    restrict: 'AE'
    scope:{
        data : "=ngRecpData"
        curClass : "@ngRecpStyle"
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
             scope.addSender scope.currentSenders[scope.curindex].name if scope.currentSenders.length>0
             scope.currentSender=""
          else if e.keyCode == 38 #up
             e.preventDefault()
             if scope.curindex > 0 then --scope.curindex
          else if e.keyCode == 40 #down
             e.preventDefault()
             if scope.curindex < sendersLength-1 then ++scope.curindex
          else if e.keyCode == 8
             if (scope.senderArrTemp.length > 0 && !scope.currentSender)
               scope.senderArrTemp.pop()
          return

    controller: ($scope,User) ->

        $scope.senderArrTemp = []

        # 所有用户数据源模拟
        allUser = [] 
        User.query (user) ->
          allUser = user
          $scope.$watch "data", (data) ->
            $scope.senderArrTemp = queryUserByEmail(data.split(",")) if data

        $scope.$watchCollection "senderArrTemp", (senders) ->
          arr = []
          for sender in senders
            arr.push sender.email
          $scope.data = arr.join "," ,true

        # 用户当前输入发件人
        $scope.currentSender = undefined
        $scope.currentSenders = []

        # 添加当前发件人
        $scope.addSender = (name) ->
          for user in allUser
            if name != "" && user.name == name && !isContainUser($scope.senderArrTemp, name)
              $scope.senderArrTemp.push user
          $scope.currentSender = ""
          $scope.autoComplateSender($scope.currentSender)

        # 删除当前发件人
        $scope.removeSender = (name) ->
          arr = []
          for sender in $scope.senderArrTemp
            arr.push(sender) if sender.name != name
          $scope.senderArrTemp = arr

        # 发件人自动提示
        $scope.autoComplateSender = (name) ->
          $scope.currentSenders = []
          for user in allUser
            $scope.currentSenders.push(user) if name != "" && (user.name.indexOf(name) != -1 || user.email.indexOf(name) == 0) && !isContainUser($scope.senderArrTemp, user.name)

        # 快速添加收件人
        $scope.switchSenders = (groupId) ->
          arr = senderConfig[groupId]
          $scope.senderArrTemp = arr if arr

        # 判断数组中是否含有当前名字的人
        isContainUser = (arr, name) ->
          for user in arr
            return true if name != "" && user.name == name
          return false

        queryUserByEmail = (emails) ->
          arr = []
          for email in emails
            for user in allUser
              if user.email == email then arr.push user

          return arr

        return
)
