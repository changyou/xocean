angular.module('xoceanApp')
  .controller 'ReporteditorCtrl', ($scope, $location, Report, id) ->

    $scope.report = if not id then {} else Report.get { id: id }
  
    # 发件人列表
    $scope.senders = []
    # 抄送人列表
    $scope.copyers = []

    # 所有用户数据源模拟
    $scope.allUser = [{
      "name": "周树枫"
    }, {
      "name": "蒋志德"
    }, {
      "name": "白雪娇"
    }, {
      "name": "周地方"
    }, {
      "name": "周耳朵"
    }, {
      "name": "迟晓靓"
    }, {
      "name": "李晓露"
    }, {
      "name": "李毅"
    }, {
      "name": "夏田"
    }, {
      "name": "刘剑锋"
    }, {
      "name": "陈友国"
    }, {
      "name": "陈友发"
    }, {
      "name": "陈友人"
    }, {
      "name": "陈友俄"
    }, {
      "name": "陈友都"
    }, {
      "name": "陈点国"
    }, {
      "name": "陈大国"
    }]

    # 用户当前输入发件人
    $scope.currentSender
    $scope.currentSenders = []

    # 用户当前输入发件人
    $scope.currentCopyer
    $scope.currentCopyers = []

    if not $scope.report.curWeek then $scope.report.curWeek = [ { done: false, content: ""} ]

    if not $scope.report.nextWeek then $scope.report.nextWeek = [{content: ""}]



    $scope.save = ->

      if not $scope.report._id
        $scope.report = new Report $scope.report
        $scope.report.$create()
      else

        $scope.report.$save()


    $scope.send = ->
      if confirm('确定发送？')
        $scope.report.$postMail()
          .success ->
            $location.url("/report")

    # 添加当前发件人
    $scope.addSender = (name) ->
      for sender in $scope.allUser
        $scope.senders.push(sender) if name != "" && sender.name == name && !isContainUser($scope.senders, name)
      $scope.currentSender = ""
      $scope.autoComplateSender($scope.currentSender)

    # 删除当前发件人
    $scope.removeSender = (name) ->
      arr = []
      for sender in $scope.senders
        arr.push(sender) if sender.name != name
      $scope.senders = arr

    # 发件人自动提示
    $scope.autoComplateSender = (name) ->
      $scope.currentSenders = []
      for user in $scope.allUser
        $scope.currentSenders.push(user) if name != "" && user.name.indexOf(name) != -1

    # 增加当前抄送人
    $scope.addCopyer= (name) ->
      for user in $scope.allUser
        $scope.copyers.push(user) if name != "" && user.name == name && !isContainUser($scope.copyers, name)
      $scope.currentCopyer = ""
      $scope.autoComplateCopyer($scope.currentCopyer)

    # 删除当前抄送人
    $scope.removeCopyer = (name) ->
      arr = []
      for copyer in $scope.copyers
        arr.push(copyer) if copyer.name != name
      $scope.copyers = arr

    # 抄送人自动提示
    $scope.autoComplateCopyer = (name) ->
      $scope.currentCopyers = []
      for user in $scope.allUser
        $scope.currentCopyers.push(user) if name != "" && user.name.indexOf(name) != -1

    # 判断数组中是否含有当前名字的人
    isContainUser = (arr, name) ->
      for sender in arr
        return true if name != "" && sender.name == name
      return false

    # 增加一条本周工作记录
    $scope.addCurWeek = (e) ->
      if e&&e.keyCode == 13 
        e.preventDefault() 
        $scope.report.curWeek.push({ done: false, content: ""})
      else if e.type=="click"
        $scope.report.curWeek.push({ done: false, content: ""})
      return

    # 改变工作记录的状态
    $scope.cwToggleDone = (index) ->
      $scope.report.curWeek[index].done = $scope.report.curWeek[index].done == false ? true : false;
      return 

    # 删除一条本周工作记录
    $scope.removeCurWeek = (index) ->
      if $scope.report.curWeek[index] then $scope.report.curWeek.splice(index,1)
      return  

     # 增加一条下周工作记录
    $scope.addNextWeek = (e) ->
      if e&&e.keyCode == 13 
        e.preventDefault()
        $scope.report.nextWeek.push({content: ""})
      else if e.type=="click"
        $scope.report.nextWeek.push({content: ""})
      return

    # 删除一条下周工作
    $scope.removeNextWeek = (index) ->
      if $scope.report.nextWeek[index] then $scope.report.nextWeek.splice(index,1)
      return

  
     
     
 