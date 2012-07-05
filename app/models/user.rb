class User
  include Mongoid::Document
  field :name, :type => String
  field :password, :type => String
  field :email, :type => String
  field :currently_working, :type => Boolean
  field :_id, :type => String

  embeds_many :clock_times
end
