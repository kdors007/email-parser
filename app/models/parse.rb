class Parser

	# Choose txt file of your choice.
	def initialize(txt_file) 
		# Array used to read txt_file
		@arr = []
		@txt_file = File.open(txt_file, "r").each_line do |line|
						@arr << line
					end
	end

	# Find the relevant fields
	def return_path
		@arr[@arr.index{|line| line.include?('Return-Path: ')}]
	end

	def date
		@arr[@arr.index{|line| line.include?('Date: ')}]
	end

	def from
		@arr[@arr.index{|line| line.include?('From: ')}]
	end

	def to
		@arr[@arr.index{|line| line.include?('To:')}]
	end

	def message_id
		@arr[@arr.index{|line| line.include?('Message-ID:')}]
	end

	def subject
		@arr[@arr.index{|line| line.include?('Subject:')}]
	end

	def body
		body_start = (@arr.index{|line| line.include?('Content-Type: text/plain;')} + 3)
		body_end = (@arr[body_start..-1].index{|line| line.include?('------=')}) + body_start - 1
		@arr[body_start..body_end]
	end
	
end
