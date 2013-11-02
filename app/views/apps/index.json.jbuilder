json.array!(@apps) do |app|
  json.extract! app, :trackId
  json.url app_url(app, format: :json)
end
