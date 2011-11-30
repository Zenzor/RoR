class Door < ActiveRecord::Base
  belongs_to :calendar

  validates_presence_of :content
end
