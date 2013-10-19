class AppGroup < ActsAsTaggableOn::Tag

  def apps
    HerokuApp.tagged_with(name)
  end

  def dynos_summary
    dynos = apps.map{|a| a.dynos.to_i}.sum
    workers = apps.map{|a| a.workers.to_i}.sum
    "#{dynos + workers} (web: #{dynos}, worker: #{workers})"
  end

  def addon_cost
    apps.map(&:addon_cost).sum
  end
end
