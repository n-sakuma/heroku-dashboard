##########
# Usage:
#
# chartPosition =
#   positionId: 'dynos-chart-holder'
#   chart_x: 250
#   chart_y: 200
#   radial: 120
#   title_x: 150
#   title_y: 30
#   title_pos: "west"
# HerokuDashboard.displayChart('Dynos', 10000, "/dynos/info.json", chartPosition)

class @HerokuDashboard

  @displayChart = (chartType, maxValue, get_url, chartPosition) ->
    $.ajax get_url,
      type: 'GET'
      dataType: 'json'
      error: (jqXHR, textStatus, errorThrown) =>
        console.log textStatus
      success: (data, textStatus, jqXHR) =>
        @parseRequest(chartType, data)
        r = Raphael(chartPosition['positionId'])
        pie = r.piechart(chartPosition['chart_x'], chartPosition['chart_y'], chartPosition['radial'], @data, { legend: @labels, legendpos: chartPosition['title_pos'], href: @descriptions})
        @titlize(chartType, @data, maxValue)
        r.text(chartPosition['title_x'], chartPosition['title_y'], @title).attr font: "20px sans-serif"
        pie.hover (->
          @sector.stop()
          @sector.scale 1.1, 1.1, @cx, @cy
          if @label
            @label[0].stop()
            @label[0].attr r: 7.5
            @label[1].attr "font-weight": 800
        ), ->
          @sector.animate
            transform: "s1 1 " + @cx + " " + @cy
          , 500, "bounce"
          if @label
            @label[0].animate
              r: 5
            , 500, "bounce"
            @label[1].attr "font-weight": 400

  @parseRequest = (chartType, responseData) =>
    @resetValues()
    $(responseData).each (key, message) =>
      if chartType == 'Dynos'
        @labels.push message.name
        @data.push message.dyno_data
        @descriptions.push message.dyno_desc if message.dyno_data > 0
      else
        @labels.push message.name
        @data.push message.addons_cost
    @total = @data.reduce (a, b) -> a + b
    @data.push @total
    @labels.push "Free  (%%.%)"

  @resetValues = ->
    @data = []
    @labels = []
    @descriptions = []
    @title = ""
    @total = null

  @titlize = (chartType, data, maxValue) ->
    parcentage = (@total / maxValue * 100).toFixed(1)
    if chartType == 'Dynos'
      @title = "#{chartType}: #{parcentage}% (#{@total}/#{maxValue})"
    else
      @title = "#{chartType}: #{parcentage}% ($#{@total}/$#{maxValue})"
