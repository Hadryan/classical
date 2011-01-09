# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def title(page_title)
		content_for(:title) { page_title }
	end

	def errors_for(model)
	  if model.errors.any?
	    header = content_tag(:h2, "#{pluralize(model.errors.count, "error")} prohibited this #{model.class} from being saved:")
      errors = model.errors.full_messages.map{|msg| content_tag(:li, msg)}.join

      contents = ''
      contents << header
      contents << content_tag(:ul, errors.html_safe)

      content_tag(:div, contents.html_safe, :class => "error-explanation").html_safe
    end
	end
end

