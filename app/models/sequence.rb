class Sequence < ApplicationRecord
  has_many :asana_instances
  has_many :asanas, :through => :asana_instances 
end