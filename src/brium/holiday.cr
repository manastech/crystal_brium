class Brium::Holiday
  include JSON::Serializable

  property id : Int64
  property worker_id : Int64?
  property kind : String

  @[JSON::Field(converter: Time::Format.new("%F"))]
  property from : Time

  @[JSON::Field(converter: Time::Format.new("%F"))]
  property to : Time

  property description : String?

  def initialize(id : Int, worker_id = nil, @kind = "vacations", @from = Time.local, @to = Time.local, @description = nil)
    @id = id.to_i64
    @worker_id = worker_id.try &.to_i64
  end

  def_equals_and_hash id
end
