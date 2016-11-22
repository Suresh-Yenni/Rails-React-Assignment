class Student < ActiveRecord::Base
  belongs_to :colleges
  attr_accessible :chemistry, :dept, :maths, :physics, :regid, :year, :colleges_id
end
