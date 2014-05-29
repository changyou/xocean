angular.module('xoceanApp')
  .controller 'ReporteditorCtrl', ($scope, $location, Report, User, id, $rootScope, Auth, Datecal) ->

    if not id
      currentUser = Auth.currentUser()
      currentUser.$promise.then (user) -> 
        $scope.report.to = user.receivers.to
        $scope.report.cc = user.receivers.cc
        return

    $scope.report = if not id then {} else Report.get({id: id})

    if not $scope.report.curWeek then $scope.report.curWeek = [{ status: "none", content: ""}]
    if not $scope.report.nextWeek then $scope.report.nextWeek = [{content: ""}]
    if not $scope.report.to then $scope.report.to = ""
    if not $scope.report.cc then $scope.report.cc = ""
    if not $scope.report.name then $scope.report.name = $rootScope.currentUser.name

    #自动生成邮件主题
    getSubject = () ->
      subjectStr = "【个人周报】"
      dataRange = Datecal.getDataRange()
      startDate = dataRange.startDate
      endDate = dataRange.endDate
      subjectStr += "-" + $rootScope.currentUser.name
      subjectStr += "-" +startDate.getFullYear() + "." + (startDate.getMonth()+1) + "." + startDate.getDate()
      subjectStr += "-" +endDate.getFullYear() + "." + (endDate.getMonth()+1) + "." + endDate.getDate()
      return subjectStr

    if not $scope.report.subject then $scope.report.subject = getSubject()
    # 所有用户数据源模拟
    allUser = User.query()

    # 用户当前输入发件人
    $scope.currentSender = ""
    $scope.currentSenders = []

    # 用户当前输入发件人
    $scope.currentCopyer = ""
    $scope.currentCopyers = []

    $scope.$watch "report.to", (reports)->
      if not reports then return
      $scope.report.to = reports

    $scope.$watch "report.cc", (reports)->
      if not reports then return
      $scope.report.cc = reports

    $scope.errorFlag = false
    $scope.save = (cb) ->

      if $scope.reportForm.$valid
        if not $scope.report._id
          $scope.report = new Report $scope.report
          $scope.report.$create ->
            if cb then cb();
        else
          $scope.report.$save ->
            if cb then cb();
      else
        $scope.errorFlag = true


    $scope.send = ->
      NProgress.start()
      $scope.save ->
        NProgress.set(0.6)  
        $scope.report.$postMail null, ->
            NProgress.done()
            $location.url("/report")
            return
          , ->
            NProgress.done()
            alert("Send Email error!")

      return

    # 增加一条本周工作记录
    $scope.addCurWeek = (e) ->
      if e&&e.keyCode == 13
        e.preventDefault()
        $scope.report.curWeek.push({ status: "none", content: ""})
      else if e.type=="click"
        $scope.report.curWeek.push({ status: "none", content: ""})
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

    # 获取上周工作记录
    $scope.lastestReport = Report.workList($scope.report._id)

    $scope.showTip = (e)->
      $(e.currentTarget).tooltip('show')
      return
      
    # 显示预览界面
    $scope.preview = ()->
        $scope.save ->
          window.open("/api/report/"+$scope.report._id+"/preview")
    return