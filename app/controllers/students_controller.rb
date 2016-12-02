class StudentsController < ApplicationController

    def filter
        @students = Student.order(params[:sort])
        @students = @students.all.group_by(&:"#{params[:group]}")
        @display = params[:display]

        first = 0
        second = 0
        @marks_change = {}
        @total_marks = {}

        !params[:year1].empty? ? year1 = Integer(params[:year1]) : year1 = nil
        !params[:year2].empty? ? year2 = Integer(params[:year2]) : year2 = nil
        total = params[:total]
        Student.compute_change_and_total!(@marks_change, @total_marks, @students, year1, year2, total)
        render json: [@students, @marks_change, @total_marks, @display]
    end

    def query
    end

    def index
        student = Student.all
        college = Student.pluck(:colleges_id)
        college = college.map { |id| College.find(id).name }
        @details = student.zip(college)
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
