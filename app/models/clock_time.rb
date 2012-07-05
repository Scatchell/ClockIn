class ClockTime
  include Mongoid::Document
  field :in, :type => Time
  field :out, :type => Time

  embedded_in :user
end
