class Brium::Keyword
  json_mapping({
    keyword: String,
    budget: Int32,
    start: {type: Time, converter: Time::Format.new("%F")},
    end: {type: Time, converter: Time::Format.new("%F"), nilable: true},
    actual: Int32,
    expected_end: {type: Time, converter: Time::Format.new("%F"), nilable: true},
    billable: Bool,
  })
end

