class Brium::Holiday
  json_mapping({
    id: Int64,
    worker_id: {type: Int64, nilable: true},
    kind: String,
    from: {type: Time, converter: TimeFormat::ISO_8601_DATE},
    to: {type: Time, converter: TimeFormat::ISO_8601_DATE},
    description: {type: String, nilable: true},
  })

  def initialize(id : Int, worker_id = nil, @kind = "vacations", @from = Time.now, @to = Time.now, @description = nil)
    @id = id.to_i64
    @worker_id = worker_id.try &.to_i64
  end

  def_equals_and_hash id
end
