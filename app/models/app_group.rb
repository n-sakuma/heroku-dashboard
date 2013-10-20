class AppGroup < ActsAsTaggableOn::Tag

  def apps
    HerokuApp.tagged_with(name)
  end

  def dynos_summary
    total = 0
    dyno_kind = Hash.new(0)
    apps.map(&:dynos_kind).each do |kind|
      total += kind.delete(:total)
      kind.each_pair do |k, v|
        dyno_kind[v.keys.first] += v.values.first
      end
    end
    "#{total} ( #{dyno_kind.to_a.map{|d| d.join('x ')}.join(', ')} )"
  end

  def dynos_total_count
    apps.map(&:dynos_kind).map{|v| v[:total]}.sum
  end

  def addon_cost
    apps.map(&:addon_cost).sum
  end
end
