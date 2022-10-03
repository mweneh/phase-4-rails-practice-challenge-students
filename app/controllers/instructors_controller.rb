class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response
    
        def index
            render json: Instructor.all, status: :ok
        end
    
        def show
            instructor = Instructor.find(params[:id])
            render json:instructor, serializer: InstructorAndStudentsSerializer, status: :ok
        end
    
        def create
            instructor = Instructor.create!(instructor_params)
            render json: instructor, status: :created
        end
    
        def update
            instructor = Instructor.find(params[:id])  
            instructor.update!(instructor_params)
            render json: instructor, status: :ok
        end
    
        def destroy
            instructor = Instructor.find(params[:id])
            instructor.destroy
            render json: {}, status: 204
        end
    
        private
    
        def instructor_params
            params.permit(:name)
        end
    
        def render_not_found_response
            render json: {error:"Instructor not found"}, status: 404
        end
    
        def render_invalid_response(invalid)
            render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
        end
    
    end
    