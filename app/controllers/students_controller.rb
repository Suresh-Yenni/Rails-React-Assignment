class StudentsController < ApplicationController

  ## this method computes the change in marks for two provided year and
  ## also computes the total of rows of each group
  def compute_change_and_total(student, marks_change_array, total_marks_array, year1, year2, total)
      math1, math2, phy1, phy2, chem1, chem2 = [0,0,0,0,0,0]
      student.each do |key, value|
        marks_change = {"maths"=> 0, "physics" => 0, "chemistry" => 0}
        total_marks = {"maths"=> 0, "physics" => 0, "chemistry" => 0}
        math1, math2, phy1, phy2, chem1, chem2 = [0,0,0,0,0,0]
        student[key].each do |stu|
          total_marks["maths"] += stu.maths
          total_marks["physics"] += stu.physics
          total_marks["chemistry"] += stu.chemistry
          if year1 != nil && year2 != nil
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
        if year1 != nil && year2 != nil
          marks_change["maths"] = math1 - math2
          marks_change["physics"] = phy1 - phy2
          marks_change["chemistry"] = chem1 - chem2
          marks_change_array.push(marks_change)
        end
        if total == "true"
          total_marks_array.push(total_marks)
        end
      end
  end

  def filter
    @student = Student.order(params[:sort])
    @student = @student.all.group_by(&:"#{params[:group]}")
    @display = params[:display].split(",")

    first = 0
    second = 0
    @marks_change_array = []
    @total_marks_array = []

    year1 = Integer(params[:year1])
    year2 = Integer(params[:year2])
    total = params[:total]
    compute_change_and_total(@student, @marks_change_array, @total_marks_array, year1, year2, total)
  end

  def index
    student = Student.all
    college = Student.pluck(:colleges_id)
    college = college.map { |id| College.find(id).name }
    @details = student.zip(college)
  end

  def show
    @student = Student.find(params[:id])
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(params[:student])
    @student.save
    col_name = College.select("name").find(params[:student][:colleges_id])
    col_name = col_name.name[0...2]
    @student.update_attribute :extended_sid, "#{@student.id}_#{col_name}"
    redirect_to students_path
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    @student.update_attributes(params[:student])
    redirect_to students_path
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    redirect_to students_path
  end

end
