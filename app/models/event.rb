class Event < ActiveRecord::Base
  belongs_to :user
  attr_accessible :calendar_date, :content, :repeat
  validates :content, :presence => true
  validates :calendar_date, :presence => true
  validates :user_id, :presence => true
  paginates_per 10
  scope :all_events, order("repeat DESC, calendar_date ASC")
end
