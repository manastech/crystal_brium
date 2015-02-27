class Brium::Project
  json_mapping({
    id: Int64,
    name: String,
    active: Bool,
  })

  def initialize(id : Int, @name, @active = true)
    @id = id.to_i64
  end
end

