class BusCourse < ApplicationRecord
	belongs_to :bus
	has_many :bus_stops
	serialize :a_departure_time, Tod::TimeOfDay
	serialize :a_arrival_time, Tod::TimeOfDay
	serialize :b_departure_time, Tod::TimeOfDay
	serialize :b_arrival_time, Tod::TimeOfDay
	serialize :c_departure_time, Tod::TimeOfDay
	serialize :c_arrival_time, Tod::TimeOfDay

# http://ruby-rails.hatenadiary.com/entry/20141208/1418018874
  accepts_nested_attributes_for :bus_stops, allow_destroy: true, reject_if: proc { |attributes| attributes[:name].blank? }
end
