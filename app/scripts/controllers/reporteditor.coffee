angular.module('xoceanApp')
  .controller 'ReporteditorCtrl', ($scope, $location, Report, User, id) ->

    # 默认抄送
    defaultCopyer = [{
      "name": "陈宁"
      "email": "chenning@cyou-inc.com"
    }, {
      "name": "石山松"
      "email": "shishansong@cyou-inc.com"
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
        "name": "王贵喜"
      }],

      "3": [{
        "name": "陈开洪"
      }]
    }

    # 判断数组中是否含有当前名字的人
    isContainUser = (arr, name) ->
      for user in arr
        return true if name != "" && user.name == name
      return false

    # 获取所有联系人
    getContacts = (users) ->
      if users == undefined
        return
      emailArr = []
      for user in users
        emailArr.push(user.email)
      return emailArr.join(',');

    $scope.report = if not id then {} else Report.get({id: id})

    if not $scope.report.to then $scope.report.to = "zhoushufeng@cyou-inc.com,zhoushufeng@cyou-inc.com"

    if not $scope.report.cc then $scope.report.cc = ""

    if not $scope.report.curWeek then $scope.report.curWeek = [{ done: false, content: ""}]

    if not $scope.report.nextWeek then $scope.report.nextWeek = [{content: ""}]

    # 发件人列表
    $scope.senders = []

    # 抄送人列表
    $scope.copyers = []

    # 所有用户数据源模拟
    allUser = User.query()

    # 用户当前输入发件人
    $scope.currentSender = ""
    $scope.currentSenders = []

    # 用户当前输入发件人
    $scope.currentCopyer = ""
    $scope.currentCopyers = []

    $scope.$watch "report", ()->
      $scope.senders = $scope.report.to.split(',')
      $scope.copyers = $scope.report.cc.split(',')
      console.log $scope.report.to
      console.log $scope.senders

    $scope.save = ->
      if not $scope.report._id
        $scope.report = new Report $scope.report
        $scope.report.to = getContacts($scope.senders)
        $scope.report.cc = getContacts($scope.copyers)
        $scope.report.$create()
      else
        $scope.report.to = getContacts($scope.senders)
        $scope.report.cc = getContacts($scope.copyers)
        $scope.report.$save()

    $scope.send = ->
      if confirm('确定发送？')
        $scope.report.$postMail()
          # .success ->
          #   $location.url("/report")

    # 添加当前发件人
    $scope.addSender = (name) ->
      for user in allUser
        $scope.senders.push(user) if name != "" && user.name == name && !isContainUser($scope.senders, name)
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
      for user in allUser
        $scope.currentSenders.push(user) if name != "" && (user.name.indexOf(name) != -1 || user.email.indexOf(name) == 0) && !isContainUser($scope.senders, user.name)

    # 增加当前抄送人
    $scope.addCopyer= (name) ->
      for user in allUser
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
      for user in allUser
        $scope.currentCopyers.push(user) if name != "" && (user.name.indexOf(name) != -1 || user.email.indexOf(name) == 0) && !isContainUser($scope.copyers, user.name)

    # 快速添加收件人
    $scope.switchSenders = (groupId) ->
      arr = senderConfig[groupId]
      $scope.senders = arr if arr

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
