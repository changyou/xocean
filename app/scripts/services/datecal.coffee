'use strict'
# 日期计算service
angular.module('xoceanApp')
  .service 'Datecal', () ->
    return {
      # 获得基于当前日期的周报主题日期对象
      getDataRange : ()->
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

        return {
          startDate:startDate
          endDate:endDate
        }
      
    }