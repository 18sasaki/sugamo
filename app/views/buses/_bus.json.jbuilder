json.extract! bus, :id, :name, :view_name, :created_at, :updated_at
json.url bus_url(bus, format: :json)