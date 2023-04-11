class Brium::Project
  include JSON::Serializable

  property id : Int64
  property name : String
  property active : Bool

  def initialize(id : Int, @name, @active = true)
    @id = id.to_i64
  end

  def_equals_and_hash id
end
