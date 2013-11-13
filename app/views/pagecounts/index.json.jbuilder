json.array!(@pagecounts) do |pagecount|
  json.extract! pagecount, :pageview
  json.url pagecount_url(pagecount, format: :json)
end
