module Sinatra
	module FormHelper

		def form_open(record, options={})
			if options[:method]
				method = options[:method]
			else
				method = record.persisted? ? 'get' : 'post'
			end
			action = resource_index_path(record.class.table_name)
			open_form_tag(action, method, record)
		end

		def open_form_tag(action, method, record)
			full_action = [action, record.id].compact.join("/")
			str =""
			if ['delete','patch', 'put'].include?(method)
				str << "<form class ='menu' action='#{full_action}' method='post'>"
				str << "<input type='hidden' name='_method' value='#{method}' />"
			else
				str << "<form class='menu' action='#{full_action}' method='#{method}'>"
			end
		end

		def input_tag(options={})
			type = options[:type]
			resource = options[:resource]
			name = options[:name]
			value = options[:value]
			placeholder = options[:placeholder]
			label = options[:label]
			str = ""
			if type != "submit"
				str << "<label for='#{resource}[#{name}]'>#{label}</label>"
			end
			str << "<input type='#{type}' name='#{resource}[#{name}]' value='#{value}' placeholder='#{placeholder}' />"
		end
	end

	def form_close
		"</form>"
	end
	helpers FormHelper
end