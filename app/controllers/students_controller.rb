class StudentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_response    

    def index
        render json:Student.all, status: :ok
    end

    def show
        student = Student.find(params[:id])
        render json:student, status: :ok
    end

    def create
        student = Student.create!(student_params)
        render json:student, status: :created
    end

    def update
        student = Student.find(params[:id])
        student.update
        render json: student, status: 201
    end

    def destroy
        student = Student.find(params[:id])
        student.destory
        render json: {}, status: 204
    end

    
    private

    def student_params
        params.permit(:name, :age, :major, :instructor_id)

    end

    def render_record_not_found
        render json:{errors:["Student not found"]}, status: :not_found
    end

    def unprocessable_entity_response(invalid)
        render json:{errors:invalid.record.errors}, status: 422
    end
end
