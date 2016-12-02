class Student < ActiveRecord::Base
    belongs_to :colleges
    attr_accessible :chemistry, :dept, :maths, :physics, :regid, :year, :colleges_id

    ## this method computes the change in marks for two provided year and
    ## also computes the total of rows of each group
    def self.compute_change_and_total!(marks_change, total_marks, student, year1, year2, total)
        student.each do |key, value|
            change_row = {"maths"=> 0, "physics" => 0, "chemistry" => 0}
            total_row = {"maths"=> 0, "physics" => 0, "chemistry" => 0}
            math1, math2, phy1, phy2, chem1, chem2 = [0,0,0,0,0,0]
            student[key].each do |stu|
                total_row["maths"] += stu.maths
                total_row["physics"] += stu.physics
                total_row["chemistry"] += stu.chemistry
                if !year1.nil? && !year2.nil?
                    if stu.year == year1
                        math1 = stu.maths
                        phy1 = stu.physics
                        chem1 = stu.chemistry
                    elsif stu.year == year2
                        math2 = stu.maths
                        phy2 = stu.physics
                        chem2 = stu.chemistry
                    end
                end
            end
            if !year1.nil? && !year2.nil?
                change_row["maths"] = math1 - math2
                change_row["physics"] = phy1 - phy2
                change_row["chemistry"] = chem1 - chem2
                marks_change[key] = change_row
            end
            if total == "true"
                total_marks[key] = total_row
            end
        end
    end
end
