json.array!(@tasks) do |task|
  json.extract! task, :name, :description, :due, :priority
  json.url task_url(task, format: :json)
end
