class Brium::Worker
  json_mapping({
    id: Int64,
    email: String,
    name: {type: String, nilable: true},
    hours_per_day: Float64,
    active: Bool,
    admin: Bool,
  })

  def initialize(id : Int, @email : String,
      @name = nil,
      @hours_per_day = 8,
      @active = true,
      @admin = false)
    @id = id.to_i64
  end

  def_equals_and_hash id
end
