$ ->
  # for dynos chart
  renderDynosChart = ->
    dynos_legend = []
    dynos_data = []
    dynos_desc = []
    $.ajax "/dynos/info.json",
      type: 'GET'
      dataType: 'json'
      error: (jqXHR, textStatus, errorThrown) =>
        console.log textStatus
      success: (data, textStatus, jqXHR) =>
        $(data).each (key, message) =>
          dynos_legend.push message.name
          dynos_data.push message.dyno_data
          dynos_desc.push message.dyno_desc if message.dyno_data > 0
        r = Raphael("dynos-chart-holder")
        pie = r.piechart(250, 200, 120, dynos_data, { legend: dynos_legend, legendpos: "west", href: dynos_desc})
        total = 0
        total += i for i in dynos_data
        parcentage = total / 10000 * 100
        title = "Dynos: #{parcentage}% (#{total}/10000)"
        r.text(150, 30, title).attr font: "20px sans-serif"
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

  renderAddonsChart = ->
    addons_legend = []
    addons_cost = []
    $.ajax "/addons/info.json",
      type: 'GET'
      dataType: 'json'
      error: (jqXHR, textStatus, errorThrown) =>
        console.log textStatus
      success: (data, textStatus, jqXHR) =>
        $(data).each (key, message) =>
          addons_legend.push message.name
          addons_cost.push message.addons_cost
        r = Raphael("addons-chart-holder")
        pie = r.piechart(280, 200, 120, addons_cost, { legend: addons_legend, legendpos: "west"})
        total = 0
        total += i for i in addons_cost
        parcentage = total / 2000 * 100
        title = "Addons: #{parcentage}% ($#{total}/$2,000)"
        r.text(280, 30, title).attr font: "20px sans-serif"
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

  renderDynosChart()
  renderAddonsChart()

