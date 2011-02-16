# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def title(page_title)
		content_for(:title) { page_title }
	end

	def errors_for(model)
	  if model.errors.any?
	    header = content_tag(:h2, "#{pluralize(model.errors.count, "error ocurrio", "errores ocurrieron")} al grabar el #{model.class}:")
      errors = model.errors.full_messages.map{|msg| content_tag(:li, msg)}.join

      contents = ''
      contents << header
      contents << content_tag(:ul, errors.html_safe)

      content_tag(:div, contents.html_safe, :id => "ErrorExplanation").html_safe
    end
	end
end

