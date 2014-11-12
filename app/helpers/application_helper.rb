module ApplicationHelper

	def time_ago(date_time)
		s = (Time.now - date_time).to_i
		case s
		when 0...60 then
			"#{s} #{"second".pluralize(s)} ago"
		when 60...7200 then
			m = (s/60).to_i
			"#{m} #{"minute".pluralize(m)} ago"
		when 7200...86400
			h = (s/3600).to_i
			"#{h} #{"hour".pluralize(h)} ago"
		when 86400...31557600
			d = (s/86400).to_i
			"#{d} #{"day".pluralize(d)} ago"
		else
			"on #{Date.strptime(date_time.to_i.to_s, '%s')}"
		end
	end
end
