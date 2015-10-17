class Brium::Project
  JSON.mapping({
    id:     Int64,
    name:   String,
    active: Bool,
  })

  def initialize(id : Int, @name, @active = true)
    @id = id.to_i64
  end

  def_equals_and_hash id
end
