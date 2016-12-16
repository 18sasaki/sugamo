json.extract! class_room, :id, :grade_code, :name, :short_name, :color, :teacher_name, :sub_teacher_name, :created_at, :updated_at
json.url class_room_url(class_room, format: :json)