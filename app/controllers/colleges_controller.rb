class CollegesController < ApplicationController

    def home
    end

    def search
        str = params[:college][:name]
        @college = College.where("name like ?", "%#{str}%")
    end

    def index
        @college = College.all
    end

    def show
        @student = Student.select("regid").select("dept").select("year").where(:colleges_id => params[:id])
    end

    def new
        @college = College.new
    end

    def create
        @college = College.new(params[:college])
        @college.save
        redirect_to colleges_path
    end

    def edit
        @college = College.find(params[:id])
    end

    def update
        @college = College.find(params[:id])
        @college.update_attributes(params[:college])
        redirect_to colleges_path
    end

    def destroy
        @student = Student.where(:colleges_id => params[:id])
        @student.each do |stu|
            stu.destroy
    end
        @college = College.find(params[:id])
        @college.destroy
        redirect_to colleges_path
    end

end
