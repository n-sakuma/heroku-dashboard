json.array! @app_groups do |group|
  json.name "#{group.name}(%%.%)"
  json.addons_cost group.addon_cost
end
