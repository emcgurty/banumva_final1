class Signatures < ActiveRecord::Base

  set_primary_key :uuid
#  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  alpha_regex = /\A[ a-zA-Z'-]+\z/
  alpha_numeric_regex = /\A[ a-zA-Z0-9!?.,:;'-()@+"]+\z/
  alpha_numeric_regex_comments = /\A[ \r\n|\r\na-zA-Z0-9!?.,:;'-()@+"]+\z/

  attr_accessor :signature_agreement
  validates :first_name, :last_name, :signer_alias, :city,  :presence => {:message => "is a required field."}
  validates_format_of :first_name, :last_name, :with => alpha_regex, :message => "must contain only alpha-characters, no numbers"
  validates_format_of  :city,  :with => alpha_numeric_regex, :message => "must contain only alpha-numeric characters with limited punctuation"
  #  validates_format_of :postal_code, :allow_blank => true, :with => alpha_regex, :message => "must contain only alpha-numeric characters with limited punctuation"
  validates_length_of :first_name, :last_name, :maximum => 35,  :message => "has too many characters."
  validates_length_of :postal_code, :allow_blank => true, :maximum => 20,  :message => "has too many characters."
  validates_length_of :mi, :is => 1, :allow_blank => true, :message => "is not a valid size."
  validates_format_of :mi,          :allow_blank => true, :with => alpha_regex, :message => "must contain only alpha-characters"
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates_length_of :signer_alias,  :in => 8..16, :message => "must be between 8 and 16 characters"
  validates_uniqueness_of :signer_alias,  :message => "is already being used."
  validates_length_of :comments, :allow_blank => true, :maximum => 255, :message => "has too many characters."
  validates_format_of :comments, :allow_blank => true,  :with => alpha_numeric_regex_comments, :message => "must contain only alpha-numeric characters with limited punctuation"
end

#$ZIPREG=array(
#    "US"=>"^\d{5}([\-]?\d{4})?$",
#    "UK"=>"^(GIR|[A-Z]\d[A-Z\d]??|[A-Z]{2}\d[A-Z\d]??)[ ]??(\d[A-Z]{2})$",
#    "DE"=>"\b((?:0[1-46-9]\d{3})|(?:[1-357-9]\d{4})|(?:[4][0-24-9]\d{3})|(?:[6][013-9]\d{3}))\b",
#    "CA"=>"^([ABCEGHJKLMNPRSTVXY]\d[ABCEGHJKLMNPRSTVWXYZ])\ {0,1}(\d[ABCEGHJKLMNPRSTVWXYZ]\d)$",
#    "FR"=>"^(F-)?((2[A|B])|[0-9]{2})[0-9]{3}$",
#    "IT"=>"^(V-|I-)?[0-9]{5}$",
#    "AU"=>"^(0[289][0-9]{2})|([1345689][0-9]{3})|(2[0-8][0-9]{2})|(290[0-9])|(291[0-4])|(7[0-4][0-9]{2})|(7[8-9][0-9]{2})$",
#    "NL"=>"^[1-9][0-9]{3}\s?([a-zA-Z]{2})?$",
#    "ES"=>"^([1-9]{2}|[0-9][1-9]|[1-9][0-9])[0-9]{3}$",
#    "DK"=>"^([D-d][K-k])?( |-)?[1-9]{1}[0-9]{3}$",
#    "SE"=>"^(s-|S-){0,1}[0-9]{3}\s?[0-9]{2}$",
#    "BE"=>"^[1-9]{1}[0-9]{3}$"
#);