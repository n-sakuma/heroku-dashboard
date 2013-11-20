module BootstrapFlashHelper
  ALERT_TYPES = [:error, :info, :success, :warning]

  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      next if message.blank?

      type = :success if type == :notice
      type = :error   if type == :alert
      next unless ALERT_TYPES.include?(type)

      flash_messages << content_tag(:div, Array(message).compact.join("<br />").html_safe, class: "alert alert-#{type}")
    end
    flash_messages.join("\n").html_safe
  end
end
