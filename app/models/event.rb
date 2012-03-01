class Event < ActiveRecord::Base
  belongs_to :user
  attr_accessible :calendar_date, :content
  validates :content, :presence => true
  validates :calendar_date, :presence => true
  validates :user_id, :presence => true
  scope :events_for, lambda {|date| where("calendar_date = ?", date)}
end
