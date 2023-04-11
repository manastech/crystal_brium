class Brium::Worker
  include JSON::Serializable

  property id : Int64
  property email : String
  property name : String?
  property hours_per_day : Float64
  property active : Bool
  property admin : Bool

  def initialize(id : Int, @email : String,
                 @name = nil,
                 @hours_per_day = 8.0_f64,
                 @active = true,
                 @admin = false)
    @id = id.to_i64
  end

  def_equals_and_hash id
end
