class Calendar < ActiveRecord::Base
  has_many :doors, :dependent => :destroy

  belongs_to :user
  has_and_belongs_to_many :users

  validates_presence_of :title

end
