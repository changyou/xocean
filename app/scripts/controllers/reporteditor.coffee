angular.module('xoceanApp')
  .controller 'ReporteditorCtrl', ($scope, $location, Report, User, id, $rootScope) ->

    $scope.report = if not id then {} else Report.get({id: id})

    if not $scope.report.curWeek then $scope.report.curWeek = [{ status: "none", content: ""}]
    if not $scope.report.nextWeek then $scope.report.nextWeek = [{content: ""}]
    if not $scope.report.to then $scope.report.to = ""
    if not $scope.report.cc then $scope.report.cc = ""

    #自动生成邮件主题
    #
    getSubject = () ->
      subjectStr = "【个人周报】"
      curDate = new Date() 
      #周五之前写的周报，工作周期都是上一周的工作
      if curDate.getDay() < 5 and curDate.getDay() != 0 
        startOffset = (curDate.getDay()+ 2 + 4) * 60 * 60 * 24 * 1000
        endOffset = (curDate.getDay()+ 2) * 60 * 60 * 24 * 1000
      else
        if curDate.getDay() == 0 then isSunday = 7 else isSunday = curDate.getDay()
        startOffset = (isSunday - 1) * 60 * 60 * 24 * 1000
        endOffset = (isSunday - 5)* 60 * 60 * 24 * 1000

      startDate = new Date((+curDate) - startOffset)
      endDate = new Date((+curDate) - endOffset)
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
    $scope.save = ->
      if $scope.reportForm.$valid
        if not $scope.report._id
          $scope.report = new Report $scope.report
          $scope.report.$create()
        else
          $scope.report.$save()
      else
        $scope.errorFlag = true

    $scope.send = ->
      $scope.save()
      $scope.report.$postMail()
          # .success ->
          #   $location.url("/report")

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

    $scope.showTip= (e)->
      $(e.currentTarget).tooltip('show')
      return


    return