json.extract! code, :id, :code_type, :code_key, :view_name, :short_name, :check_string, :created_at, :updated_at
json.url code_url(code, format: :json)