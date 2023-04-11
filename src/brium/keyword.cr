class Brium::Keyword
  include JSON::Serializable

  property keyword : String
  property budget : Int32

  @[JSON::Field(converter: Time::Format.new("%F"))]
  property start : Time

  @[JSON::Field(converter: Time::Format.new("%F"))]
  property end : Time?

  property actual : Int32

  @[JSON::Field(converter: Time::Format.new("%F"))]
  property expected_end : Time?

  property billable : Bool
end
