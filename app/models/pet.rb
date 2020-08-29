class Pet < ApplicationRecord
  belongs_to :shelter

  validates_presence_of :image
  validates_presence_of :name
  validates_presence_of :age
  validates_presence_of :sex
end
