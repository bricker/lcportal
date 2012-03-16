module ApplicationHelper
  def check_for(content, options={})
    case content
      when String, Symbol
        options[:default] ||= content.to_s.titleize
        content_for?(content) ? content_for(content) : options[:default]
      else
        options[:default] ||= "There is nothing here to list."
        content.present? ? nil : content_tag(:div, options[:default], class: 'none-to-list')
      end
  end
  
  def nav_link_to(text, path, options={})
    content_tag(:li, link_to(text, path, options), class: controller.controller_name == path.split("/")[1] ? "active" : nil)
  end
  
  def any_to_list?(records, options={}, &block)
    if records.present?
      block_given? ? capture(&block) : true
    else
      if block_given?
        if options[:message].blank?
          if options[:title].present?
            options[:message] ||= "<thead><tr><td class='none-to-list'>There are currently no #{options[:title]}.</td></tr></thead>"
          else
            options[:message] ||= "<thead><tr><td class='none-to-list'>There is nothing to list yet.</td></tr></thead>"
          end
        end
        return options[:message].html_safe
      else
        return false
      end
    end
  end
  
  def pretty_date(date, options={})
    format = options[:format].to_s
    case format
      when "numbers"
        formatted = date.strftime("%m-%e-%y") # 10-11-11
      when "full"
        formatted = date.strftime("%B #{date.day.ordinalize}, %Y") # October 11th, 2011
      when "custom"
        formatted = date.strftime(options[:with])
      end
    formatted ||= date.strftime("%b %e, %Y") # Oct 11, 2011
  end
end
