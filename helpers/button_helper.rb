module Sinatra
	module ButtonHelper

		def button_to(url_or_record, body)
			return "<a class='button' href='#{url_or_record}'><div class='button'>#{body}</div></a>" if url_or_record.is_a? String
			return button_to(record_path(url_or_record), body)
		end

		def record_path(record)
			table_name = record.class.table_name
			record_id = record.id
			"/#{table_name}/#{record_id}"
		end

		def method_missing(*args)
			str = args[0].to_s
			if str[0..3] == "new_" && str[-7..-1] == "_button"
				resource = str[4..-8]
				super unless constant_defined(resource)
				return new_resource_button(resource)
			elsif str[-7..-1] == "_button"
				resource = str[0..-8]
				super unless constant_defined(resource)
				return resource_index_button(resource)
			end
			super
		end

		def new_resource_button(resource)
			button_to("/#{pluralize(resource)}/new", "New #{resource.humanize}")
		end

		def resource_index_button(resource)
			button_to("/#{pluralize(resource)}", "#{pluralize(resource).humanize}")
		end

		def constant_defined(resource)
			resource = singularize(resource).camelcase
			binding.pry
			Module.const_defined?(resource)
		end

	end
	helpers ButtonHelper
end