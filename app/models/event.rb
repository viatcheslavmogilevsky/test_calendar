class Event < ActiveRecord::Base
  belongs_to :user
  attr_accessible :calendar_date, :content, :repeat, :picture
  validates :content, :presence => true
  validates :calendar_date, :presence => true, :unless => :every_day?
  validates :user_id, :presence => true
  before_create :change_date
  paginates_per 10
  scope :all_events, order("repeat DESC, calendar_date ASC")
  has_attached_file :picture
  protected
  def change_date
    case repeat
    when 3
      self.calendar_date = Date.new(2012,3,25)+self.calendar_date.cwday
    when 2
      self.calendar_date = Date.new(2012,3,self.calendar_date.day)
    when 1
      self.calendar_date = Date.new(2012,self.calendar_date.month,self.calendar_date.day)
    end
  end

  def every_day?
    repeat == 4
  end
end
