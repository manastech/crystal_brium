class Brium::Entry
  json_mapping({
    id: Int64,
    worker_id: Int64,
    record: String,
    worked_at: {type: Time, converter: TimeFormat::ISO_8601_DATE},
    hours: Float64,
    client_id: {type: Int64, nilable: true},
    project_id: {type: Int64, nilable: true},
    billable_status: {type: String, nilable: true},
  })

  def initialize(id : Int, worker_id : Int, @record, @worked_at, @hours, @client_id = nil, @project_id = nil, @billable_status = nil)
    @id = id.to_i64
    @worker_id = worker_id.to_i64
  end

  def keyword
    @record.split(':', 2).first.strip
  end

  def_hash_and_equals id
end
