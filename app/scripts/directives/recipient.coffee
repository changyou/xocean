'use strict'

angular.module('xoceanApp')
  .directive('recipient', () ->
    templateUrl: 'partials/recipients.html'
    restrict: 'AE'
    scope:{
        data : "=ngRecpData"
        curClass : "@ngRecpStyle"
    }
    link: (scope, element, attrs) ->
        sendersLength = 0
        scope.$watch "currentSenders", (senders)->
            if !senders then return
            scope.curindex = 0
            sendersLength = senders.length
            return

        scope.chooseSender = (e)->
          #adapter the width of input tag
          elem = $(e.target)
          txt = elem.val().replace(/[\u4e00-\u9fa5]/g, "**")
          autoWidth = if txt.length*8 > 95 then txt.length*8 else 95
          elem.css({width: autoWidth})

          if e.keyCode == 13        #enter
             e.preventDefault()
             if scope.currentSenders.length>0
              scope.addSender scope.currentSenders[scope.curindex].name 
             else 
              scope.addSender elem.val()
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
          dataWatcher = $scope.$watch "data", (data) ->
            if data
              $scope.senderArrTemp = queryUserByEmail(data.split(",")) 
              dataWatcher()


        $scope.$watchCollection "senderArrTemp", (senders) ->
          if !senders then return
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
              return;
          $scope.senderArrTemp.push {
            name: name
            email: name
          }

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
          # for email in emails
          #   conti = false
          #   for user in allUser
          #     if user.email == email 
          #       arr.push user
          #       conti = true
                    
          #   if conti then continue;

          #   arr.push {
          #     name: email
          #     email: email
          #   }

          arr = emails.map (email)->

            testUser = allUser.filter (user)->
              return user.email == email
            
            if testUser.length  
              return testUser[0] 
            else 
              return {
                name: email
                email: email
              }
          return arr

        return
)