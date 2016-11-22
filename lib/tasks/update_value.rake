namespace :update_value do
  desc "update value to extented_sid in student table"

  task :update_extended_sid_value => :environment do
    #binding.pry
    student = Student.all
    college = College.select("name").find(Student.pluck(:colleges_id))
    details = student.zip(college)
    details.each do |stu, col|
      temp = col.name[0...2]
      stu.update_attribute :extended_sid, "#{stu.regid}_#{temp}"
    end
  end
end
