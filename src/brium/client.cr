class Brium::Client
  include JSON::Serializable

  property id : Int64
  property name : String
  property projects : Array(Project)
  property active : Bool

  def initialize(id : Int, @name, @projects = [] of Project, @active = true)
    @id = id.to_i64
  end

  def_equals_and_hash id
end
