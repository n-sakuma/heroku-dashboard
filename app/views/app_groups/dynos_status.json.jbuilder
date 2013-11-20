json.array! @app_groups do |group|
  json.name "#{group.name}  (%%.%)"
  json.dyno_data group.dynos_count
  json.dyno_desc group.dynos_summary unless group.dynos_count.zero?
end
