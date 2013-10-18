class HerokuApp < ActiveRecord::Base
  acts_as_taggable

  API_ATTRIBUTE = %W(dynos workers web_url released_at)

  def update_from_api(attr)
    self.attributes = parse_attr(attr)
    self.save
  end


  private

  def parse_attr(attr)
    hs = {}
    API_ATTRIBUTE.each {|key| hs[key.to_sym] = attr[key] }
    hs
  end
end
