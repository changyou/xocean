angular.module('xoceanApp')
  .controller 'ReporteditorCtrl', ($scope, $location, Report, id) ->

    $scope.report = if not id then {} else Report.get { id: id }
  
    # 发件人列表
    $scope.senders = []
    # 抄送人列表
    $scope.copyers = [{
      "name": "陈宁"
    }, {
      "name": "石山松"
    }]

  
    console.log $scope.report
    $scope.$watch "senders", (senders) ->
      return

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
 