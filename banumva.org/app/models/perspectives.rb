class Perspectives < ActiveRecord::Base
  set_primary_key :p_uuid
  #\A\r\n|\r\n\z
  alpha_numeric_regex_comments = /\A[ \r\n|\r\na-zA-Z0-9!?.,:;'-()@+"]+\z/
  validates_length_of :record_text, :maximum => 255, :message => "has too many characters."
  validates :record_text,  :presence => {:message => "is a required field."}
  validates_format_of :record_text, :with => alpha_numeric_regex_comments, :message => "must contain only alpha-numeric characters with limited punctuation"
end    
