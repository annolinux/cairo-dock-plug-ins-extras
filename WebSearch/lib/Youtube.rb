# This is a part of the external WebSearch applet for Cairo-Dock
# Author: Eduardo Mucelli Rezende Oliveira
# E-mail: edumucelli@gmail.com or eduardom@dcc.ufmg.br
#
# This module fetch results from Youtube, including thumbnails - www.youtube.com

class Youtube < Engine
	
	def initialize
		self.name = self.class.to_s
		self.base_url = "http://www.youtube.com"
		self.query_url = "#{self.base_url}/results?search_query="						# 20 results per page
		super
	end

	# url, e.g, /watch?v=WwojCsQ3Fa8
	# thumb_url, e.g, "http://i4.ytimg.com/vi/WwojCsQ3Fa8/default.jpg"
	def retrieve_links(query, page = 1)
		youtube = Nokogiri::HTML(open(URI.encode("#{self.query_url}#{query}&page=#{page}")))
		self.stats = retrieve_youtube_result_stats(youtube, query)
		(youtube/"h3[@id^='video-long-title-']/a").each do |res|							# 'a' tag has id which starts with "video-long-title-"
			url = res['href']
			description = res.inner_text
			video_id = url.split('=').last												# /watch?v=WwojCsQ3Fa8 => WwojCsQ3Fa8 => video_id
			thumb_url = "http://i4.ytimg.com/vi/#{video_id}/default.jpg"
			self.links << ThumbnailedLink.new("#{self.base_url}#{url}", description, thumb_url, self.name)
		end
		self.links
	end

	def retrieve_youtube_result_stats (youtube, query)
		total = youtube.at("p[@class='num-results']/strong").inner_text
		"Search for #{query} returned #{total} results"
	end
end
