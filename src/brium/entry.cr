class Brium::Entry
  include JSON::Serializable

  property id : Int64
  property worker_id : Int64
  property record : String

  @[JSON::Field(converter: Time::Format.new("%F"))]
  property worked_at : Time

  property hours : Float64
  property client_id : Int64?
  property project_id : Int64?
  property billable_status : String?

  def initialize(id : Int, worker_id : Int, @record, @worked_at, @hours, @client_id = nil, @project_id = nil, @billable_status = nil)
    @id = id.to_i64
    @worker_id = worker_id.to_i64
  end

  def keyword
    @record.split(':', 2).first.strip
  end

  def_equals_and_hash id
end
