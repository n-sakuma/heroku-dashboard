class HerokuApp
  def initialize(attr)
    @attr = attr
  end

  def method_missing(action, *args)
    if @attr.include? action.to_s
      return @attr[action.to_s]
    end
    super
  end
end
